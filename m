From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/6] Compatible string consolidation for NXP DSPI driver
Date: Mon,  2 Mar 2020 02:19:52 +0200
Message-ID: <20200302001958.11105-1-olteanv@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This series makes room in the driver for differentiation between the
controllers which currently operate in TCFQ mode. Most of these are
actually capable of a lot more in terms of throughput. This is in
preparation of a second series which will convert the remaining users of
TCFQ mode altogether to XSPI mode with command cycling.

Vladimir Oltean (6):
  doc: spi-fsl-dspi: Add specific compatibles for all Layerscape SoCs
  spi: spi-fsl-dspi: Use specific compatible strings for all SoC
    instantiations
  spi: spi-fsl-dspi: Parameterize the FIFO size and DMA buffer size
  spi: spi-fsl-dspi: LS2080A and LX2160A support XSPI mode
  spi: spi-fsl-dspi: Support SPI software timestamping in all non-DMA
    modes
  spi: spi-fsl-dspi: Convert the instantiations that support it to DMA

 .../devicetree/bindings/spi/spi-fsl-dspi.txt  |  17 +-
 drivers/spi/spi-fsl-dspi.c                    | 162 +++++++++++++-----
 2 files changed, 128 insertions(+), 51 deletions(-)

-- 
2.17.1
