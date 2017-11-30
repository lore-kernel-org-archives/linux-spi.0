From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/trivial] spi: Fix double "when"
Date: Thu, 30 Nov 2017 14:35:08 +0100
Message-ID: <1512048908-19246-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Jiri Kosina <trivial@kernel.org>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7b2170bfd6e7dae4..bc6bb325d1bf7c03 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -126,7 +126,7 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  *	for that name.  This appears in the sysfs "modalias" attribute
  *	for driver coldplugging, and in uevents used for hotplugging
  * @cs_gpio: gpio number of the chipselect line (optional, -ENOENT when
- *	when not using a GPIO line)
+ *	not using a GPIO line)
  *
  * @statistics: statistics for the spi_device
  *
-- 
2.7.4
