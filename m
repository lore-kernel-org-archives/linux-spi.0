From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] SPI: fix in PL022 stop queue procedure
Date: Fri, 21 May 2010 00:28:30 +0200
Message-ID: <1274394510-18467-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	Grzegorz Sygieda <grzegorz.sygieda-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>,
	Lukasz Baj <lukasz.baj-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Grzegorz Sygieda <grzegorz.sygieda-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>

This fix prevents queue being marked as "stopped", if data exists
in the queue list.

Signed-off-by: Grzegorz Sygieda <grzegorz.sygieda-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Lukasz Baj <lukasz.baj-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/spi/amba-pl022.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index e9aeee1..ba9663f 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -1148,7 +1148,6 @@ static int stop_queue(struct pl022 *pl022)
 	 * A wait_queue on the pl022->busy could be used, but then the common
 	 * execution path (pump_messages) would be required to call wake_up or
 	 * friends on every SPI message. Do this instead */
-	pl022->run = QUEUE_STOPPED;
 	while (!list_empty(&pl022->queue) && pl022->busy && limit--) {
 		spin_unlock_irqrestore(&pl022->queue_lock, flags);
 		msleep(10);
@@ -1157,6 +1156,7 @@ static int stop_queue(struct pl022 *pl022)
 
 	if (!list_empty(&pl022->queue) || pl022->busy)
 		status = -EBUSY;
+	else pl022->run = QUEUE_STOPPED;
 
 	spin_unlock_irqrestore(&pl022->queue_lock, flags);
 
-- 
1.6.3.3


------------------------------------------------------------------------------
