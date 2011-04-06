From: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: Fix race condition in stop_queue()
Date: Wed,  6 Apr 2011 17:49:15 +0300
Message-ID: <1302101355-31187-1-git-send-email-anarsoul__908.194148405705$1302101512$gmane$org@gmail.com>
References: <201104061746.44134.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>,
	Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AIRDUWM+popnw@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201104061746.44134.anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

There's a race condition in stop_queue() in some drivers -
if drv_data->queue is empty, but drv_data->busy is still set
(or opposite situation) stop_queue will return -EBUSY.
So fix loop condition to check that both drv_data->queue is empty
and drv_data->busy is not set.

This patch affects following drivers:
pxa2xx_spi
spi_bfin5xx
amba-pl022
dw_spi

Signed-off-by: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/amba-pl022.c  |    2 +-
 drivers/spi/dw_spi.c      |    2 +-
 drivers/spi/pxa2xx_spi.c  |    2 +-
 drivers/spi/spi_bfin5xx.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 71a1219..23aaaa9 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -1553,7 +1553,7 @@ static int stop_queue(struct pl022 *pl022)
 	 * A wait_queue on the pl022->busy could be used, but then the common
 	 * execution path (pump_messages) would be required to call wake_up or
 	 * friends on every SPI message. Do this instead */
-	while (!list_empty(&pl022->queue) && pl022->busy && limit--) {
+	while ((!list_empty(&pl022->queue) || pl022->busy) && limit--) {
 		spin_unlock_irqrestore(&pl022->queue_lock, flags);
 		msleep(10);
 		spin_lock_irqsave(&pl022->queue_lock, flags);
diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 22af77f..b53be4d 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -821,7 +821,7 @@ static int stop_queue(struct dw_spi *dws)
 
 	spin_lock_irqsave(&dws->lock, flags);
 	dws->run = QUEUE_STOPPED;
-	while (!list_empty(&dws->queue) && dws->busy && limit--) {
+	while ((!list_empty(&dws->queue) || dws->busy) && limit--) {
 		spin_unlock_irqrestore(&dws->lock, flags);
 		msleep(10);
 		spin_lock_irqsave(&dws->lock, flags);
diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 9592883..39cc10f 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1493,7 +1493,7 @@ static int stop_queue(struct driver_data *drv_data)
 	 * execution path (pump_messages) would be required to call wake_up or
 	 * friends on every SPI message. Do this instead */
 	drv_data->run = QUEUE_STOPPED;
-	while (!list_empty(&drv_data->queue) && drv_data->busy && limit--) {
+	while ((!list_empty(&drv_data->queue) || drv_data->busy) && limit--) {
 		spin_unlock_irqrestore(&drv_data->lock, flags);
 		msleep(10);
 		spin_lock_irqsave(&drv_data->lock, flags);
diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 3f22351..0e14f40 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -1244,7 +1244,7 @@ static inline int bfin_spi_stop_queue(struct bfin_spi_master_data *drv_data)
 	 * friends on every SPI message. Do this instead
 	 */
 	drv_data->running = false;
-	while (!list_empty(&drv_data->queue) && drv_data->busy && limit--) {
+	while ((!list_empty(&drv_data->queue) || drv_data->busy) && limit--) {
 		spin_unlock_irqrestore(&drv_data->lock, flags);
 		msleep(10);
 		spin_lock_irqsave(&drv_data->lock, flags);
-- 
1.7.4.1


------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
