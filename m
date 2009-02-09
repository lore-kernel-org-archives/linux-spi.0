From: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 2/3] pxa2xx_spi: set
	spi_master.dma_alignment = 8
Date: Mon,  9 Feb 2009 10:12:29 +0200
Message-ID: <60c923e5a328f72fee1e7f91eccb31f120329eb3.1234167048.git.mike@compulab.co.il>
References: <cover.1234167048.git.mike@compulab.co.il>
	<b9186e380ae53df7b4ce65a552b39d34879f3dd6.1234167048.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	andrey-W/OLz77bvjtBDgjK7y7TUQ@public.gmane.org, mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <b9186e380ae53df7b4ce65a552b39d34879f3dd6.1234167048.git.mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
In-Reply-To: <cover.1234167048.git.mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
References: <cover.1234167048.git.mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
 drivers/spi/pxa2xx_spi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index d0fc4ca..e38f6e0 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -55,6 +55,7 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 #define RESET_DMA_CHANNEL	(DCSR_NODESC | DMA_INT_MASK)
 #define IS_DMA_ALIGNED(x)	((((u32)(x)) & 0x07) == 0)
 #define MAX_DMA_LEN		8191
+#define DMA_ALIGNMENT		8
 
 /*
  * for testing SSCR1 changes that require SSP restart, basically
@@ -1440,6 +1441,7 @@ static int __init pxa2xx_spi_probe(struct platform_device *pdev)
 
 	master->bus_num = pdev->id;
 	master->num_chipselect = platform_info->num_chipselect;
+	master->dma_alignment = DMA_ALIGNMENT;
 	master->cleanup = cleanup;
 	master->setup = setup;
 	master->transfer = transfer;
-- 
1.5.6.4


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
