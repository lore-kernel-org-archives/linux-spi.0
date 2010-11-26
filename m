From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [sodaville] [PATCH 1/9] spi/pxa2xx: don't use subys initcall for
	driver	init
Date: Fri, 26 Nov 2010 11:50:28 +0100
Message-ID: <20101126105028.GA24010@www.tglx.de>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
	<1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
	<AANLkTin4vh85XRkEd7YocCmKngViR_qZDe7z1b4JXyd-@mail.gmail.com>
	<4CED1C95.8070300@linutronix.de>
	<20101124141623.GH24970@rakim.wolfsonmicro.main>
	<4CED3199.2040700@linutronix.de>
	<20101125235415.GA9310@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101125235415.GA9310-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

* Russell King - ARM Linux | 2010-11-25 23:54:15 [+0000]:

>Why should the PXA code change when you haven't explained _why_ you want
>to change the SPI driver to conform to your idea?

The problem was, that the platform driver never got probed after I
registered the PCI driver. For that reason I made the patch attached. It
got lost while moving the tree forward and I did not notice it earlier.
While at it, I changed the subsys_init to module_init because it looked
wrong. At this time I was also thinking about using one module for the
platform and PCI code but never got to it.

>From fbd29a14af42d374ddce9c16ff5f7805e69c764f Mon Sep 17 00:00:00 2001
From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Date: Fri, 19 Nov 2010 09:00:11 -0800
Subject: [PATCH] spi/pxa2xx: register driver properly

use platform_driver_register instead of platform_driver_probe. The
latter only checks available devices at the time of calling. So if a
device gets inserter at a later point in time then the driver will never
play with it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/pxa2xx_spi.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index e76b1af..4e169b5 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1366,7 +1366,7 @@ static void cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
-static int __init init_queue(struct driver_data *drv_data)
+static int __devinit init_queue(struct driver_data *drv_data)
 {
 	INIT_LIST_HEAD(&drv_data->queue);
 	spin_lock_init(&drv_data->lock);
@@ -1454,7 +1454,7 @@ static int destroy_queue(struct driver_data *drv_data)
 	return 0;
 }
 
-static int __init pxa2xx_spi_probe(struct platform_device *pdev)
+static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct pxa2xx_spi_master *platform_info;
@@ -1723,13 +1723,14 @@ static struct platform_driver driver = {
 		.pm	= &pxa2xx_spi_pm_ops,
 #endif
 	},
+	.probe = pxa2xx_spi_probe,
 	.remove = pxa2xx_spi_remove,
 	.shutdown = pxa2xx_spi_shutdown,
 };
 
 static int __init pxa2xx_spi_init(void)
 {
-	return platform_driver_probe(&driver, pxa2xx_spi_probe);
+	return platform_driver_register(&driver);
 }
 subsys_initcall(pxa2xx_spi_init);
 
-- 
1.7.3.2

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
