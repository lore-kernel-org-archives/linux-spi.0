From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH] spi/spi: don't release the spi device twice
Date: Mon, 22 Nov 2010 14:35:03 +0100
Message-ID: <20101122133503.GA25553@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

While rmmoding pxa2xx_spi I hit:

|BUG: unable to handle kernel paging request at 6b6b6b9b
|IP: [<c115bf61>] device_del+0x11/0x140
|Call Trace:
| [<c115c09b>] ? device_unregister+0xb/0x20
| [<c118fe33>] ? spi_unregister_master+0x93/0xc0
| [<f806c554>] ? pxa2xx_spi_remove+0x84/0xc0 [pxa2xx_spi]

According to my debug printks, the loop

| dummy = device_for_each_child(master->dev.parent, &master->dev,
| 		__unregister);

calls __unregister for all childs of spi devicee (spidev in my case) and
the spi device itself. So calling device_unregister() for the device
itself leads to trouble.
This seems to be comming from  3486008 aka ("spi: free children in
spi_unregister_master, not siblings") so therefore I cc stable for v36.

Cc: <stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> # .36.x
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
This is on v2.6.37-rc1. Unless this got fixed somewhere else in the
meantime it is still there.

 drivers/spi/spi.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 709c836..3c8ff6f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -586,7 +586,6 @@ void spi_unregister_master(struct spi_master *master)
 
 	dummy = device_for_each_child(master->dev.parent, &master->dev,
 					__unregister);
-	device_unregister(&master->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_master);
 
-- 
1.7.3.2


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
