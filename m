From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Use menuconfig for CONFIG_SPI
Date: Wed, 13 Feb 2008 15:39:06 -0800
Message-ID: <200802131539.06642.david-b@pacbell.net>
References: <200802132328.01729.alessandro.guido@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Alessandro Guido <alessandro.guido-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200802132328.01729.alessandro.guido-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

From: Alessandro Guido <alessandro.guido-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Use menuconfig for CONFIG_SPI

Signed-off-by: Alessandro Guido <alessandro.guido-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/Kconfig |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- g26.orig/drivers/spi/Kconfig	2008-02-11 19:18:40.000000000 -0800
+++ g26/drivers/spi/Kconfig	2008-02-13 15:33:03.000000000 -0800
@@ -5,11 +5,9 @@
 # nobody's needed a slave side API yet.  The master-role API is not
 # fully appropriate there, so it'd need some thought to do well.
 #
-menu "SPI support"
-	depends on HAS_IOMEM
-
-config SPI
+menuconfig SPI
 	bool "SPI support"
+	depends on HAS_IOMEM
 	help
 	  The "Serial Peripheral Interface" is a low level synchronous
 	  protocol.  Chips that support SPI can have data transfer rates
@@ -28,9 +26,11 @@ config SPI
 	  (half duplex), SSP, SSI, and PSP.  This driver framework should
 	  work with most such devices and controllers.
 
+if SPI
+
 config SPI_DEBUG
 	boolean "Debug support for SPI drivers"
-	depends on SPI && DEBUG_KERNEL
+	depends on DEBUG_KERNEL
 	help
 	  Say "yes" to enable debug messaging (like dev_dbg and pr_debug),
 	  sysfs, and debugfs support in SPI controller and protocol drivers.
@@ -252,5 +252,4 @@ config SPI_TLE62X0
 
 # (slave support would go here)
 
-endmenu # "SPI support"
-
+endif # SPI

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
