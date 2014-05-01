From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: core: Don't destroy master queue if we fail to create it
Date: Thu,  1 May 2014 10:49:27 -0700
Message-ID: <1398966567-5182-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kerne-cunTk1MwBs8s++Sfvej+rw@public.gmane.org,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

If we fail to create the master queue for some reason we should not attempt
to clean it up since attempting to stop a kthread that was not created will
hang and it's just generally bad practice. Unfortunately at present we call
spi_destroy_queue() even in cases where the creation fails.

Fix this by fixing the error handling in spi_master_initialize_queue() so
that we only flag the master as queued or destroy the queue if creation
succeeded. The change to the flag is done since the general master
cleanup uses this to destroy the queue.

Reported-by: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

This has been compile tested only but it should hopefully be more robust
in the long term than just skipping the queue deletion inside the
destructor.

 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 38ba75a..bc42e27 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1151,7 +1151,6 @@ static int spi_master_initialize_queue(struct spi_master *master)
 {
 	int ret;
 
-	master->queued = true;
 	master->transfer = spi_queued_transfer;
 	if (!master->transfer_one_message)
 		master->transfer_one_message = spi_transfer_one_message;
@@ -1162,6 +1161,7 @@ static int spi_master_initialize_queue(struct spi_master *master)
 		dev_err(&master->dev, "problem initializing queue\n");
 		goto err_init_queue;
 	}
+	master->queued = true;
 	ret = spi_start_queue(master);
 	if (ret) {
 		dev_err(&master->dev, "problem starting queue\n");
@@ -1171,8 +1171,8 @@ static int spi_master_initialize_queue(struct spi_master *master)
 	return 0;
 
 err_start_queue:
-err_init_queue:
 	spi_destroy_queue(master);
+err_init_queue:
 	return ret;
 }
 
-- 
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
