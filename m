From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: atmel: Fix DMA-setup for transfers with more than 8 bits per word" to the spi tree
Date: Fri, 23 Oct 2015 08:10:56 +0900
Message-ID: <E1ZpP0a-0000L6-Ql@finisterre>
References: <1445288084-31805-1-git-send-email-davidm@egauge.net>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445288084-31805-1-git-send-email-davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: atmel: Fix DMA-setup for transfers with more than 8 bits per word

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

>From 06515f83908d038d9e12ffa3dcca27a1b67f2de0 Mon Sep 17 00:00:00 2001
From: David Mosberger-Tang <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>
Date: Tue, 20 Oct 2015 14:26:47 +0200
Subject: [PATCH] spi: atmel: Fix DMA-setup for transfers with more than 8 bits
 per word

The DMA-slave configuration depends on the whether <= 8 or > 8 bits
are transferred per word, so we need to call
atmel_spi_dma_slave_config() with the correct value.

Signed-off-by: David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>
Signed-off-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/spi/spi-atmel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index bf9ed38..41d95a6 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -773,7 +773,8 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 
 	*plen = len;
 
-	if (atmel_spi_dma_slave_config(as, &slave_config, 8))
+	if (atmel_spi_dma_slave_config(as, &slave_config,
+				       xfer->bits_per_word))
 		goto err_exit;
 
 	/* Send both scatterlists */
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
