From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 0/7] NXP DSPI bugfixes and support for LS1028A
Date: Tue, 10 Mar 2020 16:56:39 +0200
Message-ID: <CA+h21hrYoHVDvsxT1EPWhYprL+zNHfE4MW7k4HxiK7ma4ZWn1g@mail.gmail.com>
References: <20200310125542.5939-1-olteanv@gmail.com> <615284875b709f602d57e4a4621a83c1@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Esben Haabendal <eha-/iRVSOupHO4@public.gmane.org>,
        angelo-BIYBQhTR83Y@public.gmane.org, andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
        Wei Chen <weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mohamed Hosny <mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        peng.ma-3arQi8VN3Tc@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <615284875b709f602d57e4a4621a83c1-QKn5cuLxLXY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Michael,

On Tue, 10 Mar 2020 at 16:11, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
>

>
> XSPI mode, while now I cannot reproduce the kernel oops anymore, I've
> found two
> other problems (1), (2). Which are likely the same underlying problem.
> DMA mode
> works "better" now, still one problem (3).
>
> (1) It seems like the first write/read/erase after the aborted
> instruction
> don't get through:
>
> # hexdump -C /dev/mtd0
> 00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> [  627.914654] fsl-dspi 2120000.spi: Waiting for transfer to complete
> failed!
> ^C[  627.921649] spi_master spi1: failed to transfer one message from
> queue
>
> #
> # echo huhu > /dev/mtd0
> # hexdump -C /dev/mtd0
> 00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> hexdump: /dev/mtd0: Input/output error
> 003df000
> # echo huhu > /dev/mtd0
> # hexdump -C /dev/mtd0
> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |huhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> [  642.738905] fsl-dspi 2120000.spi: Waiting for transfer to complete
> failed!
> ^C[  642.745832] spi_master spi1: failed to transfer one message from
> queue
> #
> # flash_erase /dev/mtd0 0 1
> Erasing 4 Kibyte @ 0 -- 100 % complete
> #
> # hexdump -C /dev/mtd0
> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |huhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> hexdump: /dev/mtd0: Input/output error
> 0023d000
> # hexdump -C /dev/mtd0
> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |huhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
>
> (2) Also, reading the flash, every second time there is (reproducibly)
> an
> IO error:
>
> # hexdump -C /dev/mtd0
> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |huhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> 01000000
> # hexdump -C /dev/mtd0
> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |huhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> hexdump: /dev/mtd0: Input/output error
> 00dc0000
> # hexdump -C /dev/mtd0
> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |huhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> 01000000
> # hexdump -C /dev/mtd0
> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |huhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> hexdump: /dev/mtd0: Input/output error
> 00e6a000
>

Just to be clear, issue 2 is seen only after you abort another
transaction, right?

> (3) Depening on the content length there is also an IO error. Funny
> enough,
> the content is still written to the SPI flash.
>
> # echo -n 1 > /dev/mtd10
> # echo -n 12 > /dev/mtd10
> # echo -n 123 > /dev/mtd10
> # echo -n 1234 > /dev/mtd10
> # echo -n 12345 > /dev/mtd10
> sh: write error: Input/output error
> # echo -n 123456 > /dev/mtd10
> # echo -n 1234567 > /dev/mtd10
> sh: write error: Input/output error
> # echo -n 12345678 > /dev/mtd10
> # echo -n 123456789 > /dev/mtd10
> # echo -n 1234567890 > /dev/mtd10
> # echo -n 12345678901 > /dev/mtd10
> # echo -n 123456789012 > /dev/mtd10
> # echo -n 1234567890123 > /dev/mtd10
> sh: write error: Input/output error
> # echo -n 12345678901234 > /dev/mtd10
> # echo -n 123456789012345 > /dev/mtd10
> sh: write error: Input/output error
> # echo -n 1234567890123456 > /dev/mtd10
> # echo -n 12345678901234567 > /dev/mtd10
> # echo -n 123456789012345678 > /dev/mtd10
>
>
> # flash_erase /dev/mtd10 0 1
> Erasing 4 Kibyte @ 0 -- 100 % complete
> # hexdump -C /dev/mtd10
> 00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> ^C
> # echo -n 12345 > /dev/mtd10
> sh: write error: Input/output error
> # hexdump -C /dev/mtd10
> 00000000  31 32 33 34 35 ff ff ff  ff ff ff ff ff ff ff ff
> |12345...........|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> ^C
>

For this one, I think the reported message->actual_length is incorrect
in dspi_dma_xfer, which makes spi-mem scream.

>
> -michael
>
> >
> > Vladimir Oltean (7):
> >   spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
> >   spi: spi-fsl-dspi: Avoid use-after-free in interrupt mode
> >   spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
> >   spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
> >   spi: spi-fsl-dspi: Add support for LS1028A
> >   arm64: dts: ls1028a: Specify the DMA channels for the DSPI
> > controllers
> >   arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
> >
> >  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    |  14 ++
> >  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +
> >  drivers/spi/spi-fsl-dspi.c                    | 188 +++++++++++-------
> >  3 files changed, 134 insertions(+), 74 deletions(-)

Thanks,
-Vladimir
