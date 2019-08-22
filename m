From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 0/5] Poll mode for NXP DSPI driver
Date: Fri, 23 Aug 2019 00:15:09 +0300
Message-ID: <20190822211514.19288-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This series makes the EOQ and TCFQ operating modes of spi-fsl-dspi work
when no platform IRQ is defined in the DT.

The NXP LS1021A-TSN board needs this setting for performance reasons,
and I am adding the corresponding DTS patch to this series to avoid
runtime errors that may occur if the DTS and the driver patches part
ways and get included through separate trees.

The series also contains a bug fix for the shared IRQ of the DSPI
driver. I am going to respin a version of it as a separate patch for
inclusion in stable trees, independent of this patchset.

Vladimir Oltean (5):
  spi: spi-fsl-dspi: Reduce indentation level in dspi_interrupt
  spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when it's not ours
  spi: spi-fsl-dspi: Remove impossible to reach error check
  spi: spi-fsl-dspi: Use poll mode in case the platform IRQ is missing
  ARM: dts: ls1021a-tsn: Use the DSPI controller in poll mode

 arch/arm/boot/dts/ls1021a-tsn.dts |   1 +
 drivers/spi/spi-fsl-dspi.c        | 128 ++++++++++++++++++------------
 2 files changed, 78 insertions(+), 51 deletions(-)

-- 
2.17.1
