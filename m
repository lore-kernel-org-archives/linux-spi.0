From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] OMAP: SPI: Fix the trying to free nonexistent resource error
Date: Mon, 24 Oct 2011 15:54:24 +0530
Message-ID: <1319451864-8212-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Currently there is a request_mem_region(r->start, ..
followed by r->start += pdata->regs_offset;

And then in remove

   r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   release_mem_region(r->start, resource_size(r));

Here the offset addition is not taken care. Fix the code for the
same.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 06dc9a9..471b0f3 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1123,15 +1123,15 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 		status = -ENODEV;
 		goto err1;
 	}
+	r->start += pdata->regs_offset;
+	r->end += pdata->regs_offset;
+	mcspi->phys = r->start;
 	if (!request_mem_region(r->start, resource_size(r),
 				dev_name(&pdev->dev))) {
 		status = -EBUSY;
 		goto err1;
 	}
 
-	r->start += pdata->regs_offset;
-	r->end += pdata->regs_offset;
-	mcspi->phys = r->start;
 	mcspi->base = ioremap(r->start, resource_size(r));
 	if (!mcspi->base) {
 		dev_dbg(&pdev->dev, "can't ioremap MCSPI\n");
-- 
1.7.1


------------------------------------------------------------------------------
The demand for IT networking professionals continues to grow, and the
demand for specialized networking skills is growing even more rapidly.
Take a complimentary Learning@Cisco Self-Assessment and learn 
about Cisco certifications, training, and career opportunities. 
http://p.sf.net/sfu/cisco-dev2dev
