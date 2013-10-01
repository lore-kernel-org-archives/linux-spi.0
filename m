From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 02/13] spi: spi-mxs: Remove mxs_spi_enable and mxs_spi_disable
Date: Tue, 01 Oct 2013 13:14:32 -0700
Message-ID: <20131001201432.13660.6230.stgit@Graphine>
References: <20131001201425.13660.72740.stgit@Graphine>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20131001201425.13660.72740.stgit@Graphine>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

These functions consist of nothing but one single writel call and are
only called once.  And the names really aren't accurate or clear,
since they don't enable or disble SPI.  Rather they set the bit that
controls the state of CS at the end of transfer.  It easier to follow
the code to just set this bit with a writel() along with all the other
bits being set in the same function.

Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c |   22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index e6172ae..991ee01 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -145,22 +145,6 @@ static void mxs_spi_set_cs(struct mxs_spi *spi, unsigned cs)
 	writel(select, ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 }
 
-static inline void mxs_spi_enable(struct mxs_spi *spi)
-{
-	struct mxs_ssp *ssp = &spi->ssp;
-
-	writel(BM_SSP_CTRL0_IGNORE_CRC,
-		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
-}
-
-static inline void mxs_spi_disable(struct mxs_spi *spi)
-{
-	struct mxs_ssp *ssp = &spi->ssp;
-
-	writel(BM_SSP_CTRL0_IGNORE_CRC,
-		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
-}
-
 static int mxs_ssp_wait(struct mxs_spi *spi, int offset, int mask, bool set)
 {
 	const unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
@@ -335,13 +319,15 @@ static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
 	struct mxs_ssp *ssp = &spi->ssp;
 
 	if (*first)
-		mxs_spi_enable(spi);
+		writel(BM_SSP_CTRL0_IGNORE_CRC,
+		       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
 
 	mxs_spi_set_cs(spi, cs);
 
 	while (len--) {
 		if (*last && len == 0)
-			mxs_spi_disable(spi);
+			writel(BM_SSP_CTRL0_IGNORE_CRC,
+			       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 
 		if (ssp->devid == IMX23_SSP) {
 			writel(BM_SSP_CTRL0_XFER_COUNT,


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
