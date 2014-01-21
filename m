From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/4] mtd: m25p80: Add dual read support
Date: Tue, 21 Jan 2014 13:59:18 +0100
Message-ID: <1390309159-19643-4-git-send-email-geert@linux-m68k.org>
References: <1390309159-19643-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex@denx.de>, Sourav Poddar <sourav.poddar@ti.com>,
 linux-mtd@lists.infradead.org,
 Geert Uytterhoeven <geert+renesas@linux-m68k.org>, linux-spi@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1390309159-19643-1-git-send-email-geert@linux-m68k.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add support for Dual SPI read transfers, which is supported by some
Spansion SPI FLASHes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/mtd/devices/m25p80.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index ad1913909702..73bf661100f7 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -41,7 +41,8 @@
 #define	OPCODE_WRSR		0x01	/* Write status register 1 byte */
 #define	OPCODE_NORM_READ	0x03	/* Read data bytes (low frequency) */
 #define	OPCODE_FAST_READ	0x0b	/* Read data bytes (high frequency) */
-#define	OPCODE_QUAD_READ        0x6b    /* Read data bytes */
+#define	OPCODE_DUAL_READ        0x3b    /* Read data bytes (Dual SPI) */
+#define	OPCODE_QUAD_READ        0x6b    /* Read data bytes (Quad SPI) */
 #define	OPCODE_PP		0x02	/* Page program (up to 256 bytes) */
 #define	OPCODE_BE_4K		0x20	/* Erase 4KiB block */
 #define	OPCODE_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
@@ -54,7 +55,8 @@
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
 #define	OPCODE_NORM_READ_4B	0x13	/* Read data bytes (low frequency) */
 #define	OPCODE_FAST_READ_4B	0x0c	/* Read data bytes (high frequency) */
-#define	OPCODE_QUAD_READ_4B	0x6c    /* Read data bytes */
+#define	OPCODE_DUAL_READ_4B	0x3c    /* Read data bytes (Dual SPI) */
+#define	OPCODE_QUAD_READ_4B	0x6c    /* Read data bytes (Quad SPI) */
 #define	OPCODE_PP_4B		0x12	/* Page program (up to 256 bytes) */
 #define	OPCODE_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
 
@@ -95,6 +97,7 @@
 enum read_type {
 	M25P80_NORMAL = 0,
 	M25P80_FAST,
+	M25P80_DUAL,
 	M25P80_QUAD,
 };
 
@@ -479,6 +482,7 @@ static inline int m25p80_dummy_cycles_read(struct m25p *flash)
 {
 	switch (flash->flash_read) {
 	case M25P80_FAST:
+	case M25P80_DUAL:
 	case M25P80_QUAD:
 		return 1;
 	case M25P80_NORMAL:
@@ -492,6 +496,8 @@ static inline int m25p80_dummy_cycles_read(struct m25p *flash)
 static inline unsigned int m25p80_rx_nbits(const struct m25p *flash)
 {
 	switch (flash->flash_read) {
+	case M25P80_DUAL:
+		return 2;
 	case M25P80_QUAD:
 		return 4;
 	default:
@@ -855,7 +861,8 @@ struct flash_info {
 #define	SST_WRITE	0x04		/* use SST byte programming */
 #define	M25P_NO_FR	0x08		/* Can't do fastread */
 #define	SECT_4K_PMC	0x10		/* OPCODE_BE_4K_PMC works uniformly */
-#define	M25P80_QUAD_READ	0x20    /* Flash supports Quad Read */
+#define	M25P80_DUAL_READ	0x20    /* Flash supports Dual Read */
+#define	M25P80_QUAD_READ	0x40    /* Flash supports Quad Read */
 };
 
 #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags)	\
@@ -1226,7 +1233,7 @@ static int m25p_probe(struct spi_device *spi)
 	if (info->flags & M25P_NO_FR)
 		flash->flash_read = M25P80_NORMAL;
 
-	/* Quad-read mode takes precedence over fast/normal */
+	/* Quad/Dual-read mode takes precedence over fast/normal */
 	if (spi->mode & SPI_RX_QUAD && info->flags & M25P80_QUAD_READ) {
 		ret = set_quad_mode(flash, info->jedec_id);
 		if (ret) {
@@ -1234,6 +1241,8 @@ static int m25p_probe(struct spi_device *spi)
 			return ret;
 		}
 		flash->flash_read = M25P80_QUAD;
+	} else if (spi->mode & SPI_RX_DUAL && info->flags & M25P80_DUAL_READ) {
+		flash->flash_read = M25P80_DUAL;
 	}
 
 	/* Default commands */
@@ -1241,6 +1250,9 @@ static int m25p_probe(struct spi_device *spi)
 	case M25P80_QUAD:
 		flash->read_opcode = OPCODE_QUAD_READ;
 		break;
+	case M25P80_DUAL:
+		flash->read_opcode = OPCODE_DUAL_READ;
+		break;
 	case M25P80_FAST:
 		flash->read_opcode = OPCODE_FAST_READ;
 		break;
@@ -1265,6 +1277,9 @@ static int m25p_probe(struct spi_device *spi)
 			case M25P80_QUAD:
 				flash->read_opcode = OPCODE_QUAD_READ_4B;
 				break;
+			case M25P80_DUAL:
+				flash->read_opcode = OPCODE_DUAL_READ_4B;
+				break;
 			case M25P80_FAST:
 				flash->read_opcode = OPCODE_FAST_READ_4B;
 				break;
-- 
1.7.9.5


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
