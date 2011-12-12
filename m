From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH v2] spi: Fix device unregistration when unregistering the bus
	master
Date: Mon, 12 Dec 2011 01:15:06 +0100
Message-ID: <1323648906-24863-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <CACRpkda685p+fe_P5Ww=4Qtup6qmCe_oqiwTqN+KAaAktPNKFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACRpkda685p+fe_P5Ww=4Qtup6qmCe_oqiwTqN+KAaAktPNKFw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Device are added as children of the bus master's parent device, but
spi_unregister_master() looks for devices to unregister in the bus
master's children. This results in the child devices not being
unregistered.

Fix this by registering devices as direct children of the bus master.

Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/spi/spi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2e13a14..b423fe9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -318,7 +318,7 @@ struct spi_device *spi_alloc_device(struct spi_master *master)
 	}
 
 	spi->master = master;
-	spi->dev.parent = dev;
+	spi->dev.parent = &master->dev;
 	spi->dev.bus = &spi_bus_type;
 	spi->dev.release = spidev_release;
 	device_initialize(&spi->dev);
-- 
Regards,

Laurent Pinchart


------------------------------------------------------------------------------
Learn Windows Azure Live!  Tuesday, Dec 13, 2011
Microsoft is holding a special Learn Windows Azure training event for 
developers. It will provide a great way to learn Windows Azure and what it 
provides. You can attend the event by watching it streamed LIVE online.  
Learn more at http://p.sf.net/sfu/ms-windowsazure
