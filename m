From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v2 09/10] mtd: spi-nor: add DDR quad read support for Micron
Date: Mon, 28 Apr 2014 11:53:46 +0800
Message-ID: <1398657227-20721-10-git-send-email-b32955@freescale.com>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <marex-ynQEQJNshbs@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398657227-20721-1-git-send-email-b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch adds the DDR(or DTR) quad read support for the Micron
SPI NOR flash.

Tested with n25q256a.

Signed-off-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/mtd/spi-nor/spi-nor.c |    5 +++++
 include/linux/mtd/spi-nor.h   |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 07d249c..c5ea969 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -873,6 +873,9 @@ static int set_ddr_quad_mode(struct spi_nor *nor, u32 jedec_id)
 			return status;
 		}
 		return status;
+	case CFI_MFR_ST: /* Micron, actually */
+		/* DTR quad read works with the Extended SPI protocol. */
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -1072,6 +1075,8 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 	case SPI_NOR_DDR_QUAD:
 		if (JEDEC_MFR(info->jedec_id) == CFI_MFR_AMD) { /* Spansion */
 			nor->read_opcode = SPINOR_OP_READ_1_4_4_D;
+		} else if (JEDEC_MFR(info->jedec_id) == CFI_MFR_ST) {
+			nor->read_opcode = SPINOR_OP_READ_1_1_4_D;
 		} else {
 			dev_err(dev, "DDR Quad Read is not supported.\n");
 			return -EINVAL;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index d191a6b..2fb40b6 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -27,6 +27,7 @@
 #define SPINOR_OP_READ_FAST	0x0b	/* Read data bytes (high frequency) */
 #define SPINOR_OP_READ_1_1_2	0x3b	/* Read data bytes (Dual SPI) */
 #define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad SPI) */
+#define SPINOR_OP_READ_1_1_4_D	0x6d	/* Read data bytes (DDR Quad SPI) */
 #define SPINOR_OP_READ_1_4_4_D	0xed	/* Read data bytes (DDR Quad SPI) */
 #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_BE_4K		0x20	/* Erase 4KiB block */
-- 
1.7.2.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
