From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 0/7] NXP DSPI bugfixes and support for LS1028A
Date: Tue, 10 Mar 2020 14:55:35 +0200
Message-ID: <20200310125542.5939-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This series addresses a few issues that were missed during the previous
series "[PATCH 00/12] TCFQ to XSPI migration for NXP DSPI driver", on
SoCs other than LS1021A and LS1043A. DMA mode has been completely broken
by that series, and XSPI mode never worked on little-endian controllers.

Then it introduces support for the LS1028A chip, whose compatible has
recently been documented here:

https://lore.kernel.org/linux-devicetree/20200218171418.18297-1-michael@walle.cc/

The device tree for the LS1028A SoC is extended with DMA channels
definition, such that even though the default operating mode is XSPI,
one can simply change DSPI_XSPI_MODE to DSPI_DMA_MODE in the
devtype_data structure of the driver and use that instead.

I don't expect the "fixes" patches to reach very far down the stable
pipe, since there has been pretty heavy refactoring in this driver.

For testing, benchmarking and debugging, the mikroBUS connector on the
LS1028A-RDB is made available via spidev.

Vladimir Oltean (7):
  spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
  spi: spi-fsl-dspi: Avoid use-after-free in interrupt mode
  spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
  spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
  spi: spi-fsl-dspi: Add support for LS1028A
  arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
  arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS

 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    |  14 ++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +
 drivers/spi/spi-fsl-dspi.c                    | 188 +++++++++++-------
 3 files changed, 134 insertions(+), 74 deletions(-)

-- 
2.17.1
