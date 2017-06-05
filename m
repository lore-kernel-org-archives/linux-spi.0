From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH linux-next v3 0/4] i.MX ECSPI controller slave mode support
Date: Mon, 5 Jun 2017 12:38:05 +0900
Message-ID: <20170605033809.13726-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Changes in v3:
* renamed several variables for for better readability
* created spi_imx_pio_transfer_slave() for slave pio transfer
* added fifo_size, has_dmamode and has_slavemode in spi_imx_devtype_data

Changes in v2:
* re-workd i.MX ECSPI controller slave mode support based on Geert's work

Jiada Wang (4):
  spi: imx: introduce fifo_size and has_dmamode in spi_imx_devtype_data
  spi: imx: add selection for iMX53 and iMX6 controller
  ARM: dts: imx: change compatiblity for SPI controllers on imx53 later
    soc
  spi: imx: Add support for SPI Slave mode

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   1 +
 arch/arm/boot/dts/imx53.dtsi                       |   4 +-
 arch/arm/boot/dts/imx6q.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   8 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   8 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   8 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   8 +-
 drivers/spi/spi-imx.c                              | 275 ++++++++++++++++++---
 8 files changed, 257 insertions(+), 57 deletions(-)

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
