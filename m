From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Kernel coding style fixes" to the spi tree
Date: Thu, 17 Aug 2017 18:14:02 +0100
Message-ID: <E1diOMs-0000Kx-0P@debutante>
References: <1502974102-4033-1-git-send-email-sunil.m@techveda.org>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lukas@wunner.de, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, karthik@techveda.org,
        linux-spi@vger.kernel.org
To: Suniel Mahesh <sunil.m@techveda.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502974102-4033-1-git-send-email-sunil.m@techveda.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Kernel coding style fixes

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 9a9a047a39d9173b0639017e5ba249443e76dd9e Mon Sep 17 00:00:00 2001
From: Suniel Mahesh <sunil.m@techveda.org>
Date: Thu, 17 Aug 2017 18:18:22 +0530
Subject: [PATCH] spi: Kernel coding style fixes

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b851888a0a0b..f47d1ccdf292 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -424,7 +424,7 @@ static LIST_HEAD(spi_controller_list);
 /*
  * Used to protect add/del opertion for board_info list and
  * spi_controller list, and their matching process
- * also used to protect object of type struct idr 
+ * also used to protect object of type struct idr
  */
 static DEFINE_MUTEX(board_lock);
 
@@ -2075,7 +2075,6 @@ int spi_register_controller(struct spi_controller *ctlr)
 	 */
 	if (ctlr->num_chipselect == 0)
 		return -EINVAL;
-	
 	/* allocate dynamic bus number using Linux idr */
 	if ((ctlr->bus_num < 0) && ctlr->dev.of_node) {
 		id = of_alias_get_id(ctlr->dev.of_node, "spi");
@@ -2090,16 +2089,14 @@ int spi_register_controller(struct spi_controller *ctlr)
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
@@ -2222,18 +2219,16 @@ void spi_unregister_controller(struct spi_controller *ctlr)
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
2.13.3
