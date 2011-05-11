From: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: tle620x: add missing device_remove_file()
Date: Wed, 11 May 2011 20:39:05 +0800
Message-ID: <1305117545.6324.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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

This patch includes below fixes:
1. Add missing device_remove_file for dev_attr_status_show in tle62x0_remove.
2. Fix tle62x0_probe error handling:
   Currently, if the error happens when ptr > 0, gpio_attrs[0] is not
   properly remove.

Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/tle62x0.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/tle62x0.c b/drivers/spi/tle62x0.c
index a393895..32a4087 100644
--- a/drivers/spi/tle62x0.c
+++ b/drivers/spi/tle62x0.c
@@ -283,7 +283,7 @@ static int __devinit tle62x0_probe(struct spi_device *spi)
 	return 0;
 
  err_gpios:
-	for (; ptr > 0; ptr--)
+	while (--ptr >= 0)
 		device_remove_file(&spi->dev, gpio_attrs[ptr]);
 
 	device_remove_file(&spi->dev, &dev_attr_status_show);
@@ -301,6 +301,7 @@ static int __devexit tle62x0_remove(struct spi_device *spi)
 	for (ptr = 0; ptr < st->nr_gpio; ptr++)
 		device_remove_file(&spi->dev, gpio_attrs[ptr]);
 
+	device_remove_file(&spi->dev, &dev_attr_status_show);
 	kfree(st);
 	return 0;
 }
-- 
1.7.1




------------------------------------------------------------------------------
Achieve unprecedented app performance and reliability
What every C/C++ and Fortran developer should know.
Learn how Intel has extended the reach of its next-generation tools
to help boost performance applications - inlcuding clusters.
http://p.sf.net/sfu/intel-dev2devmay
