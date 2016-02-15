From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/3] spi: rockchip: disable runtime pm when in err case
Date: Mon, 15 Feb 2016 16:27:58 +0800
Message-ID: <1455524878-2696-1-git-send-email-shawn.lin@rock-chips.com>
References: <1455524848-2646-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455524848-2646-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Before registering master, driver enables runtime pm.
This patch  pm_runtime_disable in err case while probing
driver to balance pm reference count.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/spi/spi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 79a8bc4..c0f9bae 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -749,6 +749,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	return 0;
 
 err_register_master:
+	pm_runtime_disable(&pdev->dev);
 	if (rs->dma_tx.ch)
 		dma_release_channel(rs->dma_tx.ch);
 	if (rs->dma_rx.ch)
-- 
2.3.7
