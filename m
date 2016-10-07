From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] spi: change post transfer udelay() to usleep_range() for long delays
Date: Fri,  7 Oct 2016 18:55:47 +0800
Message-ID: <1475837747-7385-1-git-send-email-djkurtz@chromium.org>
Cc: dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, gwendal-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SPI SUBSYSTEM),
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The spi_transfer parameter delay_usecs allows specifying a time to wait
after transferring a spi message.  This wait can be quite long - some
devices, such as some Chrome OS ECs, require as much as 2000 usecs after
a SPI transaction, before it can respond.

(cf: arch/arm64/boot/dts/nvidia/tegra132-norrin.dts:
   google,cros-ec-spi-msg-delay = <2000>
)

Blocking a CPU for 2 msecs in a busy loop like this doesn't seem very
friendly to other processes, so change the blocking delay to a sleep
to allow other things to use this CPU (or so it can sleep).

This should be safe to do, because:
 (a) A post-transaction delay like this is always specified as a minimum
     wait time
 (b) A delay here is most likely not very time sensitive, as it occurs
     after all data has been transferred
 (c) This delay occurs in a non-critical section of the spi worker thread
     so where it is safe to sleep.

Two caveats:
 1) To avoid penalizing short delays, still use udelay for delays < 10us.
 2) usleep_range() very often picks the upper bound, an upper bounds 10%
    should be plenty.

Signed-off-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/spi/spi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a0b6e14..31b4440 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -845,8 +845,14 @@ static int spi_transfer_one_message(struct spi_master *master,
 		if (msg->status != -EINPROGRESS)
 			goto out;
 
-		if (xfer->delay_usecs)
-			udelay(xfer->delay_usecs);
+		if (xfer->delay_usecs) {
+			u16 us = xfer->delay_usecs;
+
+			if (us <= 10)
+				udelay(us);
+			else
+				usleep_range(us, us + DIV_ROUND_UP(us, 10));
+		}
 
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list,
-- 
2.8.0.rc3.226.g39d4020

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
