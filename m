From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH RFC 16/18] mtd: spi-nor: Add the concept of full DTR modes
Date: Fri, 12 Oct 2018 10:48:23 +0200
Message-ID: <20181012084825.23697-17-boris.brezillon@bootlin.com>
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

Full DTR modes are modes where even the instruction opcode is sent
using DTR.

Define the relevant macros and enum to add such modes and patch
spi_nor_select_preferred_mode() to select them when appropriate.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 17 ++++++++++++++++-
 include/linux/mtd/spi-nor.h   | 29 ++++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 9ff957dc351c..849ba0a1c157 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4124,6 +4124,11 @@ static void spi_nor_select_preferred_mode(struct spi_nor *nor, u32 hwcaps)
 	if (hwcaps & SNOR_HWCPAS_READ_OCTO && hwcaps & SNOR_HWCAPS_PP_OCTO)
 		return;
 
+	if (hwcaps & SNOR_HWCAPS_OPI_FULL_DTR) {
+		nor->preferred_mode = SPI_NOR_MODE_OPI_FULL_DTR;
+		return;
+	}
+
 	if (hwcaps & SNOR_HWCAPS_OPI) {
 		nor->preferred_mode = SPI_NOR_MODE_OPI;
 		return;
@@ -4132,6 +4137,11 @@ static void spi_nor_select_preferred_mode(struct spi_nor *nor, u32 hwcaps)
 	if (hwcaps & SNOR_HWCAPS_READ_QUAD && hwcaps & SNOR_HWCAPS_PP_QUAD)
 		return;
 
+	if (hwcaps & SNOR_HWCAPS_QPI_FULL_DTR) {
+		nor->preferred_mode = SPI_NOR_MODE_QPI_FULL_DTR;
+		return;
+	}
+
 	if (hwcaps & SNOR_HWCAPS_QPI) {
 		nor->preferred_mode = SPI_NOR_MODE_QPI;
 		return;
@@ -4140,6 +4150,11 @@ static void spi_nor_select_preferred_mode(struct spi_nor *nor, u32 hwcaps)
 	if (hwcaps & SNOR_HWCAPS_READ_DUAL)
 		return;
 
+	if (hwcaps & SNOR_HWCAPS_DPI_FULL_DTR) {
+		nor->preferred_mode = SPI_NOR_MODE_DPI_FULL_DTR;
+		return;
+	}
+
 	if (hwcaps & SNOR_HWCAPS_DPI) {
 		nor->preferred_mode = SPI_NOR_MODE_DPI;
 		return;
@@ -4177,7 +4192,7 @@ static int spi_nor_setup(struct spi_nor *nor, const struct flash_info *info,
 		 * controller directly implements the spi_nor interface.
 		 * Yet another reason to switch to spi-mem.
 		 */
-		ignored_mask = SNOR_HWCAPS_X_X_X;
+		ignored_mask = SNOR_HWCAPS_X_X_X | SNOR_HWCAPS_XD_XD_XD;
 		if (shared_mask & ignored_mask) {
 			dev_dbg(nor->dev,
 				"SPI n-n-n protocols are not supported.\n");
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 1035706bc6db..3735d1a0fd0d 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -188,6 +188,10 @@
 #define SNOR_PROTO_1_XD_XD(_nbits)				\
 	(SNOR_PROTO_DATA_IS_DTR | SNOR_PROTO_ADDR_IS_DTR |	\
 	 SNOR_PROTO_STR(1, _nbits, _nbits))
+#define SNOR_PROTO_XD_XD_XD(_nbits)				\
+	(SNOR_PROTO_INST_IS_DTR | SNOR_PROTO_DATA_IS_DTR |	\
+	 SNOR_PROTO_ADDR_IS_DTR |				\
+	 SNOR_PROTO_STR(_nbits, _nbits, _nbits))
 
 enum spi_nor_protocol {
 	SNOR_PROTO_1_1_1 = SNOR_PROTO_STR(1, 1, 1),
@@ -360,9 +364,13 @@ struct flash_info;
 
 enum spi_nor_mode {
 	SPI_NOR_MODE_SPI,
+	SPI_NOR_MODE_SPI_FULL_DTR,
 	SPI_NOR_MODE_DPI,
+	SPI_NOR_MODE_DPI_FULL_DTR,
 	SPI_NOR_MODE_QPI,
+	SPI_NOR_MODE_QPI_FULL_DTR,
 	SPI_NOR_MODE_OPI,
+	SPI_NOR_MODE_OPI_FULL_DTR,
 	SPI_NOR_NUM_MODES,
 };
 
@@ -561,19 +569,34 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_DPI			BIT(24)
 #define SNOR_HWCAPS_QPI			BIT(25)
 #define SNOR_HWCAPS_OPI			BIT(26)
+#define SNOR_HWCAPS_SPI_FULL_DTR	BIT(27)
+#define SNOR_HWCAPS_DPI_FULL_DTR	BIT(28)
+#define SNOR_HWCAPS_QPI_FULL_DTR	BIT(29)
+#define SNOR_HWCAPS_OPI_FULL_DTR	BIT(30)
 
 #define SNOR_HWCAPS_X_X_X	(SNOR_HWCAPS_DPI |		\
 				 SNOR_HWCAPS_QPI |		\
-				 SNOR_HWCAPS_OPI)
+				 SNOR_HWCAPS_OPI |		\
+				 SNOR_HWCAPS_SPI_FULL_DTR |	\
+				 SNOR_HWCAPS_DPI_FULL_DTR |	\
+				 SNOR_HWCAPS_QPI_FULL_DTR |	\
+				 SNOR_HWCAPS_OPI_FULL_DTR)
+
+#define SNOR_HWCAPS_XD_XD_XD	(SNOR_HWCAPS_SPI_FULL_DTR |	\
+				 SNOR_HWCAPS_DPI_FULL_DTR |	\
+				 SNOR_HWCAPS_QPI_FULL_DTR |	\
+				 SNOR_HWCAPS_OPI_FULL_DTR)
 
 #define SNOR_HWCAPS_DTR		(SNOR_HWCAPS_READ_1_1D_1D |	\
 				 SNOR_HWCAPS_READ_1_2D_2D |	\
 				 SNOR_HWCAPS_READ_1_4D_4D |	\
-				 SNOR_HWCAPS_READ_1_8D_8D)
+				 SNOR_HWCAPS_READ_1_8D_8D |	\
+				 SNOR_HWCAPS_XD_XD_XD)
 
 #define SNOR_HWCAPS_ALL		(SNOR_HWCAPS_READ_MASK |	\
 				 SNOR_HWCAPS_PP_MASK |		\
-				 SNOR_HWCAPS_X_X_X)
+				 SNOR_HWCAPS_X_X_X |		\
+				 SNOR_HWCAPS_XD_XD_XD)
 
 /**
  * spi_nor_scan() - scan the SPI NOR
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
