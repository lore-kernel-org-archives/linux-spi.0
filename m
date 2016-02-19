From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2] i.MX SPI DMA cleanup
Date: Fri, 19 Feb 2016 08:43:00 +0100
Message-ID: <1455867792-26389-1-git-send-email-s.hauer@pengutronix.de>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Second round for the i.MX SPI DMA patches. No changes to code, only
updated commit messages.

Mark, you already applied patch 1/12 and 2/12. I'm resending them here
anyway because I updated the commit message as you requested. Feel free
to ignore 1/12 and 2/12 or replace them with this updated version.

Changes since v1:

- Add missing Signed-off-by to Patch 3
- Drop device tree change as it's already applied by Shawn
- Add patch subject when referring to commits

----------------------------------------------------------------
Anton Bondarenko (3):
      spi: imx: allow only WML aligned transfers to use DMA
      spi: imx: replace fixed timeout with calculated
      spi: imx: add support for all SPI word width for DMA

Sascha Hauer (9):
      spi: imx: use proper dev_* functions for driver messages
      spi: imx: drop fallback to PIO
      spi: imx: initialize usedma earlier
      spi: imx: drop unnecessary read/modify/write
      spi: imx: drop unncessary dma_is_inited variable
      spi: imx: remove unnecessary bit clearing in mx51_ecspi_config
      spi: imx: make some register defines simpler
      spi: imx: set MX51_ECSPI_CTRL_SMC bit in setup function
      spi: imx: drop bogus tests for rx/tx bufs in DMA transfer

 drivers/spi/spi-imx.c | 350 ++++++++++++++++++++++++++------------------------
 1 file changed, 181 insertions(+), 169 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
