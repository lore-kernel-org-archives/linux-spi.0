From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: core: Extract of_spi_parse_dt()" to the spi tree
Date: Thu, 15 Dec 2016 18:28:51 +0000
Message-ID: <E1cHalv-0000CG-4Q@debutante>
References: <1473713446-30366-3-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473713446-30366-3-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: core: Extract of_spi_parse_dt()

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c2e51ac3d0542440d5b2b8b52ff2ad00751af4da Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 12 Sep 2016 22:50:41 +0200
Subject: [PATCH] spi: core: Extract of_spi_parse_dt()

Extract the parsing of SPI slave-specific properties into its own
function, so it can be reused later for SPI slave controllers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 60 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 656dd3e3220c..1861255866d7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1502,37 +1502,18 @@ static int spi_master_initialize_queue(struct spi_master *master)
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_OF)
-static struct spi_device *
-of_register_spi_device(struct spi_master *master, struct device_node *nc)
+static int of_spi_parse_dt(struct spi_master *master, struct spi_device *spi,
+			   struct device_node *nc)
 {
-	struct spi_device *spi;
-	int rc;
 	u32 value;
-
-	/* Alloc an spi_device */
-	spi = spi_alloc_device(master);
-	if (!spi) {
-		dev_err(&master->dev, "spi_device alloc error for %s\n",
-			nc->full_name);
-		rc = -ENOMEM;
-		goto err_out;
-	}
-
-	/* Select device driver */
-	rc = of_modalias_node(nc, spi->modalias,
-				sizeof(spi->modalias));
-	if (rc < 0) {
-		dev_err(&master->dev, "cannot find modalias for %s\n",
-			nc->full_name);
-		goto err_out;
-	}
+	int rc;
 
 	/* Device address */
 	rc = of_property_read_u32(nc, "reg", &value);
 	if (rc) {
 		dev_err(&master->dev, "%s has no valid 'reg' property (%d)\n",
 			nc->full_name, rc);
-		goto err_out;
+		return rc;
 	}
 	spi->chip_select = value;
 
@@ -1590,10 +1571,41 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	if (rc) {
 		dev_err(&master->dev, "%s has no valid 'spi-max-frequency' property (%d)\n",
 			nc->full_name, rc);
-		goto err_out;
+		return rc;
 	}
 	spi->max_speed_hz = value;
 
+	return 0;
+}
+
+static struct spi_device *
+of_register_spi_device(struct spi_master *master, struct device_node *nc)
+{
+	struct spi_device *spi;
+	int rc;
+
+	/* Alloc an spi_device */
+	spi = spi_alloc_device(master);
+	if (!spi) {
+		dev_err(&master->dev, "spi_device alloc error for %s\n",
+			nc->full_name);
+		rc = -ENOMEM;
+		goto err_out;
+	}
+
+	/* Select device driver */
+	rc = of_modalias_node(nc, spi->modalias,
+				sizeof(spi->modalias));
+	if (rc < 0) {
+		dev_err(&master->dev, "cannot find modalias for %s\n",
+			nc->full_name);
+		goto err_out;
+	}
+
+	rc = of_spi_parse_dt(master, spi, nc);
+	if (rc)
+		goto err_out;
+
 	/* Store a pointer to the node in the device structure */
 	of_node_get(nc);
 	spi->dev.of_node = nc;
-- 
2.11.0
