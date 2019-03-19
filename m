From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: lpspi: fsl_lpspi_runtime_resume() can be static" to the spi tree
Date: Tue, 19 Mar 2019 13:14:00 +0000 (GMT)
Message-ID: <20190319131400.6D59711288DF@debutante.sirena.org.uk>
References: <20190319014633.GA8434@ivb42>
Cc: Mark Brown <broonie@kernel.org>, Han Xu <han.xu@nxp.com>,
        kbuild-all@01.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Frank Li <frank.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319014633.GA8434@ivb42>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: lpspi: fsl_lpspi_runtime_resume() can be static

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

>From 809b169abbfe2b916f70c957b08dfaaaad0d7c02 Mon Sep 17 00:00:00 2001
From: kbuild test robot <lkp@intel.com>
Date: Tue, 19 Mar 2019 09:46:33 +0800
Subject: [PATCH] spi: lpspi: fsl_lpspi_runtime_resume() can be static

Fixes: 944c01a889d9 ("spi: lpspi: enable runtime pm for lpspi")
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 1860f066f838..4de8eb378752 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -780,7 +780,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-int fsl_lpspi_runtime_resume(struct device *dev)
+static int fsl_lpspi_runtime_resume(struct device *dev)
 {
 	struct fsl_lpspi_data *fsl_lpspi = dev_get_drvdata(dev);
 	int ret;
@@ -798,7 +798,7 @@ int fsl_lpspi_runtime_resume(struct device *dev)
 	return 0;
 }
 
-int fsl_lpspi_runtime_suspend(struct device *dev)
+static int fsl_lpspi_runtime_suspend(struct device *dev)
 {
 	struct fsl_lpspi_data *fsl_lpspi = dev_get_drvdata(dev);
 
-- 
2.20.1
