From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] SPI: BCM2835: enable support of 3-wire mode
Date: Thu, 19 Mar 2015 09:01:53 +0000
Message-ID: <1426755714-28130-4-git-send-email-kernel@martin.sperl.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, warren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426755714-28130-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index e1dea40..51883f8 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -67,7 +67,8 @@
 #define BCM2835_SPI_CS_CS_01		0x00000001
 
 #define BCM2835_SPI_TIMEOUT_MS	30000
-#define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS)
+#define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
+				| SPI_NO_CS | SPI_3WIRE)
 
 #define DRV_NAME	"spi-bcm2835"
 
@@ -201,6 +202,9 @@ static int bcm2835_spi_start_transfer(
 		cdiv = 0; /* 0 is the slowest we can go */
 	}
 
+	if ((spi->mode & SPI_3WIRE) && (tfr->rx_buf))
+		cs |= BCM2835_SPI_CS_REN;
+
 	if (spi->mode & SPI_CPOL)
 		cs |= BCM2835_SPI_CS_CPOL;
 	if (spi->mode & SPI_CPHA)
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
