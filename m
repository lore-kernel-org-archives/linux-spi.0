From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: [PATCH] spi: Correct name for spi_txx9
Date: Thu, 23 Aug 2007 12:35:34 +0900 (JST)
Message-ID: <20070823.123534.78704256.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
To: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Correct the name of the spi_txx9 driver (and their in-tree user)
instead of MODULE_ALIAS workaround.  This would be preferable in the
long term.

Signed-off-by: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
This patch is on top of "SPI driver hotplug/coldplug fixes" for
2.6.23-rc3-git by David Brownell.

diff -urNp linux.old/arch/mips/tx4938/toshiba_rbtx4938/setup.c linux/arch/mips/tx4938/toshiba_rbtx4938/setup.c
--- linux.old/arch/mips/tx4938/toshiba_rbtx4938/setup.c	2007-08-23 11:44:48.000000000 +0900
+++ linux/arch/mips/tx4938/toshiba_rbtx4938/setup.c	2007-08-23 11:50:17.000000000 +0900
@@ -1121,7 +1121,7 @@ static void __init txx9_spi_init(unsigne
 			.flags	= IORESOURCE_IRQ,
 		},
 	};
-	platform_device_register_simple("txx9spi", 0,
+	platform_device_register_simple("spi_txx9", 0,
 					res, ARRAY_SIZE(res));
 }
 
diff -urNp linux.old/drivers/spi/spi_txx9.c linux/drivers/spi/spi_txx9.c
--- linux.old/drivers/spi/spi_txx9.c	2007-08-23 11:48:47.000000000 +0900
+++ linux/drivers/spi/spi_txx9.c	2007-08-23 11:49:50.000000000 +0900
@@ -450,11 +450,10 @@ static int __exit txx9spi_remove(struct 
 	return 0;
 }
 
-MODULE_ALIAS("txx9spi");			/* for platform bus hotplug */
 static struct platform_driver txx9spi_driver = {
 	.remove = __exit_p(txx9spi_remove),
 	.driver = {
-		.name = "txx9spi",
+		.name = "spi_txx9",
 		.owner = THIS_MODULE,
 	},
 };

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
