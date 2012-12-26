From: Juha Lumme <juha.lumme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] mxs: spi: clear XFER_LEN in CTRL0 register during DMA
Date: Wed, 26 Dec 2012 14:01:28 +0900
Message-ID: <1356498088-31176-1-git-send-email-juha.lumme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Juha Lumme <juha.lumme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

On MX23 the XFER_LEN part in CTRL0 register was improperly OR'd, and because
of that too many characters were being expected from SPI.
This caused a timeout (SSP_TIMEOUT) to happen in the last package in the DMA
chain, and resulted into a corrupted read.
This is a workaround for the problem, by clearing the XFER_LEN bytes always
before reading the new size for XFER_LEN.

Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Signed-off-by: Juha Lumme <juha.lumme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-mxs.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 86dd04d..265c33f 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -241,6 +241,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 	INIT_COMPLETION(spi->c);
 
 	ctrl0 = readl(ssp->base + HW_SSP_CTRL0);
+	ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
 	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
 
 	if (*first)
@@ -256,8 +257,10 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 		if ((sg_count + 1 == sgs) && *last)
 			ctrl0 |= BM_SSP_CTRL0_IGNORE_CRC;
 
-		if (ssp->devid == IMX23_SSP)
+		if (ssp->devid == IMX23_SSP) {
+			ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
 			ctrl0 |= min;
+		}
 
 		dma_xfer[sg_count].pio[0] = ctrl0;
 		dma_xfer[sg_count].pio[3] = min;
-- 
1.7.10.4


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
