From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 1/5] spi: Use an abbreviated pointer to ctlr->cur_msg in __spi_pump_messages
Date: Sun, 18 Aug 2019 21:25:56 +0300
Message-ID: <20190818182600.3047-2-olteanv@gmail.com>
References: <20190818182600.3047-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
To: broonie@kernel.org, h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190818182600.3047-1-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This helps a bit with line fitting now (the list_first_entry call) as
well as during the next patch which needs to iterate through all
transfers of ctlr->cur_msg so it timestamps them.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index aef55acb5ccd..d96e04627982 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1265,8 +1265,9 @@ EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
  */
 static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 {
-	unsigned long flags;
+	struct spi_message *mesg;
 	bool was_busy = false;
+	unsigned long flags;
 	int ret;
 
 	/* Lock queue */
@@ -1325,10 +1326,10 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	}
 
 	/* Extract head of queue */
-	ctlr->cur_msg =
-		list_first_entry(&ctlr->queue, struct spi_message, queue);
+	mesg = list_first_entry(&ctlr->queue, struct spi_message, queue);
+	ctlr->cur_msg = mesg;
 
-	list_del_init(&ctlr->cur_msg->queue);
+	list_del_init(&mesg->queue);
 	if (ctlr->busy)
 		was_busy = true;
 	else
@@ -1361,7 +1362,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 			if (ctlr->auto_runtime_pm)
 				pm_runtime_put(ctlr->dev.parent);
 
-			ctlr->cur_msg->status = ret;
+			mesg->status = ret;
 			spi_finalize_current_message(ctlr);
 
 			mutex_unlock(&ctlr->io_mutex);
@@ -1369,28 +1370,28 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 		}
 	}
 
-	trace_spi_message_start(ctlr->cur_msg);
+	trace_spi_message_start(mesg);
 
 	if (ctlr->prepare_message) {
-		ret = ctlr->prepare_message(ctlr, ctlr->cur_msg);
+		ret = ctlr->prepare_message(ctlr, mesg);
 		if (ret) {
 			dev_err(&ctlr->dev, "failed to prepare message: %d\n",
 				ret);
-			ctlr->cur_msg->status = ret;
+			mesg->status = ret;
 			spi_finalize_current_message(ctlr);
 			goto out;
 		}
 		ctlr->cur_msg_prepared = true;
 	}
 
-	ret = spi_map_msg(ctlr, ctlr->cur_msg);
+	ret = spi_map_msg(ctlr, mesg);
 	if (ret) {
-		ctlr->cur_msg->status = ret;
+		mesg->status = ret;
 		spi_finalize_current_message(ctlr);
 		goto out;
 	}
 
-	ret = ctlr->transfer_one_message(ctlr, ctlr->cur_msg);
+	ret = ctlr->transfer_one_message(ctlr, mesg);
 	if (ret) {
 		dev_err(&ctlr->dev,
 			"failed to transfer one message from queue\n");
-- 
2.17.1
