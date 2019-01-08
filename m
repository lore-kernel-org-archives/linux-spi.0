From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Date: Tue, 8 Jan 2019 09:24:35 +0000
Message-ID: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

- Add driver for NXP FlexSPI host controller

 FlexSPI is a flexsible SPI host controller [1], Chapter 30 page 1475,
 which supports two SPI channels and up to 4 external devices.
 Each channel supports Single/Dual/Quad/Octal mode data transfer (1/2/4/8 b=
idirectional data lines)
 i.e. FlexSPI acts as an interface to external devices, maximum 4, each wit=
h up to 8
 bidirectional data lines.

- Tested this driver with mtd_debug(Erase/Write/Read) utility and JFFS2
 filesystem mounting and booting on NXP LX2160ARDB[2] and LX2160AQDS target=
s.
 LX2160ARDB is having two NOR slave device connected on single bus A
 i.e. A0 and A1 (CS0 and CS1).
 LX2160AQDS is having two NOR slave device connected on separate buses
 one flash on A0 and second on B1 i.e. (CS0 and CS3).
 Verified this driver on following SPI NOR flashes:
   Micron, mt35xu512aba, [Read - 1 bit mode]
   Cypress, s25fl512s, [Read - 1/2/4 bit mode]

[1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
[2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?submitter=
=3D182097

Yogesh Narayan Gaur (5):
  spi: spi-mem: Add driver for NXP FlexSPI controller
  dt-bindings: spi: add binding file for NXP FlexSPI controller
  arm64: dts: lx2160a: add FlexSPI node property
  arm64: defconfig: enable NXP FlexSPI driver
  MAINTAINERS: add maintainers for the NXP FlexSPI driver

Changes for v6:
- Rebase on top of v5.0-rc1.
- Incorporated review comments for
  patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
- Updated s-b tag in all patches.
Changes for v5:
- Rebase on top of v4.20-rc2
- Incorporated review comments for
  patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
Changes for v4:
- Incorporated review comments for
  patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
- Incorporated binding file review comments.
Changes for v3:
- Incorporated review comments for
  patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
Changes for v2:
- Incorporated Boris review comments and drop below patches as per the comm=
ents.
 - Patch 'spi: add slave device size in spi_device struct'
 - Patch 'spi: add flags for octal I/O data transfer'
- Incorporated DTS and Binding file review comments of Shawn Guo and Rob He=
rring.

 .../devicetree/bindings/spi/spi-nxp-fspi.txt  |   39 +
 MAINTAINERS                                   |    7 +
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |   22 +
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   13 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/spi/Kconfig                           |   10 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-nxp-fspi.c                    | 1095 +++++++++++++++++
 8 files changed, 1188 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
 create mode 100644 drivers/spi/spi-nxp-fspi.c

--=20
2.17.1
