From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi/pl022: Fill master->dev.of_node to get spi devices
	registered via DT
Date: Sat, 18 Aug 2012 07:55:05 +0530
Message-ID: <b76734a7fe072120c174bc76d287cff361a2492a.1345255737.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
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

spi_register_master() calls of_register_spi_devices() to register spi devices.
This routine expects master->dev.of_node to be a valid pointer. This is
responsibility of master driver to fill this field, which wasn't done for pl022.
Fix it to get devices added to pl022.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pl022.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index aab518e..3a46848 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2029,6 +2029,7 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	master->transfer_one_message = pl022_transfer_one_message;
 	master->unprepare_transfer_hardware = pl022_unprepare_transfer_hardware;
 	master->rt = platform_info->rt;
+	master->dev.of_node = dev->of_node;
 
 	/*
 	 * Supports mode 0-3, loopback, and active low CS. Transfers are
-- 
1.7.12.rc2.18.g61b472e


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
