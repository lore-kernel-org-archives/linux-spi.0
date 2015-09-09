From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH linux-next v6 3/8] mtd: spi-nor: update the SPI protocol when enabling manufacturer Quad mode
Date: Wed, 9 Sep 2015 15:24:13 +0200
Message-ID: <a27d3a653f931e268d94c6efcb36ce32d758b602.1441803609.git.cyrille.pitchen@atmel.com>
References: <cover.1441803609.git.cyrille.pitchen@atmel.com>
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
	<ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1441803609.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Micron:
Once their Quad SPI protocol enabled, Micron spi-nor memories expect all
commands to use the SPI 4-4-4 protocol. Also when the Dual SPI protocol is
enabled, all commands must use the SPI 2-2-2 protocol.

Macronix:
When the QPI mode is enabled, all commands must use the SPI 4-4-4 protocol.

Spansion:
When Quad I/O operations are enabled, the Fast Read Quad Output (0x6b / 0x6c)
commands use the SPI 1-1-4 protocol, the Page Program Quad Output (0x32 /
0x34) command use the SPI 1-1-4 protocol whereas other commands use the
SPI 1-1-1 protocol.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/mtd/spi-nor/spi-nor.c | 74 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/mtd/spi-nor.h   |  1 +
 2 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 80a0db078aaa..4b36aada3f4c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -891,6 +891,12 @@ static int macronix_quad_enable(struct spi_nor *nor)
 	nor->cmd_buf[0] = val | SR_QUAD_EN_MX;
 	nor->write_reg(nor, SPINOR_OP_WRSR, nor->cmd_buf, 1, 0);
 
+	/* Once QPI mode enabled, all commands use SPI 4-4-4 protocol. */
+	nor->erase_proto = SPI_PROTO_4_4_4;
+	nor->read_proto = SPI_PROTO_4_4_4;
+	nor->write_proto = SPI_PROTO_4_4_4;
+	nor->reg_proto = SPI_PROTO_4_4_4;
+
 	if (spi_nor_wait_till_ready(nor))
 		return 1;
 
@@ -938,10 +944,16 @@ static int spansion_quad_enable(struct spi_nor *nor)
 		return -EINVAL;
 	}
 
+	/* set read/write protocols */
+	nor->read_proto = SPI_PROTO_1_1_4;
+	nor->write_proto = SPI_PROTO_1_1_4;
+
 	return 0;
 }
 
-static int micron_quad_enable(struct spi_nor *nor)
+static int micron_set_protocol(struct spi_nor *nor,
+			       u8 mask, u8 value,
+			       enum spi_protocol proto)
 {
 	int ret;
 	u8 val;
@@ -954,14 +966,20 @@ static int micron_quad_enable(struct spi_nor *nor)
 
 	write_enable(nor);
 
-	/* set EVCR, enable quad I/O */
-	nor->cmd_buf[0] = val & ~EVCR_QUAD_EN_MICRON;
+	/* set EVCR protocol bits */
+	nor->cmd_buf[0] = (val & ~mask) | value;
 	ret = nor->write_reg(nor, SPINOR_OP_WD_EVCR, nor->cmd_buf, 1, 0);
 	if (ret < 0) {
 		dev_err(nor->dev, "error while writing EVCR register\n");
 		return ret;
 	}
 
+	/* switch protocol for ALL commands */
+	nor->erase_proto = proto;
+	nor->read_proto = proto;
+	nor->write_proto = proto;
+	nor->reg_proto = proto;
+
 	ret = spi_nor_wait_till_ready(nor);
 	if (ret)
 		return ret;
@@ -972,14 +990,23 @@ static int micron_quad_enable(struct spi_nor *nor)
 		dev_err(nor->dev, "error %d reading EVCR\n", ret);
 		return ret;
 	}
-	if (val & EVCR_QUAD_EN_MICRON) {
-		dev_err(nor->dev, "Micron EVCR Quad bit not clear\n");
+	if ((val & mask) != value) {
+		dev_err(nor->dev, "Micron EVCR protocol bits not valid\n");
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
+static inline int micron_quad_enable(struct spi_nor *nor)
+{
+	/* Clear Quad bit to enable quad mode */
+	return micron_set_protocol(nor,
+				   EVCR_QUAD_EN_MICRON | EVCR_DUAL_EN_MICRON,
+				   EVCR_DUAL_EN_MICRON,
+				   SPI_PROTO_4_4_4);
+}
+
 static int set_quad_mode(struct spi_nor *nor, const struct flash_info *info)
 {
 	int status;
@@ -1009,6 +1036,38 @@ static int set_quad_mode(struct spi_nor *nor, const struct flash_info *info)
 	}
 }
 
+static inline int micron_dual_enable(struct spi_nor *nor)
+{
+	/* Clear Dual bit but keep Quad bit set to enable dual mode */
+	return micron_set_protocol(nor,
+				   EVCR_QUAD_EN_MICRON | EVCR_DUAL_EN_MICRON,
+				   EVCR_QUAD_EN_MICRON,
+				   SPI_PROTO_2_2_2);
+}
+
+static int set_dual_mode(struct spi_nor *nor, const struct flash_info *info)
+{
+	int status;
+
+	switch (JEDEC_MFR(info)) {
+	case CFI_MFR_ST:
+		status = micron_dual_enable(nor);
+		if (status) {
+			dev_err(nor->dev, "Micron dual-read not enabled\n");
+			return -EINVAL;
+		}
+		return status;
+	case CFI_MFR_MACRONIX:
+	case CFI_MFR_AMD:
+		nor->read_proto = SPI_PROTO_1_1_2;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int spi_nor_check(struct spi_nor *nor)
 {
 	if (!nor->dev || !nor->read || !nor->write ||
@@ -1160,6 +1219,11 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 		}
 		nor->flash_read = SPI_NOR_QUAD;
 	} else if (mode == SPI_NOR_DUAL && info->flags & SPI_NOR_DUAL_READ) {
+		ret = set_dual_mode(nor, info);
+		if (ret) {
+			dev_err(dev, "dual mode not supported\n");
+			return ret;
+		}
 		nor->flash_read = SPI_NOR_DUAL;
 	}
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 08e405cbb6af..ce81b0e2cb37 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -74,6 +74,7 @@
 
 /* Enhanced Volatile Configuration Register bits */
 #define EVCR_QUAD_EN_MICRON    0x80    /* Micron Quad I/O */
+#define EVCR_DUAL_EN_MICRON    0x40    /* Micron Dual I/O */
 
 /* Flag Status Register bits */
 #define FSR_READY		0x80
-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
