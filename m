From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 2/7] spi: core: Extract of_spi_parse_dt()
Date: Mon, 12 Sep 2016 22:50:41 +0200
Message-ID: <1473713446-30366-3-git-send-email-geert+renesas@glider.be>
References: <1473713446-30366-1-git-send-email-geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473713446-30366-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Extract the parsing of SPI slave-specific properties into its own
function, so it can be reused later for SPI slave controllers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/spi/spi.c | 60 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51ad42fad5679133..79e5c1ba23c81dc1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1471,37 +1471,18 @@ err_init_queue:
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
 
@@ -1559,10 +1540,41 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
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
1.9.1
