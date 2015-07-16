From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/7] mtd: spi-nor: allow the set the latency code on Spansion memories
Date: Thu, 16 Jul 2015 17:27:52 +0200
Message-ID: <12f0bceb57e1bf25279a995f76103b4e75091e82.1437059658.git.cyrille.pitchen@atmel.com>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com>
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
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1437059658.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Both the SPI controller and the flash memory must agree on the number of
dummy cycles to use for Fast Read commands. For Spansion memories, this
number of dummy cycles is configured through a so called latency code in
their Control Register.
The right latency code can be found in the memory datasheet and depends
on the SPI clock frequency, the op code of the Fast Read command and the
Single/Dual Data Rate mode.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/mtd/spi-nor/spi-nor.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 5df6e4712a9e..32fddf06da3f 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -989,6 +989,50 @@ static int set_quad_mode(struct spi_nor *nor, struct flash_info *info)
 	}
 }
 
+static int spansion_set_latency_code(struct spi_nor *nor)
+{
+	struct device_node *np = nor->dev->of_node;
+	u8 cr, mask = GENMASK(7, 6);
+	u32 lc;
+	int ret;
+
+	if (!np || of_property_read_u32(np, "spansion,latency-code", &lc))
+		return 0;
+
+	if (lc & ~(mask >> 6)) {
+		dev_err(nor->dev, "invalid latency code: %u\n", lc);
+		return -EINVAL;
+	}
+
+	ret = read_cr(nor);
+	if (ret < 0) {
+		dev_err(nor->dev,
+			"error while reading configuration register\n");
+		return ret;
+	}
+
+	write_enable(nor);
+
+	cr = ret;
+	cr &= ~mask;
+	cr |= (lc << 6);
+	ret = write_sr_cr(nor, cr << 8);
+	if (ret < 0) {
+		dev_err(nor->dev,
+			"error while updating configuration register\n");
+		return -EINVAL;
+	}
+
+	/* read back and check it */
+	ret = read_cr(nor);
+	if (!(ret >= 0 && (ret & mask) == (lc << 6))) {
+		dev_err(nor->dev, "Spansion latency code not set\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int micron_set_dummy_cycles(struct spi_nor *nor)
 {
 	int ret;
@@ -1045,6 +1089,8 @@ static int spi_nor_read_dummy_cycles(struct spi_nor *nor,
 		 * backward compatibility.
 		 */
 		switch (JEDEC_MFR(info)) {
+		case CFI_MFR_AMD:
+			return spansion_set_latency_code(nor);
 		case CFI_MFR_ST:
 			return micron_set_dummy_cycles(nor);
 		default:
-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
