From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: omap2-mcspi: Prevent duplicate gpio_request" to the spi tree
Date: Tue, 01 Dec 2015 23:00:31 +0000
Message-ID: <E1a3tuR-00086n-26@debutante>
References: <1448895759-4282-1-git-send-email-mwelling@ieee.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Bell <joe-frEo4xfazcg+9D430DZnzg@public.gmane.org>,
	Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448895759-4282-1-git-send-email-mwelling-EkmVulN54Sk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: omap2-mcspi: Prevent duplicate gpio_request

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

>From 2f538c017e1a8620d19553931199c6d6a6d31bb2 Mon Sep 17 00:00:00 2001
From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Date: Mon, 30 Nov 2015 09:02:39 -0600
Subject: [PATCH] spi: omap2-mcspi: Prevent duplicate gpio_request

Occasionally the setup function will be called multiple times. Only request
the gpio the first time otherwise -EBUSY will occur on subsequent calls to
setup.

Reported-by: Joseph Bell <joe-frEo4xfazcg+9D430DZnzg@public.gmane.org>

Signed-off-by: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 02aa1d0607b3..7273820275e9 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1025,6 +1025,16 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 		spi->controller_state = cs;
 		/* Link this to context save list */
 		list_add_tail(&cs->node, &ctx->cs);
+
+		if (gpio_is_valid(spi->cs_gpio)) {
+			ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
+			if (ret) {
+				dev_err(&spi->dev, "failed to request gpio\n");
+				return ret;
+			}
+			gpio_direction_output(spi->cs_gpio,
+					 !(spi->mode & SPI_CS_HIGH));
+		}
 	}
 
 	if (!mcspi_dma->dma_rx || !mcspi_dma->dma_tx) {
@@ -1033,15 +1043,6 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 			return ret;
 	}
 
-	if (gpio_is_valid(spi->cs_gpio)) {
-		ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
-		if (ret) {
-			dev_err(&spi->dev, "failed to request gpio\n");
-			return ret;
-		}
-		gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
-	}
-
 	ret = pm_runtime_get_sync(mcspi->dev);
 	if (ret < 0)
 		return ret;
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
