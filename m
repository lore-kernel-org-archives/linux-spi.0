From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v9 5/6] mtd: spinand: Add initial support for the MX35LF1GE4AB
 chip
Date: Fri, 22 Jun 2018 14:28:27 +0200
Message-ID: <20180622122828.12939-6-boris.brezillon@bootlin.com>
References: <20180622122828.12939-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Piotr Bugalski <Piotr.Bugalski@cryptera.com>,
 Peter Pan <peterpansjtu@gmail.com>, Julien Su <juliensu@mxic.com.tw>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Mason Yang <masonccyang@mxic.com.tw>, zhengxunli@mxic.com.tw
To: Boris Brezillon <boris.brezillon@bootlin.com>,
 Richard Weinberger <richard@nod.at>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180622122828.12939-1-boris.brezillon@bootlin.com>
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

Add minimal support for the MX35LF1GE4AB SPI NAND chip.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v9:
- new patch
---
 drivers/mtd/nand/spi/Makefile   |   2 +-
 drivers/mtd/nand/spi/core.c     |   1 +
 drivers/mtd/nand/spi/macronix.c | 136 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h     |   1 +
 4 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/macronix.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 100008d202ed..b74e074b363a 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o micron.o winbond.o
+spinand-objs := core.o macronix.o micron.o winbond.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index c951c9739c4b..7230457c3ee2 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -779,6 +779,7 @@ static const struct nand_ops spinand_ops = {
 };
 
 static const struct spinand_manufacturer *spinand_manufacturers[] = {
+	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
 };
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
new file mode 100644
index 000000000000..8ba3489d332a
--- /dev/null
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Macronix
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_MACRONIX		0xC2
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int mx35lfxge4ab_ooblayout_ecc(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int mx35lfxge4ab_ooblayout_free(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset = 2;
+	region->length = mtd->oobsize - 2;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops mx35lfxge4ab_ooblayout = {
+	.ecc = mx35lfxge4ab_ooblayout_ecc,
+	.free = mx35lfxge4ab_ooblayout_free,
+};
+
+static int mx35lf1ge4ab_get_eccsr(struct spinand_device *spinand, u8 *eccsr)
+{
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0x7c, 1),
+					  SPI_MEM_OP_NO_ADDR,
+					  SPI_MEM_OP_DUMMY(1, 1),
+					  SPI_MEM_OP_DATA_IN(1, eccsr, 1));
+
+	return spi_mem_exec_op(spinand->spimem, &op);
+}
+
+static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
+				       u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	u8 eccsr;
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		/*
+		 * Let's try to retrieve the real maximum number of bitflips
+		 * in order to avoid forcing the wear-leveling layer to move
+		 * data around if it's not necessary.
+		 */
+		if (mx35lf1ge4ab_get_eccsr(spinand, &eccsr))
+			return nand->eccreq.strength;
+
+		if (WARN_ON(eccsr > nand->eccreq.strength || !eccsr))
+			return nand->eccreq.strength;
+
+		return eccsr;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct spinand_info macronix_spinand_table[] = {
+	SPINAND_INFO("MX35LF1GE4AB", 0x12,
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+};
+
+static int macronix_spinand_detect(struct spinand_device *spinand)
+{
+	u8 *id = spinand->id.data;
+	int ret;
+
+	/*
+	 * Macronix SPI NAND read ID needs a dummy byte, so the first byte in
+	 * raw_id is garbage.
+	 */
+	if (id[1] != SPINAND_MFR_MACRONIX)
+		return 0;
+
+	ret = spinand_match_and_init(spinand, macronix_spinand_table,
+				     ARRAY_SIZE(macronix_spinand_table),
+				     id[2]);
+	if (ret)
+		return ret;
+
+	return 1;
+}
+
+static const struct spinand_manufacturer_ops macronix_spinand_manuf_ops = {
+	.detect = macronix_spinand_detect,
+};
+
+const struct spinand_manufacturer macronix_spinand_manufacturer = {
+	.id = SPINAND_MFR_MACRONIX,
+	.name = "Macronix",
+	.ops = &macronix_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index f0f16b9029e7..088ff96c3eb6 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -194,6 +194,7 @@ struct spinand_manufacturer {
 };
 
 /* SPI NAND manufacturers */
+extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
 
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
