From: Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 0/2] spi: Add FSI-attached SPI controller driver
Date: Fri,  6 Mar 2020 13:41:16 -0600
Message-ID: <20200306194118.18581-1-eajames@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, andy.shevchenko@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This series adds a dts binding and a driver for a new SPI controller that is
accessed over FSI bus.

Eddie James (2):
  dt-bindings: fsi: Add FSI2SPI bindings
  spi: Add FSI-attached SPI controller driver

 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml  |  36 ++
 MAINTAINERS                                   |   7 +
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-fsi.c                         | 558 ++++++++++++++++++
 5 files changed, 609 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
 create mode 100644 drivers/spi/spi-fsi.c

-- 
2.24.0
