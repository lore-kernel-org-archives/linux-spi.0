From: "Hermann Kraus" <hermr2d2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-sun4i, spi-sun6i: Fix bit rate calculation
Date: Sun, 02 Aug 2015 00:06:31 +0200
Message-ID: <op.x2pmc5kiltbbtz@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"Mark Brown" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Maxime Ripard" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use requested bit rate instead of maximum possible and correctly calculate
the divider.

There are two different maximum bitrates. "max_speed_hz" which is the  
maximum
for a given SPI device and "speed_hz" in "struct spi_transfer" which is  
the rate
used for this transfer. If "speed_hz" is non-zero it must be used.
The divider must be calculated by calling ilog2 only once, because this  
function
truncates the fractional part. Calling it twice increases the error so  
much that
certain bit rates which are available from the hardware can't be reached by
the kernel.
The result of this calculation must be checked to fit into the register  
size
instead of being truncated silently.

Signed-off-by: Hermann Kraus <hermr2d2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
  drivers/spi/spi-sun4i.c | 16 ++++++++++++----
  drivers/spi/spi-sun6i.c | 16 ++++++++++++----
  2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index fbb0a4d..82d717d 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -173,6 +173,7 @@ static int sun4i_spi_transfer_one(struct spi_master  
*master,
  	unsigned int tx_len = 0;
  	int ret = 0;
  	u32 reg;
+	u32 speed_hz = tfr->speed_hz ? : spi->max_speed_hz;

  	/* We don't support transfer larger than the FIFO */
  	if (tfr->len > SUN4I_FIFO_DEPTH)
@@ -229,8 +230,8 @@ static int sun4i_spi_transfer_one(struct spi_master  
*master,

  	/* Ensure that we have a parent clock fast enough */
  	mclk_rate = clk_get_rate(sspi->mclk);
-	if (mclk_rate < (2 * spi->max_speed_hz)) {
-		clk_set_rate(sspi->mclk, 2 * spi->max_speed_hz);
+	if (mclk_rate < (2 * speed_hz)) {
+		clk_set_rate(sspi->mclk, 2 * speed_hz);
  		mclk_rate = clk_get_rate(sspi->mclk);
  	}

@@ -248,14 +249,21 @@ static int sun4i_spi_transfer_one(struct spi_master  
*master,
  	 * First try CDR2, and if we can't reach the expected
  	 * frequency, fall back to CDR1.
  	 */
-	div = mclk_rate / (2 * spi->max_speed_hz);
+	div = mclk_rate / (2 * speed_hz);
  	if (div <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
  		if (div > 0)
  			div--;

  		reg = SUN4I_CLK_CTL_CDR2(div) | SUN4I_CLK_CTL_DRS;
  	} else {
-		div = ilog2(mclk_rate) - ilog2(spi->max_speed_hz);
+		/* ilog2 truncates the fractional part. Therefore we don't
+		 * subtract 1 from the result. */
+		div = ilog2(mclk_rate / speed_hz + 1);
+		if (div & ~SUN4I_CLK_CTL_CDR1_MASK) {
+			/* Can't reach low enough bit rate. */
+			ret = -EINVAL;
+			goto out;
+		}
  		reg = SUN4I_CLK_CTL_CDR1(div);
  	}

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index ac48f59..c3870be 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -163,6 +163,7 @@ static int sun6i_spi_transfer_one(struct spi_master  
*master,
  	unsigned int tx_len = 0;
  	int ret = 0;
  	u32 reg;
+	u32 speed_hz = tfr->speed_hz ? : spi->max_speed_hz;

  	/* We don't support transfer larger than the FIFO */
  	if (tfr->len > SUN6I_FIFO_DEPTH)
@@ -217,8 +218,8 @@ static int sun6i_spi_transfer_one(struct spi_master  
*master,

  	/* Ensure that we have a parent clock fast enough */
  	mclk_rate = clk_get_rate(sspi->mclk);
-	if (mclk_rate < (2 * spi->max_speed_hz)) {
-		clk_set_rate(sspi->mclk, 2 * spi->max_speed_hz);
+	if (mclk_rate < (2 * speed_hz)) {
+		clk_set_rate(sspi->mclk, 2 * speed_hz);
  		mclk_rate = clk_get_rate(sspi->mclk);
  	}

@@ -236,14 +237,21 @@ static int sun6i_spi_transfer_one(struct spi_master  
*master,
  	 * First try CDR2, and if we can't reach the expected
  	 * frequency, fall back to CDR1.
  	 */
-	div = mclk_rate / (2 * spi->max_speed_hz);
+	div = mclk_rate / (2 * speed_hz);
  	if (div <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
  		if (div > 0)
  			div--;

  		reg = SUN6I_CLK_CTL_CDR2(div) | SUN6I_CLK_CTL_DRS;
  	} else {
-		div = ilog2(mclk_rate) - ilog2(spi->max_speed_hz);
+		/* ilog2 truncates the fractional part. Therefore we don't
+		 * subtract 1 from the result. */
+		div = ilog2(mclk_rate / speed_hz + 1);
+		if (div & ~SUN6I_CLK_CTL_CDR1_MASK) {
+			/* Can't reach low enough bit rate. */
+			ret = -EINVAL;
+			goto out;
+		}
  		reg = SUN6I_CLK_CTL_CDR1(div);
  	}

-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
