From: "H Hartley Sweeten" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH] spi_sh_sci.c: use resource_size()
Date: Mon, 14 Dec 2009 17:40:05 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200EA8E@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

---

diff --git a/drivers/spi/spi_sh_sci.c b/drivers/spi/spi_sh_sci.c
index 7d36720..a65c12f 100644
--- a/drivers/spi/spi_sh_sci.c
+++ b/drivers/spi/spi_sh_sci.c
@@ -148,7 +148,7 @@ static int sh_sci_spi_probe(struct platform_device *dev)
 		ret = -ENOENT;
 		goto err1;
 	}
-	sp->membase = ioremap(r->start, r->end - r->start + 1);
+	sp->membase = ioremap(r->start, resource_size(r));
 	if (!sp->membase) {
 		ret = -ENXIO;
 		goto err1; 

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
