From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 12/13] spi: spi-mxs: Don't set clock for each xfer
Date: Tue, 01 Oct 2013 13:15:47 -0700
Message-ID: <20131001201547.13660.33199.stgit@Graphine>
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

mxs_spi_setup_transfer() would set the SSP SCK rate every time it was
called, which is before every transfer.  It is uncommon for the SCK rate to
change between transfers (or at all of that matter) and this causes many
unnecessary reprogrammings of the clock registers.

Code changed to only set the rate when it changes.  This significantly
speeds up short SPI messages, especially messages made up of many transfers,
as the calculation of the clock divisors is rather costly.  On an iMX287,
using spidev with messages that consist of 511 transfers of 4 bytes each at
an SCK of 48 MHz, the effective transfer rate more than doubles from about
290 KB/sec to 600 KB/sec!

Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 9e6101a..759de70 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -67,6 +67,7 @@
 struct mxs_spi {
 	struct mxs_ssp		ssp;
 	struct completion	c;
+	unsigned int		sck;	/* Rate requested (vs actual) */
 };
 
 static int mxs_spi_setup_transfer(struct spi_device *dev,
@@ -81,7 +82,19 @@ static int mxs_spi_setup_transfer(struct spi_device *dev,
 		return -EINVAL;
 	}
 
-	mxs_ssp_set_clk_rate(ssp, hz);
+	if (hz != spi->sck) {
+		mxs_ssp_set_clk_rate(ssp, hz);
+		/*
+		 * Save requested rate, hz, rather than the actual rate,
+		 * ssp->clk_rate.  Otherwise we would set the rate every trasfer
+		 * when the actual rate is not quite the same as requested rate.
+		 */
+		spi->sck = hz;
+		/*
+		 * Perhaps we should return an error if the actual clock is
+		 * nowhere close to what was requested?
+		 */
+	}
 
 	writel(BM_SSP_CTRL0_LOCK_CS,
 		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
