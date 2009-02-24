From: Wolfgang Ocker <weo-pMF0Ia4UJXeoYr4blSSd5g@public.gmane.org>
Subject: [PATCH] spidev: do not reference spidev_remove
	using __devexit_p
Date: Tue, 24 Feb 2009 13:48:03 +0100
Message-ID: <1235479683.3964.31.camel@goedel.recco.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

This patch removes the usage of __devexit_p() for spidev_remove() in the
definition of struct spi_driver spidev_spi.

This causes a kernel oops if the master driver is removed and reinserted
in case spidev is builtin.

Signed-off-by: Wolfgang Ocker <weo-pMF0Ia4UJXeoYr4blSSd5g@public.gmane.org>
---
linux-2.6.28.6/drivers/spi/spidev.c.fix_spidev_remove	2009-02-17 18:29:27.000000000 +0100
+++ linux-2.6.28.6/drivers/spi/spidev.c	2009-02-24 13:30:07.000000000 +0100
@@ -633,7 +633,7 @@ static struct spi_driver spidev_spi = {
 		.owner =	THIS_MODULE,
 	},
 	.probe =	spidev_probe,
-	.remove =	__devexit_p(spidev_remove),
+	.remove =	spidev_remove,
 
 	/* NOTE:  suspend/resume methods are not necessary here.
 	 * We don't do anything except pass the requests to/from



------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
