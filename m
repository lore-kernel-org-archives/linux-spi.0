From: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 3/3] spi_imx: set
	spi_master.dma_alignment = 4
Date: Mon,  9 Feb 2009 10:12:30 +0200
Message-ID: <fbb789f954d4dc939100f6d3e823f4dc4d8c2205.1234167048.git.mike@compulab.co.il>
References: <cover.1234167048.git.mike@compulab.co.il>
	<b9186e380ae53df7b4ce65a552b39d34879f3dd6.1234167048.git.mike@compulab.co.il>
	<60c923e5a328f72fee1e7f91eccb31f120329eb3.1234167048.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	andrey-W/OLz77bvjtBDgjK7y7TUQ@public.gmane.org, mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <60c923e5a328f72fee1e7f91eccb31f120329eb3.1234167048.git.mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
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
 drivers/spi/spi_imx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 269a55e..b36b5a1 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -186,6 +186,7 @@
 #define QUEUE_STOPPED			(1)
 
 #define IS_DMA_ALIGNED(x) 		(((u32)(x) & 0x03) == 0)
+#define DMA_ALIGNMENT			4
 /*-------------------------------------------------------------------------*/
 
 
@@ -1481,6 +1482,7 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 
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
