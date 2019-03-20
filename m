From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw: Add support for an optional interface clock" to the spi tree
Date: Wed, 20 Mar 2019 17:30:05 +0000 (GMT)
Message-ID: <20190320173005.8B0771126E4C@debutante.sirena.org.uk>
References: <1553010727-23157-4-git-send-email-gareth.williams.jx@renesas.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-spi@vger.kernel.org
To: Phil Edworthy <phil.edworthy@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553010727-23157-4-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: dw: Add support for an optional interface clock

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

>From 560ee7e9100916e30e126a53d127ca54745b2a8e Mon Sep 17 00:00:00 2001
From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 19 Mar 2019 15:52:07 +0000
Subject: [PATCH] spi: dw: Add support for an optional interface clock

The Synopsys SSI Controller has an interface clock, but most SoCs hide
this away. However, on some SoCs you need to explicitly enable the
interface clock in order to access the registers. Therefore, add support
for an optional interface clock.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 4bd59a93d988..de952b17bc10 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -30,6 +30,7 @@
 struct dw_spi_mmio {
 	struct dw_spi  dws;
 	struct clk     *clk;
+	struct clk     *pclk;
 	void           *priv;
 };
 
@@ -172,6 +173,14 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Optional clock needed to access the registers */
+	dwsmmio->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
+	if (IS_ERR(dwsmmio->pclk))
+		return PTR_ERR(dwsmmio->pclk);
+	ret = clk_prepare_enable(dwsmmio->pclk);
+	if (ret)
+		goto out_clk;
+
 	dws->bus_num = pdev->id;
 
 	dws->max_freq = clk_get_rate(dwsmmio->clk);
@@ -199,6 +208,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	return 0;
 
 out:
+	clk_disable_unprepare(dwsmmio->pclk);
+out_clk:
 	clk_disable_unprepare(dwsmmio->clk);
 	return ret;
 }
@@ -208,6 +219,7 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
 
 	dw_spi_remove_host(&dwsmmio->dws);
+	clk_disable_unprepare(dwsmmio->pclk);
 	clk_disable_unprepare(dwsmmio->clk);
 
 	return 0;
-- 
2.20.1
