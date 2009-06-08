From: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: size of a pointer to determine the
 size of the pointed-to type
Date: Tue, 09 Jun 2009 00:38:24 +0200
Message-ID: <4A2D92E0.8030801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Do not take the size of a pointer to determine the size of the pointed-to type

Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
This wasn't tested, please review.

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index f4573a9..a32ccb4 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -711,12 +711,12 @@ static int of_mpc83xx_spi_get_chipselects(struct device *dev)
 		return 0;
 	}
 
-	pinfo->gpios = kmalloc(ngpios * sizeof(pinfo->gpios), GFP_KERNEL);
+	pinfo->gpios = kmalloc(ngpios * sizeof(*pinfo->gpios), GFP_KERNEL);
 	if (!pinfo->gpios)
 		return -ENOMEM;
-	memset(pinfo->gpios, -1, ngpios * sizeof(pinfo->gpios));
+	memset(pinfo->gpios, -1, ngpios * sizeof(*pinfo->gpios));
 
-	pinfo->alow_flags = kzalloc(ngpios * sizeof(pinfo->alow_flags),
+	pinfo->alow_flags = kzalloc(ngpios * sizeof(*pinfo->alow_flags),
 				    GFP_KERNEL);
 	if (!pinfo->alow_flags) {
 		ret = -ENOMEM;

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
