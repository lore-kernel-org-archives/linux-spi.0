From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH REPOST v2] spi/spi: don't release the spi device twice
Date: Mon, 20 Dec 2010 18:13:30 +0100
Message-ID: <20101220171330.GA15344@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
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

This was fixed by David Lamparter in v2.6.36-rc5 3486008
("spi: free children in spi_unregister_master, not siblings") and broken
again in v2.6.37-rc1~2^2~4 during the merge of 2b9603a0 ("spi: enable
spi_board_info to be registered after spi_master").

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
---

Andrew, I resent this to you because it fixes a regression which was
introduced in the merge window for v2.6.37.
I posted this patch at 2010-11-23 14:59:10 and sent a ping 2010-12-09
16:06:22 and got no response so far from the maintainer. The patch is at
https://patchwork.kernel.org/patch/349721/

 drivers/spi/spi.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 709c836..b02d0cb 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -584,8 +584,7 @@ void spi_unregister_master(struct spi_master *master)
 	list_del(&master->list);
 	mutex_unlock(&board_lock);
 
-	dummy = device_for_each_child(master->dev.parent, &master->dev,
-					__unregister);
+	dummy = device_for_each_child(&master->dev, NULL, __unregister);
 	device_unregister(&master->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_master);

------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
