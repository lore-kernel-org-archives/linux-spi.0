From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: lpspi: Add the missing NULL check" to the spi tree
Date: Mon, 18 Mar 2019 14:52:07 +0000 (GMT)
Message-ID: <20190318145207.DD4F81128874@debutante.sirena.org.uk>
References: <20190306063020.793-8-xiaoning.wang@nxp.com>
Cc: Fugang Duan <Fugang.duan@nxp.com>, Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306063020.793-8-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: lpspi: Add the missing NULL check

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

>From 578465ea2b4b56368ddc3dcefb1f6d607382ef86 Mon Sep 17 00:00:00 2001
From: Clark Wang <xiaoning.wang@nxp.com>
Date: Wed, 6 Mar 2019 06:30:47 +0000
Subject: [PATCH] spi: lpspi: Add the missing NULL check

The spi_transfer *t will be used in one transfer whatever. If t is NULL,
there has no need to try sending data, so add an error return here.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Acked-by: Fugang Duan <Fugang.duan@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 9ff32fb67a29..2ac3ac5ea50a 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -438,9 +438,12 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 	struct fsl_lpspi_data *fsl_lpspi =
 				spi_controller_get_devdata(spi->controller);
 
+	if (t == NULL)
+		return -EINVAL;
+
 	fsl_lpspi->config.mode = spi->mode;
-	fsl_lpspi->config.bpw = t ? t->bits_per_word : spi->bits_per_word;
-	fsl_lpspi->config.speed_hz = t ? t->speed_hz : spi->max_speed_hz;
+	fsl_lpspi->config.bpw = t->bits_per_word;
+	fsl_lpspi->config.speed_hz = t->speed_hz;
 	fsl_lpspi->config.chip_select = spi->chip_select;
 
 	if (!fsl_lpspi->config.speed_hz)
-- 
2.20.1
