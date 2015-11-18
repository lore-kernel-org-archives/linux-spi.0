From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: sun4i: allow transfers to set transmission speed" to the spi tree
Date: Wed, 18 Nov 2015 18:47:23 +0000
Message-ID: <E1Zz7lL-0001TT-Oh@debutante>
References: <1446980603-27435-1-git-send-email-mweseloh42@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446980603-27435-1-git-send-email-mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: sun4i: allow transfers to set transmission speed

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

>From 47284e3e0f3c427c93f8583549b6c938e8a18015 Mon Sep 17 00:00:00 2001
From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 8 Nov 2015 12:03:23 +0100
Subject: [PATCH] spi: sun4i: allow transfers to set transmission speed

Allow transfers to set the transmission speed rather than using the
device max_speed_hz value. The SPI core makes sure that the speed_hz
value is always set on the transfer.

Signed-off-by: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-sun4i.c | 8 ++++----
 drivers/spi/spi-sun6i.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index fbb0a4d74e91..f60a6d634d61 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -229,8 +229,8 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	/* Ensure that we have a parent clock fast enough */
 	mclk_rate = clk_get_rate(sspi->mclk);
-	if (mclk_rate < (2 * spi->max_speed_hz)) {
-		clk_set_rate(sspi->mclk, 2 * spi->max_speed_hz);
+	if (mclk_rate < (2 * tfr->speed_hz)) {
+		clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
 		mclk_rate = clk_get_rate(sspi->mclk);
 	}
 
@@ -248,14 +248,14 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	 * First try CDR2, and if we can't reach the expected
 	 * frequency, fall back to CDR1.
 	 */
-	div = mclk_rate / (2 * spi->max_speed_hz);
+	div = mclk_rate / (2 * tfr->speed_hz);
 	if (div <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
 		if (div > 0)
 			div--;
 
 		reg = SUN4I_CLK_CTL_CDR2(div) | SUN4I_CLK_CTL_DRS;
 	} else {
-		div = ilog2(mclk_rate) - ilog2(spi->max_speed_hz);
+		div = ilog2(mclk_rate) - ilog2(tfr->speed_hz);
 		reg = SUN4I_CLK_CTL_CDR1(div);
 	}
 
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index ac48f59705a8..42e2c4bd690a 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -217,8 +217,8 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 
 	/* Ensure that we have a parent clock fast enough */
 	mclk_rate = clk_get_rate(sspi->mclk);
-	if (mclk_rate < (2 * spi->max_speed_hz)) {
-		clk_set_rate(sspi->mclk, 2 * spi->max_speed_hz);
+	if (mclk_rate < (2 * tfr->speed_hz)) {
+		clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
 		mclk_rate = clk_get_rate(sspi->mclk);
 	}
 
@@ -236,14 +236,14 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	 * First try CDR2, and if we can't reach the expected
 	 * frequency, fall back to CDR1.
 	 */
-	div = mclk_rate / (2 * spi->max_speed_hz);
+	div = mclk_rate / (2 * tfr->speed_hz);
 	if (div <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
 		if (div > 0)
 			div--;
 
 		reg = SUN6I_CLK_CTL_CDR2(div) | SUN6I_CLK_CTL_DRS;
 	} else {
-		div = ilog2(mclk_rate) - ilog2(spi->max_speed_hz);
+		div = ilog2(mclk_rate) - ilog2(tfr->speed_hz);
 		reg = SUN6I_CLK_CTL_CDR1(div);
 	}
 
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
