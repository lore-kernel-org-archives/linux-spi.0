From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH] spi: add support for SPI over SuperH SCI pins
Date: Tue, 22 Jan 2008 12:56:18 +0900
Message-ID: <aec7e5c30801211956p285de9a6gfb8debafbb876c37@mail.gmail.com>
References: <20080121104913.11908.50319.sendpatchset@clockwork.opensource.se>
	 <200801211429.29906.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, lethal@linux-sh.org,
	linux-sh@vger.kernel.org
To: "David Brownell" <david-b@pacbell.net>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <200801211429.29906.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Jan 22, 2008 7:29 AM, David Brownell <david-b@pacbell.net> wrote:
>
> On Monday 21 January 2008, Magnus Damm wrote:
> > spi: add support for SPI over SuperH SCI pins
> >
> > This patch adds support for SPI over SCI pins. SCI is a very simple serial
> > controller block that can be found on older SuperH processors. In theory it
> > is possible to use the SCI hardware block in syncronous mode, but this version
> > of the driver simply hooks up the bit banging code on the SCI pins.
> >
> > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > ---
> >
> >  drivers/spi/Kconfig      |    7 +
> >  drivers/spi/Makefile     |    1
> >  drivers/spi/spi_sh_sci.c |  217 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 225 insertions(+)
> >
> > --- 0001/drivers/spi/Kconfig
> > +++ work/drivers/spi/Kconfig  2008-01-21 16:59:39.000000000 +0900
> > @@ -175,6 +175,13 @@ config SPI_S3C24XX_GPIO
> >         the inbuilt hardware cannot provide the transfer mode, or
> >         where the board is using non hardware connected pins.
> >
> > +config SPI_SH_SCI
> > +     tristate "SuperH SCI SPI controller"
> > +     depends on SPI_MASTER && SUPERH
> > +     select SPI_BITBANG
> > +     help
> > +       SPI driver for SuperH SCI blocks.
> > +
> >  config SPI_TXX9
> >       tristate "Toshiba TXx9 SPI controller"
> >       depends on SPI_MASTER && GENERIC_GPIO && CPU_TX49XX
> > --- 0001/drivers/spi/Makefile
> > +++ work/drivers/spi/Makefile 2008-01-21 16:59:39.000000000 +0900
> > @@ -27,6 +27,7 @@ obj-$(CONFIG_SPI_S3C24XX_GPIO)              += spi_s
> >  obj-$(CONFIG_SPI_S3C24XX)            += spi_s3c24xx.o
> >  obj-$(CONFIG_SPI_TXX9)                       += spi_txx9.o
> >  obj-$(CONFIG_SPI_XILINX)             += xilinx_spi.o
> > +obj-$(CONFIG_SPI_SH_SCI)             += spi_sh_sci.o
> >  #    ... add above this line ...
> >
> >  # SPI protocol drivers (device/link on bus)
> > --- /dev/null
> > +++ work/drivers/spi/spi_sh_sci.c     2008-01-21 17:04:02.000000000 +0900
> > @@ -0,0 +1,217 @@
> > +/* linux/drivers/spi/spi_sh_sci.c
>
> The general policy is to not include the whole driver pathname,
> since paths change over time.  Better yet, I don't see any need
> for a pathname here ... just remove it.

Ok, I'll remove that comment.

> > + *
> > + * SH SCI SPI interface
> > + *
> > + * Based on S3C24XX GPIO based SPI driver
> > + *
> > + * Copyright (c) 2006 Ben Dooks
> > + * Copyright (c) 2006 Simtec Electronics
>
> I see a missing copyright there:  yours!

Uhm, yes. I'll add that. =)

> I'd be relatively certain Ben and Simtek don't want to be
> maintain a driver they never had anything to do with, so
> please make sure it doesn't look like they wrote it.

Absolutely. Sorry about that.

> You should consider adding yourself to MAINTAINERS for
> this driver...

Yes. If it's ok with you then i'll send a separate patch for that. I
should probably add more than one entry there.

> > +struct sh_sci_spi {
> > +     struct spi_bitbang bitbang;
> > +
> > +     unsigned long mapbase;
>
> Not "void __iomem *mapbase"?
>
> I notice that you're not doing an ioremap() to get this address.
> Is the platform device properly registering a *physical* address
> in the IORESOURCE_MEM record for the device?

I just followed the good old sh-sci.c serial driver, but i'll rewrite that part.

> > +     struct sh_spi_info *info;
> > +     struct platform_device *dev;
> > +};
> > +
> > +#define SCSPTR(sg) (sg->mapbase + 0x1c)
> > +#define PIN_SCK (1 << 2)
> > +#define PIN_TXD (1 << 0)
> > +#define PIN_RXD PIN_TXD
> > +#define PIN_INIT ((1 << 1) | (1 << 3))
> > +
> > +static inline struct sh_sci_spi *spidev_to_sg(struct spi_device *spi)
> > +{
> > +     return spi->controller_data;
> > +}
> > +
> > +static inline void setbits(struct sh_sci_spi *sg, int bits, int on)
> > +{
> > +     unsigned char val;
> > +
> > +     val = ctrl_inb(SCSPTR(sg));
> > +     if (on)
> > +             val |= bits;
> > +     else
> > +             val &= ~bits;
> > +     ctrl_outb(val, SCSPTR(sg));
>
> I notice there are no locks around this read/modify/write operation.
>
> As a rule that's unsafe for GPIO registers -- since another activity
> (IRQ handler or whatever) can do the same thing, and then you'd have
> one stomping all over the other.  Is there something that would make
> it safe in this case?  If not, fix; if so, comment.

The SCSPTR register is part of the serial controller block and this
driver should be the only user of that block. So no locks needed. I'll
add a comment that clarifies that.

> > +}
> > +
> > +static inline unsigned char getbits(struct sh_sci_spi *sg, int bits)
> > +{
> > +     return ctrl_inb(SCSPTR(sg)) & bits;
> > +}
> > +
> > +static inline void setsck(struct spi_device *dev, int on)
> > +{
> > +     setbits(spidev_to_sg(dev), PIN_SCK, on);
> > +}
> > +
> > +static inline void setmosi(struct spi_device *dev, int on)
> > +{
> > +     setbits(spidev_to_sg(dev), PIN_TXD, on);
> > +}
> > +
> > +static inline u32 getmiso(struct spi_device *dev)
> > +{
> > +     return getbits(spidev_to_sg(dev), PIN_RXD) ? 1 : 0;
>
> I worry about all those spidev_to_sg(dev) calls ... did you look
> at the generated code to make sure they get pulled out of the
> inner loops?  Declaring some stuff "const" might help if that's
> an issue.

No, I have not had look at the generated assembly code for this driver
yet, but I'll check it out.

> Ideally the setsck(), setmosi(), and getmiso() calls optimize
> to a couple instructions each, at least inside the I/O loops
> below.  It works that way on some systems, and I'd think it
> might be possible on this one too.

Right.

> > +     /* register the chips to go with the board */
> > +
> > +     for (i = 0; i < sp->info->board_size; i++) {
> > +             dev_info(&dev->dev, "registering %p: %s\n",
> > +                      &sp->info->board_info[i],
> > +                      sp->info->board_info[i].modalias);
> > +
> > +             sp->info->board_info[i].controller_data = sp;
> > +             spi_new_device(master, sp->info->board_info + i);
>
> NO -- this doesn't belong here at all.  Such registration is handled
> by the SPI core code, according to what the board init code told it.

Hehe. My gut reaction was the same when i read the s3c24xx drivers,
but then I decided to follow their style. I'll remove that part then
and instead register the spi devices from the board code using
spi_register_board_info().

I'll fix up the code and repost in a bit. Thanks for your review!

/ magnus
