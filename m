From: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] spi: core: Increase timeout value
Date: Fri, 11 Apr 2014 12:06:28 +0530
Message-ID: <1397198188-8602-1-git-send-email-harinik@xilinx.com>
Cc: michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The existing timeout value in wait_for_completion_timeout is
calculated from the transfer length and speed with tolerance of 10msec.
This is too low because this is used for error conditions such as
hardware hang etc.
The xfer->speed_hz considered may not be the actual speed set
because the best clock divisor is chosen from a limited set such that
the actual speed <= requested speed. This will lead to timeout being
less than actual transfer time.
Considering acceptable latencies, this timeout can be set to a
value double the expected transfer plus 100 msecs.
This patch adds the same in the core.

Signed-off-by: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---

v2 changes:
Decrease timeout - make it double of expected time + 100ms

---
 drivers/spi/spi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4eb9bf0..f01cbb4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -775,7 +775,7 @@ static int spi_transfer_one_message(struct spi_master *master,
 		if (ret > 0) {
 			ret = 0;
 			ms = xfer->len * 8 * 1000 / xfer->speed_hz;
-			ms += 10; /* some tolerance */
+			ms += ms + 100; /* some tolerance */
 
 			ms = wait_for_completion_timeout(&master->xfer_completion,
 							 msecs_to_jiffies(ms));
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
