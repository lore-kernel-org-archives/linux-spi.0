From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: a3700: Change SPI mode before asserting chip-select" to the spi tree
Date: Tue, 10 Oct 2017 10:19:52 +0100
Message-ID: <E1e1qhc-0003cS-Ia@debutante>
References: <1507624998-31425-2-git-send-email-maxime.chevallier@smile.fr>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
        miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1507624998-31425-2-git-send-email-maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: a3700: Change SPI mode before asserting chip-select

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

>From dd7aa8d4b53b3484ba31ba56f3ff1be7deb38530 Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Date: Tue, 10 Oct 2017 10:43:18 +0200
Subject: [PATCH] spi: a3700: Change SPI mode before asserting chip-select

The spi device mode should be configured in the controller before the
chip-select is asserted, so that a clock polarity configuration change
is not interpreted as a clock tick by the device.

This patch moves the mode setting to the 'prepare_message' function
instead of the 'transfer_one' function.

By doing so, this patch also removes redundant code in
a3700_spi_clock_set.

This was tested on EspressoBin board, with spidev.

Signed-off-by: Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-armada-3700.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 568e1c65aa82..77fe55ce790c 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -213,7 +213,7 @@ static void a3700_spi_mode_set(struct a3700_spi *a3700_spi,
 }
 
 static void a3700_spi_clock_set(struct a3700_spi *a3700_spi,
-				unsigned int speed_hz, u16 mode)
+				unsigned int speed_hz)
 {
 	u32 val;
 	u32 prescale;
@@ -231,17 +231,6 @@ static void a3700_spi_clock_set(struct a3700_spi *a3700_spi,
 		val |= A3700_SPI_CLK_CAPT_EDGE;
 		spireg_write(a3700_spi, A3700_SPI_IF_TIME_REG, val);
 	}
-
-	val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
-	val &= ~(A3700_SPI_CLK_POL | A3700_SPI_CLK_PHA);
-
-	if (mode & SPI_CPOL)
-		val |= A3700_SPI_CLK_POL;
-
-	if (mode & SPI_CPHA)
-		val |= A3700_SPI_CLK_PHA;
-
-	spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
 }
 
 static void a3700_spi_bytelen_set(struct a3700_spi *a3700_spi, unsigned int len)
@@ -423,7 +412,7 @@ static void a3700_spi_transfer_setup(struct spi_device *spi,
 
 	a3700_spi = spi_master_get_devdata(spi->master);
 
-	a3700_spi_clock_set(a3700_spi, xfer->speed_hz, spi->mode);
+	a3700_spi_clock_set(a3700_spi, xfer->speed_hz);
 
 	byte_len = xfer->bits_per_word >> 3;
 
@@ -584,6 +573,8 @@ static int a3700_spi_prepare_message(struct spi_master *master,
 
 	a3700_spi_bytelen_set(a3700_spi, 4);
 
+	a3700_spi_mode_set(a3700_spi, spi->mode);
+
 	return 0;
 }
 
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
