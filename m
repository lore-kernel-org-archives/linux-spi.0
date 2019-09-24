From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 0/2] spi: Fix problem with interrupted slave transmission
Date: Tue, 24 Sep 2019 13:05:45 +0200
Message-ID: <20190924110547.14770-1-lukma@denx.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, Lukasz Majewski <lukma@denx.de>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch series fixes problem with recovering Vybrid's NXP DSPI
controller state after master transmission distortion.

It was tested with a setup where /dev/spidevX.Y devices were used in
a loopback mode (provided by proper HW connections). During this test
the distortion was introduced and the system was assessed if it is
possible to continue correct SPI transmission.

This series applies clearly on v5.2 (tag) and current mainline:
SHA1: 4c07e2ddab5b6b57dbcb09aedbda1f484d5940cc

Lukasz Majewski (2):
  spi: Add call to spi_slave_abort() function when spidev driver is
    released
  spi: Introduce dspi_slave_abort() function for NXP's dspi SPI driver

 drivers/spi/spi-fsl-dspi.c | 20 ++++++++++++++++++++
 drivers/spi/spidev.c       |  1 +
 2 files changed, 21 insertions(+)

-- 
2.20.1
