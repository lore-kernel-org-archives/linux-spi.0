From: Girish K S <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V3 RESEND 3/5] spi: s3c64xx: Added provision for non-gpio i/o's
Date: Mon, 15 Apr 2013 14:10:28 +0530
Message-ID: <1366015230-18243-2-git-send-email-ks.giri@samsung.com>
References: <1366015230-18243-1-git-send-email-ks.giri@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	Girish K S <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1366015230-18243-1-git-send-email-ks.giri-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Girish K S <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Currently the drivers supports only the GPIO based i/o pins.
But there are Exynos SoC's that use the same controller with
dedicated i/o pins.

This patch  provides provision to support gpio/dedicated pins.
The decision is made by parsing the "gpios" property in the spi
node.

Signed-off-by: Girish K S <ks.giri-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index a6fdc71..79de18f 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1111,6 +1111,9 @@ static int s3c64xx_spi_parse_dt_gpio(struct s3c64xx_spi_driver_data *sdd)
 	struct device *dev = &sdd->pdev->dev;
 	int idx, gpio, ret;
 
+	if (!of_find_property(dev->of_node, "gpios", NULL))
+		return 0;
+
 	/* find gpios for mosi, miso and clock lines */
 	for (idx = 0; idx < 3; idx++) {
 		gpio = of_get_gpio(dev->of_node, idx);
@@ -1137,6 +1140,11 @@ free_gpio:
 static void s3c64xx_spi_dt_gpio_free(struct s3c64xx_spi_driver_data *sdd)
 {
 	unsigned int idx;
+	struct device *dev = &sdd->pdev->dev;
+
+	if (!of_find_property(dev->of_node, "gpios", NULL))
+		return;
+
 	for (idx = 0; idx < 3; idx++)
 		gpio_free(sdd->gpios[idx]);
 }
-- 
1.7.5.4


------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
