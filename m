From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH v3 0/7] NXP DSPI bugfixes and support for LS1028A
Date: Tue, 10 Mar 2020 15:11:10 +0100
Message-ID: <615284875b709f602d57e4a4621a83c1@walle.cc>
References: <20200310125542.5939-1-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, peng.ma-3arQi8VN3Tc@public.gmane.org
To: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200310125542.5939-1-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Vladimir,

Am 2020-03-10 13:55, schrieb Vladimir Oltean:
> From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
> 
> This series addresses a few issues that were missed during the previous
> series "[PATCH 00/12] TCFQ to XSPI migration for NXP DSPI driver", on
> SoCs other than LS1021A and LS1043A. DMA mode has been completely 
> broken
> by that series, and XSPI mode never worked on little-endian 
> controllers.
> 
> Then it introduces support for the LS1028A chip, whose compatible has
> recently been documented here:
> 
> https://lore.kernel.org/linux-devicetree/20200218171418.18297-1-michael-QKn5cuLxLXY@public.gmane.org/
> 
> The device tree for the LS1028A SoC is extended with DMA channels
> definition, such that even though the default operating mode is XSPI,
> one can simply change DSPI_XSPI_MODE to DSPI_DMA_MODE in the
> devtype_data structure of the driver and use that instead.
> 
> I don't expect the "fixes" patches to reach very far down the stable
> pipe, since there has been pretty heavy refactoring in this driver.
> 
> For testing, benchmarking and debugging, the mikroBUS connector on the
> LS1028A-RDB is made available via spidev.


XSPI mode, while now I cannot reproduce the kernel oops anymore, I've 
found two
other problems (1), (2). Which are likely the same underlying problem. 
DMA mode
works "better" now, still one problem (3).

(1) It seems like the first write/read/erase after the aborted 
instruction
don't get through:

# hexdump -C /dev/mtd0
00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
[  627.914654] fsl-dspi 2120000.spi: Waiting for transfer to complete 
failed!
^C[  627.921649] spi_master spi1: failed to transfer one message from 
queue

#
# echo huhu > /dev/mtd0
# hexdump -C /dev/mtd0
00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
hexdump: /dev/mtd0: Input/output error
003df000
# echo huhu > /dev/mtd0
# hexdump -C /dev/mtd0
00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|huhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
[  642.738905] fsl-dspi 2120000.spi: Waiting for transfer to complete 
failed!
^C[  642.745832] spi_master spi1: failed to transfer one message from 
queue
#
# flash_erase /dev/mtd0 0 1
Erasing 4 Kibyte @ 0 -- 100 % complete
#
# hexdump -C /dev/mtd0
00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|huhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
hexdump: /dev/mtd0: Input/output error
0023d000
# hexdump -C /dev/mtd0
00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|huhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*

(2) Also, reading the flash, every second time there is (reproducibly) 
an
IO error:

# hexdump -C /dev/mtd0
00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|huhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
01000000
# hexdump -C /dev/mtd0
00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|huhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
hexdump: /dev/mtd0: Input/output error
00dc0000
# hexdump -C /dev/mtd0
00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|huhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
01000000
# hexdump -C /dev/mtd0
00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|huhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
hexdump: /dev/mtd0: Input/output error
00e6a000

(3) Depening on the content length there is also an IO error. Funny 
enough,
the content is still written to the SPI flash.

# echo -n 1 > /dev/mtd10
# echo -n 12 > /dev/mtd10
# echo -n 123 > /dev/mtd10
# echo -n 1234 > /dev/mtd10
# echo -n 12345 > /dev/mtd10
sh: write error: Input/output error
# echo -n 123456 > /dev/mtd10
# echo -n 1234567 > /dev/mtd10
sh: write error: Input/output error
# echo -n 12345678 > /dev/mtd10
# echo -n 123456789 > /dev/mtd10
# echo -n 1234567890 > /dev/mtd10
# echo -n 12345678901 > /dev/mtd10
# echo -n 123456789012 > /dev/mtd10
# echo -n 1234567890123 > /dev/mtd10
sh: write error: Input/output error
# echo -n 12345678901234 > /dev/mtd10
# echo -n 123456789012345 > /dev/mtd10
sh: write error: Input/output error
# echo -n 1234567890123456 > /dev/mtd10
# echo -n 12345678901234567 > /dev/mtd10
# echo -n 123456789012345678 > /dev/mtd10


# flash_erase /dev/mtd10 0 1
Erasing 4 Kibyte @ 0 -- 100 % complete
# hexdump -C /dev/mtd10
00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
^C
# echo -n 12345 > /dev/mtd10
sh: write error: Input/output error
# hexdump -C /dev/mtd10
00000000  31 32 33 34 35 ff ff ff  ff ff ff ff ff ff ff ff  
|12345...........|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
^C


-michael

> 
> Vladimir Oltean (7):
>   spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
>   spi: spi-fsl-dspi: Avoid use-after-free in interrupt mode
>   spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
>   spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
>   spi: spi-fsl-dspi: Add support for LS1028A
>   arm64: dts: ls1028a: Specify the DMA channels for the DSPI 
> controllers
>   arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
> 
>  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    |  14 ++
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +
>  drivers/spi/spi-fsl-dspi.c                    | 188 +++++++++++-------
>  3 files changed, 134 insertions(+), 74 deletions(-)
