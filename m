From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/7] Improvements for SPI IMX driver for Freescale IMX51, IMX53 and IMX6
Date: Sun,  1 Nov 2015 15:41:34 +0100
Message-ID: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org,
	s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

A number of patches to impove or add the implementation
for the spi-imx driver related to Freescale IMX51, IMX53 and IMX6.
It would also possible some of patches can be applied for other
Freescale controllers using spi-imx driver but could not be tested
due to lack of hardware.

Changes since V2:
Removed patch V2 8/8 since it's not ready due to quality problems
Simlified patch 4/7 since V2 8/8 removed
Addressed all comments from reviewers and build bot failure

Anton Bondarenko (7):
  spi: imx: Fix DMA transfer
  spi: imx: replace fixed timeout with calculated one
  spi: imx: add support for all SPI word width for DMA transfer
  spi: imx: add function to check for IMX51 family controller
  spi: imx: Add support for loopback for ECSPI controllers
  spi: imx: return error from dma channel request
  spi: imx: defer spi initialization, if DMA engine is pending

 drivers/spi/spi-imx.c | 333 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 250 insertions(+), 83 deletions(-)

-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
