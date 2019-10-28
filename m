From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/2] spi: sprd: adi: Add missing lock protection when rebooting
Date: Mon, 28 Oct 2019 18:10:30 +0800
Message-ID: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, ling_ling.xu@unisoc.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Lingling Xu <ling_ling.xu@unisoc.com>

When rebooting the system, we should lock the watchdog after
configuration to make sure the watchdog can reboot the system
successfully.

Signed-off-by: Lingling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 9a05128..9613cfe 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -393,6 +393,9 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 	val |= BIT_WDG_RUN | BIT_WDG_RST;
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
 
+	/* Lock the watchdog */
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOCK, ~WDG_UNLOCK_KEY);
+
 	mdelay(1000);
 
 	dev_emerg(sadi->dev, "Unable to restart system\n");
-- 
1.7.9.5
