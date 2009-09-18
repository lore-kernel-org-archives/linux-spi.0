From: Jan Weitzel <J.Weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] MAX7301 GPIO fix portconfig
Date: Fri, 18 Sep 2009 14:56:21 +0200
Message-ID: <20090918125620.GA29417@lws-weitzel>
Reply-To: Jan Weitzel <J.Weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Fix wrong setting of portconfig register. 
mask size is 2bits, so shift must be twice offset
direction input value is 2

Signed-off-by: Jan Weitzel <J.Weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
---
Index: linux-2.6.28/drivers/gpio/max7301.c
===================================================================
--- linux-2.6.28.orig/drivers/gpio/max7301.c
+++ linux-2.6.28/drivers/gpio/max7301.c
@@ -123,7 +123,7 @@ static int max7301_direction_input(struc
 
 	/* Standard GPIO API doesn't support pull-ups, has to be extended.
 	 * Hard-coding no pollup for now. */
-	*config = (*config & ~(3 << (offset & 3))) | (1 << (offset & 3));
+	*config = (*config & ~(3 << (2*(offset & 3)))) | (2 << (2*(offset & 3)));
 
 	ret = max7301_write(ts->spi, 0x08 + (offset >> 2), *config);
 
@@ -157,7 +157,7 @@ static int max7301_direction_output(stru
 
 	mutex_lock(&ts->lock);
 
-	*config = (*config & ~(3 << (offset & 3))) | (1 << (offset & 3));
+	*config = (*config & ~(3 << (2*(offset & 3)))) | (1 << (2*(offset & 3)));
 
 	ret = __max7301_set(ts, offset, value);
 

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
