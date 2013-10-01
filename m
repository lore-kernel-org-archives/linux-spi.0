From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 01/13] spi: spi-mxs: Always set LOCK_CS
Date: Tue, 01 Oct 2013 13:14:25 -0700
Message-ID: <20131001201425.13660.72740.stgit@Graphine>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

There are two bits which control the CS line in the CTRL0 register:
LOCK_CS and IGNORE_CRC.  The latter would be better named DEASSERT_CS
in SPI mode.

LOCK_CS keeps CS asserted though the entire transfer.  This should
always be set.  The DMA code will always set it, explicitly on the
first segment of the first transfer, and then implicitly on all the
rest by never clearing the bit from the value read from the ctrl0
register.

The PIO code will explicitly set it for the first transfer, leave it
set for intermediate transfers, and then clear it for the final
transfer.  It should not clear it.

The only reason to not set LOCK_CS would be to attempt an altered
protocol where CS pulses between each word.  Though don't get your
hopes up if you want to do this, as the hardware doesn't appear to do
this in any sane manner.  It appears to be related to the hardware
FIFO fill level.

The code can be simplified by just setting LOCK_CS once and then not
needing to deal with it at all in the PIO and DMA transfer functions.

Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index de7b114..e6172ae 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -79,6 +79,8 @@ static int mxs_spi_setup_transfer(struct spi_device *dev,
 
 	mxs_ssp_set_clk_rate(ssp, hz);
 
+	writel(BM_SSP_CTRL0_LOCK_CS,
+		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 	writel(BF_SSP_CTRL1_SSP_MODE(BV_SSP_CTRL1_SSP_MODE__SPI) |
 		     BF_SSP_CTRL1_WORD_LENGTH
 		     (BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS) |
@@ -147,8 +149,6 @@ static inline void mxs_spi_enable(struct mxs_spi *spi)
 {
 	struct mxs_ssp *ssp = &spi->ssp;
 
-	writel(BM_SSP_CTRL0_LOCK_CS,
-		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 	writel(BM_SSP_CTRL0_IGNORE_CRC,
 		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
 }
@@ -157,8 +157,6 @@ static inline void mxs_spi_disable(struct mxs_spi *spi)
 {
 	struct mxs_ssp *ssp = &spi->ssp;
 
-	writel(BM_SSP_CTRL0_LOCK_CS,
-		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
 	writel(BM_SSP_CTRL0_IGNORE_CRC,
 		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 }
@@ -232,8 +230,6 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 	ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
 	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
 
-	if (*first)
-		ctrl0 |= BM_SSP_CTRL0_LOCK_CS;
 	if (!write)
 		ctrl0 |= BM_SSP_CTRL0_READ;
 


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
