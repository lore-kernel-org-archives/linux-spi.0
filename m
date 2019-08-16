From: Vladimir Oltean <olteanv@gmail.com>
Subject: [RFC PATCH net-next 03/11] spi: Add a PTP system timestamp to the transfer structure
Date: Fri, 16 Aug 2019 03:44:41 +0300
Message-ID: <20190816004449.10100-4-olteanv@gmail.com>
References: <20190816004449.10100-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
To: h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        broonie@kernel.org
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190816004449.10100-1-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SPI is one of the interfaces used to access devices which have a POSIX
clock driver (real time clocks, 1588 timers etc).

Since there are lots of sources of timing jitter when retrieving the
time from such a device (controller delays, locking contention etc),
introduce a PTP system timestamp structure in struct spi_transfer. This
is to be used by SPI device drivers when they need to know the exact
time at which the underlying device's time was snapshotted.

Because SPI controllers may have jitter even between frames, also
introduce a field which specifies to the controller driver specifically
which byte needs to be snapshotted.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 include/linux/spi/spi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index af4f265d0f67..5a1e4b24c617 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -13,6 +13,7 @@
 #include <linux/completion.h>
 #include <linux/scatterlist.h>
 #include <linux/gpio/consumer.h>
+#include <linux/ptp_clock_kernel.h>
 
 struct dma_chan;
 struct property_entry;
@@ -842,6 +843,9 @@ struct spi_transfer {
 
 	u32		effective_speed_hz;
 
+	struct ptp_system_timestamp *ptp_sts;
+	unsigned int	ptp_sts_word_offset;
+
 	struct list_head transfer_list;
 };
 
-- 
2.17.1
