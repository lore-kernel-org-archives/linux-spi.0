From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v7 0/5] spi: add support for octal mode
Date: Tue, 15 Jan 2019 10:05:04 +0000
Message-ID: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for octal mode IO data transfer.
Micron flash, mt35xu512aba, supports octal mode data transfer and
NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).

Patch series
* Add parsing logic for m25p80.c device file.
* Add opcodes for octal I/O commands in spi-nor framework, Read and Write p=
roto for (1-1-8/1-8-8) mode.
  Opcodes are added as per octal data IO commands required for mt35xu512aba=
 flash.
* Add mode bit required for octal mode in nxp-fspi driver [1].
* Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [1].

Tested on LX2160ARDB target with nxp-fspi driver, below are
Read performance number of 1-1-1 and 1-1-8 read protocol.

 root@lxxx:~# cat /proc/mtd
 dev:    size   erasesize  name
 mtd0: 04000000 00001000 "spi0.0"
 mtd1: 04000000 00001000 "spi0.1"
 root@lxxx:~# time mtd_debug read /dev/mtd0 0x0 0x1000000 0read
 Copied 16777216 bytes from address 0x00000000 in flash to 0read

 real    0m2.792s
 user    0m0.000s
 sys     0m2.790s
 root@lxxx:~# time mtd_debug read /dev/mtd1 0x0 0x1000000 0read
 Copied 16777216 bytes from address 0x00000000 in flash to 0read

 real    0m0.441s
 user    0m0.000s
 sys     0m0.440s
 root@ls1012ardb:~#

 Flash device MTD0 configured in 1-1-1 protocol.
 Flash device MTD1 configured in 1-1-8 protocol.

[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D86130

Changes for v7:
- Rebase on top of SPI tree
  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/
  branch: for-next
- Drop below patches from series as these have already been applied.
  'spi-add-support-for-octal-mode-I-O-data-transfer.patch' and
  'spi-spi-mem-add-support-for-octal-mode-I-O-data-tran.patch'
- Add r-o-b tag of Tudor Ambarus for
  patch 'mtd-spi-nor-add-opcodes-for-octal-Read-Write-command.patch'
Changes for v6:
- Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
- Rebase on top of v4.20-rc5.
Changes for v5:
- Modified string 'octo' as 'octal' in all patches.
Changes for v4:
- Rebase on top of v4.20-rc2.
- Modify octo entries enum value in spi.h.
Changes for v3:
- Add octo mode support in spi_setup().
- Rename all patches with 'octal' string modified as 'octo'.
Changes for v2:
- Incorporated review comments of Boris and Vignesh.

Yogesh Narayan Gaur (5):
  mtd: spi-nor: add opcodes for octal Read/Write commands
  mtd: spi-nor: add octal read flag for flash mt35xu512aba
  mtd: m25p80: add support of octal mode I/O transfer
  spi: nxp-fspi: add octal mode flag bit for octal support
  arm64: dts: lx2160a: update fspi node

 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |  4 ++++
 drivers/mtd/devices/m25p80.c                  |  9 ++++++++-
 drivers/mtd/spi-nor/spi-nor.c                 | 19 ++++++++++++++++---
 drivers/spi/spi-nxp-fspi.c                    |  4 ++--
 include/linux/mtd/spi-nor.h                   | 16 ++++++++++++----
 5 files changed, 42 insertions(+), 10 deletions(-)

--=20
2.17.1
