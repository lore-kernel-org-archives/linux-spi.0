From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: davinci: Set prescale value based on register value" to the spi tree
Date: Fri, 24 Jul 2015 18:29:21 +0100
Message-ID: <E1ZIgmf-0001Jb-JC@debutante>
References: <1436903127-6777-2-git-send-email-fcooper@ti.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436903127-6777-2-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: davinci: Set prescale value based on register value

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

>From bba732d86694f7217a41e83a2c1deb42ed9aa7fd Mon Sep 17 00:00:00 2001
From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Date: Wed, 22 Jul 2015 07:32:21 -0500
Subject: [PATCH] spi: davinci: Set prescale value based on register value

Within davinci_spi_get_prescale() the prescale has two meanings. First one
being the calculated prescale value and then at the end translates it to the
prescale value that will be written to the SPI register.

At first glance this can be confusing especially when comparing the minimum
prescale value against what is seen in the TRM.

To simplify things make it clear that the calculated prescale value will always
be based on the value that will be written into the SPI register.

Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 987afebea093..b4605c4158f4 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -255,7 +255,7 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
  * This function calculates the prescale value that generates a clock rate
  * less than or equal to the specified maximum.
  *
- * Returns: calculated prescale - 1 for easy programming into SPI registers
+ * Returns: calculated prescale value for easy programming into SPI registers
  * or negative error number if valid prescalar cannot be updated.
  */
 static inline int davinci_spi_get_prescale(struct davinci_spi *dspi,
@@ -263,12 +263,13 @@ static inline int davinci_spi_get_prescale(struct davinci_spi *dspi,
 {
 	int ret;
 
-	ret = DIV_ROUND_UP(clk_get_rate(dspi->clk), max_speed_hz);
+	/* Subtract 1 to match what will be programmed into SPI register. */
+	ret = DIV_ROUND_UP(clk_get_rate(dspi->clk), max_speed_hz) - 1;
 
-	if (ret < 1 || ret > 256)
+	if (ret < 0 || ret > 255)
 		return -EINVAL;
 
-	return ret - 1;
+	return ret;
 }
 
 /**
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
