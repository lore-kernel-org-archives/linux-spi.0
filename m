From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.30-rc2] pxa2xx_spi: restore DRCMR on
	resume
Date: Thu, 16 Apr 2009 11:44:23 -0700
Message-ID: <200904161144.23813.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

If DMA is enabled, any spi_sync call after suspend/resume would block forever,
because DRCMR is lost on suspend. This patch restores DRCMR to the same values
set by probe.

Signed-off-by: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/pxa2xx_spi.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1700,6 +1700,13 @@ static int pxa2xx_spi_resume(struct plat
 	struct ssp_device *ssp = drv_data->ssp;
 	int status = 0;
 
+	if (drv_data->rx_channel != -1)
+		DRCMR(drv_data->ssp->drcmr_rx) =
+			DRCMR_MAPVLD | drv_data->rx_channel;
+	if (drv_data->tx_channel != -1)
+		DRCMR(drv_data->ssp->drcmr_tx) =
+			DRCMR_MAPVLD | drv_data->tx_channel;
+
 	/* Enable the SSP clock */
 	clk_enable(ssp->clk);
 

------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
