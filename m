From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/9] spi: sunxi: check that transfer speed is non-zero
Date: 20 Aug 2015 14:19:46 -0000
Message-ID: <3688fab67e7cdc7bcbff73dfd6b0fcdcc4e79eb6.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
  Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
  Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
  Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
  Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
  Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
  linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
  linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
Return-path: <linux-sunxi+bncBCQMLUOX54MBBBOE26XAKGQEDCICVKY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <cover.1440080122.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

When the maximum transfer speed is not set for a SPI slave the value
remains 0 and the code in sunxi SPI divides by it. Use an arbitrary
speed instead in that case.

Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-sun4i.c | 15 ++++++++++-----
 drivers/spi/spi-sun6i.c | 15 ++++++++++-----
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 707f61b..4dda366 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -169,7 +169,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 				  struct spi_transfer *tfr)
 {
 	struct sun4i_spi *sspi = spi_master_get_devdata(master);
-	unsigned int mclk_rate, div, timeout;
+	unsigned int speed, mclk_rate, div, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int tx_len = 0;
 	int ret = 0;
@@ -230,10 +230,15 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
 
+	speed = spi->max_speed_hz;
+	if (!speed) {
+		speed = 100000;
+		dev_warn(&spi->dev, "SPI speed not set. Using %uHz.", speed);
+	}
 	/* Ensure that we have a parent clock fast enough */
 	mclk_rate = clk_get_rate(sspi->mclk);
-	if (mclk_rate < (2 * spi->max_speed_hz)) {
-		clk_set_rate(sspi->mclk, 2 * spi->max_speed_hz);
+	if (mclk_rate < (2 * speed)) {
+		clk_set_rate(sspi->mclk, 2 * speed);
 		mclk_rate = clk_get_rate(sspi->mclk);
 	}
 
@@ -251,14 +256,14 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	 * First try CDR2, and if we can't reach the expected
 	 * frequency, fall back to CDR1.
 	 */
-	div = mclk_rate / (2 * spi->max_speed_hz);
+	div = mclk_rate / (2 * speed);
 	if (div <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
 		if (div > 0)
 			div--;
 
 		reg = SUN4I_CLK_CTL_CDR2(div) | SUN4I_CLK_CTL_DRS;
 	} else {
-		div = ilog2(mclk_rate) - ilog2(spi->max_speed_hz);
+		div = ilog2(mclk_rate) - ilog2(speed);
 		reg = SUN4I_CLK_CTL_CDR1(div);
 	}
 
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 3d0f66c..cf6a33e 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -159,7 +159,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 				  struct spi_transfer *tfr)
 {
 	struct sun6i_spi *sspi = spi_master_get_devdata(master);
-	unsigned int mclk_rate, div, timeout;
+	unsigned int speed, mclk_rate, div, timeout;
 	unsigned int tx_len = 0;
 	int ret = 0;
 	unsigned int start, end, tx_time;
@@ -216,10 +216,15 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
 
+	speed = spi->max_speed_hz;
+	if(!speed) {
+		speed = 100000;
+		dev_warn(&spi->dev, "SPI speed not set. Using %uHz.", speed);
+	}
 	/* Ensure that we have a parent clock fast enough */
 	mclk_rate = clk_get_rate(sspi->mclk);
-	if (mclk_rate < (2 * spi->max_speed_hz)) {
-		clk_set_rate(sspi->mclk, 2 * spi->max_speed_hz);
+	if (mclk_rate < (2 * speed)) {
+		clk_set_rate(sspi->mclk, 2 * speed);
 		mclk_rate = clk_get_rate(sspi->mclk);
 	}
 
@@ -237,14 +242,14 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	 * First try CDR2, and if we can't reach the expected
 	 * frequency, fall back to CDR1.
 	 */
-	div = mclk_rate / (2 * spi->max_speed_hz);
+	div = mclk_rate / (2 * speed);
 	if (div <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
 		if (div > 0)
 			div--;
 
 		reg = SUN6I_CLK_CTL_CDR2(div) | SUN6I_CLK_CTL_DRS;
 	} else {
-		div = ilog2(mclk_rate) - ilog2(spi->max_speed_hz);
+		div = ilog2(mclk_rate) - ilog2(speed);
 		reg = SUN6I_CLK_CTL_CDR1(div);
 	}
 
-- 
2.1.4
