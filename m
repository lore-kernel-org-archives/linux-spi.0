From: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 1/3] spi: bitbang: fix shift for getmosi
Date: Wed, 12 Mar 2014 16:20:34 +0100
Message-ID: <1394637636-29042-2-git-send-email-m.grzeschik@pengutronix.de>
References: <1394637636-29042-1-git-send-email-m.grzeschik@pengutronix.de>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394637636-29042-1-git-send-email-m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The driver needs to shift the word bit after reading the mosi bit.
Otherwise the return word will have an Off-by-one bit value.

Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi-bitbang-txrx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
index c616e41..b6e348d 100644
--- a/drivers/spi/spi-bitbang-txrx.h
+++ b/drivers/spi/spi-bitbang-txrx.h
@@ -61,10 +61,10 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 		spidelay(nsecs);
 
 		/* sample MSB (from slave) on leading edge */
-		word <<= 1;
 		if ((flags & SPI_MASTER_NO_RX) == 0)
 			word |= getmiso(spi);
 		setsck(spi, cpol);
+		word <<= 1;
 	}
 	return word;
 }
@@ -89,9 +89,9 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 		spidelay(nsecs);
 
 		/* sample MSB (from slave) on trailing edge */
-		word <<= 1;
 		if ((flags & SPI_MASTER_NO_RX) == 0)
 			word |= getmiso(spi);
+		word <<= 1;
 	}
 	return word;
 }
-- 
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
