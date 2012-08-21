From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi-topcliff-pch: fix to use list_for_each_entry_safe() when
	delete items
Date: Tue, 21 Aug 2012 12:16:16 +0800
Message-ID: <CAPgLHd8fm6BysDeifRnaG8PPRKynEuAWp1ZXHkcoiF_NJPQkzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
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

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

Since we will be removing items off the list using list_del() we need
to use a safer version of the list_for_each_entry() macro aptly named
list_for_each_entry_safe(). We should use the safe macro if the loop
involves deletions of items.

Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/spi/spi-topcliff-pch.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index cd56dcf..309b717 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -615,7 +615,7 @@ static void pch_spi_set_tx(struct pch_spi_data *data, int *bpw)
 	int size;
 	u32 n_writes;
 	int j;
-	struct spi_message *pmsg;
+	struct spi_message *pmsg, *tmp;
 	const u8 *tx_buf;
 	const u16 *tx_sbuf;
 
@@ -656,7 +656,7 @@ static void pch_spi_set_tx(struct pch_spi_data *data, int *bpw)
 	if (!data->pkt_rx_buff) {
 		/* flush queue and set status of all transfers to -ENOMEM */
 		dev_err(&data->master->dev, "%s :kzalloc failed\n", __func__);
-		list_for_each_entry(pmsg, data->queue.next, queue) {
+		list_for_each_entry_safe(pmsg, tmp, data->queue.next, queue) {
 			pmsg->status = -ENOMEM;
 
 			if (pmsg->complete != 0)
@@ -703,7 +703,7 @@ static void pch_spi_set_tx(struct pch_spi_data *data, int *bpw)
 
 static void pch_spi_nomore_transfer(struct pch_spi_data *data)
 {
-	struct spi_message *pmsg;
+	struct spi_message *pmsg, *tmp;
 	dev_dbg(&data->master->dev, "%s called\n", __func__);
 	/* Invoke complete callback
 	 * [To the spi core..indicating end of transfer] */
@@ -740,7 +740,7 @@ static void pch_spi_nomore_transfer(struct pch_spi_data *data)
 		dev_dbg(&data->master->dev,
 			"%s suspend/remove initiated, flushing queue\n",
 			__func__);
-		list_for_each_entry(pmsg, data->queue.next, queue) {
+		list_for_each_entry_safe(pmsg, tmp, data->queue.next, queue) {
 			pmsg->status = -EIO;
 
 			if (pmsg->complete)
@@ -1187,7 +1187,7 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 
 static void pch_spi_process_messages(struct work_struct *pwork)
 {
-	struct spi_message *pmsg;
+	struct spi_message *pmsg, *tmp;
 	struct pch_spi_data *data;
 	int bpw;
 
@@ -1199,7 +1199,7 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 	if (data->board_dat->suspend_sts || (data->status == STATUS_EXITING)) {
 		dev_dbg(&data->master->dev, "%s suspend/remove initiated,"
 			"flushing queue\n", __func__);
-		list_for_each_entry(pmsg, data->queue.next, queue) {
+		list_for_each_entry_safe(pmsg, tmp, data->queue.next, queue) {
 			pmsg->status = -EIO;
 
 			if (pmsg->complete != 0) {



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
