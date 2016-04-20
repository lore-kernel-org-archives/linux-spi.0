From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] spi: spi-pxa2xx: Remove CLK_IS_ROOT
Date: Tue, 19 Apr 2016 18:10:07 -0700
Message-ID: <1461114607-15627-1-git-send-email-sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 4fd7f9802f1b..5202de94f792 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -173,8 +173,8 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	ssp->type = c->type;
 
 	snprintf(buf, sizeof(buf), "pxa2xx-spi.%d", ssp->port_id);
-	ssp->clk = clk_register_fixed_rate(&dev->dev, buf , NULL,
-					CLK_IS_ROOT, c->max_clk_rate);
+	ssp->clk = clk_register_fixed_rate(&dev->dev, buf , NULL, 0,
+					   c->max_clk_rate);
 	 if (IS_ERR(ssp->clk))
 		return PTR_ERR(ssp->clk);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
