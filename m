From: Jesper Juhl <jesper.juhl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH][14/37] Clean up duplicate includes in
	drivers/spi/
Date: Sat, 21 Jul 2007 17:02:56 +0200
Message-ID: <200707211702.56466.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Jesper Juhl <jesper.juhl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Aubrey Li <aubrey.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>
To: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

This patch cleans up duplicate includes in
	drivers/spi/


Signed-off-by: Jesper Juhl <jesper.juhl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index e51311b..16bf66b 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -26,7 +26,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/spi/spi.h>
 #include <linux/workqueue.h>
-#include <linux/errno.h>
 #include <linux/delay.h>
 
 #include <asm/io.h>
diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 48587c2..88362b4 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -39,7 +39,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/spi/spi.h>
 #include <linux/workqueue.h>
-#include <linux/errno.h>
 #include <linux/delay.h>
 
 #include <asm/io.h>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
