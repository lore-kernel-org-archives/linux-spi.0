From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Setup the master controller driver before setting the chipselect" to the spi tree
Date: Wed, 28 Oct 2015 09:52:28 +0900
Message-ID: <E1ZrEya-0008Rg-Nw@finisterre>
References: <1444683671-15570-2-git-send-email-fcooper@ti.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>,
	Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>,
	Ivan Khoronzhuk <ivan.khoronzhuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444683671-15570-2-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Setup the master controller driver before setting the chipselect

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

>From abeedb0159eec42c52a28fc44457164f71aa12a9 Mon Sep 17 00:00:00 2001
From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Date: Fri, 16 Oct 2015 10:29:03 -0500
Subject: [PATCH] spi: Setup the master controller driver before setting the
 chipselect

SPI controllers may need to be properly setup before chip selects
can be used. Therefore, wait until the spi controller has a chance
to perform their setup procedure before trying to use the chip
select.

This also insures that the chip selects pins are in a good
state before asseting them which otherwise may cause confusion.

Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Tested-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Tested-by: Ivan Khoronzhuk <ivan.khoronzhuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3abb390..7b528b0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1993,11 +1993,11 @@ int spi_setup(struct spi_device *spi)
 	if (!spi->max_speed_hz)
 		spi->max_speed_hz = spi->master->max_speed_hz;
 
-	spi_set_cs(spi, false);
-
 	if (spi->master->setup)
 		status = spi->master->setup(spi);
 
+	spi_set_cs(spi, false);
+
 	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
 			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
 			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
