From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 1/7] spi: qup: call spi_qup_pm_resume_runtime before suspending
Date: Sun, 15 Mar 2020 22:35:41 -0400
Message-ID: <20200316023548.2347-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Yuji Sasaki <sasakiy@chromium.org>, Vinod Koul <vkoul@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Yuji Sasaki <sasakiy@chromium.org>

[ Upstream commit 136b5cd2e2f97581ae560cff0db2a3b5369112da ]

spi_qup_suspend() will cause synchronous external abort when
runtime suspend is enabled and applied, as it tries to
access SPI controller register while clock is already disabled
in spi_qup_pm_suspend_runtime().

Signed-off-by: Yuji sasaki <sasakiy@chromium.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20200214074340.2286170-1-vkoul@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-qup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 810a7fae34798..2487a91c4cfdb 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -961,6 +961,11 @@ static int spi_qup_suspend(struct device *device)
 	struct spi_qup *controller = spi_master_get_devdata(master);
 	int ret;
 
+	if (pm_runtime_suspended(device)) {
+		ret = spi_qup_pm_resume_runtime(device);
+		if (ret)
+			return ret;
+	}
 	ret = spi_master_suspend(master);
 	if (ret)
 		return ret;
-- 
2.20.1
