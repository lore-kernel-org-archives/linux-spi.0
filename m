From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/9] mtd: spi-nor: drop \t after #define
Date: Wed,  9 Apr 2014 10:32:46 -0700
Message-ID: <1397064774-31784-1-git-send-email-computersforpeace@gmail.com>
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
To: <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Spacing is a little non-standard here.

Signed-off-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Series based on l2-mtd.git/spinor:

  http://git.infradead.org/l2-mtd.git

 include/linux/mtd/spi-nor.h | 68 ++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 41dae78fbd1d..558097e14932 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -2,50 +2,50 @@
 #define __LINUX_MTD_SPI_NOR_H
 
 /* Flash opcodes. */
-#define	OPCODE_WREN		0x06	/* Write enable */
-#define	OPCODE_RDSR		0x05	/* Read status register */
-#define	OPCODE_WRSR		0x01	/* Write status register 1 byte */
-#define	OPCODE_NORM_READ	0x03	/* Read data bytes (low frequency) */
-#define	OPCODE_FAST_READ	0x0b	/* Read data bytes (high frequency) */
-#define	OPCODE_DUAL_READ        0x3b    /* Read data bytes (Dual SPI) */
-#define	OPCODE_QUAD_READ        0x6b    /* Read data bytes (Quad SPI) */
-#define	OPCODE_PP		0x02	/* Page program (up to 256 bytes) */
-#define	OPCODE_BE_4K		0x20	/* Erase 4KiB block */
-#define	OPCODE_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
-#define	OPCODE_BE_32K		0x52	/* Erase 32KiB block */
-#define	OPCODE_CHIP_ERASE	0xc7	/* Erase whole flash chip */
-#define	OPCODE_SE		0xd8	/* Sector erase (usually 64KiB) */
-#define	OPCODE_RDID		0x9f	/* Read JEDEC ID */
-#define	OPCODE_RDCR             0x35    /* Read configuration register */
+#define OPCODE_WREN		0x06	/* Write enable */
+#define OPCODE_RDSR		0x05	/* Read status register */
+#define OPCODE_WRSR		0x01	/* Write status register 1 byte */
+#define OPCODE_NORM_READ	0x03	/* Read data bytes (low frequency) */
+#define OPCODE_FAST_READ	0x0b	/* Read data bytes (high frequency) */
+#define OPCODE_DUAL_READ        0x3b    /* Read data bytes (Dual SPI) */
+#define OPCODE_QUAD_READ        0x6b    /* Read data bytes (Quad SPI) */
+#define OPCODE_PP		0x02	/* Page program (up to 256 bytes) */
+#define OPCODE_BE_4K		0x20	/* Erase 4KiB block */
+#define OPCODE_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
+#define OPCODE_BE_32K		0x52	/* Erase 32KiB block */
+#define OPCODE_CHIP_ERASE	0xc7	/* Erase whole flash chip */
+#define OPCODE_SE		0xd8	/* Sector erase (usually 64KiB) */
+#define OPCODE_RDID		0x9f	/* Read JEDEC ID */
+#define OPCODE_RDCR             0x35    /* Read configuration register */
 
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
-#define	OPCODE_NORM_READ_4B	0x13	/* Read data bytes (low frequency) */
-#define	OPCODE_FAST_READ_4B	0x0c	/* Read data bytes (high frequency) */
-#define	OPCODE_DUAL_READ_4B	0x3c    /* Read data bytes (Dual SPI) */
-#define	OPCODE_QUAD_READ_4B	0x6c    /* Read data bytes (Quad SPI) */
-#define	OPCODE_PP_4B		0x12	/* Page program (up to 256 bytes) */
-#define	OPCODE_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
+#define OPCODE_NORM_READ_4B	0x13	/* Read data bytes (low frequency) */
+#define OPCODE_FAST_READ_4B	0x0c	/* Read data bytes (high frequency) */
+#define OPCODE_DUAL_READ_4B	0x3c    /* Read data bytes (Dual SPI) */
+#define OPCODE_QUAD_READ_4B	0x6c    /* Read data bytes (Quad SPI) */
+#define OPCODE_PP_4B		0x12	/* Page program (up to 256 bytes) */
+#define OPCODE_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
 
 /* Used for SST flashes only. */
-#define	OPCODE_BP		0x02	/* Byte program */
-#define	OPCODE_WRDI		0x04	/* Write disable */
-#define	OPCODE_AAI_WP		0xad	/* Auto address increment word program */
+#define OPCODE_BP		0x02	/* Byte program */
+#define OPCODE_WRDI		0x04	/* Write disable */
+#define OPCODE_AAI_WP		0xad	/* Auto address increment word program */
 
 /* Used for Macronix and Winbond flashes. */
-#define	OPCODE_EN4B		0xb7	/* Enter 4-byte mode */
-#define	OPCODE_EX4B		0xe9	/* Exit 4-byte mode */
+#define OPCODE_EN4B		0xb7	/* Enter 4-byte mode */
+#define OPCODE_EX4B		0xe9	/* Exit 4-byte mode */
 
 /* Used for Spansion flashes only. */
-#define	OPCODE_BRWR		0x17	/* Bank register write */
+#define OPCODE_BRWR		0x17	/* Bank register write */
 
 /* Status Register bits. */
-#define	SR_WIP			1	/* Write in progress */
-#define	SR_WEL			2	/* Write enable latch */
+#define SR_WIP			1	/* Write in progress */
+#define SR_WEL			2	/* Write enable latch */
 /* meaning of other SR_* bits may differ between vendors */
-#define	SR_BP0			4	/* Block protect 0 */
-#define	SR_BP1			8	/* Block protect 1 */
-#define	SR_BP2			0x10	/* Block protect 2 */
-#define	SR_SRWD			0x80	/* SR write protect */
+#define SR_BP0			4	/* Block protect 0 */
+#define SR_BP1			8	/* Block protect 1 */
+#define SR_BP2			0x10	/* Block protect 2 */
+#define SR_SRWD			0x80	/* SR write protect */
 
 #define SR_QUAD_EN_MX           0x40    /* Macronix Quad I/O */
 
@@ -86,7 +86,7 @@ struct spi_nor_xfer_cfg {
 	u8		dummy_cycles;
 };
 
-#define	SPI_NOR_MAX_CMD_SIZE	8
+#define SPI_NOR_MAX_CMD_SIZE	8
 enum spi_nor_ops {
 	SPI_NOR_OPS_READ = 0,
 	SPI_NOR_OPS_WRITE,
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
