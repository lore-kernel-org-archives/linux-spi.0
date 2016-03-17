From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: only do necessary changes to ECSPIx_CONFIGREG" to the spi tree
Date: Thu, 17 Mar 2016 11:45:30 +0000
Message-ID: <E1agWMs-000201-H8@debutante>
References: <1458048276-31884-1-git-send-email-dirk.behme@de.bosch.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>,
	Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458048276-31884-1-git-send-email-dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: only do necessary changes to ECSPIx_CONFIGREG

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

>From 793c7f9212fdb7bea5e017427e750afa11217c29 Mon Sep 17 00:00:00 2001
From: Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Date: Tue, 15 Mar 2016 14:24:36 +0100
Subject: [PATCH] spi: imx: only do necessary changes to ECSPIx_CONFIGREG

If the SPI chip select (CS) for a dedicated channel is done manually by
the used higher device driver, the CS may be active while writing to
ECSPIx_CONFIGREG. To prevent unwanted clock edges when selecting
the clock mode,  only do the necessary changes to the i.MX SPI
configuration register and leave not selected channels untouched.

To prevent unwanted clock edges on first use, an empty dummy
transmission shall be done by the initialization procedure of the device
driver of this channel. This will set the clock mode to the correct state.

Signed-off-by: Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Signed-off-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Acked-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e7a19be87c38..b79d70d6dabf 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -333,8 +333,9 @@ static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
-	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0;
+	u32 ctrl = MX51_ECSPI_CTRL_ENABLE;
 	u32 clk = config->speed_hz, delay, reg;
+	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
 
 	/*
 	 * The hardware seems to have a race condition when changing modes. The
@@ -358,13 +359,20 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 
 	if (config->mode & SPI_CPHA)
 		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
+	else
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
 
 	if (config->mode & SPI_CPOL) {
 		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
 		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
+	} else {
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
 	}
 	if (config->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
+	else
+		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(config->cs);
 
 	if (spi_imx->usedma)
 		ctrl |= MX51_ECSPI_CTRL_SMC;
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
