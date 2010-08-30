From: David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] spi: free children in spi_unregister_master, not siblings
Date: Mon, 30 Aug 2010 23:39:49 +0200
Message-ID: <20100830213949.GB2413339@jupiter.n2.diac24.net>
References: <20100830095837.GA2404529@jupiter.n2.diac24.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>, Tony Jones <tonyj-l3A5Bk7waGM@public.gmane.org>,
	David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100830095837.GA2404529-sd4rSCkhOesKVZNVnti56SRbHCANfdcW@public.gmane.org>
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
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---

Hi Grant,

please see attached patch :)

(reply from David Brownell went off-list because I accidentally Cc'ed an
old e-mail address of him. moving this to on-list thread.)

-David L.

On Mon, Aug 30, 2010 at 11:58:37AM +0200, David Lamparter wrote:
> "siblings" were usb endpoint devices in my case, causing a very nice
> *boom* when the usb code tried to unregister them after they were gone
> already because of spi_unregister_master. went looking for a bug in my
> code for 20 hours...
> 
> patch is against 2.6.35.4 but there shouldn't be much change in this
> file.
> 
On Mon, Aug 30, 2010 at 10:08:12AM -0700, David Brownell wrote:
> Bug since 2007?  OUch!
> 
> 
> At a real quick review, it looked right; but
> I couldn't test.
> 
> Please send this patch also to Grant Likely.

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
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
