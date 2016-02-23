From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v3] i.MX SPI DMA cleanup
Date: Tue, 23 Feb 2016 10:23:49 +0100
Message-ID: <1456219438-21205-1-git-send-email-s.hauer@pengutronix.de>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

(hopefully) final round...

Changes since v2:

- Drop patches already applied
- rebase on next

Changes since v1:

- Add missing Signed-off-by to Patch 3
- Drop device tree change as it's already applied by Shawn
- Add patch subject when referring to commits

----------------------------------------------------------------
Anton Bondarenko (1):
      spi: imx: add support for all SPI word width for DMA

Sascha Hauer (8):
      spi: imx: drop fallback to PIO
      spi: imx: initialize usedma earlier
      spi: imx: drop unnecessary read/modify/write
      spi: imx: drop unncessary dma_is_inited variable
      spi: imx: remove unnecessary bit clearing in mx51_ecspi_config
      spi: imx: make some register defines simpler
      spi: imx: set MX51_ECSPI_CTRL_SMC bit in setup function
      spi: imx: drop bogus tests for rx/tx bufs in DMA transfer

 drivers/spi/spi-imx.c | 296 ++++++++++++++++++++++++++------------------------
 1 file changed, 153 insertions(+), 143 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
