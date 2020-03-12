From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/7] spi:dw: Add support for Intel Keem Bay SPI
Date: Thu, 12 Mar 2020 19:31:22 +0800
Message-ID: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patchset adds support for DesignWare DWC_ssi. This soft IP
is an AMBA version 2.0-compliant AHB slave device. Existing driver
already supports the older APB version.

Intel Keem Bay SPI controller is using this IP. This patchset is
tested on Keem Bay evaluation module board.

Wan Ahmad Zainie (7):
  spi: dw: Fix typo in few registers name
  spi: dw: Add update_cr0() callback to update CTRLR0
  dt-bindings: spi: dw-apb-ssi: Convert bindings to json-schema
  dt-bindings: spi: dw-apb-ssi: Add compatible string for DesignWare
    DWC_ssi
  spi: dw: Add support for DesignWare DWC_ssi
  dt-bindings: spi: dw-apb-ssi: Add Intel Keem Bay support
  spi: dw: Add support for Intel Keem Bay SPI

 .../bindings/spi/snps,dw-apb-ssi.txt          |  41 ------
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 106 +++++++++++++++
 drivers/spi/spi-dw-mid.c                      |   4 +
 drivers/spi/spi-dw-mmio.c                     |  57 +++++++-
 drivers/spi/spi-dw.c                          | 125 +++++++++++++-----
 drivers/spi/spi-dw.h                          |  25 +++-
 6 files changed, 277 insertions(+), 81 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

-- 
2.17.1
