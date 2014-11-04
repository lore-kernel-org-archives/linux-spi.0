From: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: [PATCH] spi: dw: Fix dynamic speed change
Date: Tue, 4 Nov 2014 16:36:56 -0600
Message-ID: <1415140617-2028-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	<setka-3PjVBYxTQDg@public.gmane.org>, <tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>,
	<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>

Changing SPI transfer speed using a utility such as spi_config with
spidev updates chip->speed_hz which is compared to the next transfer
speed.

When speed_hz is not declared in a SPI transfer, the transfer speed is
not updated for the next read/write on /dev/spidevX.Y. The element
spi_transfer->speed_hz is filled with spi->max_speed_hz. The test of
if (transfer->speed_hz != speed) doesn't work because the chip->speed_hz
matches transfer->speed_hz and the clock divider is not updated.

This fix: On each transfer update the clock divider, compare to the
previous clock divider and update if necessary. This fixes another
bug where the clock divider calculation at the top of the
pump_transfers() function could be an odd-number.

Reported-by: Vlastimil Setka <setka-3PjVBYxTQDg@public.gmane.org>
Signed-off-by: Vlastimil Setka <setka-3PjVBYxTQDg@public.gmane.org>
Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
---
 drivers/spi/spi-dw.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 72e12ba..3456b34 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -376,9 +376,6 @@ static void pump_transfers(unsigned long data)
 	chip = dws->cur_chip;
 	spi = message->spi;
 
-	if (unlikely(!chip->clk_div))
-		chip->clk_div = dws->max_freq / chip->speed_hz;
-
 	if (message->state == ERROR_STATE) {
 		message->status = -EIO;
 		goto early_exit;
@@ -415,21 +412,27 @@ static void pump_transfers(unsigned long data)
 
 	cr0 = chip->cr0;
 
-	/* Handle per transfer options for bpw and speed */
-	if (transfer->speed_hz) {
-		speed = chip->speed_hz;
+	/* Always calculate the desired clock divider */
+	speed = transfer->speed_hz ? transfer->speed_hz : chip->speed_hz;
+
+	if (speed > dws->max_freq) {
+		dev_err(&spi->dev, "Unsupported SPI freq: %d Hz\n", speed);
+		message->status = -EIO;
+		goto early_exit;
+	}
+
+	/* clk_div doesn't support odd number */
+	clk_div = dws->max_freq / speed;
+	clk_div = (clk_div + 1) & 0xfffe;
 
-		if (transfer->speed_hz != speed) {
-			speed = transfer->speed_hz;
+	/* Determine if the clock divider changed, if so update chip struct */
+	if (clk_div != chip->clk_div)
+		chip->clk_div = clk_div;
+	else
+		clk_div = 0; /* Prevent register programming below */
 
-			/* clk_div doesn't support odd number */
-			clk_div = dws->max_freq / speed;
-			clk_div = (clk_div + 1) & 0xfffe;
+	chip->speed_hz = speed;
 
-			chip->speed_hz = speed;
-			chip->clk_div = clk_div;
-		}
-	}
 	if (transfer->bits_per_word) {
 		bits = transfer->bits_per_word;
 		dws->n_bytes = dws->dma_width = bits >> 3;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
