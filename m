From: Beniamino Galvani <b.galvani@gmail.com>
Subject: [PATCH 0/3] spi: Add support for Amlogic Meson SPIFC
Date: Sun,  9 Nov 2014 10:25:10 +0100
Message-ID: <1415525113-25598-1-git-send-email-b.galvani@gmail.com>
Cc: linux-spi@vger.kernel.org, Carlo Caione <carlo@caione.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jerry Cao <jerry.cao@amlogic.com>,
	Victor Wan <victor.wan@amlogic.com>,
	Beniamino Galvani <b.galvani@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

this patchset adds a driver for the SPIFC (SPI flash controller)
available in Amlogic Meson6 and Meson8 SoCs. It doesn't support DMA
and has a 64-byte unified transmit/receive buffer.

The driver has been tested on a Meson8 based device to communicate
with a Macronix mx25l1606e serial flash.

Beniamino Galvani (3):
  spi: meson: Add device tree bindings documentation for SPIFC
  spi: meson: Add support for Amlogic Meson SPIFC
  ARM: dts: meson: add node for SPIFC

 .../devicetree/bindings/spi/spi-meson.txt          |  22 ++
 arch/arm/boot/dts/meson.dtsi                       |   9 +
 drivers/spi/Kconfig                                |   7 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-meson-spifc.c                      | 411 +++++++++++++++++++++
 5 files changed, 450 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-meson.txt
 create mode 100644 drivers/spi/spi-meson-spifc.c

-- 
1.9.1
