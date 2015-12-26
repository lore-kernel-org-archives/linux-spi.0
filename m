From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 2/3] spi: sun4i: Fix clock calculations to be
 predictable and never exceed the requested rate
Date: Sat, 26 Dec 2015 16:53:05 +0100
Message-ID: <1451145186-14235-3-git-send-email-mweseloh42@gmail.com>
References: <1451145186-14235-1-git-send-email-mweseloh42@gmail.com>
Reply-To: mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Return-path: <linux-sunxi+bncBDFO74UEV4IRB5HP7KZQKGQESPNCO4A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1451145186-14235-1-git-send-email-mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

This patch fixes multiple problems with the current clock calculations:

1. The A10/A20 datasheet contains the formula AHB_CLK / (2^(n+1)) to
calculate SPI_CLK from CDR1, but this formula is wrong. The actual
formula - determined by analyzing the actual waveforms - is
AHB_CLK / (2^n).

2. The divisor calculations for CDR1 and CDR2 both rounded to the
nearest integer. This could lead to a transfer speed that is higher than
the requested speed. This patch changes both calculations to always
round down.

3. The mclk frequency was only ever increased, never decreased. This could
lead to unpredictable transfer speeds, depending on the order in which
transfers with different speeds where serviced by the SPI driver.

Signed-off-by: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-sun4i.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index f60a6d6..d67e142 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -79,6 +79,9 @@ struct sun4i_spi {
 	struct clk		*hclk;
 	struct clk		*mclk;
 
+	int			cur_max_speed;
+	int			cur_mclk;
+
 	struct completion	done;
 
 	const u8		*tx_buf;
@@ -227,11 +230,17 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
 
-	/* Ensure that we have a parent clock fast enough */
+	/*
+	 * Ensure that the parent clock is set to twice the max speed
+	 * of the spi device (possibly rounded up by the clk driver)
+	 */
 	mclk_rate = clk_get_rate(sspi->mclk);
-	if (mclk_rate < (2 * tfr->speed_hz)) {
-		clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
+	if (spi->max_speed_hz != sspi->cur_max_speed ||
+	    mclk_rate != sspi->cur_mclk) {
+		clk_set_rate(sspi->mclk, 2 * spi->max_speed_hz);
 		mclk_rate = clk_get_rate(sspi->mclk);
+		sspi->cur_mclk = mclk_rate;
+		sspi->cur_max_speed = spi->max_speed_hz;
 	}
 
 	/*
@@ -239,7 +248,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	 *
 	 * We have two choices there. Either we can use the clock
 	 * divide rate 1, which is calculated thanks to this formula:
-	 * SPI_CLK = MOD_CLK / (2 ^ (cdr + 1))
+	 * SPI_CLK = MOD_CLK / (2 ^ cdr)
 	 * Or we can use CDR2, which is calculated with the formula:
 	 * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
 	 * Wether we use the former or the latter is set through the
@@ -248,14 +257,11 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	 * First try CDR2, and if we can't reach the expected
 	 * frequency, fall back to CDR1.
 	 */
-	div = mclk_rate / (2 * tfr->speed_hz);
-	if (div <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
-		if (div > 0)
-			div--;
-
+	div = DIV_ROUND_UP(mclk_rate, 2 * tfr->speed_hz) - 1;
+	if (div <= SUN4I_CLK_CTL_CDR2_MASK) {
 		reg = SUN4I_CLK_CTL_CDR2(div) | SUN4I_CLK_CTL_DRS;
 	} else {
-		div = ilog2(mclk_rate) - ilog2(tfr->speed_hz);
+		div = ilog2(roundup_pow_of_two(mclk_rate / tfr->speed_hz));
 		reg = SUN4I_CLK_CTL_CDR1(div);
 	}
 
-- 
1.9.1
