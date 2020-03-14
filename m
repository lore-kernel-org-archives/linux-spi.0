From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 00/12] NXP DSPI bugfixes and support for LS1028A
Date: Sun, 15 Mar 2020 00:43:28 +0200
Message-ID: <20200314224340.1544-1-olteanv@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, michael-QKn5cuLxLXY@public.gmane.org, peng.ma-3arQi8VN3Tc@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>

This series addresses a few issues that were missed during the previous
series "[PATCH 00/12] TCFQ to XSPI migration for NXP DSPI driver", on
SoCs other than LS1021A and LS1043A. DMA mode has been completely broken
by that series, and XSPI mode never worked on little-endian controllers.

Then it introduces support for the LS1028A chip, whose compatible has
recently been documented here:

https://lore.kernel.org/linux-devicetree/20200218171418.18297-1-michael-QKn5cuLxLXY@public.gmane.org/

The device tree for the LS1028A SoC is extended with DMA channels
definition, such that even though the default operating mode is XSPI,
one can simply change DSPI_XSPI_MODE to DSPI_DMA_MODE in the
devtype_data structure of the driver and use that instead.

I don't expect the "fixes" patches to reach very far down the stable
pipe, since there has been pretty heavy refactoring in this driver.

For testing, benchmarking and debugging, the mikroBUS connector on the
LS1028A-RDB is made available via spidev.

Vladimir Oltean (12):
  spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
  spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
  spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
  spi: spi-fsl-dspi: Avoid reading more data than written in EOQ mode
  spi: spi-fsl-dspi: Protect against races on dspi->words_in_flight
  spi: spi-fsl-dspi: Replace interruptible wait queue with a simple
    completion
  spi: spi-fsl-dspi: Avoid NULL pointer in dspi_slave_abort for non-DMA
    mode
  spi: spi-fsl-dspi: Fix interrupt-less DMA mode taking an XSPI code
    path
  spi: spi-fsl-dspi: Move invariant configs out of
    dspi_transfer_one_message
  spi: spi-fsl-dspi: Add support for LS1028A
  arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
  arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS

 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    |  14 ++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +
 drivers/spi/spi-fsl-dspi.c                    | 227 +++++++++---------
 3 files changed, 138 insertions(+), 109 deletions(-)

-- 
2.17.1
