From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv8 0/2] Add ti qspi controller
Date: Thu, 1 Aug 2013 19:30:00 +0530
Message-ID: <1375365602-31321-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <balbi@ti.com>, <rnayak@ti.com>, <linux-omap@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Sourav Poddar <sourav.poddar@ti.com>
To: <broonie@kernel.org>, <spi-devel-general@lists.sourceforge.net>,
	<grant.likely@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch series add support for ti qspi controller.
Adapted this series on top of Mark brown series[1]:

[1]: https://patchwork.kernel.org/patch/2834694/
 
Sourav Poddar (2):
  drivers: spi: Add qspi flash controller
  driver: spi: Add quad spi read support

 Documentation/devicetree/bindings/spi/ti_qspi.txt |   22 +
 drivers/spi/Kconfig                               |    8 +
 drivers/spi/Makefile                              |    1 +
 drivers/spi/spi-ti-qspi.c                         |  600 +++++++++++++++++++++
 4 files changed, 631 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/ti_qspi.txt
 create mode 100644 drivers/spi/spi-ti-qspi.c

