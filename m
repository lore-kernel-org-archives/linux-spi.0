From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 13/13] spi: spi-mxs: Use u32 instead of uint32_t
Date: Tue, 01 Oct 2013 13:15:54 -0700
Message-ID: <20131001201554.13660.4423.stgit@Graphine>
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

It's consistent with all the other spi drivers that way.

Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 759de70..2a819f7 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -119,9 +119,9 @@ static int mxs_spi_setup(struct spi_device *dev)
 	return 0;
 }
 
-static uint32_t mxs_spi_cs_to_reg(unsigned cs)
+static u32 mxs_spi_cs_to_reg(unsigned cs)
 {
-	uint32_t select = 0;
+	u32 select = 0;
 
 	/*
 	 * i.MX28 Datasheet: 17.10.1: HW_SSP_CTRL0
@@ -143,7 +143,7 @@ static int mxs_ssp_wait(struct mxs_spi *spi, int offset, int mask, bool set)
 {
 	const unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
 	struct mxs_ssp *ssp = &spi->ssp;
-	uint32_t reg;
+	u32 reg;
 
 	do {
 		reg = readl_relaxed(ssp->base + offset);
@@ -187,11 +187,11 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
 	const int sgs = DIV_ROUND_UP(len, desc_len);
 	int sg_count;
 	int min, ret;
-	uint32_t ctrl0;
+	u32 ctrl0;
 	struct page *vm_page;
 	void *sg_buf;
 	struct {
-		uint32_t		pio[4];
+		u32			pio[4];
 		struct scatterlist	sg;
 	} *dma_xfer;
 


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
