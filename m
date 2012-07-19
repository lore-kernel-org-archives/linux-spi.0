From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH resend] spi: Add AD-FMCOMMS1-EBZ I2C-SPI bridge driver
Date: Thu, 19 Jul 2012 18:44:07 +0200
Message-ID: <1342716247-28776-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch adds support for the I2C-SPI bridge which can be found on the Analog
Devices AD-FMCOMMS1-EBZ board.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
Just a resend of the patch to Mark as he kindly takes care of the SPI subsystem
while Grant is busy moving.
---
 drivers/spi/Kconfig     |    7 ++
 drivers/spi/Makefile    |    1 +
 drivers/spi/spi-xcomm.c |  276 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+)
 create mode 100644 drivers/spi/spi-xcomm.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 0a72569..12468e5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -384,6 +384,13 @@ config SPI_TXX9
 	help
 	  SPI driver for Toshiba TXx9 MIPS SoCs
 
+config SPI_XCOMM
+	tristate "Analog Devices AD-FMCOMMS1-EBZ SPI-I2C-bridge driver"
+	depends on I2C
+	help
+	  Support for the SPI-I2C bridge found on the Analog Devices
+	  AD-FMCOMMS1-EBZ board.
+
 config SPI_XILINX
 	tristate "Xilinx SPI controller common module"
 	depends on HAS_IOMEM && EXPERIMENTAL
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 9d75d21..273f50d 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -61,5 +61,6 @@ obj-$(CONFIG_SPI_TI_SSP)		+= spi-ti-ssp.o
 obj-$(CONFIG_SPI_TLE62X0)		+= spi-tle62x0.o
 obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
 obj-$(CONFIG_SPI_TXX9)			+= spi-txx9.o
+obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
 obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
 
diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
new file mode 100644
index 0000000..266a847
--- /dev/null
+++ b/drivers/spi/spi-xcomm.c
@@ -0,0 +1,276 @@
+/*
+ * Analog Devices AD-FMCOMMS1-EBZ board I2C-SPI bridge driver
+ *
+ * Copyright 2012 Analog Devices Inc.
+ * Author: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/spi/spi.h>
+#include <asm/unaligned.h>
+
+#define SPI_XCOMM_SETTINGS_LEN_OFFSET		10
+#define SPI_XCOMM_SETTINGS_3WIRE		BIT(6)
+#define SPI_XCOMM_SETTINGS_CS_HIGH		BIT(5)
+#define SPI_XCOMM_SETTINGS_SAMPLE_END		BIT(4)
+#define SPI_XCOMM_SETTINGS_CPHA			BIT(3)
+#define SPI_XCOMM_SETTINGS_CPOL			BIT(2)
+#define SPI_XCOMM_SETTINGS_CLOCK_DIV_MASK	0x3
+#define SPI_XCOMM_SETTINGS_CLOCK_DIV_64		0x2
+#define SPI_XCOMM_SETTINGS_CLOCK_DIV_16		0x1
+#define SPI_XCOMM_SETTINGS_CLOCK_DIV_4		0x0
+
+#define SPI_XCOMM_CMD_UPDATE_CONFIG	0x03
+#define SPI_XCOMM_CMD_WRITE		0x04
+
+#define SPI_XCOMM_CLOCK 48000000
+
+struct spi_xcomm {
+	struct i2c_client *i2c;
+
+	uint16_t settings;
+	uint16_t chipselect;
+
+	unsigned int current_speed;
+
+	uint8_t buf[63];
+};
+
+static int spi_xcomm_sync_config(struct spi_xcomm *spi_xcomm, unsigned int len)
+{
+	uint16_t settings;
+	uint8_t *buf = spi_xcomm->buf;
+
+	settings = spi_xcomm->settings;
+	settings |= len << SPI_XCOMM_SETTINGS_LEN_OFFSET;
+
+	buf[0] = SPI_XCOMM_CMD_UPDATE_CONFIG;
+	put_unaligned_be16(settings, &buf[1]);
+	put_unaligned_be16(spi_xcomm->chipselect, &buf[3]);
+
+	return i2c_master_send(spi_xcomm->i2c, buf, 5);
+}
+
+static void spi_xcomm_chipselect(struct spi_xcomm *spi_xcomm,
+	struct spi_device *spi, int is_active)
+{
+	unsigned long cs = spi->chip_select;
+	uint16_t chipselect = spi_xcomm->chipselect;
+
+	if (is_active)
+		chipselect |= BIT(cs);
+	else
+		chipselect &= ~BIT(cs);
+
+	spi_xcomm->chipselect = chipselect;
+}
+
+static int spi_xcomm_setup_transfer(struct spi_xcomm *spi_xcomm,
+	struct spi_device *spi, struct spi_transfer *t, unsigned int *settings)
+{
+	unsigned int speed;
+
+	if ((t->bits_per_word && t->bits_per_word != 8) || t->len > 62)
+		return -EINVAL;
+
+	speed = t->speed_hz ? t->speed_hz : spi->max_speed_hz;
+
+	if (speed != spi_xcomm->current_speed) {
+		unsigned int divider = DIV_ROUND_UP(SPI_XCOMM_CLOCK, speed);
+		if (divider >= 64)
+			*settings |= SPI_XCOMM_SETTINGS_CLOCK_DIV_64;
+		else if (divider >= 16)
+			*settings |= SPI_XCOMM_SETTINGS_CLOCK_DIV_16;
+		else
+			*settings |= SPI_XCOMM_SETTINGS_CLOCK_DIV_4;
+
+		spi_xcomm->current_speed = speed;
+	}
+
+	if (spi->mode & SPI_CPOL)
+		*settings |= SPI_XCOMM_SETTINGS_CPOL;
+	else
+		*settings &= ~SPI_XCOMM_SETTINGS_CPOL;
+
+	if (spi->mode & SPI_CPHA)
+		*settings &= ~SPI_XCOMM_SETTINGS_CPHA;
+	else
+		*settings |= SPI_XCOMM_SETTINGS_CPHA;
+
+	if (spi->mode & SPI_3WIRE)
+		*settings |= SPI_XCOMM_SETTINGS_3WIRE;
+	else
+		*settings &= ~SPI_XCOMM_SETTINGS_3WIRE;
+
+	return 0;
+}
+
+static int spi_xcomm_txrx_bufs(struct spi_xcomm *spi_xcomm,
+	struct spi_device *spi, struct spi_transfer *t)
+{
+	int ret;
+
+	if (t->tx_buf) {
+		spi_xcomm->buf[0] = SPI_XCOMM_CMD_WRITE;
+		memcpy(spi_xcomm->buf + 1, t->tx_buf, t->len);
+
+		ret = i2c_master_send(spi_xcomm->i2c, spi_xcomm->buf, t->len + 1);
+		if (ret < 0)
+			return ret;
+		else if (ret != t->len + 1)
+			return -EIO;
+	} else if (t->rx_buf) {
+		ret = i2c_master_recv(spi_xcomm->i2c, t->rx_buf, t->len);
+		if (ret < 0)
+			return ret;
+		else if (ret != t->len)
+			return -EIO;
+	}
+
+	return t->len;
+}
+
+static int spi_xcomm_transfer_one(struct spi_master *master,
+	struct spi_message *msg)
+{
+	struct spi_xcomm *spi_xcomm = spi_master_get_devdata(master);
+	unsigned int settings = spi_xcomm->settings;
+	struct spi_device *spi = msg->spi;
+	unsigned cs_change = 0;
+	struct spi_transfer *t;
+	bool is_first = true;
+	int status = 0;
+	bool is_last;
+
+	is_first = true;
+
+	spi_xcomm_chipselect(spi_xcomm, spi, true);
+
+	list_for_each_entry(t, &msg->transfers, transfer_list) {
+
+		if (!t->tx_buf && !t->rx_buf && t->len) {
+			status = -EINVAL;
+			break;
+		}
+
+		status = spi_xcomm_setup_transfer(spi_xcomm, spi, t, &settings);
+		if (status < 0)
+			break;
+
+		is_last = list_is_last(&t->transfer_list, &msg->transfers);
+		cs_change = t->cs_change;
+
+		if (cs_change ^ is_last)
+			settings |= BIT(5);
+		else
+			settings &= ~BIT(5);
+
+		if (t->rx_buf) {
+			spi_xcomm->settings = settings;
+			status = spi_xcomm_sync_config(spi_xcomm, t->len);
+			if (status < 0)
+				break;
+		} else if (settings != spi_xcomm->settings || is_first) {
+			spi_xcomm->settings = settings;
+			status = spi_xcomm_sync_config(spi_xcomm, 0);
+			if (status < 0)
+				break;
+		}
+
+		if (t->len) {
+			status = spi_xcomm_txrx_bufs(spi_xcomm, spi, t);
+
+			if (status < 0)
+				break;
+
+			if (status > 0)
+				msg->actual_length += status;
+		}
+		status = 0;
+
+		if (t->delay_usecs)
+			udelay(t->delay_usecs);
+
+		is_first = false;
+	}
+
+	if (status != 0 || !cs_change)
+		spi_xcomm_chipselect(spi_xcomm, spi, false);
+
+	msg->status = status;
+	spi_finalize_current_message(master);
+
+	return status;
+}
+
+static int spi_xcomm_setup(struct spi_device *spi)
+{
+	if (spi->bits_per_word != 8)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __devinit spi_xcomm_probe(struct i2c_client *i2c,
+	const struct i2c_device_id *id)
+{
+	struct spi_xcomm *spi_xcomm;
+	struct spi_master *master;
+	int ret;
+
+	master = spi_alloc_master(&i2c->dev, sizeof(*spi_xcomm));
+	if (!master)
+		return -ENOMEM;
+
+	spi_xcomm = spi_master_get_devdata(master);
+	spi_xcomm->i2c = i2c;
+
+	master->num_chipselect = 16;
+	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_3WIRE;
+	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->setup = spi_xcomm_setup;
+	master->transfer_one_message = spi_xcomm_transfer_one;
+	master->dev.of_node = i2c->dev.of_node;
+	i2c_set_clientdata(i2c, master);
+
+	ret = spi_register_master(master);
+	if (ret < 0)
+		spi_master_put(master);
+
+	return ret;
+}
+
+static int __devexit spi_xcomm_remove(struct i2c_client *i2c)
+{
+	struct spi_master *master = i2c_get_clientdata(i2c);
+
+	spi_unregister_master(master);
+
+	return 0;
+}
+
+static const struct i2c_device_id spi_xcomm_ids[] = {
+	{ "spi-xcomm" },
+	{ },
+};
+
+static struct i2c_driver spi_xcomm_driver = {
+	.driver = {
+		.name	= "spi-xcomm",
+		.owner	= THIS_MODULE,
+	},
+	.id_table	= spi_xcomm_ids,
+	.probe		= spi_xcomm_probe,
+	.remove		= __devexit_p(spi_xcomm_remove),
+};
+module_i2c_driver(spi_xcomm_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>");
+MODULE_DESCRIPTION("Analog Devices AD-FMCOMMS1-EBZ board I2C-SPI bridge driver");
-- 
1.7.10.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
