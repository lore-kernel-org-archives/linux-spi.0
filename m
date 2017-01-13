From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 17/17] spi/topcliff-pch: One check less in pch_spi_set_tx()
Date: Fri, 13 Jan 2017 18:28:17 +0100
Message-ID: <bdf5a12c-39cb-398a-f6c8-58142c7abd8d@users.sourceforge.net>
References: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 17:30:46 +0100

Delete a duplicate check after a bit of exception handling was moved into
a previous if branch of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/spi/spi-topcliff-pch.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 97fd1ea9826b..33043a830032 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -584,22 +584,25 @@ static void pch_spi_set_tx(struct pch_spi_data *data, int *bpw)
 	data->pkt_tx_buff = kzalloc(size, GFP_KERNEL);
 	if (data->pkt_tx_buff) {
 		data->pkt_rx_buff = kzalloc(size, GFP_KERNEL);
-		if (!data->pkt_rx_buff)
+		if (!data->pkt_rx_buff) {
 			kfree(data->pkt_tx_buff);
-	}
 
-	if (!data->pkt_rx_buff) {
-		/* flush queue and set status of all transfers to -ENOMEM */
-		list_for_each_entry_safe(pmsg, tmp, data->queue.next, queue) {
-			pmsg->status = -ENOMEM;
+			/*
+			 * Flush queue and set status of all transfers
+			 * to -ENOMEM.
+			 */
+			list_for_each_entry_safe(pmsg, tmp, data->queue.next,
+						 queue) {
+				pmsg->status = -ENOMEM;
 
-			if (pmsg->complete)
-				pmsg->complete(pmsg->context);
+				if (pmsg->complete)
+					pmsg->complete(pmsg->context);
 
-			/* delete from queue */
-			list_del_init(&pmsg->queue);
+				/* delete from queue */
+				list_del_init(&pmsg->queue);
+			}
+			return;
 		}
-		return;
 	}
 
 	/* copy Tx Data */
-- 
2.11.0

