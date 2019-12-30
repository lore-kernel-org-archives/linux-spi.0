From: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v6 0/2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller
Date: Mon, 30 Dec 2019 15:41:00 +0800
Message-ID: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Cc: robh+dt@kernel.org, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To: broonie@kernel.org, vigneshr@ti.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for the Cadence QSPI controller. This controller is
present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
This driver has been tested on the Intel LGM SoCs.

This driver does not support generic SPI and also the implementation
only supports spi-mem interface to replace the existing driver in
mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
flash memory.

Thank you Vignesh for the valuable review comments and guidance,
sorry for the delay since waitting for the merge window to rebase
and send it now by one-shot.

changes from v5:
 -- kbuild test robot warnings fixed
 -- Add Reported-By: Dan Carpenter <dan.carpenter@oracle.com>

changes from v4:
 -- kbuild test robot warnings fixed
 -- Add Reborted-by: tag

changes from v3:
spi-cadence-quadspi.c
 -- static to all functions wrt to local to the file.
 -- Prefix cqspi_ and make the function static
 -- cmd_ops, data_ops and dummy_ops dropped
 -- addr_ops kept since it is required for address calculation.
 -- devm_ used for supported functions , removed legacy API's
 -- removed "indirect" name from functions
 -- replaced by master->mode_bits = SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL | SPI_RX_OCTAL;
    as per Vignesh susggestion
 -- removed free functions since devm_ handles automatically.
 -- dropped all unused Macros

YAML file update:
 -- cadence,qspi.yaml file name replace by cdns,qspi-nor.yaml
 -- compatible string updated as per Vignesh suggestion
 -- for single entry, removed descriptions
 -- removed optional parameters
  Build Result:
   linux$ make DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml dt_binding_check
    CHKDT   Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
    SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
    DTC     Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dt.yaml
    CHECK   Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dt.yaml



Ramuthevar Vadivel Murugan (2):
  dt-bindings: spi: Add schema for Cadence QSPI Controller driver
  spi: cadence-quadpsi: Add support for the Cadence QSPI controller

 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |  147 +++
 drivers/spi/Kconfig                                |    8 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-cadence-quadspi.c                  | 1175 ++++++++++++++++++++
 drivers/spi/spi-cadence-quadspi.h                  |  245 ++++
 5 files changed, 1576 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
 create mode 100644 drivers/spi/spi-cadence-quadspi.c
 create mode 100644 drivers/spi/spi-cadence-quadspi.h


base-commit: c52db0e2f5ec0e5e196fe0045621dcb0141bf90f
-- 
2.11.0
