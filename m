From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v2 0/2] spi: support inter-word delays
Date: Fri, 25 Jan 2019 13:24:23 +0100
Message-ID: <20190125122425.30676-1-jonas@norrbonn.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jonas Bonn <jonas@norrbonn.se>
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Resubmission to fix thinko in spi-atmel patch.

Changed in v2:
* Fix atmel-spi driver to not unconditionally set minimal delay if no
  delay is required (erroneous clamping)

This short series adds support for SPI inter-word delays and configures
the spi-atmel driver to honour the setting.

Some SPI slaves are so slow that they are unable to keep up even at the
SPI controller's lowest available clock frequency.  I have such a
configuration where an AVR-based SPI slave is unable to feed the SPI bus
fast enough even the SPI master runs at the lowest possible clock speed.

Jonas Bonn (2):
  spi: support inter-word delay requirement for devices
  spi-atmel: support inter-word delay

 .../devicetree/bindings/spi/spi-bus.txt        |  1 +
 drivers/spi/spi-atmel.c                        | 18 +++++++++++++-----
 drivers/spi/spi.c                              |  4 ++++
 include/linux/spi/spi.h                        |  1 +
 4 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.19.1
