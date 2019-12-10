From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 168/350] spi: sprd: adi: Add missing lock protection when rebooting
Date: Tue, 10 Dec 2019 16:04:33 -0500
Message-ID: <20191210210735.9077-129-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Lingling Xu <ling_ling.xu@unisoc.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Lingling Xu <ling_ling.xu@unisoc.com>

[ Upstream commit 91ea1d70607e374b014b4b9bea771ce661f9f64b ]

When rebooting the system, we should lock the watchdog after
configuration to make sure the watchdog can reboot the system
successfully.

Signed-off-by: Lingling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 9a051286f1207..9613cfe3c0a25 100644
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
2.20.1
