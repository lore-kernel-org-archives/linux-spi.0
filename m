From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/3] spi: rockchip: add missing spi_master_put
Date: Mon, 15 Feb 2016 16:28:12 +0800
Message-ID: <1455524892-2739-1-git-send-email-shawn.lin@rock-chips.com>
References: <1455524848-2646-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455524848-2646-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add missing spi_master_put for rockchip_spi_remove since
it calls spi_master_get already.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index c0f9bae..7cb1b2d 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -779,6 +779,8 @@ static int rockchip_spi_remove(struct platform_device *pdev)
 	if (rs->dma_rx.ch)
 		dma_release_channel(rs->dma_rx.ch);
 
+	spi_master_put(master);
+
 	return 0;
 }
 
-- 
2.3.7
