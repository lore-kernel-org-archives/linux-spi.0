From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: round up result of calculation for clock divider" to the spi tree
Date: Mon, 12 Sep 2016 20:08:03 +0100
Message-ID: <E1bjWaJ-0002pJ-SL@debutante>
References: <20160906191652.01a11698@vm>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Seidel <kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160906191652.01a11698@vm>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: round up result of calculation for clock divider

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

>From 3aef463222eaf1ca505629e93a0b64e4040a4472 Mon Sep 17 00:00:00 2001
From: Matthias Seidel <kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org>
Date: Wed, 7 Sep 2016 17:45:30 +0200
Subject: [PATCH] spi: dw: round up result of calculation for clock divider

Avoid ending up with a higher frequency than requested

Signed-off-by: Matthias Seidel <kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index c85e4b327a4a..27960e46135d 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -300,7 +300,7 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	if (transfer->speed_hz != dws->current_freq) {
 		if (transfer->speed_hz != chip->speed_hz) {
 			/* clk_div doesn't support odd number */
-			chip->clk_div = (dws->max_freq / transfer->speed_hz + 1) & 0xfffe;
+			chip->clk_div = (DIV_ROUND_UP(dws->max_freq, transfer->speed_hz) + 1) & 0xfffe;
 			chip->speed_hz = transfer->speed_hz;
 		}
 		dws->current_freq = transfer->speed_hz;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
