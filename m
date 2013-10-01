From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 11/13] spi: spi-mxs: Clean up setup_transfer function
Date: Tue, 01 Oct 2013 13:15:40 -0700
Message-ID: <20131001201539.13660.12669.stgit@Graphine>
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

It can't be called with a NULL transfer anymore so it can be simplified
to not check for that.

Fix indention of line-wrapped code to Linux standard.

The transfer pointer can be const.

It's not necessary to check if the spi_transfer's speed_hz is zero, as
the spi core also fills it in from the spi_device.  However, the spi
core does not check if spi_device's speed is zero so we have to do
that still.

Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 23cc412..9e6101a 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -70,17 +70,14 @@ struct mxs_spi {
 };
 
 static int mxs_spi_setup_transfer(struct spi_device *dev,
-				struct spi_transfer *t)
+				  const struct spi_transfer *t)
 {
 	struct mxs_spi *spi = spi_master_get_devdata(dev->master);
 	struct mxs_ssp *ssp = &spi->ssp;
-	uint32_t hz = 0;
+	const unsigned int hz = min(dev->max_speed_hz, t->speed_hz);
 
-	hz = dev->max_speed_hz;
-	if (t && t->speed_hz)
-		hz = min(hz, t->speed_hz);
 	if (hz == 0) {
-		dev_err(&dev->dev, "Cannot continue with zero clock\n");
+		dev_err(&dev->dev, "SPI clock rate of zero not allowed\n");
 		return -EINVAL;
 	}
 
@@ -88,12 +85,12 @@ static int mxs_spi_setup_transfer(struct spi_device *dev,
 
 	writel(BM_SSP_CTRL0_LOCK_CS,
 		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
+
 	writel(BF_SSP_CTRL1_SSP_MODE(BV_SSP_CTRL1_SSP_MODE__SPI) |
-		     BF_SSP_CTRL1_WORD_LENGTH
-		     (BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS) |
-		     ((dev->mode & SPI_CPOL) ? BM_SSP_CTRL1_POLARITY : 0) |
-		     ((dev->mode & SPI_CPHA) ? BM_SSP_CTRL1_PHASE : 0),
-		     ssp->base + HW_SSP_CTRL1(ssp));
+	       BF_SSP_CTRL1_WORD_LENGTH(BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS) |
+	       ((dev->mode & SPI_CPOL) ? BM_SSP_CTRL1_POLARITY : 0) |
+	       ((dev->mode & SPI_CPHA) ? BM_SSP_CTRL1_PHASE : 0),
+	       ssp->base + HW_SSP_CTRL1(ssp));
 
 	writel(0x0, ssp->base + HW_SSP_CMD0);
 	writel(0x0, ssp->base + HW_SSP_CMD1);


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
