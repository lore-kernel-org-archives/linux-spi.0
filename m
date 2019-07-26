From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/6] spi: sprd: adi: Add a reset reason for TOS panic
Date: Fri, 26 Jul 2019 15:20:49 +0800
Message-ID: <97583aad1f2b849d69b4e76e8d29113da72a9fff.1564125131.git.baolin.wang@linaro.org>
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

From: Chenxu Wei <weicx@spreadst.com>

Add a new reset flag to indicate the reset reason is caused by TOS.

Signed-off-by: Chenxu Wei <weicx@spreadst.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 11880db..0b3f23a 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -86,6 +86,7 @@
 #define BIT_WDG_EN			BIT(2)
 
 /* Definition of PMIC reset status register */
+#define HWRST_STATUS_SECURITY		0x02
 #define HWRST_STATUS_RECOVERY		0x20
 #define HWRST_STATUS_NORMAL		0x40
 #define HWRST_STATUS_ALARM		0x50
@@ -336,6 +337,8 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 		reboot_mode = HWRST_STATUS_IQMODE;
 	else if (!strncmp(cmd, "sprdisk", 7))
 		reboot_mode = HWRST_STATUS_SPRDISK;
+	else if (!strncmp(cmd, "tospanic", 8))
+		reboot_mode = HWRST_STATUS_SECURITY;
 	else
 		reboot_mode = HWRST_STATUS_NORMAL;
 
-- 
1.7.9.5
