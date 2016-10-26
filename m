From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: change post transfer udelay() to usleep_range() for long delays" to the spi tree
Date: Wed, 26 Oct 2016 16:13:04 +0100
Message-ID: <E1bzPt2-0008DQ-55@debutante>
References: <1475837747-7385-1-git-send-email-djkurtz@chromium.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        gwendal-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1475837747-7385-1-git-send-email-djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: change post transfer udelay() to usleep_range() for long delays

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

>From 8244bd3ab405a1268223a282b32d28031f7e16fe Mon Sep 17 00:00:00 2001
From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Date: Fri, 7 Oct 2016 18:55:47 +0800
Subject: [PATCH] spi: change post transfer udelay() to usleep_range() for long
 delays

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
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5787b723b593..42f3e1cb9212 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1034,8 +1034,14 @@ static int spi_transfer_one_message(struct spi_master *master,
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
