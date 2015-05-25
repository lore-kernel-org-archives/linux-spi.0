From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 4/4] spi: bcm2835: set SPI_MASTER_MUST_RX_SG/TX_SG flags
Date: Mon, 25 May 2015 12:44:26 +0000
Message-ID: <1432557867-2427-5-git-send-email-kernel@martin.sperl.org>
References: <2B971A09-33E3-42BC-B13D-49B6DD3D2E7A@martin.sperl.org>
 <1432557867-2427-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432557867-2427-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index bfcc436..e98db57 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -462,6 +462,8 @@ static void bcm2835_dma_init(struct spi_master *master, struct device *dev)
 	/* all went well, so set can_dma */
 	master->can_dma = bcm2835_spi_can_dma;
 	master->max_dma_len = 65535; /* limitation by BCM2835_SPI_DLEN */
+	/* need to do TX AND RX DMA, so we need scatter-gather lists */
+	master->flags = SPI_MASTER_MUST_RX_SG | SPI_MASTER_MUST_TX_SG;
 
 	return;
 
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
