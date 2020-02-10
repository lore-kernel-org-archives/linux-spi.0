From: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 0/2] spi: add driver for ar934x spi controller
Date: Mon, 10 Feb 2020 11:41:50 +0800
Message-ID: <20200210034152.49063-1-gch981213@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This controller is a superset of the already supported qca,ar7100-spi.
Besides the bit-bang mode in spi-ath79.c, this new controller added
a new "shift register" mode, allowing faster spi operations.
This mode doesn't need all the bit-bang code in spi-ath79.c and needs
a different clock setup, so I decided to write a new driver for it
instead of extending current spi-ath79 driver.

Changes since v3:
1. restore pin state in probe to terminate unfinished SPI transfer
   done by bootloader.
2. replace clock binding with ath79 pll as this is the actual
   clock binding used in all SoC supported by this driver.

Change since v2:
fix binding documentation check.

Changes since v1:
1. change comment at the beginning to C++ style
2. rename ar934x_spi_transfer_one to ar934x_spi_transfer_one_message

Chuanhong Guo (2):
  spi: add driver for ar934x spi controller
  dt-binding: spi: add bindings for spi-ar934x

 .../bindings/spi/qca,ar934x-spi.yaml          |  41 +++
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-ar934x.c                      | 235 ++++++++++++++++++
 4 files changed, 284 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
 create mode 100644 drivers/spi/spi-ar934x.c

-- 
2.24.1
