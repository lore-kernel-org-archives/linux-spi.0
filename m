From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Use an abbreviated pointer to ctlr->cur_msg in __spi_pump_messages" to the spi tree
Date: Thu,  5 Sep 2019 18:39:00 +0100 (BST)
Message-ID: <20190905173900.188DF2742D07@ypsilon.sirena.org.uk>
References: <20190905010114.26718-2-olteanv@gmail.com>
Cc: andrew@lunn.ch, broonie@kernel.org, f.fainelli@gmail.com,
        h.feurstein@gmail.com, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mlichvar@redhat.com,
        netdev@vger.kernel.org, richardcochran@gmail.com
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190905010114.26718-2-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Use an abbreviated pointer to ctlr->cur_msg in __spi_pump_messages

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d1c44c9342c17e3314371325d9272684a075b65c Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Thu, 5 Sep 2019 04:01:11 +0300
Subject: [PATCH] spi: Use an abbreviated pointer to ctlr->cur_msg in
 __spi_pump_messages

This helps a bit with line fitting now (the list_first_entry call) as
well as during the next patch which needs to iterate through all
transfers of ctlr->cur_msg so it timestamps them.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190905010114.26718-2-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index aef55acb5ccd..b2890923d256 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1265,8 +1265,9 @@ EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
  */
 static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 {
-	unsigned long flags;
+	struct spi_message *msg;
 	bool was_busy = false;
+	unsigned long flags;
 	int ret;
 
 	/* Lock queue */
@@ -1325,10 +1326,10 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	}
 
 	/* Extract head of queue */
-	ctlr->cur_msg =
-		list_first_entry(&ctlr->queue, struct spi_message, queue);
+	msg = list_first_entry(&ctlr->queue, struct spi_message, queue);
+	ctlr->cur_msg = msg;
 
-	list_del_init(&ctlr->cur_msg->queue);
+	list_del_init(&msg->queue);
 	if (ctlr->busy)
 		was_busy = true;
 	else
@@ -1361,7 +1362,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 			if (ctlr->auto_runtime_pm)
 				pm_runtime_put(ctlr->dev.parent);
 
-			ctlr->cur_msg->status = ret;
+			msg->status = ret;
 			spi_finalize_current_message(ctlr);
 
 			mutex_unlock(&ctlr->io_mutex);
@@ -1369,28 +1370,28 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 		}
 	}
 
-	trace_spi_message_start(ctlr->cur_msg);
+	trace_spi_message_start(msg);
 
 	if (ctlr->prepare_message) {
-		ret = ctlr->prepare_message(ctlr, ctlr->cur_msg);
+		ret = ctlr->prepare_message(ctlr, msg);
 		if (ret) {
 			dev_err(&ctlr->dev, "failed to prepare message: %d\n",
 				ret);
-			ctlr->cur_msg->status = ret;
+			msg->status = ret;
 			spi_finalize_current_message(ctlr);
 			goto out;
 		}
 		ctlr->cur_msg_prepared = true;
 	}
 
-	ret = spi_map_msg(ctlr, ctlr->cur_msg);
+	ret = spi_map_msg(ctlr, msg);
 	if (ret) {
-		ctlr->cur_msg->status = ret;
+		msg->status = ret;
 		spi_finalize_current_message(ctlr);
 		goto out;
 	}
 
-	ret = ctlr->transfer_one_message(ctlr, ctlr->cur_msg);
+	ret = ctlr->transfer_one_message(ctlr, msg);
 	if (ret) {
 		dev_err(&ctlr->dev,
 			"failed to transfer one message from queue\n");
-- 
2.20.1
