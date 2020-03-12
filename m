From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/9] spi: meson-spicc: add support for AXG and G12A variants
Date: Thu, 12 Mar 2020 14:31:22 +0100
Message-ID: <20200312133131.26430-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The SPICC controller in Amlogic AXG & G12A is capable of driving the
CLK/MOSI/SS signal lines through the idle state which avoid the signals
floating in unexpected state, is capable of using linear clock divider
to reach a much fine tuned range of clocks, while the old controller only
uses a power of two clock divider, result at a more coarse clock range and
finally is capable of running at 80M clock.

The SPICC controller in Amlogic G12A takes the source clock from a specific
clock instead of the bus clock and has a different FIFO size and doesn't
handle the RX Half interrupt the same way as GXL & AXG variants. Thus
the burst management is simplified and takes in account a variable FIFO
size.

Now the controller can support frequencies higher than 30MHz, we need
the setup the I/O line delays in regard of the SPI clock frequency.

Neil Armstrong (7):
  spi: meson-spicc: remove unused variables
  spi: meson-spicc: support max 80MHz clock
  spi: meson-spicc: add min sclk for each compatible
  spi: meson-spicc: setup IO line delay
  spi: meson-spicc: adapt burst handling for G12A support
  dt-bindings: spi: amlogic,meson-gx-spicc: add Amlogic G12A compatible
  spi: meson-spicc: add support for Amlogic G12A

Sunny Luo (2):
  spi: meson-spicc: enhance output enable feature
  spi: meson-spicc: add a linear clock divider support

 .../bindings/spi/amlogic,meson-gx-spicc.yaml  |  22 +
 drivers/spi/Kconfig                           |   1 +
 drivers/spi/spi-meson-spicc.c                 | 496 +++++++++++++-----
 3 files changed, 392 insertions(+), 127 deletions(-)

-- 
2.22.0
