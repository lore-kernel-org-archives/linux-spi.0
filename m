From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: rename 'bpw' variables" to the spi tree
Date: Tue, 06 Jun 2017 20:07:18 +0100
Message-ID: <E1dIJp0-0007ap-LH@debutante>
References: <20170602053804.3238-7-s.hauer@pengutronix.de>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170602053804.3238-7-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: rename 'bpw' variables

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

>From 2e312f6cdb02a2707870172473b9dee34f620b93 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date: Fri, 2 Jun 2017 07:38:04 +0200
Subject: [PATCH] spi: imx: rename 'bpw' variables

'bpw' is ambiguous and only the context makes sure if bytes_per_word
or bits_per_word is meant. Use the full names instead to make reading
the code easier.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 12e5ef7beb0b..e544f45348cc 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -200,27 +200,27 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
 	return i;
 }
 
-static int spi_imx_bytes_per_word(const int bpw)
+static int spi_imx_bytes_per_word(const int bits_per_word)
 {
-	return DIV_ROUND_UP(bpw, BITS_PER_BYTE);
+	return DIV_ROUND_UP(bits_per_word, BITS_PER_BYTE);
 }
 
 static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 			 struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
-	unsigned int bpw, i;
+	unsigned int bytes_per_word, i;
 
 	if (!master->dma_rx)
 		return false;
 
-	bpw = spi_imx_bytes_per_word(transfer->bits_per_word);
+	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
 
-	if (bpw != 1 && bpw != 2 && bpw != 4)
+	if (bytes_per_word != 1 && bytes_per_word != 2 && bytes_per_word != 4)
 		return false;
 
 	for (i = spi_imx_get_fifosize(spi_imx) / 2; i > 0; i--) {
-		if (!(transfer->len % (i * bpw)))
+		if (!(transfer->len % (i * bytes_per_word)))
 			break;
 	}
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
