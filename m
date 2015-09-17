From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: Remove test for non-zero spi->max_speed_hz" to the spi tree
Date: Thu, 17 Sep 2015 18:37:08 +0100
Message-ID: <E1Zcd7M-0006VZ-DJ@finisterre>
References: <1442323588-29642-12-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-12-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: Remove test for non-zero spi->max_speed_hz

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

>From 55f9a0706f60df4639010c91d6f28ce6b2351179 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 15 Sep 2015 16:26:24 +0300
Subject: [PATCH] spi: dw: Remove test for non-zero spi->max_speed_hz

Test for non-zero spi->max_speed_hz in dw_spi_setup() looks needless as
spi_setup() defaults to master->max_speed_hz in case it is not set. This
drivers sets the master->max_speed_hz based on max_freq data passed to it
via dw_spi_add_host() call. I suppose things have already fallen apart if
dw_spi_mmio_probe() or spi_pci_probe() ever passes zero max_freq.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 2b5d736..1153d36 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -448,11 +448,6 @@ static int dw_spi_setup(struct spi_device *spi)
 	}
 	chip->bits_per_word = spi->bits_per_word;
 
-	if (!spi->max_speed_hz) {
-		dev_err(&spi->dev, "No max speed HZ parameter\n");
-		return -EINVAL;
-	}
-
 	chip->tmode = 0; /* Tx & Rx */
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	chip->cr0 = (chip->bits_per_word - 1)
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
