From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 0/8]  Improvements for SPI IMX driver for Freescale ECSPI controller, continuation
Date: Tue,  8 Dec 2015 07:43:42 +0100
Message-ID: <1449557030-27525-1-git-send-email-anton.bondarenko.sama@gmail.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This series is to complement commits already applied to topic/imx branch

Changes since V5:
 * Fix for commit "spi: imx: Add loopback mode support"
 * Addressed some comments from Sascha Hauer for DMA initialization error report
 * Fixed 32 bytes transaction. It will be DMA now.

Anton Bondarenko (8):
  spi: imx: fix loopback mode setup after controller reset
  spi: imx: enable loopback only for ECSPI controller family
  spi: imx: return error from dma channel request
  spi: imx: defer spi initialization, if DMA engine is
  spi: imx: allow only WML aligned transfers to use DMA
  spi: imx: remove dead RX DMA tail handling code
  spi: imx: replace fixed timeout with calculated
  spi: imx: add support for all SPI word width for DMA

 drivers/spi/spi-imx.c | 203 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 145 insertions(+), 58 deletions(-)

-- 
2.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
