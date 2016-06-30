From: apronin@chromium.org
Subject: [PATCH 3/4] spi: Add option to insert delay between transactions
Date: Wed, 29 Jun 2016 20:54:26 -0700
Message-ID: <1467258867-117727-3-git-send-email-apronin@chromium.org>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Andrey Pronin <apronin@chromium.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467258867-117727-1-git-send-email-apronin@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Andrey Pronin <apronin@chromium.org>

Some devices may need CS to be deasserted for some time
between transactions. Added a new capability to guarantee
a delay between SPI transactions for the device.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
---
 drivers/spi/spi.c       | 3 +++
 include/linux/spi/spi.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c51c864..639c7bd 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -971,6 +971,9 @@ static int spi_transfer_one_message(struct spi_master *master,
 		spi_reset_cs_wake_timer(msg->spi);
 	}
 
+	if (msg->spi->xfer_delay)
+		mdelay(msg->spi->xfer_delay);
+
 	spi_set_cs(msg->spi, true);
 
 	SPI_STATISTICS_INCREMENT_FIELD(statm, messages);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4b06ba6..4b1aa13 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -137,6 +137,8 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  * @cs_wake_timer: Timer measuring the delay before the device goes to
  *	sleep after the last SPI transaction.
  *
+ * @xfer_delay: Delay between SPI transactions (msec).
+ *
  * @statistics: statistics for the spi_device
  *
  * A @spi_device is used to interchange data between an SPI slave
@@ -183,6 +185,8 @@ struct spi_device {
 	bool			cs_wake_needed;
 	struct timer_list	cs_wake_timer;
 
+	u32			xfer_delay;
+
 	/* the statistics */
 	struct spi_statistics	statistics;
 
-- 
2.6.6
