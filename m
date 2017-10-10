From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: a3700: Return correct value on timeout detection" to the spi tree
Date: Tue, 10 Oct 2017 10:19:55 +0100
Message-ID: <E1e1qhf-0003dO-Kp@debutante>
References: <1507624998-31425-1-git-send-email-maxime.chevallier@smile.fr>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
        miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1507624998-31425-1-git-send-email-maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: a3700: Return correct value on timeout detection

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

>From 5a866ec0014b2baa4ecbb1eaa19c835482829d08 Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Date: Tue, 10 Oct 2017 10:43:17 +0200
Subject: [PATCH] spi: a3700: Return correct value on timeout detection

When waiting for transfer completion, a3700_spi_wait_completion
returns a boolean indicating if a timeout occurred.

The function was returning 'true' everytime, failing to detect any
timeout.

This patch makes it return 'false' when a timeout is reached.

Signed-off-by: Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/spi/spi-armada-3700.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 9172cb2d2e7a..568e1c65aa82 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -387,7 +387,8 @@ static bool a3700_spi_wait_completion(struct spi_device *spi)
 
 	spireg_write(a3700_spi, A3700_SPI_INT_MASK_REG, 0);
 
-	return true;
+	/* Timeout was reached */
+	return false;
 }
 
 static bool a3700_spi_transfer_wait(struct spi_device *spi,
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
