From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] spi/pl022: Fix chipselects pointer computation
Date: Mon,  3 Sep 2012 10:14:29 +0200
Message-ID: <1346660069-16049-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
To: linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, shiraz.linux.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	gabriel.fernandez-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sachin.verma-lpHj6iFQ3dU@public.gmane.org
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

The new chip select handling via GPIO introduced a pointer computation bug:

	(int *) pl022 + sizeof(struct pl022)

doesn't point to the data immediately after the actual struct pl022 (as was
intended) but to a multiple of bytes after it because of the (int *) type.

Replacing the kludgy pointer arithmetic with managed memory allocation for the
chip selects.

Signed-off-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>

---
 drivers/spi/spi-pl022.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.orig/drivers/spi/spi-pl022.c
+++ linux-2.6/drivers/spi/spi-pl022.c
@@ -2053,8 +2053,7 @@ pl022_probe(struct amba_device *adev, co
 	}
 
 	/* Allocate master with space for data */
-	master = spi_alloc_master(dev, sizeof(struct pl022) + sizeof(int) *
-				  num_cs);
+	master = spi_alloc_master(dev, sizeof(struct pl022));
 	if (master == NULL) {
 		dev_err(&adev->dev, "probe - cannot alloc SPI master\n");
 		status = -ENOMEM;
@@ -2066,8 +2065,8 @@ pl022_probe(struct amba_device *adev, co
 	pl022->master_info = platform_info;
 	pl022->adev = adev;
 	pl022->vendor = id->data;
-	/* Point chipselects to allocated memory beyond the main struct */
-	pl022->chipselects = (int *) pl022 + sizeof(struct pl022);
+	pl022->chipselects = devm_kzalloc(dev, num_cs * sizeof(int),
+					  GFP_KERNEL);
 
 	/*
 	 * Bus Number Which has been Assigned to this SSP controller

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
