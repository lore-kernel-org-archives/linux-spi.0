From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-pxa2xx: Remove CLK_IS_ROOT" to the spi tree
Date: Wed, 20 Apr 2016 17:20:18 +0100
Message-ID: <E1asurS-00079W-82@debutante>
References: <1461114607-15627-1-git-send-email-sboyd@codeaurora.org>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Brown <broonie@kernel.org>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
To: Stephen Boyd <sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461114607-15627-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-pxa2xx: Remove CLK_IS_ROOT

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 280af2b8eb3674628223b8d143b5f71cd2a96159 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <sboyd@codeaurora.org>
Date: Tue, 19 Apr 2016 18:10:07 -0700
Subject: [PATCH] spi: spi-pxa2xx: Remove CLK_IS_ROOT

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 520ed1dd5780..83706aeb39b2 100644
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
2.8.0.rc3
