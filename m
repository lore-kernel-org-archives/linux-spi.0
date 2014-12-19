From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2] spi: sh-msiof: Configure MSIOF sync signal timing in device
 tree
Date: Fri, 19 Dec 2014 17:15:53 +0900
Message-ID: <5493DEB9.1080906@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>,
	Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The MSIOF controller has DTDL and SYNCDL in SITMDR1 register. So,
this patch adds new properties like the following commit:
  d0fb47a5237d8b9576113568bacfd27892308b62
  (spi: fsl-espi: Configure FSL eSPI CSBEF and CSAFT)

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 Changes from v1:
  - Remove properties for receive mode
  - Change properties for transmit mode to use percentage values instead of register values
  - Add actual code in the msiof driver

 Documentation/devicetree/bindings/spi/sh-msiof.txt |   16 +++++++
 drivers/spi/spi-sh-msiof.c                         |   47 ++++++++++++++++++++
 include/linux/spi/sh_msiof.h                       |    2 +
 3 files changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index d11c372..4c388bb 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -30,6 +30,22 @@ Optional properties:
 			 specifiers, one for transmission, and one for
 			 reception.
 - dma-names            : Must contain a list of two DMA names, "tx" and "rx".
+- renesas,dtdl         : delay sync signal (setup) in transmit mode.
+			 Must contain one of the following values:
+			 0   (no bit delay)
+			 50  (0.5-clock-cycle delay)
+			 100 (1-clock-cycle delay)
+			 150 (1.5-clock-cycle delay)
+			 200 (2-clock-cycle delay)
+
+- renesas,syncdl       : delay sync signal (hold) in transmit mode.
+			 Must contain one of the following values:
+			 0   (no bit delay)
+			 50  (0.5-clock-cycle delay)
+			 100 (1-clock-cycle delay)
+			 150 (1.5-clock-cycle delay)
+			 200 (2-clock-cycle delay)
+			 300 (3-clock-cycle delay)

 Optional properties, deprecated for soctype-specific bindings:
 - renesas,tx-fifo-size : Overrides the default tx fifo size given in words
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 1405293..50607cd 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -82,6 +82,8 @@ struct sh_msiof_spi_priv {
 #define MDR1_SYNCMD_LR	 0x30000000 /*   L/R mode */
 #define MDR1_SYNCAC_SHIFT	 25 /* Sync Polarity (1 = Active-low) */
 #define MDR1_BITLSB_SHIFT	 24 /* MSB/LSB First (1 = LSB first) */
+#define MDR1_DTDL_SHIFT		 20 /* Data Pin Bit Delay for MSIOF_SYNC */
+#define MDR1_SYNCDL_SHIFT	 16 /* Frame Sync Signal Timing Delay */
 #define MDR1_FLD_MASK	 0x000000c0 /* Frame Sync Signal Interval (0-3) */
 #define MDR1_FLD_SHIFT		  2
 #define MDR1_XXSTP	 0x00000001 /* Transmission/Reception Stop on FIFO */
@@ -279,6 +281,48 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 		sh_msiof_write(p, RSCR, sh_msiof_spi_clk_table[k].scr);
 }

+static u32 sh_msiof_get_delay_bit(u32 dtdl_or_syncdl)
+{
+	/*
+	 * DTDL/SYNCDL bit	: p->info->dtdl or p->info->syncdl
+	 * b'000		: 0
+	 * b'001		: 100
+	 * b'010		: 200
+	 * b'011 (SYNCDL only)	: 300
+	 * b'101		: 50
+	 * b'110		: 150
+	 */
+	if (dtdl_or_syncdl % 100)
+		return dtdl_or_syncdl / 100 + 5;
+	else
+		return dtdl_or_syncdl / 100;
+}
+
+static u32 sh_msiof_spi_get_dtdl_and_syncdl(struct sh_msiof_spi_priv *p)
+{
+	u32 val;
+
+	if (!p->info)
+		return 0;
+
+	/* check if DTDL and SYNCDL is allowed value */
+	if (p->info->dtdl > 200 || p->info->syncdl > 300) {
+		dev_warn(&p->pdev->dev, "DTDL or SYNCDL is too large\n");
+		return 0;
+	}
+
+	/* check if the sum of DTDL and SYNCDL becomes an integer value  */
+	if ((p->info->dtdl + p->info->syncdl) % 100) {
+		dev_warn(&p->pdev->dev, "the sum of DTDL/SYNCDL is not good\n");
+		return 0;
+	}
+
+	val = sh_msiof_get_delay_bit(p->info->dtdl) << MDR1_DTDL_SHIFT;
+	val |= sh_msiof_get_delay_bit(p->info->syncdl) << MDR1_SYNCDL_SHIFT;
+
+	return val;
+}
+
 static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
 				      u32 cpol, u32 cpha,
 				      u32 tx_hi_z, u32 lsb_first, u32 cs_high)
@@ -296,6 +340,7 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
 	tmp = MDR1_SYNCMD_SPI | 1 << MDR1_FLD_SHIFT | MDR1_XXSTP;
 	tmp |= !cs_high << MDR1_SYNCAC_SHIFT;
 	tmp |= lsb_first << MDR1_BITLSB_SHIFT;
+	tmp |= sh_msiof_spi_get_dtdl_and_syncdl(p);
 	sh_msiof_write(p, TMDR1, tmp | MDR1_TRMD | TMDR1_PCON);
 	if (p->chipdata->master_flags & SPI_MASTER_MUST_TX) {
 		/* These bits are reserved if RX needs TX */
@@ -957,6 +1002,8 @@ static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
 					&info->tx_fifo_override);
 	of_property_read_u32(np, "renesas,rx-fifo-size",
 					&info->rx_fifo_override);
+	of_property_read_u32(np, "renesas,dtdl", &info->dtdl);
+	of_property_read_u32(np, "renesas,syncdl", &info->syncdl);

 	info->num_chipselect = num_cs;

diff --git a/include/linux/spi/sh_msiof.h b/include/linux/spi/sh_msiof.h
index 88a14d8..b087a85 100644
--- a/include/linux/spi/sh_msiof.h
+++ b/include/linux/spi/sh_msiof.h
@@ -7,6 +7,8 @@ struct sh_msiof_spi_info {
 	u16 num_chipselect;
 	unsigned int dma_tx_id;
 	unsigned int dma_rx_id;
+	u32 dtdl;
+	u32 syncdl;
 };

 #endif /* __SPI_SH_MSIOF_H__ */
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
