From: Anton Bondarenko <anton_bondarenko-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/8] Improvements for SPI IMX driver for Freescale IMX53 and IMX6 families
Date: Fri, 25 Sep 2015 19:57:07 +0200
Message-ID: <cover.1442923630.git.anton_bondarenko@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	<muzaffar_mahmood-aV4p89LCB337vf0t80Q1PNBPR1lH4CV8@public.gmane.org>,
	<vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

A number of patches to impove or add the implementation
for the spi-imx driver related to Freescale IMX53 and IMX6.
It would also possible some of patches can be applied for other
Freescale controllers using spi-imx driver but could not be tested
due to lack of hardware.

Anton Bondarenko (8):
  spi: imx: Fix DMA transfer
  spi: imx: replace fixed timeout with calculated one
  spi: imx: add support for all SPI word width for DMA transfer
  spi: imx: add selection for iMX53 and iMX6 controller type
  spi: imx: Add support for loopback for ECSPI controllers
  spi: imx: return error from dma channel request
  spi: imx: defer spi initialization, if DMA engine is pending
  spi: imx: Add support for SPI Slave mode for imx53 and imx6 chips

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   3 +
 drivers/spi/spi-imx.c                              | 486 ++++++++++++++++-----
 2 files changed, 388 insertions(+), 101 deletions(-)

-- 
2.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
