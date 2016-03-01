From: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Subject: [PATCH 1/6] spi: add flow controll support
Date: Tue,  1 Mar 2016 15:43:15 +0100
Message-ID: <1456843400-20696-1-git-send-email-linux@rempel-privat.de>
References: <56D448E1.6090006@de.bosch.com>
Cc: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
To: fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org,
	dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56D448E1.6090006-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Different HW implement different variants of SPI based flow control (FC).
To flexible FC implementation a spited it to fallowing common parts:
Flow control: Request Sequence
Master CS   |-------2\_____________________|
Slave  FC   |-----1\_______________________|
DATA        |-----------3\_________________|

Flow control: Ready Sequence
Master CS   |-----1\_______________________|
Slave  FC   |--------2\____________________|
DATA        |-----------3\_________________|

Flow control: ACK End of Data
Master CS   |______________________/2------|
Slave  FC   |________________________/3----|
DATA        |__________________/1----------|

Flow control: Pause
Master CS   |_______________________/------|
Slave  FC   |_______1/-----\3______/-------|
DATA        |________2/------\4___/--------|

Flow control: Ready signal on MISO
Master CS   |-----1\_______________________|
MISO/DATA   |------2\____3/----------------|
CONV START  |       ^                      |
DATA READY  |             ^                |

Signed-off-by: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt |   7 +
 drivers/spi/spi.c                                 | 191 +++++++++++++++++++++-
 include/linux/spi/spi.h                           |  68 +++++++-
 3 files changed, 261 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index bbaa857..dfefc86 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -61,6 +61,13 @@ contain the following properties.
                       used for MOSI. Defaults to 1 if not present.
 - spi-rx-bus-width - (optional) The bus width(number of data wires) that
                       used for MISO. Defaults to 1 if not present.
+- spi-fc-ready      - (optional) flow control line used for ready signal.
+- spi-fc-stop-ack   - (optional) flow control line used to ACK end of transfer.
+- spi-fc-pause      - (optional) flow control line used for to pause transfer
+                      at any time.
+- spi-fc-request    - (optional) flow control line used for request signal.
+- spi-fc-miso-ready - (optional) MISO used for flow control ready signal.
+- fc-gpio           - (optional) gpio for flow control.
 
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in the SPI system to be transferred in 2 wires(DUAL) or 4 wires(QUAD).
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 47eff80..1140665 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -37,6 +37,8 @@
 #include <linux/kthread.h>
 #include <linux/ioport.h>
 #include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
@@ -396,6 +398,156 @@ int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
 EXPORT_SYMBOL_GPL(__spi_register_driver);
 
 /*-------------------------------------------------------------------------*/
+/*
+ * SPI flow control
+ */
+static int spi_fc_wait_miso(struct spi_device *spi)
+{
+	struct spi_master *master = spi->master;
+	int count = 100; /* 10 * 100 = 10 msec */
+
+	if (!master->get_miso_level)
+		return count;
+
+	while (count > 0) {
+		count--;
+		if (master->get_miso_level(spi))
+			break;
+
+		usleep_range(100, 200);
+	}
+
+	return count;
+}
+
+
+static int spi_fc_equal_cs(struct spi_device *spi)
+{
+	int fc_enabled;
+
+	fc_enabled = gpiod_get_value(spi->fc_gpio);
+	return (spi->cs_enabled == fc_enabled);
+}
+
+int spi_fc_wait_rq(struct spi_device *spi, u32 fc_state)
+{
+	unsigned long timeout = msecs_to_jiffies(10);
+	int ret = 1;
+
+	if (!(spi->mode & fc_state))
+		return ret;
+
+	if (spi->mode & SPI_FC_MISO_READY)
+		return spi_fc_wait_miso(spi);
+
+	if (atomic_read(&spi->active_rq)) {
+		if (!spi_fc_equal_cs(spi))
+			dev_warn(&spi->dev, "Got request, but device is not ready\n");
+		atomic_set(&spi->active_rq, 0);
+		return ret;
+	}
+
+	if (spi->fc_irq >= 0) {
+		ret = wait_for_completion_io_timeout(&spi->fc_complete,
+						     timeout);
+	} else {
+		int count = 100; /* 10 * 100 = 10-20 msec */
+
+		while (count > 0) {
+			count--;
+			if (spi_fc_equal_cs(spi))
+				break;
+
+			usleep_range(100, 200);
+		}
+		ret = count;
+	}
+
+	if (!ret)
+		dev_warn(&spi->dev, "FC timeout: requested state: 0x%x\n", fc_state);
+
+	return ret;
+}
+
+static irqreturn_t spi_fc_rq(int irq, void *dev_id)
+{
+	struct spi_device *spi = (struct spi_device *)dev_id;
+	int fc_enabled;
+
+	fc_enabled = gpiod_get_value(spi->fc_gpio);
+
+	if (spi->mode | SPI_FC_REQUEST &&
+			!spi->cs_enabled && fc_enabled) {
+		atomic_set(&spi->active_rq, 1);
+		if (spi->request_cb)
+			spi->request_cb(spi);
+	} else if (spi->mode | SPI_FC_STOP_ACK &&
+			!spi->cs_enabled && !fc_enabled) {
+		complete(&spi->fc_complete);
+	} else if (spi->mode | SPI_FC_READY &&
+			spi->cs_enabled && fc_enabled) {
+		complete(&spi->fc_complete);
+	} else {
+		dev_warn(&spi->dev, "Wrong FC State. CS:%i, FC:%i, Mode:0x%x\n",
+			 spi->cs_enabled, fc_enabled, spi->mode);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * spi_fc_probe - Configure Flow Control for called slave device.
+ * @spi: spi_device to register.
+ *
+ * Companion function to spi_setup.  Devices which support Flow Control
+ * functionality need to call this function to be able to use it.
+ *
+ * Return: 0 on success; negative errno on failure.
+ */
+int spi_fc_probe(struct spi_device *spi)
+{
+	struct device_node *np = spi->dev.of_node;
+	int ret;
+
+	if (!np)
+		return 0;
+
+	if (!(spi->mode & SPI_FC_MASK) || spi->mode & SPI_FC_HW_ONLY)
+		return 0;
+
+	spi->fc_gpio = devm_gpiod_get(&spi->dev, "fc", GPIOD_IN);
+	if (IS_ERR(spi->fc_gpio)) {
+		ret = PTR_ERR(spi->fc_gpio);
+		dev_err(&spi->dev, "Failed to request FC GPIO: %d\n", ret);
+		return ret;
+	}
+
+	init_completion(&spi->fc_complete);
+
+	spi->fc_irq = gpiod_to_irq(spi->fc_gpio);
+	if (spi->fc_irq < 0) {
+		/*
+		 * This will dramtically affect transfer speed,
+		 * so it is not recommended, but possible use case.
+		 */
+		dev_warn(&spi->dev, "gpio-fc, filed to get irq for configured pin, use slow polling instead\n");
+	} else {
+		snprintf(spi->fc_irq_name, sizeof(spi->fc_irq_name), "spi-fc-%s",
+			 dev_name(&spi->dev));
+		ret = devm_request_irq(&spi->dev, spi->fc_irq, spi_fc_rq,
+				       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				       spi->fc_irq_name, spi);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to request FC IRQ\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_fc_probe);
+
+/*-------------------------------------------------------------------------*/
 
 /* SPI devices should normally not be created by SPI device drivers; that
  * would make them board-specific.  Similarly with SPI master drivers.
@@ -687,6 +839,9 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 
 static void spi_set_cs(struct spi_device *spi, bool enable)
 {
+	spi->cs_enabled = enable;
+	reinit_completion(&spi->fc_complete);
+
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
 
@@ -941,9 +1096,15 @@ static int spi_transfer_one_message(struct spi_master *master,
 	unsigned long ms = 1;
 	struct spi_statistics *statm = &master->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
+	struct spi_device *spi = msg->spi;
 
 	spi_set_cs(msg->spi, true);
 
+	if (!spi_fc_wait_rq(spi, SPI_FC_READY | SPI_FC_MISO_READY)) {
+		ret = -EREMOTEIO;
+		goto out;
+	}
+
 	SPI_STATISTICS_INCREMENT_FIELD(statm, messages);
 	SPI_STATISTICS_INCREMENT_FIELD(stats, messages);
 
@@ -1006,8 +1167,20 @@ static int spi_transfer_one_message(struct spi_master *master,
 				keep_cs = true;
 			} else {
 				spi_set_cs(msg->spi, false);
-				udelay(10);
+
+				if (!spi_fc_wait_rq(spi, SPI_FC_STOP_ACK)) {
+					ret = -EREMOTEIO;
+					break;
+				}
+
+				if (!(spi->mode & SPI_FC_STOP_ACK))
+					udelay(10);
 				spi_set_cs(msg->spi, true);
+
+				if (!spi_fc_wait_rq(spi, SPI_FC_READY)) {
+					ret = -EREMOTEIO;
+					break;
+				}
 			}
 		}
 
@@ -1015,8 +1188,12 @@ static int spi_transfer_one_message(struct spi_master *master,
 	}
 
 out:
-	if (ret != 0 || !keep_cs)
+
+	if (ret != 0 || !keep_cs) {
 		spi_set_cs(msg->spi, false);
+		if (ret != -EREMOTEIO && !spi_fc_wait_rq(spi, SPI_FC_STOP_ACK))
+			ret = -EREMOTEIO;
+	}
 
 	if (msg->status == -EINPROGRESS)
 		msg->status = ret;
@@ -1483,6 +1660,16 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 		spi->mode |= SPI_3WIRE;
 	if (of_find_property(nc, "spi-lsb-first", NULL))
 		spi->mode |= SPI_LSB_FIRST;
+	if (of_find_property(nc, "spi-fc-ready", NULL))
+		spi->mode |= SPI_FC_READY;
+	if (of_find_property(nc, "spi-fc-stop-ack", NULL))
+		spi->mode |= SPI_FC_STOP_ACK;
+	if (of_find_property(nc, "spi-fc-pause", NULL))
+		spi->mode |= SPI_FC_PAUSE;
+	if (of_find_property(nc, "spi-fc-request", NULL))
+		spi->mode |= SPI_FC_REQUEST;
+	if (of_find_property(nc, "spi-fc-miso-ready", NULL))
+		spi->mode |= SPI_FC_MISO_READY;
 
 	/* Device DUAL/QUAD mode */
 	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 53be3a4..07803f8 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -136,7 +136,7 @@ struct spi_device {
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			bits_per_word;
-	u16			mode;
+	u32			mode;
 #define	SPI_CPHA	0x01			/* clock phase */
 #define	SPI_CPOL	0x02			/* clock polarity */
 #define	SPI_MODE_0	(0|0)			/* (original MicroWire) */
@@ -148,16 +148,65 @@ struct spi_device {
 #define	SPI_3WIRE	0x10			/* SI/SO signals shared */
 #define	SPI_LOOP	0x20			/* loopback mode */
 #define	SPI_NO_CS	0x40			/* 1 dev/bus, no chipselect */
-#define	SPI_READY	0x80			/* slave pulls low to pause */
+/*
+ * Flow control: Ready Sequence (SPI_FC_READY)
+ * Master CS   |-----1\_______________________|
+ * Slave  FC   |--------2\____________________|
+ * DATA        |-----------3\_________________|
+ * 1. Chips Select set to active by Master.
+ * 2. Flow Control set to active by Slave.
+ * 3. Master starting Data transmission.
+ */
+#define	SPI_FC_READY	0x80
 #define	SPI_TX_DUAL	0x100			/* transmit with 2 wires */
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
+/*
+ * Flow control: Pause (SPI_FC_PAUSE)
+ * Master CS   |_______________________/------|
+ * Slave  FC   |_______1/-----\3______/-------|
+ * DATA        |________2/------\4_____/------|
+ */
+#define SPI_FC_PAUSE		0x1000
+/*
+ * Flow control: ACK End of Data (SPI_FC_STOP_ACK)
+ * Master CS   |______________________/2------|
+ * Slave  FC   |________________________/3----|
+ * DATA        |__________________/1----------|
+ */
+#define SPI_FC_STOP_ACK		0x2000
+/*
+ * Flow control: Request Sequence (SPI_FC_REQUEST)
+ * Master CS   |-------2\_____________________|
+ * Slave  FC   |-----1\_______________________|
+ * DATA        |-----------3\_________________|
+ */
+#define SPI_FC_REQUEST		0x4000
+/* If complete FC is done by HW or controller driver, set this flag */
+#define SPI_FC_HW_ONLY		0x8000
+/*
+ * Flow control: Ready signal on MISO (SPI_FC_MISO_READY)
+ * Master CS   |-----1\_______________________|
+ * MISO/DATA   |------2\____3/----------------|
+ * CONV START  |       ^                      |
+ * DATA READY  |             ^                |
+ * When CS get asserted (1), MISO/DATA becomes dominant low (2)
+ * and the ADC conversion starts (within 100ns of (1)).
+ * When MISO/DATA goes dominant high (3) then the conversion has finished
+ * and the transfer may start.
+ * Example: MAX187/189 SPI-ADC.
+ */
+#define SPI_FC_MISO_READY	0x10000
+#define SPI_FC_MASK	(SPI_FC_READY | SPI_FC_PAUSE | \
+			 SPI_FC_STOP_ACK | SPI_FC_REQUEST)
+
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	int			cs_gpio;	/* chip select gpio */
+	int			cs_enabled;
 
 	/* the statistics */
 	struct spi_statistics	statistics;
@@ -171,6 +220,13 @@ struct spi_device {
 	 *  - chipselect delays
 	 *  - ...
 	 */
+
+	void (*request_cb)(struct spi_device *spi);
+	atomic_t		active_rq;
+	struct completion	fc_complete;
+	struct gpio_desc	*fc_gpio;	/* flow control */
+	int			fc_irq;
+	char			fc_irq_name[32];
 };
 
 static inline struct spi_device *to_spi_device(struct device *dev)
@@ -282,7 +338,6 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 #define module_spi_driver(__spi_driver) \
 	module_driver(__spi_driver, spi_register_driver, \
 			spi_unregister_driver)
-
 /**
  * struct spi_master - interface to SPI master controller
  * @dev: device interface to this driver
@@ -537,6 +592,10 @@ struct spi_master {
 	/* dummy data for full duplex devices */
 	void			*dummy_rx;
 	void			*dummy_tx;
+
+	int	(*wait_for_rq)(struct spi_device *spi);
+	/* some devices use MISO for flow control, see SPI_FC_MISO_READY */
+	int	(*get_miso_level)(struct spi_device *spi);
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
@@ -1146,4 +1205,7 @@ spi_transfer_is_last(struct spi_master *master, struct spi_transfer *xfer)
 	return list_is_last(&xfer->transfer_list, &master->cur_msg->transfers);
 }
 
+int spi_fc_wait_rq(struct spi_device *spi, u32 s5w_state);
+int spi_fc_probe(struct spi_device *spi);
+
 #endif /* __LINUX_SPI_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
