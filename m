From: Alessandro Guido <alessandro.guido-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Use menuconfig for CONFIG_SPI
Date: Wed, 13 Feb 2008 23:28:00 +0100
Message-ID: <200802132328.01729.alessandro.guido@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Signed-off-by: Alessandro Guido <alessandro.guido-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---

 drivers/spi/Kconfig |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d810789..fae9e8f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
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
@@ -245,5 +245,4 @@ config SPI_TLE62X0
 
 # (slave support would go here)
 
-endmenu # "SPI support"
-
+endif # SPI

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
