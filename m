From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] SPI: McSPI: allow configuration of pin directions
Date: Sun,  7 Oct 2012 18:02:37 +0200
Message-ID: <1349625757-21083-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Juha Yrjola <juha.yrjola-EmnPodGKVbzby3iVrkZq2A@public.gmane.org>,
	Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Matus Ujhelyi <matus.ujhelyi-6oiIBCxl0MMjD8S081q9vkEOCMrvLtNR@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Allow D0 to be an input and D1 to be an output, configurable via
platform data and a new DT property.

Based on a patch from  Matus Ujhelyi <matus.ujhelyi-6oiIBCxl0MMjD8S081q9vkEOCMrvLtNR@public.gmane.org>

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matus Ujhelyi <matus.ujhelyi-6oiIBCxl0MMjD8S081q9vkEOCMrvLtNR@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Juha Yrjola <juha.yrjola-EmnPodGKVbzby3iVrkZq2A@public.gmane.org>
---
changes from v1: forgot to stage one hunk.

 Documentation/devicetree/bindings/spi/omap-spi.txt |  3 +++
 arch/arm/plat-omap/include/plat/mcspi.h            |  4 ++++
 drivers/spi/spi-omap2-mcspi.c                      | 25 ++++++++++++++++------
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
index 11aff04..bf4cec8 100644
--- a/Documentation/devicetree/bindings/spi/omap-spi.txt
+++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
@@ -15,6 +15,9 @@ Optional properties:
 	1:1 with the ordered pairs in dmas. The string naming is
 	to be "rxN" and "txN" for RX and TX requests,
 	respectively, where N equals the chip select number.
+- ti,pindir-d0-in-d1-out: Select the D0 pin as input and D1 as
+			  output. The default is D0 as output and
+			  D1 as input.
 
 Examples:
 
diff --git a/arch/arm/plat-omap/include/plat/mcspi.h b/arch/arm/plat-omap/include/plat/mcspi.h
index a357eb2..ce70f7b 100644
--- a/arch/arm/plat-omap/include/plat/mcspi.h
+++ b/arch/arm/plat-omap/include/plat/mcspi.h
@@ -7,9 +7,13 @@
 
 #define OMAP4_MCSPI_REG_OFFSET 0x100
 
+#define MCSPI_PINDIR_D0_OUT_D1_IN	0
+#define MCSPI_PINDIR_D0_IN_D1_OUT	1
+
 struct omap2_mcspi_platform_config {
 	unsigned short	num_cs;
 	unsigned int regs_offset;
+	unsigned int pin_dir:1;
 };
 
 struct omap2_mcspi_dev_attr {
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 1cf1072..c2834d6 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -134,6 +134,7 @@ struct omap2_mcspi {
 	struct omap2_mcspi_dma	*dma_channels;
 	struct device		*dev;
 	struct omap2_mcspi_regs ctx;
+	unsigned int		pin_dir:1;
 };
 
 struct omap2_mcspi_cs {
@@ -747,8 +748,15 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	/* standard 4-wire master mode:  SCK, MOSI/out, MISO/in, nCS
 	 * REVISIT: this controller could support SPI_3WIRE mode.
 	 */
-	l &= ~(OMAP2_MCSPI_CHCONF_IS|OMAP2_MCSPI_CHCONF_DPE1);
-	l |= OMAP2_MCSPI_CHCONF_DPE0;
+	if (mcspi->pin_dir == MCSPI_PINDIR_D0_OUT_D1_IN) {
+		l &= ~OMAP2_MCSPI_CHCONF_IS;
+		l &= ~OMAP2_MCSPI_CHCONF_DPE1;
+		l |= OMAP2_MCSPI_CHCONF_DPE0;
+	} else {
+		l |= OMAP2_MCSPI_CHCONF_IS;
+		l |= OMAP2_MCSPI_CHCONF_DPE1;
+		l &= ~OMAP2_MCSPI_CHCONF_DPE0;
+	}
 
 	/* wordlength */
 	l &= ~OMAP2_MCSPI_CHCONF_WL_MASK;
@@ -1159,6 +1167,11 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 	master->cleanup = omap2_mcspi_cleanup;
 	master->dev.of_node = node;
 
+	dev_set_drvdata(&pdev->dev, master);
+
+	mcspi = spi_master_get_devdata(master);
+	mcspi->master = master;
+
 	match = of_match_device(omap_mcspi_of_match, &pdev->dev);
 	if (match) {
 		u32 num_cs = 1; /* default number of chipselect */
@@ -1167,19 +1180,17 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 		of_property_read_u32(node, "ti,spi-num-cs", &num_cs);
 		master->num_chipselect = num_cs;
 		master->bus_num = bus_num++;
+		if (of_get_property(node, "ti,pindir-d0-in-d1-out", NULL))
+			mcspi->pin_dir = MCSPI_PINDIR_D0_IN_D1_OUT;
 	} else {
 		pdata = pdev->dev.platform_data;
 		master->num_chipselect = pdata->num_cs;
 		if (pdev->id != -1)
 			master->bus_num = pdev->id;
+		mcspi->pin_dir = pdata->pin_dir;
 	}
 	regs_offset = pdata->regs_offset;
 
-	dev_set_drvdata(&pdev->dev, master);
-
-	mcspi = spi_master_get_devdata(master);
-	mcspi->master = master;
-
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
 		status = -ENODEV;
-- 
1.7.11.4


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
