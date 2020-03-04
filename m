From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH 07/12] spi: Do spi_take_timestamp_pre for as many times as necessary
Date: Thu,  5 Mar 2020 00:00:39 +0200
Message-ID: <20200304220044.11193-8-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

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

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi.c       | 19 +++++++------------
 include/linux/spi/spi.h |  3 +--
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a8495fd3bb47..22baf204a09d 100644
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
2.17.1
