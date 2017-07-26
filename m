From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH] spi: bcm-qspi: Remove hardcoded settings and spi-nor.h dependency
Date: Wed, 26 Jul 2017 19:20:15 -0400
Message-ID: <1501111215-2654-1-git-send-email-kdasu.kdev@gmail.com>
Cc: geert+renesas@glider.be, hauke@hauke-m.de, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>
To: broonie@kernel.org, rnd@arndb.de, cyrille.pitchen@atmel.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The newly added broadcom qspi driver in drivers/spi produces a build
warning when CONFIG_MTD is disabled:
include/linux/mtd/cfi.h:76:2: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]

There has been discussion on this in the link provided below. This fix in
SPI controller drivers implementing the ->spi_flash_read handler, now uses the
settings provided inside the 'struct spi_flash_read_message' parameter instead
of hardcoding them. Made changes to bcm_qspi_bspi_set_flex_mode() to set the BSPI
controller using the passed msg structure and remove the need to include
<linux/mtd/spi-nor.h> file by removing all use of SPINOR_OP_READ* macros.

Fixes: 4e3b2d236fe0 ("spi: bcm-qspi: Add BSPI spi-nor flash controller driver")
Link: https://patchwork.kernel.org/patch/9624585/
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 89 +++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 56 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index b19722b..6ef6c44 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -25,7 +25,6 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/mtd/spi-nor.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
@@ -349,76 +348,60 @@ static void bcm_qspi_bspi_set_xfer_params(struct bcm_qspi *qspi, u8 cmd_byte,
 	bcm_qspi_write(qspi, BSPI, BSPI_FLEX_MODE_ENABLE, flex_mode);
 }
 
-static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi, int width,
-				       int addrlen, int hp)
+static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi,
+				       struct spi_flash_read_message *msg,
+				       int hp)
 {
 	int bpc = 0, bpp = 0;
-	u8 command = SPINOR_OP_READ_FAST;
-	int flex_mode = 1, rv = 0;
-	bool spans_4byte = false;
+	u8 command = msg->read_opcode;
+	int width  = msg->data_nbits ? msg->data_nbits : SPI_NBITS_SINGLE;
+	int addrlen = msg->addr_width;
+	int addr_nbits = msg->addr_nbits ? msg->addr_nbits : SPI_NBITS_SINGLE;
+	int flex_mode = 1;
 
 	dev_dbg(&qspi->pdev->dev, "set flex mode w %x addrlen %x hp %d\n",
 		width, addrlen, hp);
 
-	if (addrlen == BSPI_ADDRLEN_4BYTES) {
+	if (addrlen == BSPI_ADDRLEN_4BYTES)
 		bpp = BSPI_BPP_ADDR_SELECT_MASK;
-		spans_4byte = true;
-	}
 
-	bpp |= 8;
+	bpp |= msg->dummy_bytes * (8/addr_nbits);
 
 	switch (width) {
 	case SPI_NBITS_SINGLE:
 		if (addrlen == BSPI_ADDRLEN_3BYTES)
 			/* default mode, does not need flex_cmd */
 			flex_mode = 0;
-		else
-			command = SPINOR_OP_READ_FAST_4B;
 		break;
 	case SPI_NBITS_DUAL:
 		bpc = 0x00000001;
 		if (hp) {
 			bpc |= 0x00010100; /* address and mode are 2-bit */
 			bpp = BSPI_BPP_MODE_SELECT_MASK;
-			command = OPCODE_DIOR;
-			if (spans_4byte)
-				command = OPCODE_DIOR_4B;
-		} else {
-			command = SPINOR_OP_READ_1_1_2;
-			if (spans_4byte)
-				command = SPINOR_OP_READ_1_1_2_4B;
 		}
 		break;
 	case SPI_NBITS_QUAD:
 		bpc = 0x00000002;
 		if (hp) {
 			bpc |= 0x00020200; /* address and mode are 4-bit */
-			bpp = 4; /* dummy cycles */
-			bpp |= BSPI_BPP_ADDR_SELECT_MASK;
-			command = OPCODE_QIOR;
-			if (spans_4byte)
-				command = OPCODE_QIOR_4B;
-		} else {
-			command = SPINOR_OP_READ_1_1_4;
-			if (spans_4byte)
-				command = SPINOR_OP_READ_1_1_4_4B;
+			bpp |= BSPI_BPP_MODE_SELECT_MASK;
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
+	bcm_qspi_bspi_set_xfer_params(qspi, command, bpp, bpc, flex_mode);
 
-	return rv;
+	return 0;
 }
 
-static int bcm_qspi_bspi_set_override(struct bcm_qspi *qspi, int width,
-				      int addrlen, int hp)
+static int bcm_qspi_bspi_set_override(struct bcm_qspi *qspi,
+				      struct spi_flash_read_message *msg,
+				      int hp)
 {
+	int width = msg->data_nbits ? msg->data_nbits : SPI_NBITS_SINGLE;
+	int addrlen = msg->addr_width;
 	u32 data = bcm_qspi_read(qspi, BSPI, BSPI_STRAP_OVERRIDE_CTRL);
 
 	dev_dbg(&qspi->pdev->dev, "set override mode w %x addrlen %x hp %d\n",
@@ -430,7 +413,6 @@ static int bcm_qspi_bspi_set_override(struct bcm_qspi *qspi, int width,
 		data &= ~(BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD |
 			  BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL);
 		break;
-
 	case SPI_NBITS_QUAD:
 		/* clear dual mode and set quad mode */
 		data &= ~BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL;
@@ -455,15 +437,17 @@ static int bcm_qspi_bspi_set_override(struct bcm_qspi *qspi, int width,
 	/* set the override mode */
 	data |=	BSPI_STRAP_OVERRIDE_CTRL_OVERRIDE;
 	bcm_qspi_write(qspi, BSPI, BSPI_STRAP_OVERRIDE_CTRL, data);
-	bcm_qspi_bspi_set_xfer_params(qspi, SPINOR_OP_READ_FAST, 0, 0, 0);
+	bcm_qspi_bspi_set_xfer_params(qspi, msg->read_opcode, 0, 0, 0);
 
 	return 0;
 }
 
 static int bcm_qspi_bspi_set_mode(struct bcm_qspi *qspi,
-				  int width, int addrlen, int hp)
+				  struct spi_flash_read_message *msg, int hp)
 {
 	int error = 0;
+	int width = msg->data_nbits ? msg->data_nbits : SPI_NBITS_SINGLE;
+	int addrlen = msg->addr_width;
 
 	/* default mode */
 	qspi->xfer_mode.flex_mode = true;
@@ -475,23 +459,13 @@ static int bcm_qspi_bspi_set_mode(struct bcm_qspi *qspi,
 		mask = BSPI_STRAP_OVERRIDE_CTRL_OVERRIDE;
 		if (val & mask || qspi->s3_strap_override_ctrl & mask) {
 			qspi->xfer_mode.flex_mode = false;
-			bcm_qspi_write(qspi, BSPI, BSPI_FLEX_MODE_ENABLE,
-				       0);
-
-			if ((val | qspi->s3_strap_override_ctrl) &
-			    BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL)
-				width = SPI_NBITS_DUAL;
-			else if ((val |  qspi->s3_strap_override_ctrl) &
-				 BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD)
-				width = SPI_NBITS_QUAD;
-
-			error = bcm_qspi_bspi_set_override(qspi, width, addrlen,
-							   hp);
+			bcm_qspi_write(qspi, BSPI, BSPI_FLEX_MODE_ENABLE, 0);
+			error = bcm_qspi_bspi_set_override(qspi, msg, hp);
 		}
 	}
 
 	if (qspi->xfer_mode.flex_mode)
-		error = bcm_qspi_bspi_set_flex_mode(qspi, width, addrlen, hp);
+		error = bcm_qspi_bspi_set_flex_mode(qspi, msg, hp);
 
 	if (error) {
 		dev_warn(&qspi->pdev->dev,
@@ -981,7 +955,7 @@ static int bcm_qspi_flash_read(struct spi_device *spi,
 	struct bcm_qspi *qspi = spi_master_get_devdata(spi->master);
 	int ret = 0;
 	bool mspi_read = false;
-	u32 io_width, addrlen, addr, len;
+	u32 addr, len;
 	u_char *buf;
 
 	buf = msg->buf;
@@ -1010,9 +984,7 @@ static int bcm_qspi_flash_read(struct spi_device *spi,
 	if (mspi_read)
 		return bcm_qspi_mspi_flash_read(spi, msg);
 
-	io_width = msg->data_nbits ? msg->data_nbits : SPI_NBITS_SINGLE;
-	addrlen = msg->addr_width;
-	ret = bcm_qspi_bspi_set_mode(qspi, io_width, addrlen, -1);
+	ret = bcm_qspi_bspi_set_mode(qspi, msg, -1);
 
 	if (!ret)
 		ret = bcm_qspi_bspi_flash_read(spi, msg);
@@ -1422,6 +1394,11 @@ static int __maybe_unused bcm_qspi_suspend(struct device *dev)
 {
 	struct bcm_qspi *qspi = dev_get_drvdata(dev);
 
+	/* store the override strap value */
+	if (!bcm_qspi_bspi_ver_three(qspi))
+		qspi->s3_strap_override_ctrl =
+			bcm_qspi_read(qspi, BSPI, BSPI_STRAP_OVERRIDE_CTRL);
+
 	spi_master_suspend(qspi->master);
 	clk_disable(qspi->clk);
 	bcm_qspi_hw_uninit(qspi);
-- 
1.9.0.138.g2de3478
