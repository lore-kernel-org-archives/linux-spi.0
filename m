From: Alexandru Gheorghiu <gheorghiuandru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drivers: spi: Use PTR_RET function
Date: Thu, 14 Mar 2013 11:18:18 +0200
Message-ID: <1363252698-29500-1-git-send-email-gheorghiuandru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexandru Gheorghiu <gheorghiuandru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
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

Replaced calls to IS_ERR and PTR_ERR with PTR_RET function.
Patch found using coccinelle.

Signed-off-by: Alexandru Gheorghiu <gheorghiuandru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spidev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 2e0655d..911e9e0 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -603,7 +603,7 @@ static int spidev_probe(struct spi_device *spi)
 		dev = device_create(spidev_class, &spi->dev, spidev->devt,
 				    spidev, "spidev%d.%d",
 				    spi->master->bus_num, spi->chip_select);
-		status = IS_ERR(dev) ? PTR_ERR(dev) : 0;
+		status = PTR_RET(dev);
 	} else {
 		dev_dbg(&spi->dev, "no minor number available!\n");
 		status = -ENODEV;
-- 
1.7.9.5


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
