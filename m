From: sunil.m@techveda.org
Subject: [PATCH] drivers: spi: Kernel coding style fixes
Date: Thu, 17 Aug 2017 18:18:22 +0530
Message-ID: <1502974102-4033-1-git-send-email-sunil.m@techveda.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        karthik@techveda.org, Suniel Mahesh <sunil.m@techveda.org>
To: broonie@kernel.org, lukas@wunner.de
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Suniel Mahesh <sunil.m@techveda.org>

Earlier commit:
"spi: Pick spi bus number from Linux idr or spi alias"
(SHA1:9b61e302210eba55768962f2f11e96bb508c2408)
has introduced some checkpatch issues. As pointed by
Lukas Wunner this patch does the following:
- remove whitespaces
- fix warnings, suspect code indent for conditional statements
- fix errors, code indent should use tabs
- remove spaces at the start of the line

Signed-off-by: Suniel Mahesh <sunil.m@techveda.org>
---
Note:
- Patch was compile tested and built(ARCH=arm) on next-20170817.
- No build/run-time issues reported.
---
 drivers/spi/spi.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2c83a1e..9e7961c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -425,7 +425,7 @@ struct boardinfo {
 /*
  * Used to protect add/del opertion for board_info list and
  * spi_controller list, and their matching process
- * also used to protect object of type struct idr 
+ * also used to protect object of type struct idr
  */
 static DEFINE_MUTEX(board_lock);
 
@@ -2102,7 +2102,6 @@ int spi_register_controller(struct spi_controller *ctlr)
 	 */
 	if (ctlr->num_chipselect == 0)
 		return -EINVAL;
-	
 	/* allocate dynamic bus number using Linux idr */
 	if ((ctlr->bus_num < 0) && ctlr->dev.of_node) {
 		id = of_alias_get_id(ctlr->dev.of_node, "spi");
@@ -2117,16 +2116,14 @@ int spi_register_controller(struct spi_controller *ctlr)
 		}
 	}
 	if (ctlr->bus_num < 0) {
-			mutex_lock(&board_lock);
-			id = idr_alloc(&spi_master_idr, ctlr,
-				       SPI_DYN_FIRST_BUS_NUM, 0, GFP_KERNEL);
-			mutex_unlock(&board_lock);
-			if (WARN(id < 0, "couldn't get idr"))
-				return id;
-
-			ctlr->bus_num = id;
+		mutex_lock(&board_lock);
+		id = idr_alloc(&spi_master_idr, ctlr, SPI_DYN_FIRST_BUS_NUM, 0,
+			       GFP_KERNEL);
+		mutex_unlock(&board_lock);
+		if (WARN(id < 0, "couldn't get idr"))
+			return id;
+		ctlr->bus_num = id;
 	}
-
 	INIT_LIST_HEAD(&ctlr->queue);
 	spin_lock_init(&ctlr->queue_lock);
 	spin_lock_init(&ctlr->bus_lock_spinlock);
@@ -2249,18 +2246,16 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	mutex_lock(&board_lock);
 	found = idr_find(&spi_master_idr, ctlr->bus_num);
 	mutex_unlock(&board_lock);
-        if (found != ctlr) {
-                dev_dbg(&ctlr->dev, 
+	if (found != ctlr) {
+		dev_dbg(&ctlr->dev,
 			"attempting to delete unregistered controller [%s]\n",
 			dev_name(&ctlr->dev));
-                return;
-        }
-
+		return;
+	}
 	if (ctlr->queued) {
 		if (spi_destroy_queue(ctlr))
 			dev_err(&ctlr->dev, "queue remove failed\n");
 	}
-
 	mutex_lock(&board_lock);
 	list_del(&ctlr->list);
 	mutex_unlock(&board_lock);
-- 
1.9.1
