From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/3] xtensa xtfpga SPI controller driver
Date: Tue, 11 Mar 2014 16:44:48 +0400
Message-ID: <1394541891-26469-1-git-send-email-jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Max Filippov <jcmvbkbc@gmail.com>
To: linux-xtensa@linux-xtensa.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

this series adds driver for SPI controller used on xtfpga xtensa platform,
device tree binding documentation and an entry to MAINTAINERS.

Max Filippov (3):
  spi: add xtfpga SPI controller driver
  spi/xtensa-xtfpga: add DT binding documentation
  MAINTAINERS: add xtfpga platform section

 .../devicetree/bindings/spi/spi-xtensa-xtfpga.txt  |   9 ++
 MAINTAINERS                                        |   6 +
 drivers/spi/Kconfig                                |  13 ++
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-xtensa-xtfpga.c                    | 165 +++++++++++++++++++++
 5 files changed, 194 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt
 create mode 100644 drivers/spi/spi-xtensa-xtfpga.c

-- 
1.8.1.4
