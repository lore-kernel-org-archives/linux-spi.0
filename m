From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 09/10] spi: sh-msiof: Convert to let spi core validate xfer->bits_per_word
Date: Thu, 20 Feb 2014 15:43:08 +0100
Message-ID: <1392907389-21798-10-git-send-email-geert@linux-m68k.org>
References: <1392907389-21798-1-git-send-email-geert@linux-m68k.org>
Cc: Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392907389-21798-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Set bits_per_word_mask so the spi core will reject transfers that attempt
to use an unsupported bits_per_word value.

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c |   19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 7add4be37987..bd300fcb7116 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -441,22 +441,6 @@ static u32 sh_msiof_spi_hz(struct spi_device *spi, struct spi_transfer *t)
 	return hz;
 }
 
-static int sh_msiof_spi_setup_transfer(struct spi_device *spi,
-				       struct spi_transfer *t)
-{
-	int bits;
-
-	/* noting to check hz values against since parent clock is disabled */
-
-	bits = sh_msiof_spi_bits(spi, t);
-	if (bits < 8)
-		return -EINVAL;
-	if (bits > 32)
-		return -EINVAL;
-
-	return spi_bitbang_setup_transfer(spi, t);
-}
-
 static int sh_msiof_spi_setup(struct spi_device *spi)
 {
 	struct device_node	*np = spi->master->dev.of_node;
@@ -822,10 +806,11 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	master->cleanup = spi_bitbang_cleanup;
 	master->prepare_message = sh_msiof_prepare_message;
 	master->unprepare_message = sh_msiof_unprepare_message;
+	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
 
 	p->bitbang.master = master;
 	p->bitbang.chipselect = sh_msiof_spi_chipselect;
-	p->bitbang.setup_transfer = sh_msiof_spi_setup_transfer;
+	p->bitbang.setup_transfer = spi_bitbang_setup_transfer;
 	p->bitbang.txrx_bufs = sh_msiof_spi_txrx;
 	p->bitbang.txrx_word[SPI_MODE_0] = sh_msiof_spi_txrx_word;
 	p->bitbang.txrx_word[SPI_MODE_1] = sh_msiof_spi_txrx_word;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
