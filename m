From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC] spi: Dont call prepare/unprepare transfer if not populated
Date: Thu, 10 May 2012 19:20:41 +0530
Message-ID: <1336657841-2306-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: andrew-g2DYL2Zd6BY@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Currently the prepare/unprepare transfer are called unconditionally.
The assumption is that every driver using the spi core queue infrastructure
has to populate the prepare and unprepare functions. This encourages
drivers to populate empty functions to prevent crashing.
This patch prevents the call to prepare/unprepare if not populated.

Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---

 drivers/spi/spi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 37c555e..30e114c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -532,7 +532,7 @@ static void spi_pump_messages(struct kthread_work *work)
 	/* Lock queue and check for queue work */
 	spin_lock_irqsave(&master->queue_lock, flags);
 	if (list_empty(&master->queue) || !master->running) {
-		if (master->busy) {
+		if (master->busy &&  master->unprepare_transfer_hardware) {
 			ret = master->unprepare_transfer_hardware(master);
 			if (ret) {
 				spin_unlock_irqrestore(&master->queue_lock, flags);
@@ -562,7 +562,7 @@ static void spi_pump_messages(struct kthread_work *work)
 		master->busy = true;
 	spin_unlock_irqrestore(&master->queue_lock, flags);
 
-	if (!was_busy) {
+	if (!was_busy && master->prepare_transfer_hardware) {
 		ret = master->prepare_transfer_hardware(master);
 		if (ret) {
 			dev_err(&master->dev,
-- 
1.7.5.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
