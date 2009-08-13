From: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Subject: [patch 5/7] spi_s3c24xx: use resource_size() to
	get resource size
Date: Thu, 13 Aug 2009 11:06:07 +0100
Message-ID: <20090813100639.003140517@fluff.org>
References: <20090813100602.545180197@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 dbrownell-Rn4VEauK+AKRv+LV9MX5uv+2+P5yyue3@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=spi-use-resource-size.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Change the use of (res->end - res->start) to use resource_size() to
get the size of the resource.

Signed-off-by: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
---
 drivers/spi/spi_s3c24xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/spi/spi_s3c24xx.c
===================================================================
--- a/drivers/spi/spi_s3c24xx.c	2009-08-08 09:53:33.000000000 +0100
+++ b/drivers/spi/spi_s3c24xx.c	2009-08-08 09:54:03.000000000 +0100
@@ -299,7 +299,7 @@ static int __init s3c24xx_spi_probe(stru
 		goto err_no_iores;
 	}
 
-	hw->ioarea = request_mem_region(res->start, (res->end - res->start)+1,
+	hw->ioarea = request_mem_region(res->start, resource_size(res),
 					pdev->name);
 
 	if (hw->ioarea == NULL) {
@@ -308,7 +308,7 @@ static int __init s3c24xx_spi_probe(stru
 		goto err_no_iores;
 	}
 
-	hw->regs = ioremap(res->start, (res->end - res->start)+1);
+	hw->regs = ioremap(res->start, resource_size(res));
 	if (hw->regs == NULL) {
 		dev_err(&pdev->dev, "Cannot map IO\n");
 		err = -ENXIO;

-- 

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
