From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Fall back to master maximum speed if no slave speed specified" to the spi tree
Date: Fri, 21 Aug 2015 10:24:17 -0700
Message-ID: <E1ZSq37-0004xr-Pt@finisterre>
References: <1440175235-9677-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440175235-9677-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Fall back to master maximum speed if no slave speed specified

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

>From 7dc9fbc342deb2e2658ebdecb5ffd7ff57945a66 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Date: Thu, 20 Aug 2015 11:52:18 -0700
Subject: [PATCH] spi: Fall back to master maximum speed if no slave speed
 specified

If a slave appears with no maximum transfer speed specified fall back to
using the maximum for the master instead.  It's questionable if we
should let slaves do this but let's be defensive.

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cf8b91b..637d892 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1860,6 +1860,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 
 		if (!xfer->speed_hz)
 			xfer->speed_hz = spi->max_speed_hz;
+		if (!xfer->speed_hz)
+			xfer->speed_hz = master->max_speed_hz;
 
 		if (master->max_speed_hz &&
 		    xfer->speed_hz > master->max_speed_hz)
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
