From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/bcm63xx: hardcode busnum to 0" to the spi tree
Date: Mon, 14 Sep 2015 19:54:29 +0100
Message-ID: <E1ZbYtZ-0002Jt-6L@finisterre>
References: <1441894304-22316-4-git-send-email-jogo@openwrt.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441894304-22316-4-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/bcm63xx: hardcode busnum to 0

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

>From a45fcea5b20f1dcc2abb08aa29ecb2feacae60f2 Mon Sep 17 00:00:00 2001
From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Date: Thu, 10 Sep 2015 16:11:41 +0200
Subject: [PATCH] spi/bcm63xx: hardcode busnum to 0

We always pass 0 as the spi bus number, so we might as well hard code
it.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index a997c64..c1364a8 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -32,6 +32,7 @@
 #define BCM63XX_SPI_MAX_PREPEND		15
 
 #define BCM63XX_SPI_MAX_CS		8
+#define BCM63XX_SPI_BUS_NUM		0
 
 struct bcm63xx_spi {
 	struct completion	done;
@@ -369,7 +370,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		goto out_err;
 	}
 
-	master->bus_num = pdata->bus_num;
+	master->bus_num = BCM63XX_SPI_BUS_NUM;
 	master->num_chipselect = BCM63XX_SPI_MAX_CS;
 	master->transfer_one_message = bcm63xx_spi_transfer_one;
 	master->mode_bits = MODEBITS;
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
