From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/6] spi: spi-fsl-dspi: Fix little endian access to PUSHR
 CMD and TXDATA
Date: Mon, 9 Mar 2020 20:07:58 +0200
Message-ID: <CA+h21hp4vC1c00rCgZo_hwQz3cE4dLBHjcgTHvf-+fS9a9VfxQ@mail.gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com> <20200309145624.10026-3-olteanv@gmail.com>
 <d8e39e402328b962cdbc25316a27eac8@walle.cc>
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
In-Reply-To: <d8e39e402328b962cdbc25316a27eac8-QKn5cuLxLXY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Michael,

On Mon, 9 Mar 2020 at 19:59, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
>
> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> > From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
> >
> > In XSPI mode, the 32-bit PUSHR register can be written to separately:
> > the higher 16 bits are for commands and the lower 16 bits are for data.
> >
> > This has nicely been hacked around, by defining a second regmap with a
> > width of 16 bits, and effectively splitting a 32-bit register into 2
> > 16-bit ones, from the perspective of this regmap_pushr.
> >
> > The problem is the assumption about the controller's endianness. If the
> > controller is little endian (such as anything post-LS1046A), then the
> > first 2 bytes, in the order imposed by memory layout, will actually
> > hold
> > the TXDATA, and the last 2 bytes will hold the CMD.
> >
> > So take the controller's endianness into account when performing split
> > writes to PUSHR. The obvious and simple solution would have been to
> > call
> > regmap_get_val_endian(), but that is an internal regmap function and we
> > don't want to change regmap just for this. Therefore, we define the
> > offsets per-instantiation, in the devtype_data structure. This means
> > that we have to know from the driver which controllers are big- and
> > which are little-endian (which is fine, we do, but it makes the device
> > tree binding itself a little redundant except for regmap_config).
> >
> > This patch does not apply cleanly to stable trees, and a punctual fix
> > to
> > the commit cannot be provided given this constraint of lack of access
> > to
> > regmap_get_val_endian(). The per-SoC devtype_data structures (and
> > therefore the premises to fix this bug) have been introduced only a few
> > commits ago, in commit d35054010b57 ("spi: spi-fsl-dspi: Use specific
> > compatible strings for all SoC instantiations")
> >
> > Fixes: 58ba07ec79e6 ("spi: spi-fsl-dspi: Add support for XSPI mode
> > registers")
> > Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
> > ---
> >  drivers/spi/spi-fsl-dspi.c | 28 ++++++++++++++++++++++------
> >  1 file changed, 22 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> > index 0ce26c1cbf62..a8e56abe20ac 100644
> > --- a/drivers/spi/spi-fsl-dspi.c
> > +++ b/drivers/spi/spi-fsl-dspi.c
> > @@ -103,10 +103,6 @@
> >  #define SPI_FRAME_BITS(bits)         SPI_CTAR_FMSZ((bits) - 1)
> >  #define SPI_FRAME_EBITS(bits)                SPI_CTARE_FMSZE(((bits) - 1) >> 4)
> >
> > -/* Register offsets for regmap_pushr */
> > -#define PUSHR_CMD                    0x0
> > -#define PUSHR_TX                     0x2
> > -
> >  #define DMA_COMPLETION_TIMEOUT               msecs_to_jiffies(3000)
> >
> >  struct chip_data {
> > @@ -124,6 +120,12 @@ struct fsl_dspi_devtype_data {
> >       u8                      max_clock_factor;
> >       int                     fifo_size;
> >       int                     dma_bufsize;
> > +     /*
> > +      * Offsets for CMD and TXDATA within SPI_PUSHR when accessed
> > +      * individually (in XSPI mode)
> > +      */
> > +     int                     pushr_cmd;
> > +     int                     pushr_tx;
> >  };
>
> Shouldn't this just read the "little-endian" property of the
> device tree node?

This is exactly what the driver did prior to this commit from 2014:
https://patchwork.kernel.org/patch/4732711/
Since then, "little-endian" and "big-endian" became generic regmap properties.

> Like it worked before with regmap, which takes
> the little-endian/big-endian property into account.
>

So XSPI mode allows you, among other things, to send 32 bits words at a time.
In my opinion this was tested only the big-endian DSPI controllers
(LS1021A, LS1043A etc).
On the little-endian controllers (LS2, LX2, LS1028A) I suspect this
was actually never tested.
The reason why we see it now is because we're "accelerating" even
8-bit words to 32-bit.
So it is incorrect to say "like it worked before": it never worked before.

> If I understand this correctly, this solution would mix the methods
> how the IP endianess is determined. Eg. regmap_xx uses the
> little-endian property and this driver then also uses the compatible
> string to also distinguish between the endianess.
>

Yup. Otherwise we effectively have to duplicate the logic from the
internal regmap_get_val_endian function. I found no other way to
figure out what endianness the regmap_config has. Suggestions welcome.

> -michael
>

Thanks,
-Vladimir
