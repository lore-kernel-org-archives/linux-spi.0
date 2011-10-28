From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/3] OMAP: SPI: call pm_runtime_disable in error path and
	remove
Date: Fri, 28 Oct 2011 17:14:18 +0530
Message-ID: <1319802259-16565-3-git-send-email-shubhrajyoti@ti.com>
References: <1319802259-16565-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1319802259-16565-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

omap mcspi probe() doesnt call pm_runtime  disable functions
in case of failure. remove() doesnt call pm_runtime disable. This could
lead to warnings as below on subsequent insmod.

~# insmod spi-omap2-mcspi.ko
[  255.383671] omap2_mcspi omap2_mcspi.1: Unbalanced pm_runtime_enable!
...

This patch adds the pm_runtime disable() at appropriate stages.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 471b0f3..6875a0b 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1195,6 +1195,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 err4:
 	spi_master_put(master);
 err3:
+	pm_runtime_disable(&pdev->dev);
 	kfree(mcspi->dma_channels);
 err2:
 	release_mem_region(r->start, resource_size(r));
@@ -1216,6 +1217,7 @@ static int __exit omap2_mcspi_remove(struct platform_device *pdev)
 	dma_channels = mcspi->dma_channels;
 
 	omap2_mcspi_disable_clocks(mcspi);
+	pm_runtime_disable(&pdev->dev);
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(r->start, resource_size(r));
 
-- 
1.7.1


------------------------------------------------------------------------------
The demand for IT networking professionals continues to grow, and the
demand for specialized networking skills is growing even more rapidly.
Take a complimentary Learning@Cisco Self-Assessment and learn 
about Cisco certifications, training, and career opportunities. 
http://p.sf.net/sfu/cisco-dev2dev
