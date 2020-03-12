From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: meson-spicc: remove unused variables" to the spi tree
Date: Thu, 12 Mar 2020 17:39:31 +0000
Message-ID: <applied-20200312133131.26430-2-narmstrong@baylibre.com>
References: <20200312133131.26430-2-narmstrong@baylibre.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200312133131.26430-2-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: meson-spicc: remove unused variables

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From b9dfb20eed5c7dab37d6267a985dbe16df9e4293 Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Date: Thu, 12 Mar 2020 14:31:23 +0100
Subject: [PATCH] spi: meson-spicc: remove unused variables

Remove unused variables from spicc data struct.

Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Link: https://lore.kernel.org/r/20200312133131.26430-2-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-meson-spicc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 7f5680fe2568..8425e5ae1273 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -130,9 +130,7 @@ struct meson_spicc_device {
 	u8				*rx_buf;
 	unsigned int			bytes_per_word;
 	unsigned long			tx_remain;
-	unsigned long			txb_remain;
 	unsigned long			rx_remain;
-	unsigned long			rxb_remain;
 	unsigned long			xfer_remain;
 	bool				is_burst_end;
 	bool				is_last_burst;
-- 
2.20.1
