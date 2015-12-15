From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: fix loopback mode setup after controller reset" to the spi tree
Date: Tue, 15 Dec 2015 22:41:27 +0000
Message-ID: <E1a8yHf-0008JW-5D@debutante>
References: <1449557030-27525-2-git-send-email-anton.bondarenko.sama@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449557030-27525-2-git-send-email-anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: fix loopback mode setup after controller reset

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

>From f677f17cced0ca72a4331b64de119b35b19facb0 Mon Sep 17 00:00:00 2001
From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 8 Dec 2015 07:43:43 +0100
Subject: [PATCH] spi: imx: fix loopback mode setup after controller reset

If controller hold in reset it's not possible to write any
register except CTRL. So all other registers must be updated
only after controller bring out from reset.

Signed-off-by: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 410522fdd4c9..3aa33c8c819f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -356,6 +356,9 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	else
 		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(config->cs);
 
+	/* CTRL register always go first to bring out controller from reset */
+	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
+
 	reg = readl(spi_imx->base + MX51_ECSPI_TESTREG);
 	if (config->mode & SPI_LOOP)
 		reg |= MX51_ECSPI_TESTREG_LBC;
@@ -363,7 +366,6 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 		reg &= ~MX51_ECSPI_TESTREG_LBC;
 	writel(reg, spi_imx->base + MX51_ECSPI_TESTREG);
 
-	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
 
 	/*
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
