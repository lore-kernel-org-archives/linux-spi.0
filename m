From: cezary.gapinski@gmail.com
Subject: [PATCH 0/5] Add support for STM32F4 SPI
Date: Sun,  9 Dec 2018 14:53:51 +0100
Message-ID: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

This series of patches adds support for first generation of SPI interface
for STM32F4 family.

This version of driver is mostly different to STM32H7 one. Based on linux
kernel I2C drivers for STM32 where drivers were splited into STM32F4 and
STM32F7 family the same approach seems to be sufficient for SPI STM32
drivers. Therefore STM32H7 driver was moved to spi-stm32h7.c file and
register and functions were renamed to be more specific to STM32H7.

For current version master mode with full-duplex and 8/16 bit data frame
format are supported. There is no TX and RX FIFOs like in STM32H7.
DMA capabilility is supported for messages longer than arbitrary number
of bytes (that is set already to 16 bytes) when TX and RX channels are
set at the same time.

Cezary Gapinski (5):
  spi: stm32: rename STM32 SPI registers and functions to STM32H7
  spi: stm32: rename spi-stm32 to spi-stm32h7
  spi: stm32: add driver for STM32F4 controller
  ARM: dts: stm32: add SPI support on STM32F429 SoC
  spi: stm32: add description about STM32F4 bindings

 .../devicetree/bindings/spi/spi-stm32.txt          |    9 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |   60 +
 drivers/spi/Kconfig                                |   18 +-
 drivers/spi/Makefile                               |    3 +-
 drivers/spi/spi-stm32.c                            | 1322 -------------------
 drivers/spi/spi-stm32f4.c                          | 1002 +++++++++++++++
 drivers/spi/spi-stm32h7.c                          | 1340 ++++++++++++++++++++
 7 files changed, 2424 insertions(+), 1330 deletions(-)
 delete mode 100644 drivers/spi/spi-stm32.c
 create mode 100644 drivers/spi/spi-stm32f4.c
 create mode 100644 drivers/spi/spi-stm32h7.c

-- 
2.7.4
