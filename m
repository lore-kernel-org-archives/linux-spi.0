From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] spi: Make master->handle_err() callback optional to avoid crashes
Date: Tue,  7 Apr 2015 20:39:19 +0200
Message-ID: <1428431959-23935-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If a driver doesn't implement the master->handle_err() callback and an
SPI transfer fails, the kernel will crash with a NULL pointer
dereference:

    Unable to handle kernel NULL pointer dereference at virtual address 00000000
    pgd = c0003000
    [00000000] *pgd=80000040004003, *pmd=00000000
    Internal error: Oops: 80000206 [#1] SMP ARM
    Modules linked in:
    CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc7-koelsch-05861-g1fc9fdd4add4f783 #1046
    Hardware name: Generic R8A7791 (Flattened Device Tree)
    task: eec359c0 ti: eec54000 task.ti: eec54000
    PC is at 0x0
    LR is at spi_transfer_one_message+0x1cc/0x1f0

Make the master->handle_err() callback optional to avoid the crash.

Also fix a spelling mistake in the callback documentation while we're at
it.

Fixes: b716c4ffc6a2b0bf ("spi: introduce master->handle_err() callback")
Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi.c       | 2 +-
 include/linux/spi/spi.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 04e9d9262711a56e..d5d7d2235163f9ef 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -736,7 +736,7 @@ out:
 	if (msg->status == -EINPROGRESS)
 		msg->status = ret;
 
-	if (msg->status)
+	if (msg->status && master->handle_err)
 		master->handle_err(master, msg);
 
 	spi_finalize_current_message(master);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 57a89347b038e611..d673072346f2e041 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -290,7 +290,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *                    transfer_one_message are mutually exclusive; when both
  *                    are set, the generic subsystem does not call your
  *                    transfer_one callback.
- * @handle_err: the subsystem calls the driver to handle and error that occurs
+ * @handle_err: the subsystem calls the driver to handle an error that occurs
  *		in the generic implementation of transfer_one_message().
  * @unprepare_message: undo any work done by prepare_message().
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
