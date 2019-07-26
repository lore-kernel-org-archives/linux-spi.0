From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/6] spi: sprd: adi: Add a reset reason for factory test mode
Date: Fri, 26 Jul 2019 15:20:50 +0800
Message-ID: <8ae5651e876b527920ff878721a8a8ef47b099ac.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
Cc: weicx@spreadst.com, sherry.zong@unisoc.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Sherry Zong <sherry.zong@unisoc.com>

Add a new reset flag to indicate that the system need enter factory test
mode after restarting system.

Signed-off-by: Sherry Zong <sherry.zong@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 0b3f23a..509ce69 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -98,6 +98,7 @@
 #define HWRST_STATUS_AUTODLOADER	0xa0
 #define HWRST_STATUS_IQMODE		0xb0
 #define HWRST_STATUS_SPRDISK		0xc0
+#define HWRST_STATUS_FACTORYTEST	0xe0
 
 /* Use default timeout 50 ms that converts to watchdog values */
 #define WDG_LOAD_VAL			((50 * 1000) / 32768)
@@ -339,6 +340,8 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 		reboot_mode = HWRST_STATUS_SPRDISK;
 	else if (!strncmp(cmd, "tospanic", 8))
 		reboot_mode = HWRST_STATUS_SECURITY;
+	else if (!strncmp(cmd, "factorytest", 11))
+		reboot_mode = HWRST_STATUS_FACTORYTEST;
 	else
 		reboot_mode = HWRST_STATUS_NORMAL;
 
-- 
1.7.9.5
