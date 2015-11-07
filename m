From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: sun4i: allow transfers to set transmission speed
Date: Sat,  7 Nov 2015 23:41:05 +0100
Message-ID: <1446936065-15868-1-git-send-email-mweseloh42@gmail.com>
Reply-To: mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBDFO74UEV4IRBIH47GYQKGQEZ6KDO7A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Allow transfers to set the transmission speed, only fall back to
board max_speed_hz if requested speed is not set or invalid.

Signed-off-by: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-sun4i.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index fbb0a4d..0630691 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -173,6 +173,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	unsigned int tx_len = 0;
 	int ret = 0;
 	u32 reg;
+	u32 speed;
 
 	/* We don't support transfer larger than the FIFO */
 	if (tfr->len > SUN4I_FIFO_DEPTH)
@@ -227,10 +228,16 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
 
+	/* Transfer speed setup with fallback to board max_speed_hz */
+	if (tfr->speed_hz > 0 && tfr->speed_hz <= spi->max_speed_hz)
+		speed = tfr->speed_hz;
+	else
+		speed = spi->max_speed_hz;
+
 	/* Ensure that we have a parent clock fast enough */
 	mclk_rate = clk_get_rate(sspi->mclk);
-	if (mclk_rate < (2 * spi->max_speed_hz)) {
-		clk_set_rate(sspi->mclk, 2 * spi->max_speed_hz);
+	if (mclk_rate < (2 * speed)) {
+		clk_set_rate(sspi->mclk, 2 * speed);
 		mclk_rate = clk_get_rate(sspi->mclk);
 	}
 
@@ -248,14 +255,14 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
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
 
-- 
1.9.1
