From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: rspi: Drop variable "error" in qspi_trigger_transfer_out_in()" to the spi tree
Date: Fri, 03 Jul 2015 15:10:58 +0100
Message-ID: <E1ZB1gA-00028A-8h@finisterre>
References: <1435064669-11969-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435064669-11969-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: rspi: Drop variable "error" in qspi_trigger_transfer_out_in()

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

>From 5d4db691ed978080435f4e5aad2ce707294a75b4 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Date: Tue, 23 Jun 2015 15:04:28 +0200
Subject: [PATCH] spi: rspi: Drop variable "error" in
 qspi_trigger_transfer_out_in()

Just use "ret" instead, for consistency with other similar functions.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index f9189a0..9a71fa2 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -725,24 +725,23 @@ static int qspi_trigger_transfer_out_in(struct rspi_data *rspi, const u8 *tx,
 					u8 *rx, unsigned int len)
 {
 	int i, n, ret;
-	int error;
 
 	while (len > 0) {
 		n = qspi_set_send_trigger(rspi, len);
 		qspi_set_receive_trigger(rspi, len);
 		if (n == QSPI_BUFFER_SIZE) {
-			error = rspi_wait_for_tx_empty(rspi);
-			if (error < 0) {
+			ret = rspi_wait_for_tx_empty(rspi);
+			if (ret < 0) {
 				dev_err(&rspi->master->dev, "transmit timeout\n");
-				return error;
+				return ret;
 			}
 			for (i = 0; i < n; i++)
 				rspi_write_data(rspi, *tx++);
 
-			error = rspi_wait_for_rx_full(rspi);
-			if (error < 0) {
+			ret = rspi_wait_for_rx_full(rspi);
+			if (ret < 0) {
 				dev_err(&rspi->master->dev, "receive timeout\n");
-				return error;
+				return ret;
 			}
 			for (i = 0; i < n; i++)
 				*rx++ = rspi_read_data(rspi);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
