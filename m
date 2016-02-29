From: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Subject: [PATCH RFC] spi: add flow controll support
Date: Mon, 29 Feb 2016 13:04:19 +0100
Message-ID: <1456747459-8559-1-git-send-email-linux@rempel-privat.de>
Cc: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
To: fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org,
	dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
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

Signed-off-by: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
---
 drivers/spi/spi-davinci.c |  10 ++--
 drivers/spi/spi-sun4i.c   |   3 +-
 drivers/spi/spi.c         | 120 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h   |  51 +++++++++++++++++++-
 4 files changed, 175 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index fddb7a3..8728df9 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -351,8 +351,8 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 	 *
 	 * Version 2 hardware supports an optional handshaking signal,
 	 * so it can support two more modes:
-	 *  - 5 pin SPI variant is standard SPI plus SPI_READY
-	 *  - 4 pin with enable is (SPI_READY | SPI_NO_CS)
+	 *  - 5 pin SPI variant is standard SPI plus SPI_FC_READY
+	 *  - 4 pin with enable is (SPI_FC_READY | SPI_NO_CS)
 	 */
 
 	if (dspi->version == SPI_VERSION_2) {
@@ -374,7 +374,7 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 						& SPIDELAY_T2CDELAY_MASK;
 		}
 
-		if (spi->mode & SPI_READY) {
+		if (spi->mode & SPI_FC_READY) {
 			spifmt |= SPIFMT_WAITENA_MASK;
 			delay |= (spicfg->t2edelay << SPIDELAY_T2EDELAY_SHIFT)
 						& SPIDELAY_T2EDELAY_MASK;
@@ -452,7 +452,7 @@ static int davinci_spi_setup(struct spi_device *spi)
 			set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
 	}
 
-	if (spi->mode & SPI_READY)
+	if (spi->mode & SPI_FC_READY)
 		set_io_bits(dspi->base + SPIPC0, SPIPC0_SPIENA_MASK);
 
 	if (spi->mode & SPI_LOOP)
@@ -1021,7 +1021,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
 	dspi->bitbang.flags = SPI_NO_CS | SPI_LSB_FIRST | SPI_LOOP;
 	if (dspi->version == SPI_VERSION_2)
-		dspi->bitbang.flags |= SPI_READY;
+		dspi->bitbang.flags |= SPI_FC_HW_ONLY | SPI_FC_READY | SPI_FC_PAUSE;
 
 	if (pdev->dev.of_node) {
 		int i;
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 1ddd9e2..2443728 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -390,7 +390,8 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	master->set_cs = sun4i_spi_set_cs;
 	master->transfer_one = sun4i_spi_transfer_one;
 	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
+			    SPI_FC_REQUEST | SPI_FC_READY | SPI_FC_STOP_ACK;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 47eff80..3fac4f7 100644
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
@@ -396,6 +398,89 @@ int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
 EXPORT_SYMBOL_GPL(__spi_register_driver);
 
 /*-------------------------------------------------------------------------*/
+/*
+ * SPI flow control
+ */
+int spi_fc_wait_rq(struct spi_device *spi, u32 fc_state)
+{
+	unsigned long timeout = msecs_to_jiffies(20);
+	int fc_enabled;
+	int ret = 1;
+
+	if (spi->mode & fc_state) {
+		fc_enabled = gpiod_get_value(spi->fc_gpio);
+		if (spi->cs_enabled != fc_enabled) {
+			ret = wait_for_completion_io_timeout(&spi->fc_complete,
+						     timeout);
+		}
+		if (!ret)
+			dev_warn(&spi->dev, "FC timeout: requested state: 0x%x\n", fc_state);
+	}
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
+		if (spi->request_cb)
+			spi->request_cb(spi);
+	} else if (spi->mode | SPI_FC_STOP_ACK &&
+			!spi->cs_enabled && !fc_enabled) {
+		complete(&spi->fc_complete);
+	} else if (spi->mode | SPI_FC_READY &&
+			spi->cs_enabled && fc_enabled) {
+		complete(&spi->fc_complete);
+	} else {
+		dev_warn(&spi->dev, "Wrong 5W State. CS:%i, 5W:%i, Mode:0x%x\n",
+			 spi->cs_enabled, fc_enabled, spi->mode);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* spi_fc_probe should be called by spi_device driver. */
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
+	snprintf(spi->fc_irq_name, sizeof(spi->fc_irq_name), "spi-fc-%s",
+		 dev_name(&spi->dev));
+	ret = devm_request_irq(&spi->dev, gpiod_to_irq(spi->fc_gpio),
+			       spi_fc_rq,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			       spi->fc_irq_name, spi);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to request FC IRQ\n");
+                return ret;
+        }
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_fc_probe);
+
+/*-------------------------------------------------------------------------*/
 
 /* SPI devices should normally not be created by SPI device drivers; that
  * would make them board-specific.  Similarly with SPI master drivers.
@@ -687,6 +772,9 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 
 static void spi_set_cs(struct spi_device *spi, bool enable)
 {
+	spi->cs_enabled = enable;
+	reinit_completion(&spi->fc_complete);
+
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
 
@@ -941,9 +1029,15 @@ static int spi_transfer_one_message(struct spi_master *master,
 	unsigned long ms = 1;
 	struct spi_statistics *statm = &master->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
+	struct spi_device *spi = msg->spi;
 
 	spi_set_cs(msg->spi, true);
 
+	if (!spi_fc_wait_rq(spi, SPI_FC_READY)) {
+		ret = -EREMOTEIO;
+		goto out;
+	}
+
 	SPI_STATISTICS_INCREMENT_FIELD(statm, messages);
 	SPI_STATISTICS_INCREMENT_FIELD(stats, messages);
 
@@ -1006,8 +1100,19 @@ static int spi_transfer_one_message(struct spi_master *master,
 				keep_cs = true;
 			} else {
 				spi_set_cs(msg->spi, false);
+
+				if (!spi_fc_wait_rq(spi, SPI_FC_STOP_ACK)) {
+					ret = -EREMOTEIO;
+					break;
+				}
+
 				udelay(10);
 				spi_set_cs(msg->spi, true);
+
+				if (!spi_fc_wait_rq(spi, SPI_FC_READY)) {
+					ret = -EREMOTEIO;
+					break;
+				}
 			}
 		}
 
@@ -1015,8 +1120,12 @@ static int spi_transfer_one_message(struct spi_master *master,
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
@@ -1445,6 +1554,7 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	int rc;
 	u32 value;
 
+	printk("%s:%i\n", __func__, __LINE__);
 	/* Alloc an spi_device */
 	spi = spi_alloc_device(master);
 	if (!spi) {
@@ -1483,6 +1593,14 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
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
 
 	/* Device DUAL/QUAD mode */
 	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 53be3a4..0a24688 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -148,16 +148,52 @@ struct spi_device {
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
+#define SPI_FC_PAUSE	0x1000
+/*
+ * Flow control: ACK End of Data (SPI_FC_STOP_ACK)
+ * Master CS   |______________________/2------|
+ * Slave  FC   |________________________/3----|
+ * DATA        |__________________/1----------|
+ */
+#define SPI_FC_STOP_ACK	0x2000
+/*
+ * Flow control: Request Sequence (SPI_FC_REQUEST)
+ * Master CS   |-------2\_____________________|
+ * Slave  FC   |-----1\_______________________|
+ * DATA        |-----------3\_________________|
+ */
+#define SPI_FC_REQUEST	0x4000
+/* If complete FC is done by HW or controller driver, set this flag */
+#define SPI_FC_HW_ONLY	0x8000
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
@@ -171,6 +207,11 @@ struct spi_device {
 	 *  - chipselect delays
 	 *  - ...
 	 */
+
+	void (*request_cb)(struct spi_device *spi);
+	struct completion	fc_complete;
+	struct gpio_desc	*fc_gpio;	/* request gpio */
+	char			fc_irq_name[32];
 };
 
 static inline struct spi_device *to_spi_device(struct device *dev)
@@ -282,7 +323,6 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 #define module_spi_driver(__spi_driver) \
 	module_driver(__spi_driver, spi_register_driver, \
 			spi_unregister_driver)
-
 /**
  * struct spi_master - interface to SPI master controller
  * @dev: device interface to this driver
@@ -537,6 +577,10 @@ struct spi_master {
 	/* dummy data for full duplex devices */
 	void			*dummy_rx;
 	void			*dummy_tx;
+
+	int	(*wait_for_rq)(struct spi_device *spi);
+#define	B5SPI_RQ_ACTIVE		1	/* normally request line is active low */
+#define	B5SPI_RQ_INACTIVE	0
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
@@ -1146,4 +1190,7 @@ spi_transfer_is_last(struct spi_master *master, struct spi_transfer *xfer)
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
