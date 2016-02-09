From: stephanolbrich-Mmb7MZpHnFY@public.gmane.org
Subject: [PATCH 2/4] spi: bcm2835aux: disable tx fifo empty irq
Date: Tue,  9 Feb 2016 19:10:33 +0100
Message-ID: <1455041435-8015-3-git-send-email-stephanolbrich@gmx.de>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
Cc: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455041435-8015-1-git-send-email-stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>

The tx empty irq can be disabled when all data was copied.
This prevents unnecessary interrupts while the last bytes are sent.

Signed-off-by: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
---
 drivers/spi/spi-bcm2835aux.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index ecc73c0..d2f0067 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -212,6 +212,12 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 		ret = IRQ_HANDLED;
 	}
 
+	if (!bs->tx_len) {
+		/* disable tx fifo empty interrupt */
+		bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1] |
+			BCM2835_AUX_SPI_CNTL1_IDLE);
+	}
+
 	/* and if rx_len is 0 then wake up completion and disable spi */
 	if (!bs->rx_len) {
 		bcm2835aux_spi_reset_hw(bs);
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
