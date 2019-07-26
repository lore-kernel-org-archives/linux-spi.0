From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/6] spi: sprd: adi: Remove redundant address bits setting
Date: Fri, 26 Jul 2019 15:20:48 +0800
Message-ID: <3cb57b8aadb7747a9f833e9b4fe8596ba738d9f6.1564125131.git.baolin.wang@linaro.org>
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

The ADI default transfer address bits is 12bit on Spreadtrum SC9860
platform, thus there is no need to set again, remove it.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index df5960b..11880db 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -380,9 +380,6 @@ static void sprd_adi_hw_init(struct sprd_adi *sadi)
 	const __be32 *list;
 	u32 tmp;
 
-	/* Address bits select default 12 bits */
-	writel_relaxed(0, sadi->base + REG_ADI_CTRL0);
-
 	/* Set all channels as default priority */
 	writel_relaxed(0, sadi->base + REG_ADI_CHN_PRIL);
 	writel_relaxed(0, sadi->base + REG_ADI_CHN_PRIH);
-- 
1.7.9.5
