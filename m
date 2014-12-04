From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: core: Do not mangle error code from kthread_run()
Date: Thu,  4 Dec 2014 11:02:25 +0200
Message-ID: <1417683745-26349-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

kthread_run() could return ERR_PTR(-EINTR) from kthread_create_on_node().
Return the actual error code in spi_init_queue() instead of mangling it to
-ENOMEM.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 50f20f243981..da7e6225b8f6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1001,7 +1001,7 @@ static int spi_init_queue(struct spi_master *master)
 					   dev_name(&master->dev));
 	if (IS_ERR(master->kworker_task)) {
 		dev_err(&master->dev, "failed to create message pump task\n");
-		return -ENOMEM;
+		return PTR_ERR(master->kworker_task);
 	}
 	init_kthread_work(&master->pump_messages, spi_pump_messages);
 
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
