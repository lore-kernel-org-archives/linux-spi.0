From: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Subject: [patch 4/7] spi_s3c24xx: fix header includes
Date: Thu, 13 Aug 2009 11:06:06 +0100
Message-ID: <20090813100638.799449205@fluff.org>
References: <20090813100602.545180197@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 dbrownell-Rn4VEauK+AKRv+LV9MX5uv+2+P5yyue3@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=spi-fix-includes.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The driver includes <asm/io.h> where it should be including <linux/io.h>
and also includes <mach/hardware.h> and <asm/dma.h> without using anything
from these.

Signed-off-by; Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
---
 drivers/spi/spi_s3c24xx.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: b/drivers/spi/spi_s3c24xx.c
===================================================================
--- a/drivers/spi/spi_s3c24xx.c	2009-07-28 15:19:28.000000000 +0100
+++ b/drivers/spi/spi_s3c24xx.c	2009-07-28 15:20:16.000000000 +0100
@@ -20,14 +20,11 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/io.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 
-#include <asm/io.h>
-#include <asm/dma.h>
-#include <mach/hardware.h>
-
 #include <plat/regs-spi.h>
 #include <mach/spi.h>
 

-- 

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
