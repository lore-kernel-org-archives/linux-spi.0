From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: Fix hung task timeout when initialization fails
Date: Thu,  1 May 2014 10:15:15 +0200
Message-ID: <1398932115-11646-1-git-send-email-ricardo.ribalda@gmail.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If kthread_run on spi_init_queue() fails, spi_destroy_queue can lead to
hang timeout.

Before 786235eeba0e1e85e5cbbb9f97d1087ad03dfa21 kthread:
make kthread_create() killable" it was very unlikely that kthread_run
would fail, but after that patch a kill to modprobe can lead to this
kind of error. Udev kills modprobe after 30 seconds.

When this happens, spi_destroy_queue() leads to a hung process that
outputs a error message and avoids the computer to be halted/rebooted.

This bug is particulary critical on machines that relay on the spi
subsystem to hold a file system (MTD over SPI).

[   95.900328] spi_master spi32765: failed to create message pump task
[   95.900358] spi_master spi32765: problem initializing queue
[   95.912333] qtec_pcie b0030000.pcie_bridge: Axi-pcie bridge supervisor
[  240.463698] INFO: task udevd:129 blocked for more than 120 seconds.
[  240.463733] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  240.463807] Call Trace:
[  240.463968]  [<ffffffff8178c22d>] wait_for_completion+0x1d/0x20
[  240.464036]  [<ffffffff8146c637>] spi_destroy_queue+0x27/0x60
[  240.464050]  [<ffffffff8146cc46>] spi_register_master+0x5d6/0x900

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

v2: Comment by Mark Brown:
-Improve commit message

 drivers/spi/spi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4eb9bf0..8331556 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1114,8 +1114,10 @@ static int spi_destroy_queue(struct spi_master *master)
 		return ret;
 	}
 
-	flush_kthread_worker(&master->kworker);
-	kthread_stop(master->kworker_task);
+	if (!IS_ERR(master->kworker_task)) {
+		flush_kthread_worker(&master->kworker);
+		kthread_stop(master->kworker_task);
+	}
 
 	return 0;
 }
-- 
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
