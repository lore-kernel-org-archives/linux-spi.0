From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 2/2] spi: orion: add support for multiple chip selects
Date: Sun, 27 Jul 2014 23:53:20 +0200
Message-ID: <1406498000-13079-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406498000-13079-1-git-send-email-thomas.petazzoni@free-electrons.com>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406498000-13079-1-git-send-email-thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Until now, the spi-orion driver was limited to supporting only one
internal chip select (i.e not the GPIO ones, but the ones directly
handled by the SPI controller). However, recent Marvell platforms
potentially have more than one chip select, so this commit adds
support for a new 'ncs' DT property, which indicates how many chip
selects are available on this platform.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
We could certainly discuss:

 * Whether 'ncs' should be the number of *connected* chip selects, or
   the number of *usable* chip selects.

 * If it's the number of *usable* chip selects, then maybe it
   shouldn't be a DT property, but rather something that the driver
   "knows" thanks to the compatible string (which then, would be
   different from one SoC to the other, since Armada XP and Armada 375
   for example don't have the same number of chip selects).

Suggestions welcome.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-orion.txt |  3 +++
 drivers/spi/spi-orion.c                             | 16 ++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt b/Documentation/devicetree/bindings/spi/spi-orion.txt
index a3ff50f..0388c48 100644
--- a/Documentation/devicetree/bindings/spi/spi-orion.txt
+++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
@@ -6,6 +6,8 @@ Required properties:
 - cell-index : Which of multiple SPI controllers is this.
 Optional properties:
 - interrupts : Is currently not used.
+- ncs : Number of chip selects used on the platform. Defaults to 1 when
+  unspecified.
 
 Example:
        spi@10600 {
@@ -15,5 +17,6 @@ Example:
 	       cell-index = <0>;
 	       reg = <0x10600 0x28>;
 	       interrupts = <23>;
+	       ncs = <2>;
 	       status = "disabled";
        };
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index c206a4a..8145855 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -23,7 +23,6 @@
 
 #define DRIVER_NAME			"orion_spi"
 
-#define ORION_NUM_CHIPSELECTS		1 /* only one slave is supported*/
 #define ORION_SPI_WAIT_RDY_MAX_LOOP	2000 /* in usec */
 
 #define ORION_SPI_IF_CTRL_REG		0x00
@@ -38,6 +37,8 @@
 #define ORION_SPI_CLK_PRESCALE_MASK	0x1F
 #define ORION_SPI_MODE_MASK		(ORION_SPI_MODE_CPOL | \
 					 ORION_SPI_MODE_CPHA)
+#define ORION_SPI_CS(cs)		((cs) << 2)
+#define ORION_SPI_CS_MASK		GENMASK(4, 2)
 
 struct orion_spi {
 	struct spi_master	*master;
@@ -150,6 +151,11 @@ orion_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	if (rc)
 		return rc;
 
+	orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG,
+			  ORION_SPI_CS_MASK);
+	orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG,
+			  ORION_SPI_CS(spi->chip_select));
+
 	if (bits_per_word == 16)
 		orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
 				  ORION_SPI_IF_8_16_BIT_MODE);
@@ -346,6 +352,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	struct resource *r;
 	unsigned long tclk_hz;
 	int status = 0;
+	u32 ncs;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*spi));
 	if (master == NULL) {
@@ -366,7 +373,12 @@ static int orion_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPHA | SPI_CPOL;
 
 	master->transfer_one_message = orion_spi_transfer_one_message;
-	master->num_chipselect = ORION_NUM_CHIPSELECTS;
+
+	if (of_property_read_u32(pdev->dev.of_node, "ncs", &ncs))
+		master->num_chipselect = 1;
+	else
+		master->num_chipselect = ncs;
+
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
 
 	platform_set_drvdata(pdev, master);
-- 
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
