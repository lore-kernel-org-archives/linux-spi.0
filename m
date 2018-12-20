From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v6 0/7] spi: add support for octal mode
Date: Thu, 20 Dec 2018 12:03:12 +0530
Message-ID: <d513cf77-b308-a089-71cf-4598bfd2f085@ti.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <10b25865-b93d-382a-aa4d-b21fbd9c3ba9@ti.com>
 <VI1PR04MB5726D65958C532965E12EE4F99BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
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
In-Reply-To: <VI1PR04MB5726D65958C532965E12EE4F99BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 20/12/18 11:02 AM, Yogesh Narayan Gaur wrote:
[...]
>>> Yogesh Gaur (7):
>>>   spi: add support for octal mode I/O data transfer
>>>   spi: spi-mem: add support for octal mode I/O data transfer
>>
>>
>> These two patches are already merged and is now part of linux-next[1].
>> Its preferred to send patches based on top of latest linux-next so as to avoid
>> resending patches that have already been picked up by the maintainer.
>>
>> [1]
>> commit 6b03061f882de49b83ccf44beb3a12c920a2da1b
>> Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
>> Date:   Mon Dec 3 08:39:06 2018 +0000
>>
>>     spi: add support for octal mode I/O data transfer
>>
>> commit b12a084c8729ef423089bb9a5a143eed39cd94e7
>> Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
>> Date:   Mon Dec 3 08:39:12 2018 +0000
>>
>>     spi: spi-mem: add support for octal mode I/O data transfer
>>
>>
> I have checked on repo "git://git.infradead.org/linux-mtd.git" on branch "spi-nor/next" and in that kernel version is 4.20.-rc5.
> In this repo above 2 patches are not present and hence has send the patches by moving to top of this repo.
> 

Those patches are applied to spi tree:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-next

> Can you please let me know the repo of linux-next and branch to use.
> 

The linux-next tree is the holding area for patches aimed at
the next kernel merge window. This tree includes spi-nor/next as part of mtd/next
as well as many other subsystem specific -next trees:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git branch: master


Regards
Vignesh

> --
> Regards
> Yogesh Gaur
> 
>> Regards
>> Vignesh
>>
>>>   mtd: spi-nor: add opcodes for octal Read/Write commands
>>>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
>>>   mtd: m25p80: add support of octal mode I/O transfer
>>>   spi: nxp-fspi: add octal mode flag bit for octal support
>>>   arm64: dts: lx2160a: update fspi node
>>>
>>> Changes for v6:
>>> - Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
>>> - Rebase on top of v4.20-rc5.
>>> Changes for v5:
>>> - Modified string 'octo' as 'octal' in all patches.
>>> Changes for v4:
>>> - Rebase on top of v4.20-rc2.
>>> - Modify octo entries enum value in spi.h.
>>> Changes for v3:
>>> - Add octo mode support in spi_setup().
>>> - Rename all patches with 'octal' string modified as 'octo'.
>>> Changes for v2:
>>> - Incorporated review comments of Boris and Vignesh.
>>>
>>> Yogesh Gaur (7):
>>>   spi: add support for octal mode I/O data transfer
>>>   spi: spi-mem: add support for octal mode I/O data transfer
>>>   mtd: spi-nor: add opcodes for octal Read/Write commands
>>>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
>>>   mtd: m25p80: add support of octal mode I/O transfer
>>>   spi: nxp-fspi: add octal mode flag bit for octal support
>>>   arm64: dts: lx2160a: update fspi node
>>>
>>>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
>>>  drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
>>>  drivers/mtd/spi-nor/spi-nor.c                     | 19 ++++++++++++++++---
>>>  drivers/spi/spi-mem.c                             |  9 ++++++++-
>>>  drivers/spi/spi-nxp-fspi.c                        |  4 ++--
>>>  drivers/spi/spi.c                                 | 12 ++++++++++--
>>>  include/linux/mtd/spi-nor.h                       | 16 ++++++++++++----
>>>  include/linux/spi/spi.h                           |  4 +++-
>>>  8 files changed, 63 insertions(+), 14 deletions(-)
>>>
>>
>> --
>> Regards
>> Vignesh
