From: cezary.gapinski@gmail.com
Subject: [PATCH v2 00/14] Add support for STM32F4 SPI
Date: Mon, 24 Dec 2018 23:00:26 +0100
Message-ID: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

This series of patches adds support for first generation of SPI
interface for STM32F4 family.

This version of driver is mostly different to STM32H7 one. Based on
linux kernel I2C drivers for STM32 where drivers were splited into
STM32F4 and STM32F7 family the same approach seems to be sufficient for
SPI STM32 drivers. Therefore STM32H7 driver was moved to spi-stm32h7.c
file and register and functions were renamed to be more specific to
STM32H7.

For current version master mode with full-duplex and 8/16 bit data
frame format are supported. There is no TX and RX FIFOs like
in STM32H7. DMA capabilility is supported for messages longer than
arbitrary number of bytes (that is set already to 16 bytes) when TX
and RX channels are set at the same time.

v2:
Based on Amelie Delaunay recommendation only one common file
spi-stm32.c is used. Before adding support for STM32F4 driver, first six
patches adds some improvements to actual driver.
Next patches rearrange driver to be more useful for new STM32F4 SPI
and adding support for this family.
This version also supports simplex-tx and 3wire-tx modes.

Cezary Gapinski (14):
  spi: stm32: switch to SPDX identifier
  spi: stm32: use NULL pointer instead of plain integer
  spi: stm32: fix DMA configuration with only one channel
  spi: fix typo in SPI_STM32 help text
  spi: stm32: use explicit CPOL and CPHA mode bits
  spi: stm32: remove SPI LOOP mode
  spi: stm32: rename STM32 SPI registers to STM32H7
  spi: stm32: rename interrupt function
  spi: stm32: split transfer one setup function
  spi: stm32: add start dma transfer function
  spi: stm32: introduce compatible data cfg
  spi: stm32: add support for STM32F4
  ARM: dts: stm32: add SPI support on STM32F429 SoC
  spi: stm32: add description about STM32F4 bindings

 .../devicetree/bindings/spi/spi-stm32.txt          |    9 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |   60 +
 drivers/spi/Kconfig                                |    2 +-
 drivers/spi/spi-stm32.c                            | 1403 +++++++++++++++-----
 4 files changed, 1139 insertions(+), 335 deletions(-)

-- 
2.7.4
