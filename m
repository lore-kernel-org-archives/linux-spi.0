From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-mem: stm32-qspi: stm32_qspi_pm_ops can be static" to the spi tree
Date: Wed, 20 Mar 2019 17:30:14 +0000 (GMT)
Message-ID: <20190320173014.45ACA1126E4C@debutante.sirena.org.uk>
References: <20190316073341.GA132987@lkp-hsx03>
Cc: Mark Brown <broonie@kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>, kbuild-all@01.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190316073341.GA132987@lkp-hsx03>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-mem: stm32-qspi: stm32_qspi_pm_ops can be static

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

>From 43a8d240eee4f523c7120f47a4c9469f5abfb308 Mon Sep 17 00:00:00 2001
From: kbuild test robot <lkp@intel.com>
Date: Sat, 16 Mar 2019 15:33:41 +0800
Subject: [PATCH] spi: spi-mem: stm32-qspi: stm32_qspi_pm_ops can be static

Fixes: 2e541b64ee52 ("spi: spi-mem: stm32-qspi: add suspend/resume support")
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 3e8ca10011cc..7879a523583c 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -517,7 +517,7 @@ static int __maybe_unused stm32_qspi_resume(struct device *dev)
 	return 0;
 }
 
-SIMPLE_DEV_PM_OPS(stm32_qspi_pm_ops, stm32_qspi_suspend, stm32_qspi_resume);
+static SIMPLE_DEV_PM_OPS(stm32_qspi_pm_ops, stm32_qspi_suspend, stm32_qspi_resume);
 
 static const struct of_device_id stm32_qspi_match[] = {
 	{.compatible = "st,stm32f469-qspi"},
-- 
2.20.1
