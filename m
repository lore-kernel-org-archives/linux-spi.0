From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 00/10] spi: fsl-espi: make fsl-espi independent of fsl-lib
Date: Sun, 13 Nov 2016 14:35:38 +0100
Message-ID: <2acfcfba-9ca6-6edb-1144-67b986154880@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

ESPI shares very little with other FSL SPI controllers. Sharing code
in fsl-lib therefore provides not really a benefit.
This patch series removes the dependency on fsl-lib thus improving
maintainability of the fsl-espi driver.

Heiner Kallweit (10):
  spi: fsl-espi: remove usage of pdata->initial_spmode
  spi: fsl-espi: don't set pdata->cs_control
  spi: fsl-espi: remove remaining usage of struct fsl_spi_platform_data
  spi: fsl-espi: remove usage of mpc8xxx_spi->irq
  spi: fsl-espi: remove usage of mpc8xxx_spi->flags
  spi: fsl-espi: migrate relevant parts of mpc8xxx_spi_probe and of_mpc8xxx_spi_probe
  spi: fsl-espi: introduce struct fsl_espi_cs
  spi: fsl-espi: factor out fsl_espi_init_regs
  spi: fsl-espi: introduce struct fsl_espi
  spi: fsl-espi: separate fsl-espi from fsl-lib completely

 drivers/spi/Kconfig        |   1 -
 drivers/spi/spi-fsl-espi.c | 415 +++++++++++++++++++++++----------------------
 drivers/spi/spi-fsl-lib.h  |   7 -
 3 files changed, 211 insertions(+), 212 deletions(-)

-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
