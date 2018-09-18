From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 0/3] ARM: dspi: Provide slave mode support for Vybryd vf610
Date: Tue, 18 Sep 2018 11:34:34 +0200
Message-ID: <20180918093437.26799-1-lukma@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch series provides support for DSPI slave mode operation.
It tries to maximally reuse current DMA driver (including its limitations).

For testing the spidev_test program has been used.
Test script for this patch can be found here:
https://github.com/lmajewski/tests-spi/blob/master/tests/spi/spi_tests.sh

Lukasz Majewski (3):
  dt-bindings: spi: Provide bindings for fsl dspi working in slave mode
  ARM: dspi: Provide per DSPI instance of the MCR register (SLAVE mode)
  ARM: dspi: Provide support for DSPI slave more operation (Vybryd
    vf610)

 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  8 ++++
 drivers/spi/spi-fsl-dspi.c                         | 54 ++++++++++++++++------
 2 files changed, 49 insertions(+), 13 deletions(-)

-- 
2.11.0
