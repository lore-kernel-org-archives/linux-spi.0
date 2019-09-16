From: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 0/2] spi: cadence-qspi: Add cadence-qspi support for Intel LGM SoC
Date: Mon, 16 Sep 2019 15:38:41 +0800
Message-ID: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com,
        "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

patch 1: Add YAML for cadence-qspi devicetree cdocumentation.
patch 2: cadence-qspi controller driver to support QSPI-NAND flash
using existing spi-nand framework with legacy spi protocol.

Ramuthevar Vadivel Murugan (2):
  dt-bindings: spi: Add support for cadence-qspi IP Intel LGM SoC
  spi: cadence-qspi: Add QSPI support for Intel LGM SoC

 .../devicetree/bindings/spi/cadence,qspi-nand.yaml |  84 +++
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-cadence-qspi-apb.c                 | 644 +++++++++++++++++++++
 drivers/spi/spi-cadence-qspi-apb.h                 | 174 ++++++
 drivers/spi/spi-cadence-qspi.c                     | 461 +++++++++++++++
 drivers/spi/spi-cadence-qspi.h                     |  73 +++
 7 files changed, 1446 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml
 create mode 100644 drivers/spi/spi-cadence-qspi-apb.c
 create mode 100644 drivers/spi/spi-cadence-qspi-apb.h
 create mode 100644 drivers/spi/spi-cadence-qspi.c
 create mode 100644 drivers/spi/spi-cadence-qspi.h

-- 
2.11.0
