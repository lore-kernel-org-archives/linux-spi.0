From: stephanolbrich-Mmb7MZpHnFY@public.gmane.org
Subject: [PATCH 4/4] spi: bcm2835aux: fix CPOL/CPHA setting
Date: Tue,  9 Feb 2016 19:10:35 +0100
Message-ID: <1455041435-8015-5-git-send-email-stephanolbrich@gmx.de>
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

The auxiliary spi supports only CPHA=0 modes as the first bit is
always output to the pin before the first clock cycle. In CPHA=1
modes the first clock edge outputs the second bit hence the slave
can never read the first bit.

Also the CPHA registers switch between clocking data in/out on
rising/falling edge hence depend on the CPOL setting.

Signed-off-by: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
---
 drivers/spi/spi-bcm2835aux.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index b90aa34..169f521 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -386,12 +386,12 @@ static int bcm2835aux_spi_prepare_message(struct spi_master *master,
 	bs->cntl[1] = BCM2835_AUX_SPI_CNTL1_MSBF_IN;
 
 	/* handle all the modes */
-	if (spi->mode & SPI_CPOL)
+	if (spi->mode & SPI_CPOL) {
 		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPOL;
-	if (spi->mode & SPI_CPHA)
-		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_OUT |
-			       BCM2835_AUX_SPI_CNTL0_CPHA_IN;
-
+		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_OUT;
+	} else {
+		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_IN;
+	}
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
