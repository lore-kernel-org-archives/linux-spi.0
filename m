From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: omap2-mcspi: poll OMAP2_MCSPI_CHSTAT_RXS for PIO transfer" to the spi tree
Date: Fri, 24 Mar 2017 19:16:59 +0000
Message-ID: <E1crUhn-0006G9-ND@debutante>
References: <1490141906-8908-1-git-send-email-akinobu.mita@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490141906-8908-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: omap2-mcspi: poll OMAP2_MCSPI_CHSTAT_RXS for PIO transfer

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

>From 812613591cb652344186c4cd912304ed02138566 Mon Sep 17 00:00:00 2001
From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 22 Mar 2017 09:18:26 +0900
Subject: [PATCH] spi: omap2-mcspi: poll OMAP2_MCSPI_CHSTAT_RXS for PIO
 transfer

When running the spi-loopback-test with slower clock rate like 10 KHz,
the test for 251 bytes transfer was failed.  This failure triggered an
spi-omap2-mcspi's error message "DMA RX last word empty".

This message means that PIO for reading the remaining bytes due to the
DMA transfer length reduction is failed.  This problem can be fixed by
polling OMAP2_MCSPI_CHSTAT_RXS bit in channel status register to wait
until the receive buffer register is filled.

Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 79800e991ccd..7275223dbcd4 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -454,6 +454,8 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	int			elements = 0;
 	int			word_len, element_count;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
+	void __iomem		*chstat_reg = cs->base + OMAP2_MCSPI_CHSTAT0;
+
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 	count = xfer->len;
@@ -549,8 +551,8 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	if (l & OMAP2_MCSPI_CHCONF_TURBO) {
 		elements--;
 
-		if (likely(mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHSTAT0)
-				   & OMAP2_MCSPI_CHSTAT_RXS)) {
+		if (!mcspi_wait_for_reg_bit(chstat_reg,
+					    OMAP2_MCSPI_CHSTAT_RXS)) {
 			u32 w;
 
 			w = mcspi_read_cs_reg(spi, OMAP2_MCSPI_RX0);
@@ -568,8 +570,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 			return count;
 		}
 	}
-	if (likely(mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHSTAT0)
-				& OMAP2_MCSPI_CHSTAT_RXS)) {
+	if (!mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_RXS)) {
 		u32 w;
 
 		w = mcspi_read_cs_reg(spi, OMAP2_MCSPI_RX0);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
