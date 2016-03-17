From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: Fix possible NULL pointer deref" to the spi tree
Date: Thu, 17 Mar 2016 11:45:29 +0000
Message-ID: <E1agWMr-0001zX-JM@debutante>
References: <1458202910-7565-1-git-send-email-s.hauer@pengutronix.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458202910-7565-1-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: Fix possible NULL pointer deref

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

>From cd8dd41a33264a4602539711f76670c2a1f4d007 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date: Thu, 17 Mar 2016 09:21:50 +0100
Subject: [PATCH] spi: imx: Fix possible NULL pointer deref

transfer could be NULL in spi_imx_can_dma() when it's called from
spi_imx_setupxfer() with a NULL transfer. Test for a NULL pointer before
dereferencing it.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b79d70d6dabf..50769078e72e 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -211,11 +211,15 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 			 struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
-	unsigned int bpw = transfer->bits_per_word;
+	unsigned int bpw;
 
 	if (!master->dma_rx)
 		return false;
 
+	if (!transfer)
+		return false;
+
+	bpw = transfer->bits_per_word;
 	if (!bpw)
 		bpw = spi->bits_per_word;
 
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
