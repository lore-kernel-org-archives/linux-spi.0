From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 00/12] NXP DSPI bugfixes and support for LS1028A
Date: Wed, 18 Mar 2020 21:05:02 +0200
Message-ID: <CA+h21hrd9CduD-Gw17HjALdP2u8b+iXnpdQadM+jra-zsidYjA@mail.gmail.com>
References: <20200318001603.9650-1-olteanv@gmail.com> <d37b6e0f8a35ae61bbfe147cd5809ec2@walle.cc>
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
In-Reply-To: <d37b6e0f8a35ae61bbfe147cd5809ec2-QKn5cuLxLXY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 18 Mar 2020 at 21:03, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
>
> Am 2020-03-18 01:15, schrieb Vladimir Oltean:
> > From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
> >
> > This series addresses a few issues that were missed during the previous
> > series "[PATCH 00/12] TCFQ to XSPI migration for NXP DSPI driver", on
> > SoCs other than LS1021A and LS1043A. DMA mode has been completely
> > broken
> > by that series, and XSPI mode never worked on little-endian
> > controllers.
> >
> > Then it introduces support for the LS1028A chip, whose compatible has
> > recently been documented here:
> >
> > https://lore.kernel.org/linux-devicetree/20200218171418.18297-1-michael-QKn5cuLxLXY@public.gmane.org/
> >
> > The device tree for the LS1028A SoC is extended with DMA channels
> > definition, such that even though the default operating mode is XSPI,
> > one can simply change DSPI_XSPI_MODE to DSPI_DMA_MODE in the
> > devtype_data structure of the driver and use that instead.
> >
> > Compared to earlier v4, the only change is in patch 05/12 to fix a race
> > condition signaled by Michael Walle here:
> > https://lkml.org/lkml/2020/3/17/740
> >
> > I don't expect the "fixes" patches to reach very far down the stable
> > pipe, since there has been pretty heavy refactoring in this driver.
> >
> > For testing, benchmarking and debugging, the mikroBUS connector on the
> > LS1028A-RDB is made available via spidev.
>
> Patches 1-11:
> Tested-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
>
> Thanks Vladimir for the great work.
>

Excellent! Thanks Michael for the patience!

> -michael
>
> >
> > Vladimir Oltean (12):
> >   spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
> >   spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
> >   spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
> >   spi: spi-fsl-dspi: Avoid reading more data than written in EOQ mode
> >   spi: spi-fsl-dspi: Protect against races on dspi->words_in_flight
> >   spi: spi-fsl-dspi: Replace interruptible wait queue with a simple
> >     completion
> >   spi: spi-fsl-dspi: Avoid NULL pointer in dspi_slave_abort for non-DMA
> >     mode
> >   spi: spi-fsl-dspi: Fix interrupt-less DMA mode taking an XSPI code
> >     path
> >   spi: spi-fsl-dspi: Move invariant configs out of
> >     dspi_transfer_one_message
> >   spi: spi-fsl-dspi: Add support for LS1028A
> >   arm64: dts: ls1028a: Specify the DMA channels for the DSPI
> > controllers
> >   arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
> >
> >  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    |  14 +
> >  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +
> >  drivers/spi/spi-fsl-dspi.c                    | 324 +++++++++---------
> >  3 files changed, 182 insertions(+), 162 deletions(-)

-Vladimir
