From: "H Hartley Sweeten" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH] spi_txx9.c: use resource_size()
Date: Mon, 14 Dec 2009 17:43:42 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200EA8F@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: "kernel list" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Use resource_size().

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>

---

diff --git a/drivers/spi/spi_txx9.c b/drivers/spi/spi_txx9.c
index 19f7562..dfa024b 100644
--- a/drivers/spi/spi_txx9.c
+++ b/drivers/spi/spi_txx9.c
@@ -375,12 +375,10 @@ static int __init txx9spi_probe(struct platform_device *dev)
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!res)
 		goto exit_busy;
-	if (!devm_request_mem_region(&dev->dev,
-				     res->start, res->end - res->start + 1,
+	if (!devm_request_mem_region(&dev->dev, res->start, resource_size(res),
 				     "spi_txx9"))
 		goto exit_busy;
-	c->membase = devm_ioremap(&dev->dev,
-				  res->start, res->end - res->start + 1);
+	c->membase = devm_ioremap(&dev->dev, res->start, resource_size(res));
 	if (!c->membase)
 		goto exit_busy;
  

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
