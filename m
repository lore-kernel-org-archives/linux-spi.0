From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 05/13] spi: spi-mxs: Fix extra CS pulses and read mode in
	multi-transfer messages
Date: Tue, 01 Oct 2013 13:14:57 -0700
Message-ID: <20131001201457.13660.87395.stgit@Graphine>
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

There are two bits which control the CS line in the CTRL0 register:
LOCK_CS and IGNORE_CRC.  The latter would be better named DEASSERT_CS
in SPI mode.

Setting DEASSERT_CS causes CS to be de-asserted at the end of the transfer.
It should normally be set only for the final segment of the final transfer.
The DMA code explicitly sets it in this case, but because it never clears
the bit from the ctrl0 register, it will remain set for all transfers in
subsequent messages.  This results in a CS pulse between transfers.

There is a similar problem with the read mode bit never being cleared
in DMA mode.

This patch fixes DEASSERT_CS and READ being left on in DMA mode.

Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 090930a..68ea507 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -218,7 +218,8 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 	INIT_COMPLETION(spi->c);
 
 	ctrl0 = readl(ssp->base + HW_SSP_CTRL0);
-	ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
+	ctrl0 &= ~(BM_SSP_CTRL0_XFER_COUNT | BM_SSP_CTRL0_IGNORE_CRC |
+		 BM_SSP_CTRL0_READ);
 	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
 
 	if (!(flags & TXRX_WRITE))


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
