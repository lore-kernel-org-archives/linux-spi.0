From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: ath79: simplify iomem resource mapping" to the spi tree
Date: Wed, 30 Sep 2015 20:33:51 +0100
Message-ID: <E1ZhN8R-0006ie-PU@finisterre>
References: <56081DA7.4040305@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56081DA7.4040305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: ath79: simplify iomem resource mapping

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

>From b7a2a1c0b67283442a06fcc679cba0683914f794 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 27 Sep 2015 18:47:35 +0200
Subject: [PATCH] spi: ath79: simplify iomem resource mapping

Simplify the code by switching from devm_ioremap to devm_ioremap_resource.
Checking the result of platform_get_resource is not needed as
devm_ioremap_resource checks the provided resource argument for NULL.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ath79.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index bf1f9b3..6165bf21 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -240,14 +240,9 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	sp->bitbang.flags = SPI_CS_HIGH;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (r == NULL) {
-		ret = -ENOENT;
-		goto err_put_master;
-	}
-
-	sp->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (!sp->base) {
-		ret = -ENXIO;
+	sp->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(sp->base)) {
+		ret = PTR_ERR(sp->base);
 		goto err_put_master;
 	}
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
