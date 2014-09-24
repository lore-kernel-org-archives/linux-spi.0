From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 22/27] spi: orion: use pm_runtime_last_busy_and_autosuspend helper
Date: Wed, 24 Sep 2014 21:45:12 +0530
Message-ID: <1411575342-31048-23-git-send-email-vinod.koul@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Cc: subhransu.s.prusty@intel.com, vinod.koul@intel.com,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
coding the same code

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/spi/spi-orion.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index c4675fa..3f14578 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -408,8 +408,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	if (status < 0)
 		goto out_rel_pm;
 
-	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	pm_runtime_last_busy_and_autosuspend(&pdev->dev);
 
 	master->dev.of_node = pdev->dev.of_node;
 	status = spi_register_master(master);
-- 
1.7.0.4
