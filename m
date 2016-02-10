From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bcm2835aux: disable tx fifo empty irq" to the spi tree
Date: Wed, 10 Feb 2016 19:22:59 +0000
Message-ID: <E1aTaLr-0000lF-1D@debutante>
References: <1455041435-8015-3-git-send-email-stephanolbrich@gmx.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455041435-8015-3-git-send-email-stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bcm2835aux: disable tx fifo empty irq

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

>From f29ab1845f3e2684ba1c6de6c3bd5198e4b1459c Mon Sep 17 00:00:00 2001
From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Date: Tue, 9 Feb 2016 19:10:33 +0100
Subject: [PATCH] spi: bcm2835aux: disable tx fifo empty irq

The tx empty irq can be disabled when all data was copied.
This prevents unnecessary interrupts while the last bytes are sent.

Signed-off-by: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Reviewed-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm2835aux.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 7de6f8472a81..e1b2fec1db63 100644
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
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
