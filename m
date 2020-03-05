From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Do spi_take_timestamp_pre for as many times as necessary" to the spi tree
Date: Thu, 05 Mar 2020 14:37:35 +0000
Message-ID: <applied-20200304220044.11193-8-olteanv@gmail.com>
References: <20200304220044.11193-8-olteanv@gmail.com>
Cc: andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        eha-/iRVSOupHO4@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
To: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200304220044.11193-8-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Do spi_take_timestamp_pre for as many times as necessary

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 6a726824aaa3adaaf3bcfca3b471408e225f33d6 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Date: Thu, 5 Mar 2020 00:00:39 +0200
Subject: [PATCH] spi: Do spi_take_timestamp_pre for as many times as necessary

When dealing with a SPI controller driver that is sending more than 1
byte at once (or the entire buffer at once), and the SPI peripheral
driver has requested timestamping for a byte in the middle of the
buffer, we find that spi_take_timestamp_pre never records a "pre"
timestamp.

This happens because the function currently expects to be called with
the "progress" argument >= to what the peripheral has requested to be
timestamped. But clearly there are cases when that isn't going to fly.

And since we can't change the past when we realize that the opportunity
to take a "pre" timestamp has just passed and there isn't going to be
another one, the approach taken is to keep recording the "pre" timestamp
on each call, overwriting the previously recorded one until the "post"
timestamp is also taken.

Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Link: https://lore.kernel.org/r/20200304220044.11193-8-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c       | 19 +++++++------------
 include/linux/spi/spi.h |  3 +--
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 292f26807b41..6c223f7d1ddc 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1515,17 +1515,15 @@ void spi_take_timestamp_pre(struct spi_controller *ctlr,
 	if (!xfer->ptp_sts)
 		return;
 
-	if (xfer->timestamped_pre)
+	if (xfer->timestamped)
 		return;
 
-	if (progress < xfer->ptp_sts_word_pre)
+	if (progress > xfer->ptp_sts_word_pre)
 		return;
 
 	/* Capture the resolution of the timestamp */
 	xfer->ptp_sts_word_pre = progress;
 
-	xfer->timestamped_pre = true;
-
 	if (irqs_off) {
 		local_irq_save(ctlr->irq_flags);
 		preempt_disable();
@@ -1554,7 +1552,7 @@ void spi_take_timestamp_post(struct spi_controller *ctlr,
 	if (!xfer->ptp_sts)
 		return;
 
-	if (xfer->timestamped_post)
+	if (xfer->timestamped)
 		return;
 
 	if (progress < xfer->ptp_sts_word_post)
@@ -1570,7 +1568,7 @@ void spi_take_timestamp_post(struct spi_controller *ctlr,
 	/* Capture the resolution of the timestamp */
 	xfer->ptp_sts_word_post = progress;
 
-	xfer->timestamped_post = true;
+	xfer->timestamped = true;
 }
 EXPORT_SYMBOL_GPL(spi_take_timestamp_post);
 
@@ -1675,12 +1673,9 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 		}
 	}
 
-	if (unlikely(ctlr->ptp_sts_supported)) {
-		list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
-			WARN_ON_ONCE(xfer->ptp_sts && !xfer->timestamped_pre);
-			WARN_ON_ONCE(xfer->ptp_sts && !xfer->timestamped_post);
-		}
-	}
+	if (unlikely(ctlr->ptp_sts_supported))
+		list_for_each_entry(xfer, &mesg->transfers, transfer_list)
+			WARN_ON_ONCE(xfer->ptp_sts && !xfer->timestamped);
 
 	spi_unmap_msg(ctlr, mesg);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 600e3793303e..87105272879b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -933,8 +933,7 @@ struct spi_transfer {
 
 	struct ptp_system_timestamp *ptp_sts;
 
-	bool		timestamped_pre;
-	bool		timestamped_post;
+	bool		timestamped;
 
 	struct list_head transfer_list;
 };
-- 
2.20.1
