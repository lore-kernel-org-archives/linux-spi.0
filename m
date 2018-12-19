From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v6 0/7] spi: add support for octal mode
Date: Wed, 19 Dec 2018 18:13:42 +0530
Message-ID: <10b25865-b93d-382a-aa4d-b21fbd9c3ba9@ti.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 19/12/18 3:41 PM, Yogesh Narayan Gaur wrote:
> Add support for octal mode IO data transfer.
> Micron flash, mt35xu512aba, supports octal mode data transfer and
> NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).
> 
> Patch series
> * Add support for octal mode flags and parsing of same in spi driver.
> * Add parsing logic for spi-mem framework and m25p80.c device file.
> * Add opcodes for octal I/O commands in spi-nor framework, Read and Write proto for (1-1-8/1-8-8) mode.
>   Opcodes are added as per octal data IO commands required for mt35xu512aba [1] flash.
> * Add mode bit required for octal mode in nxp-fspi driver [2].
> * Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].
> 
> Tested on LX2160ARDB target with nxp-fspi driver, below are
> Read performance number of 1-1-1 and 1-1-8 read protocol.
> 
>  root@lxxx:~# cat /proc/mtd
>  dev:    size   erasesize  name
>  mtd0: 04000000 00001000 "spi0.0"
>  mtd1: 04000000 00001000 "spi0.1"
>  root@lxxx:~# time mtd_debug read /dev/mtd0 0x0 0x1000000 0read
>  Copied 16777216 bytes from address 0x00000000 in flash to 0read
> 
>  real    0m2.792s
>  user    0m0.000s
>  sys     0m2.790s
>  root@lxxx:~# time mtd_debug read /dev/mtd1 0x0 0x1000000 0read
>  Copied 16777216 bytes from address 0x00000000 in flash to 0read
> 
>  real    0m0.441s
>  user    0m0.000s
>  sys     0m0.440s
>  root@ls1012ardb:~#
> 
> 
>  Flash device MTD0 configured in 1-1-1 protocol.
>  Flash device MTD1 configured in 1-1-8 protocol.
> 
> [1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70384&state=*
> [2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=76402
> 
> Yogesh Gaur (7):
>   spi: add support for octal mode I/O data transfer
>   spi: spi-mem: add support for octal mode I/O data transfer


These two patches are already merged and is now part of linux-next[1].
Its preferred to send patches based on top of latest linux-next so as to
avoid resending patches that have already been picked up by the maintainer.

[1]
commit 6b03061f882de49b83ccf44beb3a12c920a2da1b
Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date:   Mon Dec 3 08:39:06 2018 +0000

    spi: add support for octal mode I/O data transfer

commit b12a084c8729ef423089bb9a5a143eed39cd94e7
Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date:   Mon Dec 3 08:39:12 2018 +0000

    spi: spi-mem: add support for octal mode I/O data transfer


Regards
Vignesh

>   mtd: spi-nor: add opcodes for octal Read/Write commands
>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
>   mtd: m25p80: add support of octal mode I/O transfer
>   spi: nxp-fspi: add octal mode flag bit for octal support
>   arm64: dts: lx2160a: update fspi node
> 
> Changes for v6:
> - Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
> - Rebase on top of v4.20-rc5.
> Changes for v5:
> - Modified string 'octo' as 'octal' in all patches.
> Changes for v4:
> - Rebase on top of v4.20-rc2.
> - Modify octo entries enum value in spi.h.
> Changes for v3:
> - Add octo mode support in spi_setup().
> - Rename all patches with 'octal' string modified as 'octo'.
> Changes for v2:
> - Incorporated review comments of Boris and Vignesh.
> 
> Yogesh Gaur (7):
>   spi: add support for octal mode I/O data transfer
>   spi: spi-mem: add support for octal mode I/O data transfer
>   mtd: spi-nor: add opcodes for octal Read/Write commands
>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
>   mtd: m25p80: add support of octal mode I/O transfer
>   spi: nxp-fspi: add octal mode flag bit for octal support
>   arm64: dts: lx2160a: update fspi node
> 
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
>  drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
>  drivers/mtd/spi-nor/spi-nor.c                     | 19 ++++++++++++++++---
>  drivers/spi/spi-mem.c                             |  9 ++++++++-
>  drivers/spi/spi-nxp-fspi.c                        |  4 ++--
>  drivers/spi/spi.c                                 | 12 ++++++++++--
>  include/linux/mtd/spi-nor.h                       | 16 ++++++++++++----
>  include/linux/spi/spi.h                           |  4 +++-
>  8 files changed, 63 insertions(+), 14 deletions(-)
> 

-- 
Regards
Vignesh
