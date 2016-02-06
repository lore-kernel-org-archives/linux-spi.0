From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] spi: fix spi.h kernel-doc warning
Date: Fri, 5 Feb 2016 17:31:39 -0800
Message-ID: <56B54CFB.9050904@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@linux-foundation.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning for missing struct field notation.

..//include/linux/spi/spi.h:540: warning: No description found for parameter 'max_transfer_size'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/spi/spi.h |    2 ++
 1 file changed, 2 insertions(+)

--- lnx-45-rc2.orig/include/linux/spi/spi.h
+++ lnx-45-rc2/include/linux/spi/spi.h
@@ -303,6 +303,8 @@ static inline void spi_unregister_driver
  * @min_speed_hz: Lowest supported transfer speed
  * @max_speed_hz: Highest supported transfer speed
  * @flags: other constraints relevant to this driver
+ * @max_transfer_size: function that returns the max transfer size for
+ *	a &spi_device; may be %NULL, so the default %SIZE_MAX will be used.
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for SPI bus locking
  * @bus_lock_flag: indicates that the SPI bus is locked for exclusive use
