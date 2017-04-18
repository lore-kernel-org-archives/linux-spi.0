From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: atmel: add deepest PM support to SAMA5D2" to the spi tree
Date: Tue, 18 Apr 2017 19:00:34 +0100
Message-ID: <E1d0XQY-0007Nw-5o@debutante>
References: <20170412070520.29621-2-quentin.schulz@free-electrons.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>, nicolas.ferre@microchip.com,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com,
        thomas.petazzoni@free-electrons.com, linux-spi@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170412070520.29621-2-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: atmel: add deepest PM support to SAMA5D2

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

>From e53800787a251d67e532fadf72886be0661aba12 Mon Sep 17 00:00:00 2001
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Date: Fri, 14 Apr 2017 10:22:43 +0200
Subject: [PATCH] spi: atmel: add deepest PM support to SAMA5D2

This adds deepest (Backup+Self-Refresh) PM support to the ATMEL SAMA5D2
SoC's SPI controller.

When resuming from deepest state, it is required to restore MR register
as the registers are lost since VDD core has been shut down when
entering deepest state on the SAMA5D2.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 247d920a512f..1eb83c9613d5 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1702,8 +1702,17 @@ static int atmel_spi_suspend(struct device *dev)
 static int atmel_spi_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
+	struct atmel_spi *as = spi_master_get_devdata(master);
 	int ret;
 
+	ret = clk_prepare_enable(as->clk);
+	if (ret)
+		return ret;
+
+	atmel_spi_init(as);
+
+	clk_disable_unprepare(as->clk);
+
 	if (!pm_runtime_suspended(dev)) {
 		ret = atmel_spi_runtime_resume(dev);
 		if (ret)
-- 
2.11.0
