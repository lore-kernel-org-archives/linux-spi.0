From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: Eliminate 3WIRE spi_transfer check
Date: Thu, 26 Dec 2013 21:51:06 -0800
Message-ID: <1388123466-7525-1-git-send-email-tpiepho@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Checking for SPI_3WIRE isn't needed.  spi_setup() already prevents 3WIRE
mode from being combined with DUAL or QUAD mode support.  So there is no
need to differentiate between a single bit device with SPI_3WIRE set and
one with without.  It doesn't change the allowed bit widths.

Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Extracted from "spi: Simplify bit width checking code" as there seemed
to be no debate about this part.

 drivers/spi/spi.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 98f4b77..302ffac 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1678,9 +1678,6 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 			if ((xfer->tx_nbits == SPI_NBITS_QUAD) &&
 				!(spi->mode & SPI_TX_QUAD))
 				return -EINVAL;
-			if ((spi->mode & SPI_3WIRE) &&
-				(xfer->tx_nbits != SPI_NBITS_SINGLE))
-				return -EINVAL;
 		}
 		/* check transfer rx_nbits */
 		if (xfer->rx_buf) {
@@ -1694,9 +1691,6 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 			if ((xfer->rx_nbits == SPI_NBITS_QUAD) &&
 				!(spi->mode & SPI_RX_QUAD))
 				return -EINVAL;
-			if ((spi->mode & SPI_3WIRE) &&
-				(xfer->rx_nbits != SPI_NBITS_SINGLE))
-				return -EINVAL;
 		}
 	}
 
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
