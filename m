From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: tegra: sequence compatible strings as per preference
Date: Fri, 9 Nov 2012 14:37:32 +0530
Message-ID: <1352452052-13823-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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

Sequence compatible list for tegra20-slink driver to first
look for Tegra30 and then Tegra20. Tegra30 have additional
feature in HW which need to be utilize if it is provided from DT.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-tegra20-slink.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 07dc735..7882b50 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1109,8 +1109,8 @@ const struct tegra_slink_chip_data tegra20_spi_cdata = {
 };
 
 static struct of_device_id tegra_slink_of_match[] __devinitconst = {
-	{ .compatible = "nvidia,tegra20-slink", .data = &tegra20_spi_cdata, },
 	{ .compatible = "nvidia,tegra30-slink", .data = &tegra30_spi_cdata, },
+	{ .compatible = "nvidia,tegra20-slink", .data = &tegra20_spi_cdata, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, tegra_slink_of_match);
-- 
1.7.1.1


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
