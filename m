From: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] mcspi: Add support for GPIO chip select lines
Date: Sun, 13 Feb 2011 17:10:33 -0500
Message-ID: <1297635034-24504-1-git-send-email-bgamari.foss@gmail.com>
References: <c0ffcf4415b8edbf55d653a620b92fbbbcd8fed7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <c0ffcf4415b8edbf55d653a620b92fbbbcd8fed7>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Many applications require more chip select lines than the board or
processor allow. Introduce a mechanism to allow use of GPIO pins as chip
select lines with the McSPI controller.  To use this functionality, one
simply specifies the GPIO number in spi_board_info.controller_data.

Signed-off-by: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/omap2_mcspi.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 951a160..ca4a7dc 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 
 #include <linux/spi/spi.h>
+#include <linux/gpio.h>
 
 #include <plat/dma.h>
 #include <plat/clock.h>
@@ -235,11 +236,13 @@ static void omap2_mcspi_set_enable(const struct spi_device *spi, int enable)
 
 static void omap2_mcspi_force_cs(struct spi_device *spi, int cs_active)
 {
-	u32 l;
-
-	l = mcspi_cached_chconf0(spi);
-	MOD_REG_BIT(l, OMAP2_MCSPI_CHCONF_FORCE, cs_active);
-	mcspi_write_chconf0(spi, l);
+	if (spi->controller_data) {
+                gpio_set_value((unsigned) spi->controller_data, cs_active);
+	} else {
+		u32 l = mcspi_cached_chconf0(spi);
+		MOD_REG_BIT(l, OMAP2_MCSPI_CHCONF_FORCE, cs_active);
+		mcspi_write_chconf0(spi, l);
+	}
 }
 
 static void omap2_mcspi_set_master_mode(struct spi_master *master)
-- 
1.7.0.4


------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
