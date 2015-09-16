From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: oc-tiny: Use of_property_read_u32 instead of open-coding it" to the spi tree
Date: Wed, 16 Sep 2015 21:02:15 +0100
Message-ID: <E1ZcIuF-000858-PW@finisterre>
References: <1441799753-27183-1-git-send-email-tklauser@distanz.ch>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441799753-27183-1-git-send-email-tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: oc-tiny: Use of_property_read_u32 instead of open-coding it

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

>From 45a3e771085d16c95eb54f8009d795941b21fb28 Mon Sep 17 00:00:00 2001
From: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Date: Wed, 9 Sep 2015 13:55:53 +0200
Subject: [PATCH] spi: oc-tiny: Use of_property_read_u32 instead of open-coding
 it

Use of_property_read_u32 instead of of_get_property with return value
checks and endianness conversion.

Signed-off-by: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-oc-tiny.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 76656a7..b591128 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -207,8 +207,7 @@ static int tiny_spi_of_probe(struct platform_device *pdev)
 	struct tiny_spi *hw = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
 	unsigned int i;
-	const __be32 *val;
-	int len;
+	u32 val;
 
 	if (!np)
 		return 0;
@@ -226,13 +225,10 @@ static int tiny_spi_of_probe(struct platform_device *pdev)
 			return -ENODEV;
 	}
 	hw->bitbang.master->dev.of_node = pdev->dev.of_node;
-	val = of_get_property(pdev->dev.of_node,
-			      "clock-frequency", &len);
-	if (val && len >= sizeof(__be32))
-		hw->freq = be32_to_cpup(val);
-	val = of_get_property(pdev->dev.of_node, "baud-width", &len);
-	if (val && len >= sizeof(__be32))
-		hw->baudwidth = be32_to_cpup(val);
+	if (!of_property_read_u32(np, "clock-frequency", &val))
+		hw->freq = val;
+	if (!of_property_read_u32(np, "baud-width", &val))
+		hw->baudwidth = val;
 	return 0;
 }
 #else /* !CONFIG_OF */
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
