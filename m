From: kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
Subject: [PATCH 2/2 v2] spi: xlp: Add ACPI support for Vulcan SPI controller
Date: Tue,  9 Aug 2016 19:35:22 +0530
Message-ID: <1470751522-11060-2-git-send-email-kamlakant.patel@broadcom.com>
References: <1470751522-11060-1-git-send-email-kamlakant.patel@broadcom.com>
Cc: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470751522-11060-1-git-send-email-kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Add ACPI support for SPI controller on Broadcom Vulcan ARM64.

Signed-off-by: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
v1 -> v2:
	Fix error return code.

 drivers/spi/spi-xlp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index 8f04fec..4071a72 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -11,6 +11,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -405,8 +406,9 @@ static int xlp_spi_probe(struct platform_device *pdev)
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "could not get spi clock\n");
-		return -ENODEV;
+		return PTR_ERR(clk);
 	}
+
 	xspi->spi_clk = clk_get_rate(clk);
 
 	master = spi_alloc_master(&pdev->dev, 0);
@@ -437,6 +439,14 @@ static int xlp_spi_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xlp_spi_acpi_match[] = {
+	{ "BRCM900D", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, xlp_spi_acpi_match);
+#endif
+
 static const struct of_device_id xlp_spi_dt_id[] = {
 	{ .compatible = "netlogic,xlp832-spi" },
 	{ },
@@ -447,6 +457,7 @@ static struct platform_driver xlp_spi_driver = {
 	.driver = {
 		.name	= "xlp-spi",
 		.of_match_table = xlp_spi_dt_id,
+		.acpi_match_table = ACPI_PTR(xlp_spi_acpi_match),
 	},
 };
 module_platform_driver(xlp_spi_driver);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
