From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: a3700: Fix clk prescaling for coefficient over 15" to the spi tree
Date: Mon, 27 Nov 2017 18:54:55 +0000
Message-ID: <E1eJOYR-0007e7-EH@debutante>
References: <1511792192-7090-1-git-send-email-maxime.chevallier@smile.fr>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
        miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511792192-7090-1-git-send-email-maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: a3700: Fix clk prescaling for coefficient over 15

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

>From 251c201bf4f8b5bf4f1ccb4f8920eed2e1f57580 Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Date: Mon, 27 Nov 2017 15:16:32 +0100
Subject: [PATCH] spi: a3700: Fix clk prescaling for coefficient over 15

The Armada 3700 SPI controller has 2 ranges of prescaler coefficients.
One ranging from 0 to 15 by steps of 1, and one ranging from 0 to 30 by
steps of 2.

This commit fixes the prescaler coefficients that are over 15 so that it
uses the correct range of values. The prescaling coefficient is rounded
to the upper value if it is odd.

This was tested on Espressobin with spidev and a locigal analyser.

Signed-off-by: Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/spi/spi-armada-3700.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 77fe55ce790c..d65345312527 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -79,6 +79,7 @@
 #define A3700_SPI_BYTE_LEN		BIT(5)
 #define A3700_SPI_CLK_PRESCALE		BIT(0)
 #define A3700_SPI_CLK_PRESCALE_MASK	(0x1f)
+#define A3700_SPI_CLK_EVEN_OFFS		(0x10)
 
 #define A3700_SPI_WFIFO_THRS_BIT	28
 #define A3700_SPI_RFIFO_THRS_BIT	24
@@ -220,6 +221,13 @@ static void a3700_spi_clock_set(struct a3700_spi *a3700_spi,
 
 	prescale = DIV_ROUND_UP(clk_get_rate(a3700_spi->clk), speed_hz);
 
+	/* For prescaler values over 15, we can only set it by steps of 2.
+	 * Starting from A3700_SPI_CLK_EVEN_OFFS, we set values from 0 up to
+	 * 30. We only use this range from 16 to 30.
+	 */
+	if (prescale > 15)
+		prescale = A3700_SPI_CLK_EVEN_OFFS + DIV_ROUND_UP(prescale, 2);
+
 	val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
 	val = val & ~A3700_SPI_CLK_PRESCALE_MASK;
 
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
