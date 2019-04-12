From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/3] spi: SPI bus multiplexer
Date: Fri, 12 Apr 2019 17:02:10 +1200
Message-ID: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi All,

I have a hardware design where a single SPI chip select is steered by a
GPIO being asserted or de-asserted. On older kernels I was able to
(ab)use a gpio-hog and cs-gpios to deal with this.

Unfortunately recent changes have stopped my hacks from working. I've
tried adapting cs-gpios to work with my particular hardware but I came
to the realisation that the current cs-gpios support assumes a 1:1
mapping of gpio to SPI device whereas my hardware used the state of the
gpio selecting the device i.e. a 1:2 mapping.

This is my attempt to implement a driver to deal with this. One nice
property is that it is pretty much self contained. The only change to
the core SPI infrastructure is exposing a function I needed to lookup
the spi_controller instance.

Chris Packham (3):
  dt-bindings: spi: Add spi-mux-gpio
  spi: Make of_find_spi_controller_by_node visible
  spi: Add SPI bus gpio multiplexer

 .../devicetree/bindings/spi/spi-mux-gpio.txt  |  46 +++++
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-mux-gpio.c                    | 169 ++++++++++++++++++
 drivers/spi/spi.c                             |   7 +-
 include/linux/spi/spi.h                       |   7 +
 6 files changed, 234 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux-gpio.tx=
t
 create mode 100644 drivers/spi/spi-mux-gpio.c

--=20
2.21.0
