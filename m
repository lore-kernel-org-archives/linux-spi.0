From: Jaswinder Singh Rajput <jaswinder-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] SPI: includecheck fix:
	drivers/spi/amba-pl022.c
Date: Thu, 13 Aug 2009 12:52:51 +0530
Message-ID: <1250148171.6116.2.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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


fix the following 'make includecheck' warnings:

  drivers/spi/amba-pl022.c: linux/delay.h is included more than once.
  drivers/spi/amba-pl022.c: linux/errno.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/amba-pl022.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index da76797..c0f950a 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -38,14 +38,12 @@
 #include <linux/interrupt.h>
 #include <linux/spi/spi.h>
 #include <linux/workqueue.h>
-#include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl022.h>
 #include <linux/io.h>
-#include <linux/delay.h>
 
 /*
  * This macro is used to define some register default values.
-- 
1.6.0.6



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
