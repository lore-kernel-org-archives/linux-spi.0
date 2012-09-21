From: Bastian Hecht <hechtb-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH 2/4] spi: Add SH Mobile series as dependency to MSIOF
	controller
Date: Fri, 21 Sep 2012 13:00:47 +0200
Message-ID: <1348225249-1294-2-git-send-email-hechtb@gmail.com>
References: <1348225249-1294-1-git-send-email-hechtb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1348225249-1294-1-git-send-email-hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The MSIOF hardware block is used in the SH Mobile series as well, so we
add it here.

Signed-off-by: Bastian Hecht <hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cd2fe35..cf77a4b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -318,10 +318,10 @@ config SPI_S3C64XX
 
 config SPI_SH_MSIOF
 	tristate "SuperH MSIOF SPI controller"
-	depends on SUPERH && HAVE_CLK
+	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
 	select SPI_BITBANG
 	help
-	  SPI driver for SuperH MSIOF blocks.
+	  SPI driver for SuperH and SH Mobile MSIOF blocks.
 
 config SPI_SH
 	tristate "SuperH SPI controller"
-- 
1.7.5.4


------------------------------------------------------------------------------
Got visibility?
Most devs has no idea what their production app looks like.
Find out how fast your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219671;13503038;y?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
