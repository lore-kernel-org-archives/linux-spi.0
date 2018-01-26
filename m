From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: orion: Fix a resource leak if the optional "axi" clk is deferred" to the spi tree
Date: Fri, 26 Jan 2018 12:54:21 +0000
Message-ID: <E1ef3WP-0002Mh-9A@debutante>
References: <20180125201617.17099-1-christophe.jaillet@wanadoo.fr>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        gregory.clement@free-electrons.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-spi@vger.kernel.org
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20180125201617.17099-1-christophe.jaillet@wanadoo.fr>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: orion: Fix a resource leak if the optional "axi" clk is deferred

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 479c03a7173d07b2967f9b521159271543d99e2f Mon Sep 17 00:00:00 2001
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Date: Thu, 25 Jan 2018 21:16:17 +0100
Subject: [PATCH] spi: orion: Fix a resource leak if the optional "axi" clk is
 deferred

If the optional "axi" clk is deferred, we still need to undo some
initialisation. Especially 'master' must be released. It will be
reallocated the next time 'orion_spi_probe()' is called.

Add a new label to clean what needs to be cleaned and rename another
label to improve the names used.

Fixes: 92ae112e477a ("spi: orion: Fix clock resource by adding an optional bus clock")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-orion.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 482a0cf3b7aa..deca63e82ff6 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -638,8 +638,10 @@ static int orion_spi_probe(struct platform_device *pdev)
 	/* The following clock is only used by some SoCs */
 	spi->axi_clk = devm_clk_get(&pdev->dev, "axi");
 	if (IS_ERR(spi->axi_clk) &&
-	    PTR_ERR(spi->axi_clk) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	    PTR_ERR(spi->axi_clk) == -EPROBE_DEFER) {
+		status = -EPROBE_DEFER;
+		goto out_rel_clk;
+	}
 	if (!IS_ERR(spi->axi_clk))
 		clk_prepare_enable(spi->axi_clk);
 
@@ -667,7 +669,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	spi->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(spi->base)) {
 		status = PTR_ERR(spi->base);
-		goto out_rel_clk;
+		goto out_rel_axi_clk;
 	}
 
 	/* Scan all SPI devices of this controller for direct mapped devices */
@@ -705,7 +707,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 							    PAGE_SIZE);
 		if (!spi->direct_access[cs].vaddr) {
 			status = -ENOMEM;
-			goto out_rel_clk;
+			goto out_rel_axi_clk;
 		}
 		spi->direct_access[cs].size = PAGE_SIZE;
 
@@ -733,8 +735,9 @@ static int orion_spi_probe(struct platform_device *pdev)
 
 out_rel_pm:
 	pm_runtime_disable(&pdev->dev);
-out_rel_clk:
+out_rel_axi_clk:
 	clk_disable_unprepare(spi->axi_clk);
+out_rel_clk:
 	clk_disable_unprepare(spi->clk);
 out:
 	spi_master_put(master);
-- 
2.15.1

