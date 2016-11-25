From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: fix potential shift truncation" to the spi tree
Date: Fri, 25 Nov 2016 13:10:34 +0000
Message-ID: <E1cAGGw-0005JE-GG@debutante>
References: <1479985484-6641-2-git-send-email-pandy.gao@nxp.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pandy.gao-3arQi8VN3Tc@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org,
        fugang.duan-3arQi8VN3Tc@public.gmane.org
To: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479985484-6641-2-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: fix potential shift truncation

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

>From e3a49390ebefec6f7e3d447b5ba3ba253dd51145 Mon Sep 17 00:00:00 2001
From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Date: Thu, 24 Nov 2016 19:04:43 +0800
Subject: [PATCH] spi: imx: fix potential shift truncation

There is a static checker warning in fsl_lpspi_set_cmd().
I intended to write "temp |= (fsl_lpspi->config.mode & 0x3) << 30",
but used "temp |= (fsl_lpspi->config.mode & 0x11) << 30" by mistake.

This patch fixes this potential shift truncation.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index d7ce32aa083b..18a269d2e2f8 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -215,7 +215,7 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
 
 	temp |= fsl_lpspi->config.bpw - 1;
 	temp |= fsl_lpspi->config.prescale << 27;
-	temp |= (fsl_lpspi->config.mode & 0x11) << 30;
+	temp |= (fsl_lpspi->config.mode & 0x3) << 30;
 	temp |= (fsl_lpspi->config.chip_select & 0x3) << 24;
 
 	/*
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
