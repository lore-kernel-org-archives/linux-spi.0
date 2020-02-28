From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: HiSilicon v3xx: Properly set CMD_CONFIG for Dual/Quad modes" to the spi tree
Date: Fri, 28 Feb 2020 18:25:33 +0000
Message-ID: <applied-1582903131-160033-3-git-send-email-john.garry@huawei.com>
References: <1582903131-160033-3-git-send-email-john.garry@huawei.com>
Cc: andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1582903131-160033-3-git-send-email-john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: HiSilicon v3xx: Properly set CMD_CONFIG for Dual/Quad modes

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8fe21d6b347247227c349c9b2f7c462fae362af4 Mon Sep 17 00:00:00 2001
From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Date: Fri, 28 Feb 2020 23:18:50 +0800
Subject: [PATCH] spi: HiSilicon v3xx: Properly set CMD_CONFIG for Dual/Quad
 modes

The CMD_CONFIG register memory interface type field is not set configured
for Dual and Quad modes, so set appropriately.

This was not detected previously as we only ever operated in standard SPI
mode.

Signed-off-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Link: https://lore.kernel.org/r/1582903131-160033-3-git-send-email-john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 4cf8fc80a7b7..45d906110ed1 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -17,6 +17,12 @@
 #define HISI_SFC_V3XX_VERSION (0x1f8)
 
 #define HISI_SFC_V3XX_CMD_CFG (0x300)
+#define HISI_SFC_V3XX_CMD_CFG_DUAL_IN_DUAL_OUT (1 << 17)
+#define HISI_SFC_V3XX_CMD_CFG_DUAL_IO (2 << 17)
+#define HISI_SFC_V3XX_CMD_CFG_FULL_DIO (3 << 17)
+#define HISI_SFC_V3XX_CMD_CFG_QUAD_IN_QUAD_OUT (5 << 17)
+#define HISI_SFC_V3XX_CMD_CFG_QUAD_IO (6 << 17)
+#define HISI_SFC_V3XX_CMD_CFG_FULL_QIO (7 << 17)
 #define HISI_SFC_V3XX_CMD_CFG_DATA_CNT_OFF 9
 #define HISI_SFC_V3XX_CMD_CFG_RW_MSK BIT(8)
 #define HISI_SFC_V3XX_CMD_CFG_DATA_EN_MSK BIT(7)
@@ -161,6 +167,43 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
 	if (op->addr.nbytes)
 		config |= HISI_SFC_V3XX_CMD_CFG_ADDR_EN_MSK;
 
+	switch (op->data.buswidth) {
+	case 0 ... 1:
+		break;
+	case 2:
+		if (op->addr.buswidth <= 1) {
+			config |= HISI_SFC_V3XX_CMD_CFG_DUAL_IN_DUAL_OUT;
+		} else if (op->addr.buswidth == 2) {
+			if (op->cmd.buswidth <= 1) {
+				config |= HISI_SFC_V3XX_CMD_CFG_DUAL_IO;
+			} else if (op->cmd.buswidth == 2) {
+				config |= HISI_SFC_V3XX_CMD_CFG_FULL_DIO;
+			} else {
+				return -EIO;
+			}
+		} else {
+			return -EIO;
+		}
+		break;
+	case 4:
+		if (op->addr.buswidth <= 1) {
+			config |= HISI_SFC_V3XX_CMD_CFG_QUAD_IN_QUAD_OUT;
+		} else if (op->addr.buswidth == 4) {
+			if (op->cmd.buswidth <= 1) {
+				config |= HISI_SFC_V3XX_CMD_CFG_QUAD_IO;
+			} else if (op->cmd.buswidth == 4) {
+				config |= HISI_SFC_V3XX_CMD_CFG_FULL_QIO;
+			} else {
+				return -EIO;
+			}
+		} else {
+			return -EIO;
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
 	if (op->data.dir != SPI_MEM_NO_DATA) {
 		config |= (len - 1) << HISI_SFC_V3XX_CMD_CFG_DATA_CNT_OFF;
 		config |= HISI_SFC_V3XX_CMD_CFG_DATA_EN_MSK;
-- 
2.20.1
