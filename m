From: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: [PATCH] spi: dw: Fix dynamic speed change.
Date: Thu, 6 Nov 2014 13:50:39 -0600
Message-ID: <1415303439-31468-1-git-send-email-tthayer@opensource.altera.com>
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

An IOCTL call that calls spi_setup() and then dw_spi_setup() will
overwrite the persisted last transfer speed. On each transfer, the
SPI speed is compared to the last transfer speed to determine if the
clock divider registers need to be updated (did the speed change?).
This bug was observed with the spidev driver using spi-config to
update the max transfer speed.

This fix: Don't overwrite the persisted last transaction clock speed
when updating the SPI parameters in dw_spi_setup(). On the next
transaction, the new speed won't match the persisted last speed
and the hardware registers will be updated.
On initialization, the persisted last transaction clock
speed will be 0 but will be updated after the first SPI
transaction.

Move zeroed clock divider check into clock change test because
chip->clk_div is zero on startup and would cause a divide-by-zero
error. The calculation was wrong as well (can't support odd #).

Reported-by: Vlastimil Setka <setka-3PjVBYxTQDg@public.gmane.org>
Signed-off-by: Vlastimil Setka <setka-3PjVBYxTQDg@public.gmane.org>
Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
---
v2: Simplify fix so that last persistent SPI transfer speed is not
overwritten.
---
 drivers/spi/spi-dw.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 72e12ba..d0d5542 100644
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
@@ -419,7 +416,7 @@ static void pump_transfers(unsigned long data)
 	if (transfer->speed_hz) {
 		speed = chip->speed_hz;
 
-		if (transfer->speed_hz != speed) {
+		if ((transfer->speed_hz != speed) || (!chip->clk_div)) {
 			speed = transfer->speed_hz;
 
 			/* clk_div doesn't support odd number */
@@ -581,7 +578,6 @@ static int dw_spi_setup(struct spi_device *spi)
 		dev_err(&spi->dev, "No max speed HZ parameter\n");
 		return -EINVAL;
 	}
-	chip->speed_hz = spi->max_speed_hz;
 
 	chip->tmode = 0; /* Tx & Rx */
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
