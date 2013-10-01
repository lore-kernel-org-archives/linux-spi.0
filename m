From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 08/13] spi: spi-mxs: Remove bogus setting of ssp clk rate field
Date: Tue, 01 Oct 2013 13:15:18 -0700
Message-ID: <20131001201518.13660.34120.stgit@Graphine>
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

The ssp struct has a clock rate field, to provide the actual value, in Hz,
of the SSP output clock (the rate of SSP_SCK) after mxs_ssp_set_clk_rate()
is called.  It is set by mxs_ssp_set_clk_rate(), for SSP using drivers (like
SPI and MMC) to *read* if they want to know the actual clock rate.  The SPI
driver isn't supposed to *write* to it.

For some reason the spi-mxs driver decides to write to this field on init,
and sets it to the value of the SSP input clock (clk_sspN, from the MXS
clocking block) in kHz.  It shouldn't be setting the value, and certainly
shouldn't be setting it with the wrong clock in the wrong units.

Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index de7387e..8cb5d8b 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -536,7 +536,6 @@ static int mxs_spi_probe(struct platform_device *pdev)
 		goto out_dma_release;
 
 	clk_set_rate(ssp->clk, clk_freq);
-	ssp->clk_rate = clk_get_rate(ssp->clk) / 1000;
 
 	ret = stmp_reset_block(ssp->base);
 	if (ret)


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
