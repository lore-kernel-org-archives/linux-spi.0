From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] spi: document broadcom qspi driver as broken
Date: Sat, 22 Jul 2017 00:00:20 +0200
Message-ID: <20170721220142.3400093-1-arnd@arndb.de>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The newly broadcom qspi driver in drivers/spi produces a build
warning when CONFIG_MTD is disabled:

include/linux/mtd/cfi.h:76:2: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]

I had suggested a workaround earlier, but Cyrille Pitchen explained
that actually the broadcom qspi is broken here and needs to be
fixed, see the lenghthy reply in patchwork.

As nothing has happened on that driver, this tries to at least
avoid the build failure, by marking the driver as broken unless
CONFIG_MTD is enabled. Also, I add a WARN_ON_ONCE runtime
that triggers when the spi-nor framework and the driver disagree
about the command opcode, which was one of several issues that
Cyrille pointed out.

My patch does not attempt to fix any of the actual bugs though,
it just tries to avoid the build error while highlighting the
problems. Ideally, someone would step up to create a tested
fix. If that doesn't happen, please merge my version instead
as a workaround.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Link: https://patchwork.kernel.org/patch/9334097/
Link: https://patchwork.kernel.org/patch/9624585/
Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
---
 drivers/spi/Kconfig        |  1 +
 drivers/spi/spi-bcm-qspi.c | 23 ++++++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9b31351fe429..c7a80f9d6dd0 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -164,6 +164,7 @@ config SPI_BCM_QSPI
 	tristate "Broadcom BSPI and MSPI controller support"
 	depends on ARCH_BRCMSTB || ARCH_BCM || ARCH_BCM_IPROC || \
 			BMIPS_GENERIC || COMPILE_TEST
+	depends on BROKEN || MTD
 	default ARCH_BCM_IPROC
 	help
 	  Enables support for the Broadcom SPI flash and MSPI controller.
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index b19722ba908c..a388a3873552 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -349,12 +349,13 @@ static void bcm_qspi_bspi_set_xfer_params(struct bcm_qspi *qspi, u8 cmd_byte,
 	bcm_qspi_write(qspi, BSPI, BSPI_FLEX_MODE_ENABLE, flex_mode);
 }
 
-static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi, int width,
-				       int addrlen, int hp)
+static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi,
+				       struct spi_flash_read_message *msg,
+				       int width, int addrlen, int hp)
 {
 	int bpc = 0, bpp = 0;
 	u8 command = SPINOR_OP_READ_FAST;
-	int flex_mode = 1, rv = 0;
+	int flex_mode = 1;
 	bool spans_4byte = false;
 
 	dev_dbg(&qspi->pdev->dev, "set flex mode w %x addrlen %x hp %d\n",
@@ -405,15 +406,14 @@ static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi, int width,
 		}
 		break;
 	default:
-		rv = -EINVAL;
-		break;
+		return -EINVAL;
 	}
 
-	if (rv == 0)
-		bcm_qspi_bspi_set_xfer_params(qspi, command, bpp, bpc,
-					      flex_mode);
+	WARN_ON_ONCE(command != msg->read_opcode);
 
-	return rv;
+	bcm_qspi_bspi_set_xfer_params(qspi, command, bpp, bpc,
+					      flex_mode);
+	return 0;
 }
 
 static int bcm_qspi_bspi_set_override(struct bcm_qspi *qspi, int width,
@@ -461,6 +461,7 @@ static int bcm_qspi_bspi_set_override(struct bcm_qspi *qspi, int width,
 }
 
 static int bcm_qspi_bspi_set_mode(struct bcm_qspi *qspi,
+				  struct spi_flash_read_message *msg,
 				  int width, int addrlen, int hp)
 {
 	int error = 0;
@@ -491,7 +492,7 @@ static int bcm_qspi_bspi_set_mode(struct bcm_qspi *qspi,
 	}
 
 	if (qspi->xfer_mode.flex_mode)
-		error = bcm_qspi_bspi_set_flex_mode(qspi, width, addrlen, hp);
+		error = bcm_qspi_bspi_set_flex_mode(qspi, msg, width, addrlen, hp);
 
 	if (error) {
 		dev_warn(&qspi->pdev->dev,
@@ -1012,7 +1013,7 @@ static int bcm_qspi_flash_read(struct spi_device *spi,
 
 	io_width = msg->data_nbits ? msg->data_nbits : SPI_NBITS_SINGLE;
 	addrlen = msg->addr_width;
-	ret = bcm_qspi_bspi_set_mode(qspi, io_width, addrlen, -1);
+	ret = bcm_qspi_bspi_set_mode(qspi, msg, io_width, addrlen, -1);
 
 	if (!ret)
 		ret = bcm_qspi_bspi_flash_read(spi, msg);
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
