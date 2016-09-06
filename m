From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: fix multiple slaves with different baudrates" to the spi tree
Date: Tue, 06 Sep 2016 12:29:57 +0100
Message-ID: <E1bhEZh-00048t-7z@finisterre>
References: <20160904020449.217e13f4@vm>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Seidel <kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160904020449.217e13f4@vm>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: fix multiple slaves with different baudrates

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

>From 13b10301b858e355613bfc6dc297580bf34d3fb5 Mon Sep 17 00:00:00 2001
From: Matthias Seidel <kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org>
Date: Sun, 4 Sep 2016 02:04:49 +0200
Subject: [PATCH] spi: dw: fix multiple slaves with different baudrates

Add current master clock to dws struct and compare it against the
requestedtransfer speed. Update clock divider only if necessary.

Signed-off-by: Matthias Seidel <kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw.c | 15 +++++++--------
 drivers/spi/spi-dw.h |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index c09bb745693a..c85e4b327a4a 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -283,7 +283,6 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	struct chip_data *chip = spi_get_ctldata(spi);
 	u8 imask = 0;
 	u16 txlevel = 0;
-	u16 clk_div;
 	u32 cr0;
 	int ret;
 
@@ -298,13 +297,13 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	spi_enable_chip(dws, 0);
 
 	/* Handle per transfer options for bpw and speed */
-	if (transfer->speed_hz != chip->speed_hz) {
-		/* clk_div doesn't support odd number */
-		clk_div = (dws->max_freq / transfer->speed_hz + 1) & 0xfffe;
-
-		chip->speed_hz = transfer->speed_hz;
-		chip->clk_div = clk_div;
-
+	if (transfer->speed_hz != dws->current_freq) {
+		if (transfer->speed_hz != chip->speed_hz) {
+			/* clk_div doesn't support odd number */
+			chip->clk_div = (dws->max_freq / transfer->speed_hz + 1) & 0xfffe;
+			chip->speed_hz = transfer->speed_hz;
+		}
+		dws->current_freq = transfer->speed_hz;
 		spi_set_clk(dws, chip->clk_div);
 	}
 	if (transfer->bits_per_word == 8) {
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 61bc3cbab38d..c21ca02f8ec5 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -123,6 +123,7 @@ struct dw_spi {
 	u8			n_bytes;	/* current is a 1/2 bytes op */
 	u32			dma_width;
 	irqreturn_t		(*transfer_handler)(struct dw_spi *dws);
+	u32			current_freq;	/* frequency in hz */
 
 	/* DMA info */
 	int			dma_inited;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
