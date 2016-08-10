From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: xlp: Add ACPI support for Vulcan SPI controller" to the spi tree
Date: Wed, 10 Aug 2016 21:04:27 +0100
Message-ID: <E1bXZjn-0000bJ-3E@debutante>
References: <1470751522-11060-2-git-send-email-kamlakant.patel@broadcom.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470751522-11060-2-git-send-email-kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: xlp: Add ACPI support for Vulcan SPI controller

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

>From 097d06192caf6db29ff6b8a9117cfaf7a514821f Mon Sep 17 00:00:00 2001
From: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Date: Tue, 9 Aug 2016 19:35:22 +0530
Subject: [PATCH] spi: xlp: Add ACPI support for Vulcan SPI controller

Add ACPI support for SPI controller on Broadcom Vulcan ARM64.

Signed-off-by: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-xlp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index 8f04feca6ee3..4071a729eb2f 100644
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
