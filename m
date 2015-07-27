From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 3/5] mtd: spi-nor: allow to tune the number of dummy cycles
Date: Mon, 27 Jul 2015 10:59:42 +0200
Message-ID: <df18f832b86b871fef45201e25a28ef11b372627.1437986785.git.cyrille.pitchen@atmel.com>
References: <cover.1437986785.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	<computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, <marex-ynQEQJNshbs@public.gmane.org>,
	<shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1437986785.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The number of dummy cycles used during Fast Read commands can be reduced
to improve transfer performances. Each manufacturer has a dedicated set of
registers to provide the memory with the exact number of dummy cycles it
should expect. Both the memory and the (Q)SPI controller must agree on
this number of dummy cycles.

The number of dummy cycles can be found into the memory datasheet and
mostly depends on the SPI clock frequency, the Fast Read op code and the
Single/Dual Data Rate mode.

Probing JEDEC Serial Flash Discoverable Parameters (SFDP) tables would
only provide the driver with a high enough number of dummy cycles for each
Fast Read command to be used for all clock frequencies: this solution
would not be optimized.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/mtd/spi-nor/spi-nor.c | 97 ++++++++++++++++++++++++++++++++++---------
 include/linux/mtd/spi-nor.h   |  2 +
 2 files changed, 80 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d373a5fdf48b..2013e02e1116 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -119,24 +119,6 @@ static int read_cr(struct spi_nor *nor)
 }
 
 /*
- * Dummy Cycle calculation for different type of read.
- * It can be used to support more commands with
- * different dummy cycle requirements.
- */
-static inline int spi_nor_read_dummy_cycles(struct spi_nor *nor)
-{
-	switch (nor->flash_read) {
-	case SPI_NOR_FAST:
-	case SPI_NOR_DUAL:
-	case SPI_NOR_QUAD:
-		return 8;
-	case SPI_NOR_NORMAL:
-		return 0;
-	}
-	return 0;
-}
-
-/*
  * Write status register 1 byte
  * Returns negative if error occurred.
  */
@@ -1011,6 +993,81 @@ static int set_quad_mode(struct spi_nor *nor, struct flash_info *info)
 	}
 }
 
+static int micron_set_dummy_cycles(struct spi_nor *nor)
+{
+	int ret;
+	u8 val, mask;
+
+	/* read the Volatile Configuration Register (VCR) */
+	ret = nor->read_reg(nor, SPINOR_OP_RD_VCR, &val, 1);
+	if (ret < 0) {
+		dev_err(nor->dev, "error %d reading VCR\n", ret);
+		return ret;
+	}
+
+	write_enable(nor);
+
+	/* update the number of dummy into the VCR */
+	mask = GENMASK(7, 4);
+	val &= ~mask;
+	val |= (nor->read_dummy << 4) & mask;
+	ret = nor->write_reg(nor, SPINOR_OP_WR_VCR, &val, 1, 0);
+	if (ret < 0) {
+		dev_err(nor->dev, "error while writing VCR register\n");
+		return ret;
+	}
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * Dummy Cycle calculation for different type of read.
+ * It can be used to support more commands with
+ * different dummy cycle requirements.
+ */
+static int spi_nor_read_dummy_cycles(struct spi_nor *nor,
+				     const struct flash_info *info)
+{
+	struct device_node *np = nor->dev->of_node;
+	u32 num_dummy_cycles;
+
+	if (np && !of_property_read_u32(np, "m25p,num-dummy-cycles",
+					&num_dummy_cycles)) {
+		nor->read_dummy = num_dummy_cycles;
+
+		/*
+		 * This switch block might be moved after the if...then...else
+		 * statement but it was not tested with all Spansion or Micron
+		 * memories.
+		 * Now the "m25p,num-dummy-cycles" property needs to be
+		 * explicitly set in the device tree so the switch statement is
+		 * executed. This should avoid unwanted side effects and keep
+		 * backward compatibility.
+		 */
+		switch (JEDEC_MFR(info)) {
+		case CFI_MFR_ST:
+			return micron_set_dummy_cycles(nor);
+		default:
+			break;
+		}
+	} else {
+		switch (nor->flash_read) {
+		case SPI_NOR_FAST:
+		case SPI_NOR_DUAL:
+		case SPI_NOR_QUAD:
+			nor->read_dummy = 8;
+		case SPI_NOR_NORMAL:
+			nor->read_dummy = 0;
+		}
+	}
+
+	return 0;
+}
+
 static int spi_nor_check(struct spi_nor *nor)
 {
 	if (!nor->dev || !nor->read || !nor->write ||
@@ -1215,7 +1272,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 		nor->addr_width = 3;
 	}
 
-	nor->read_dummy = spi_nor_read_dummy_cycles(nor);
+	ret = spi_nor_read_dummy_cycles(nor, info);
+	if (ret)
+		return ret;
 
 	dev_info(dev, "%s (%lld Kbytes)\n", id->name,
 			(long long)mtd->size >> 10);
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 1bf6f11310ef..e03a4c4053d3 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -59,6 +59,8 @@
 /* Used for Micron flashes only. */
 #define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
 #define SPINOR_OP_WD_EVCR      0x61    /* Write EVCR register */
+#define SPINOR_OP_RD_VCR	0x85	/* Read VCR register */
+#define SPINOR_OP_WR_VCR	0x81	/* Write VCR register */
 
 /* Status Register bits. */
 #define SR_WIP			1	/* Write in progress */
-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
