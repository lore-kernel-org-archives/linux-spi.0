From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] spi:clk: preparation for switch to common clock framework
Date: Thu, 30 Aug 2012 14:25:21 -0400
Message-ID: <1346351121-27710-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
To: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
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

As a first step towards migrating davinci platforms to use common clock
framework, replace all instances of clk_enable() with clk_prepare_enable()
and clk_disable() with clk_disable_unprepare(). Until the platform is
switched to use the CONFIG_HAVE_CLK_PREPARE Kconfig variable, this just
adds a might_sleep() call and would work without any issues.

This will make it easy later to switch to common clk based implementation
of clk driver from DaVinci specific driver.

Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-davinci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 9b2901f..71a6423 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -873,7 +873,7 @@ static int __devinit davinci_spi_probe(struct platform_device *pdev)
 		ret = -ENODEV;
 		goto put_master;
 	}
-	clk_enable(dspi->clk);
+	clk_prepare_enable(dspi->clk);
 
 	master->bus_num = pdev->id;
 	master->num_chipselect = pdata->num_chipselect;
@@ -959,7 +959,7 @@ free_dma:
 	edma_free_channel(dspi->dma.rx_channel);
 	edma_free_slot(dspi->dma.dummy_param_slot);
 free_clk:
-	clk_disable(dspi->clk);
+	clk_disable_unprepare(dspi->clk);
 	clk_put(dspi->clk);
 put_master:
 	spi_master_put(master);
@@ -995,7 +995,7 @@ static int __devexit davinci_spi_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&dspi->bitbang);
 
-	clk_disable(dspi->clk);
+	clk_disable_unprepare(dspi->clk);
 	clk_put(dspi->clk);
 	spi_master_put(master);
 	free_irq(dspi->irq, dspi);
-- 
1.7.9.5


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
