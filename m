From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: sun4i: Prevent chip-select from being activated twice before a transfer" to the spi tree
Date: Fri, 08 Jan 2016 13:44:58 +0000
Message-ID: <E1aHXLe-0003OU-C9@debutante>
References: <1452026780-8819-1-git-send-email-mweseloh42@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452026780-8819-1-git-send-email-mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: sun4i: Prevent chip-select from being activated twice before a transfer

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

>From 218e0b575ffe6de1c93249871b25bbf570fe1cb5 Mon Sep 17 00:00:00 2001
From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 5 Jan 2016 21:46:20 +0100
Subject: [PATCH] spi: sun4i: Prevent chip-select from being activated twice
 before a transfer

The SPI core calls set_cs before a transfer, but the SUN4I_CTL_CS_MANUAL
flag is only set in transfer_one. This leads to the following pattern on
the chip-select line (with runtime power-management on every transfer,
without it only on the first one):

activate, deactivate, activate, transfer, deactivate

Moving the configuration of the SUN4I_CTL_CS_MANUAL flag from transfer_one
to set_cs removes the double activation.

Signed-off-by: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-sun4i.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index fbb0a4d74e91..a6d936c68674 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -140,6 +140,9 @@ static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
 	reg &= ~SUN4I_CTL_CS_MASK;
 	reg |= SUN4I_CTL_CS(spi->chip_select);
 
+	/* We want to control the chip select manually */
+	reg |= SUN4I_CTL_CS_MANUAL;
+
 	if (enable)
 		reg |= SUN4I_CTL_CS_LEVEL;
 	else
@@ -222,9 +225,6 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	else
 		reg |= SUN4I_CTL_DHB;
 
-	/* We want to control the chip select manually */
-	reg |= SUN4I_CTL_CS_MANUAL;
-
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
 
 	/* Ensure that we have a parent clock fast enough */
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
