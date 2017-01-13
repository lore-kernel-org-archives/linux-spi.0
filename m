From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 10/17] spi/ppc4xx: Adjust checks for null pointers in two
 functions
Date: Fri, 13 Jan 2017 18:19:35 +0100
Message-ID: <d9bd24b0-d4d5-233c-756d-71aaed63c5ef@users.sourceforge.net>
References: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 14:56:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script "checkpatch.pl" pointed information out like the following.

Comparison to NULL could be written !…

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/spi/spi-ppc4xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 967d94844b30..048794f043a0 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -229,7 +229,7 @@ static int spi_ppc4xx_setup(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	if (cs == NULL) {
+	if (!cs) {
 		cs = kzalloc(sizeof *cs, GFP_KERNEL);
 		if (!cs)
 			return -ENOMEM;
@@ -392,7 +392,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	const unsigned int *clk;
 
 	master = spi_alloc_master(dev, sizeof *hw);
-	if (master == NULL)
+	if (!master)
 		return -ENOMEM;
 	master->dev.of_node = np;
 	platform_set_drvdata(op, master);
@@ -466,14 +466,14 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 
 	/* Get the clock for the OPB */
 	opbnp = of_find_compatible_node(NULL, NULL, "ibm,opb");
-	if (opbnp == NULL) {
+	if (!opbnp) {
 		dev_err(dev, "OPB: cannot find node\n");
 		ret = -ENODEV;
 		goto free_gpios;
 	}
 	/* Get the clock (Hz) for the OPB */
 	clk = of_get_property(opbnp, "clock-frequency", NULL);
-	if (clk == NULL) {
+	if (!clk) {
 		dev_err(dev, "OPB: no clock-frequency property set\n");
 		of_node_put(opbnp);
 		ret = -ENODEV;
-- 
2.11.0
