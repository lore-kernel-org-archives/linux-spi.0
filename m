From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 2/9] S3C24XX: Fix sparse errors in
	platform uncompress.h
Date: Fri, 10 Oct 2008 11:03:46 +0100
Message-ID: <20081010100404.876945838@fluff.org.uk>
References: <20081010100344.572052114@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-s3c24xx-sparse-uncompress-header.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Ensure we __force the __iomem attribute off when we use
our minimal __raw_writel() implementation.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.27-rc6-quilt3/arch/arm/plat-s3c/include/plat/uncompress.h
===================================================================
--- linux-2.6.27-rc6-quilt3.orig/arch/arm/plat-s3c/include/plat/uncompress.h	2008-09-14 23:47:23.000000000 +0100
+++ linux-2.6.27-rc6-quilt3/arch/arm/plat-s3c/include/plat/uncompress.h	2008-09-14 23:51:39.000000000 +0100
@@ -90,7 +90,7 @@ static inline void flush(void)
 {
 }
 
-#define __raw_writel(d,ad) do { *((volatile unsigned int *)(ad)) = (d); } while(0)
+#define __raw_writel(d,ad) do { *((volatile unsigned int __force *)(ad)) = (d); } while(0)
 
 /* CONFIG_S3C_BOOT_WATCHDOG
  *

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
