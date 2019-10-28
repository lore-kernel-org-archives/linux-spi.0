From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/2] spi: sprd: adi: Set BIT_WDG_NEW bit when rebooting
Date: Mon, 28 Oct 2019 18:10:31 +0800
Message-ID: <5655318a7252c9ea518c2f7950a61228ab8f42bf.1572257085.git.baolin.wang@linaro.org>
References: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, ling_ling.xu@unisoc.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
In-Reply-To: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
References: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Lingling Xu <ling_ling.xu@unisoc.com>

When rebooting system, the PMIC watchdog time loading may not be loaded
correctly when another system is feeding the PMIC watchdog, since we did
not check the watchdog busy status before loading time values.

Thus we should set the BIT_WDG_NEW bit before loading time values, that
can support multiple loads without checking busy status to make sure the
time values can be loaded successfully to avoid this potential issue.

Signed-off-by: Lingling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 9613cfe..87dadb6 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -77,6 +77,7 @@
 
 /* Bits definitions for register REG_WDG_CTRL */
 #define BIT_WDG_RUN			BIT(1)
+#define BIT_WDG_NEW			BIT(2)
 #define BIT_WDG_RST			BIT(3)
 
 /* Registers definitions for PMIC */
@@ -383,6 +384,10 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 	/* Unlock the watchdog */
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOCK, WDG_UNLOCK_KEY);
 
+	sprd_adi_read(sadi, sadi->slave_pbase + REG_WDG_CTRL, &val);
+	val |= BIT_WDG_NEW;
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
+
 	/* Load the watchdog timeout value, 50ms is always enough. */
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_LOW,
 		       WDG_LOAD_VAL & WDG_LOAD_MASK);
-- 
1.7.9.5
