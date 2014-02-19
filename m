From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [RFT][PATCH 2/2] spi: octeon: Convert to let spi core validate
 transfer speed
Date: Wed, 19 Feb 2014 17:34:47 +0800
Message-ID: <1392802487.7991.3.camel@phoenix>
References: <1392802252.7991.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392802252.7991.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Set master->max_speed_hz then spi core will handle checking transfer speed.
The behavior is different from current code when the speed_hz is greater than
the maximum transfer speed supported by the controller.
Unless there is other good reason, I think we had better make the behavior
consistent with what spi core does.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-octeon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
index b47245c..c5e2f71 100644
--- a/drivers/spi/spi-octeon.c
+++ b/drivers/spi/spi-octeon.c
@@ -66,8 +66,6 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 	cpol = mode & SPI_CPOL;
 
 	speed_hz = xfer->speed_hz ? : spi->max_speed_hz;
-	if (speed_hz > OCTEON_SPI_MAX_CLOCK_HZ)
-		speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
 
 	clkdiv = octeon_get_io_clock_rate() / (2 * speed_hz);
 
@@ -211,6 +209,7 @@ static int octeon_spi_probe(struct platform_device *pdev)
 
 	master->transfer_one_message = octeon_spi_transfer_one_message;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->max_speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
 
 	master->dev.of_node = pdev->dev.of_node;
 	err = devm_spi_register_master(&pdev->dev, master);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
