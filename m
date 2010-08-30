From: David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
Subject: [PATCH] spi: free children in spi_unregister_master, not siblings
Date: Mon, 30 Aug 2010 11:58:37 +0200
Message-ID: <20100830095837.GA2404529@jupiter.n2.diac24.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>,
	Tony Jones <tonyj-l3A5Bk7waGM@public.gmane.org>
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

introduced by 49dce689ad4ef0fd1f970ef762168e4bd46f69a3 and bad-fixed by
350d0076c5763ca2b88ca05e3889bfa7c1905f21, spi_unregister_master would
previously device_unregister all of the spi master's siblings (instead
of its children). hilarity ensues.

fix it to unregister children.

Signed-off-by: David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
Cc: Tony Jones <tonyj-l3A5Bk7waGM@public.gmane.org>
Cc: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
---

"siblings" were usb endpoint devices in my case, causing a very nice
*boom* when the usb code tried to unregister them after they were gone
already because of spi_unregister_master. went looking for a bug in my
code for 20 hours...

patch is against 2.6.35.4 but there shouldn't be much change in this
file.

 drivers/spi/spi.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b3a1f92..144393c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -546,11 +546,9 @@ done:
 EXPORT_SYMBOL_GPL(spi_register_master);
 
 
-static int __unregister(struct device *dev, void *master_dev)
+static int __unregister(struct device *dev, void *null)
 {
-	/* note: before about 2.6.14-rc1 this would corrupt memory: */
-	if (dev != master_dev)
-		spi_unregister_device(to_spi_device(dev));
+	spi_unregister_device(to_spi_device(dev));
 	return 0;
 }
 
@@ -568,8 +566,7 @@ void spi_unregister_master(struct spi_master *master)
 {
 	int dummy;
 
-	dummy = device_for_each_child(master->dev.parent, &master->dev,
-					__unregister);
+	dummy = device_for_each_child(master->dev, NULL, _unregister);
 	device_unregister(&master->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_master);
-- 
1.7.1


------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
