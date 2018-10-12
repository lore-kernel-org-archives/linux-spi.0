From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH RFC 08/18] mtd: spi-nor: Define the DPI, QPI and OPI hwcaps
Date: Fri, 12 Oct 2018 10:48:15 +0200
Message-ID: <20181012084825.23697-9-boris.brezillon@bootlin.com>
References: <20181012084825.23697-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Julien Su <juliensu@mxic.com.tw>, Mark Brown <broonie@kernel.org>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-spi@vger.kernel.org,
 zhengxunli@mxic.com.tw
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
 Vignesh R <vigneshr@ti.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181012084825.23697-1-boris.brezillon@bootlin.com>
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

Entering Dual, Quad or Octo Peripheral mode implies sending all
following operations using the 2-2-2, 4-4-4 or 8-8-8 protocol, so,
differentiating read/program operations is useless in this case.

Define the DPI, QPI and OPI hwcap flags to replace the
{READ,PP}{2_2_2,4_4_4,8_8_8} ones.

While doing that, we get rid of the READ_{2_2_2,4_4_4} SFDP parsing
bits, because it doesn't make sense to support only READs in Dual/Quad
mode.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/spi-nor/atmel-quadspi.c |  5 ++-
 drivers/mtd/spi-nor/spi-nor.c       | 26 +++-------------
 include/linux/mtd/spi-nor.h         | 61 +++++++++++++++++++++----------------
 3 files changed, 41 insertions(+), 51 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
index 820048726b4f..e0f291492fd7 100644
--- a/drivers/mtd/spi-nor/atmel-quadspi.c
+++ b/drivers/mtd/spi-nor/atmel-quadspi.c
@@ -609,14 +609,13 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 			SNOR_HWCAPS_READ_FAST |
 			SNOR_HWCAPS_READ_1_1_2 |
 			SNOR_HWCAPS_READ_1_2_2 |
-			SNOR_HWCAPS_READ_2_2_2 |
 			SNOR_HWCAPS_READ_1_1_4 |
 			SNOR_HWCAPS_READ_1_4_4 |
-			SNOR_HWCAPS_READ_4_4_4 |
 			SNOR_HWCAPS_PP |
 			SNOR_HWCAPS_PP_1_1_4 |
 			SNOR_HWCAPS_PP_1_4_4 |
-			SNOR_HWCAPS_PP_4_4_4,
+			SNOR_HWCAPS_DPI |
+			SNOR_HWCAPS_QPI,
 	};
 	struct device_node *child, *np = pdev->dev.of_node;
 	struct atmel_qspi *aq;
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 46e5d5d4a423..7fad94588c55 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2732,14 +2732,6 @@ static const struct sfdp_bfpt_read sfdp_bfpt_reads[] = {
 		SNOR_PROTO_1_2_2,
 	},
 
-	/* Fast Read 2-2-2 */
-	{
-		SNOR_HWCAPS_READ_2_2_2,
-		BFPT_DWORD(5),  BIT(0),	/* Supported bit */
-		BFPT_DWORD(6), 16,	/* Settings */
-		SNOR_PROTO_2_2_2,
-	},
-
 	/* Fast Read 1-1-4 */
 	{
 		SNOR_HWCAPS_READ_1_1_4,
@@ -2755,14 +2747,6 @@ static const struct sfdp_bfpt_read sfdp_bfpt_reads[] = {
 		BFPT_DWORD(3), 0,	/* Settings */
 		SNOR_PROTO_1_4_4,
 	},
-
-	/* Fast Read 4-4-4 */
-	{
-		SNOR_HWCAPS_READ_4_4_4,
-		BFPT_DWORD(5), BIT(4),	/* Supported bit */
-		BFPT_DWORD(7), 16,	/* Settings */
-		SNOR_PROTO_4_4_4,
-	},
 };
 
 struct sfdp_bfpt_erase {
@@ -2807,15 +2791,15 @@ static int spi_nor_hwcaps_read2cmd(u32 hwcaps)
 		{ SNOR_HWCAPS_READ_1_1_1_DTR,	SNOR_CMD_READ_1_1_1_DTR },
 		{ SNOR_HWCAPS_READ_1_1_2,	SNOR_CMD_READ_1_1_2 },
 		{ SNOR_HWCAPS_READ_1_2_2,	SNOR_CMD_READ_1_2_2 },
-		{ SNOR_HWCAPS_READ_2_2_2,	SNOR_CMD_READ_2_2_2 },
+		{ SNOR_HWCAPS_DPI,		SNOR_CMD_READ_2_2_2 },
 		{ SNOR_HWCAPS_READ_1_2_2_DTR,	SNOR_CMD_READ_1_2_2_DTR },
 		{ SNOR_HWCAPS_READ_1_1_4,	SNOR_CMD_READ_1_1_4 },
 		{ SNOR_HWCAPS_READ_1_4_4,	SNOR_CMD_READ_1_4_4 },
-		{ SNOR_HWCAPS_READ_4_4_4,	SNOR_CMD_READ_4_4_4 },
+		{ SNOR_HWCAPS_QPI,		SNOR_CMD_READ_4_4_4 },
 		{ SNOR_HWCAPS_READ_1_4_4_DTR,	SNOR_CMD_READ_1_4_4_DTR },
 		{ SNOR_HWCAPS_READ_1_1_8,	SNOR_CMD_READ_1_1_8 },
 		{ SNOR_HWCAPS_READ_1_8_8,	SNOR_CMD_READ_1_8_8 },
-		{ SNOR_HWCAPS_READ_8_8_8,	SNOR_CMD_READ_8_8_8 },
+		{ SNOR_HWCAPS_OPI,		SNOR_CMD_READ_8_8_8 },
 		{ SNOR_HWCAPS_READ_1_8_8_DTR,	SNOR_CMD_READ_1_8_8_DTR },
 	};
 
@@ -2829,10 +2813,10 @@ static int spi_nor_hwcaps_pp2cmd(u32 hwcaps)
 		{ SNOR_HWCAPS_PP,		SNOR_CMD_PP },
 		{ SNOR_HWCAPS_PP_1_1_4,		SNOR_CMD_PP_1_1_4 },
 		{ SNOR_HWCAPS_PP_1_4_4,		SNOR_CMD_PP_1_4_4 },
-		{ SNOR_HWCAPS_PP_4_4_4,		SNOR_CMD_PP_4_4_4 },
+		{ SNOR_HWCAPS_QPI,		SNOR_CMD_PP_4_4_4 },
 		{ SNOR_HWCAPS_PP_1_1_8,		SNOR_CMD_PP_1_1_8 },
 		{ SNOR_HWCAPS_PP_1_8_8,		SNOR_CMD_PP_1_8_8 },
-		{ SNOR_HWCAPS_PP_8_8_8,		SNOR_CMD_PP_8_8_8 },
+		{ SNOR_HWCAPS_OPI,		SNOR_CMD_PP_8_8_8 },
 	};
 
 	return spi_nor_hwcaps2cmd(hwcaps, hwcaps_pp2cmd,
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 93400b17fbd0..f2154672f75a 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -472,28 +472,25 @@ struct spi_nor_hwcaps {
  * then Quad SPI protocols before Dual SPI protocols, Fast Read and lastly
  * (Slow) Read.
  */
-#define SNOR_HWCAPS_READ_MASK		GENMASK(14, 0)
+#define SNOR_HWCAPS_READ_MASK		GENMASK(11, 0)
 #define SNOR_HWCAPS_READ		BIT(0)
 #define SNOR_HWCAPS_READ_FAST		BIT(1)
 #define SNOR_HWCAPS_READ_1_1_1_DTR	BIT(2)
 
-#define SNOR_HWCAPS_READ_DUAL		GENMASK(6, 3)
+#define SNOR_HWCAPS_READ_DUAL		GENMASK(5, 3)
 #define SNOR_HWCAPS_READ_1_1_2		BIT(3)
 #define SNOR_HWCAPS_READ_1_2_2		BIT(4)
-#define SNOR_HWCAPS_READ_2_2_2		BIT(5)
-#define SNOR_HWCAPS_READ_1_2_2_DTR	BIT(6)
+#define SNOR_HWCAPS_READ_1_2_2_DTR	BIT(5)
 
-#define SNOR_HWCAPS_READ_QUAD		GENMASK(10, 7)
-#define SNOR_HWCAPS_READ_1_1_4		BIT(7)
-#define SNOR_HWCAPS_READ_1_4_4		BIT(8)
-#define SNOR_HWCAPS_READ_4_4_4		BIT(9)
-#define SNOR_HWCAPS_READ_1_4_4_DTR	BIT(10)
+#define SNOR_HWCAPS_READ_QUAD		GENMASK(8, 6)
+#define SNOR_HWCAPS_READ_1_1_4		BIT(6)
+#define SNOR_HWCAPS_READ_1_4_4		BIT(7)
+#define SNOR_HWCAPS_READ_1_4_4_DTR	BIT(8)
 
-#define SNOR_HWCPAS_READ_OCTO		GENMASK(14, 11)
-#define SNOR_HWCAPS_READ_1_1_8		BIT(11)
-#define SNOR_HWCAPS_READ_1_8_8		BIT(12)
-#define SNOR_HWCAPS_READ_8_8_8		BIT(13)
-#define SNOR_HWCAPS_READ_1_8_8_DTR	BIT(14)
+#define SNOR_HWCPAS_READ_OCTO		GENMASK(11, 9)
+#define SNOR_HWCAPS_READ_1_1_8		BIT(9)
+#define SNOR_HWCAPS_READ_1_8_8		BIT(10)
+#define SNOR_HWCAPS_READ_1_8_8_DTR	BIT(11)
 
 /*
  * Page Program capabilities.
@@ -504,24 +501,33 @@ struct spi_nor_hwcaps {
  * JEDEC/SFDP standard to define them. Also at this moment no SPI flash memory
  * implements such commands.
  */
-#define SNOR_HWCAPS_PP_MASK	GENMASK(22, 16)
+#define SNOR_HWCAPS_PP_MASK	GENMASK(20, 16)
 #define SNOR_HWCAPS_PP		BIT(16)
 
-#define SNOR_HWCAPS_PP_QUAD	GENMASK(19, 17)
+#define SNOR_HWCAPS_PP_QUAD	GENMASK(18, 17)
 #define SNOR_HWCAPS_PP_1_1_4	BIT(17)
 #define SNOR_HWCAPS_PP_1_4_4	BIT(18)
-#define SNOR_HWCAPS_PP_4_4_4	BIT(19)
 
-#define SNOR_HWCAPS_PP_OCTO	GENMASK(22, 20)
-#define SNOR_HWCAPS_PP_1_1_8	BIT(20)
-#define SNOR_HWCAPS_PP_1_8_8	BIT(21)
-#define SNOR_HWCAPS_PP_8_8_8	BIT(22)
+#define SNOR_HWCAPS_PP_OCTO	GENMASK(20, 19)
+#define SNOR_HWCAPS_PP_1_1_8	BIT(19)
+#define SNOR_HWCAPS_PP_1_8_8	BIT(20)
 
-#define SNOR_HWCAPS_X_X_X	(SNOR_HWCAPS_READ_2_2_2 |	\
-				 SNOR_HWCAPS_READ_4_4_4 |	\
-				 SNOR_HWCAPS_READ_8_8_8 |	\
-				 SNOR_HWCAPS_PP_4_4_4 |		\
-				 SNOR_HWCAPS_PP_8_8_8)
+/*
+ * DPI, QPI and OPI stand for Dual/Quad/Octo Peripheral Interface. Those modes
+ * force everything to be sent on 2, 4 or 8 I/O lines, including the opcode
+ * which is normally sent in SPI mode.
+ * They should only be used if
+ * 1/ their SPI equivalent is not supported by the chip and/or controller
+ * 2/ the chip does not have the SNOR_F_BROKEN_RESET set
+ * The same stands for the DTR variant of those modes.
+ */
+#define SNOR_HWCAPS_DPI			BIT(24)
+#define SNOR_HWCAPS_QPI			BIT(25)
+#define SNOR_HWCAPS_OPI			BIT(26)
+
+#define SNOR_HWCAPS_X_X_X	(SNOR_HWCAPS_DPI |		\
+				 SNOR_HWCAPS_QPI |		\
+				 SNOR_HWCAPS_OPI)
 
 #define SNOR_HWCAPS_DTR		(SNOR_HWCAPS_READ_1_1_1_DTR |	\
 				 SNOR_HWCAPS_READ_1_2_2_DTR |	\
@@ -529,7 +535,8 @@ struct spi_nor_hwcaps {
 				 SNOR_HWCAPS_READ_1_8_8_DTR)
 
 #define SNOR_HWCAPS_ALL		(SNOR_HWCAPS_READ_MASK |	\
-				 SNOR_HWCAPS_PP_MASK)
+				 SNOR_HWCAPS_PP_MASK |		\
+				 SNOR_HWCAPS_X_X_X)
 
 /**
  * spi_nor_scan() - scan the SPI NOR
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
