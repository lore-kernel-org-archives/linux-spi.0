From: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson-zCUwNCi8n9MAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] mpc52xx-psc-spi: Enumerate child nodes
	in the OF tree
Date: Tue, 3 Nov 2009 11:43:13 +0000
Message-ID: <4AF01751.1090806@marel.com>
References: <1256931852-13255-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40910311803m43504167s1ad802aecd2b4344@mail.gmail.com>
	<20091102131427.GB4696@pengutronix.de>
	<fa686aa40911020808n73a898ack5fb66933188555da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040803070909010204070908"
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa40911020808n73a898ack5fb66933188555da-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--------------040803070909010204070908
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I need to apply the following patch in order to get the mpc52xx-psc-spi driver
to instantiate my spi device driver.

This patch is based on 2.6.29 but should apply cleanly to the most recent kernel.

rg
kd

--------------040803070909010204070908
Content-Type: text/x-diff; name="spi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="spi.patch"

Index: drivers/spi/mpc52xx_psc_spi.c
===================================================================
--- drivers/spi/mpc52xx_psc_spi.c	(revision 692)
+++ drivers/spi/mpc52xx_psc_spi.c	(working copy)
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
+#include <linux/of_spi.h>
 #include <linux/fsl_devices.h>
 
 #include <asm/mpc52xx.h>
@@ -370,9 +371,10 @@
 }
 
 /* bus_num is used only for the case dev->platform_data == NULL */
-static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
+static int __init mpc52xx_psc_spi_do_probe(struct of_device *op, u32 regaddr,
 				u32 size, unsigned int irq, s16 bus_num)
 {
+    struct device * dev = &op->dev;
 	struct fsl_spi_platform_data *pdata = dev->platform_data;
 	struct mpc52xx_psc_spi *mps;
 	struct spi_master *master;
@@ -439,6 +441,8 @@
 	if (ret < 0)
 		goto unreg_master;
 
+	of_register_spi_devices(master, op->node);
+
 	return ret;
 
 unreg_master:
@@ -495,7 +499,7 @@
 		id = *psc_nump + 1;
 	}
 
-	return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
+	return mpc52xx_psc_spi_do_probe(op, (u32)regaddr64, (u32)size64,
 					irq_of_parse_and_map(op->node, 0), id);
 }
 

--------------040803070909010204070908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--------------040803070909010204070908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--------------040803070909010204070908--
