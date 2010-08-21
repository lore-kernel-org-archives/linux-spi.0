From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [spi-devel-general] [PATCH 1/2] spi/spi_s3c64xx: Make probe
	more robust against missing board config
Date: Sat, 21 Aug 2010 20:30:15 +0100
Message-ID: <20100821193015.GA16455@opensource.wolfsonmicro.com>
References: <1282321028-32196-1-git-send-email-broonie@opensource.wolfsonmicro.com> <AANLkTimggbZqgv=eKe+wx8YvUX5vOppDfmwpLwTgxJFM@mail.gmail.com> <20100821100855.GA5545@opensource.wolfsonmicro.com> <AANLkTikbGR4wWUEHjR74UFu8P-w9us3ZpKgmG+yDukfC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikbGR4wWUEHjR74UFu8P-w9us3ZpKgmG+yDukfC@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Aug 21, 2010 at 10:58:36PM +0900, Jassi Brar wrote:
> On Sat, Aug 21, 2010 at 7:08 PM, Mark Brown
> > On Sat, Aug 21, 2010 at 10:45:56AM +0900, Jassi Brar wrote:

> >> =A0 =A0 =A0The movement of sci assignment and check doesn't make a=
ny
> >> difference because
> >> =A0 =A0 =A0 we already check for presence of platform_data and DMA=
-Tx,Rx and
> >> IO base is
> >> =A0 =A0 =A0 set irrespective of calling s3c64xx_spi_set_info()

> > While it does check for those things for at least the 6410 they're =
all
> > unconditionally set up by dev-spi.c so the tests all pass and we ma=
ke it
> > down into to the clk_get() which then falls over horribly.

> Those parameters are SoC specific and hence will be always available =
to
> platform devices.
> Clock selection and num_cs(number of slaves attached to the SPI bus) =
are
> machine specific and hence responsibility of the machine developer to
> set appropriately via s3c64xx_spi_set_info()

Sure, the split does make sense - it's just that this means that we nee=
d
to do something to make sure that s3c64xx_spi_set_info() got called.

> > The problem with num_cs is that it gets interpreted by a custom fun=
ction
> > provided by the board driver so we really can't say anything about =
what
> > it does.

> num_cs is passed on as such to the SPI core to master->num_chipselect
> which is strictly checked for before a master is created.

Ah, too many variables with similar functions.

> > support gpiolib chip selects - my first thought when I saw that stu=
ff
> > was that it seemed like something that lots of SPI controllers woul=
d be
> > able to share but I didn't look at the overall SPI code for long en=
ough
> > to figure out what was going on there.

> we have common spi bitbanging driver that takes only four gpio pins
> and work like a charm.

Though it does burn CPU rather a lot which makes them unsuitable for
some applications where SPI is used for bulk data transfers or CPU is
otherwise tight.  In general if you've got an actual SPI controller it'=
s
much nicer to use it.

> In order to enable users use multiple CS per master, in spi_s3c64xx.c
> the single CS feature provided by the controller is deliberately left=
 unused
> and the driver accepts a gpio per slave and manually controls it. Tho=
ugh
> the callbacks and arguments are designed so that a simple gpio number
> and gpio_set can be assigned by the machine code.

It did occur to me that a nice way of dealing with this would be to hav=
e
the driver default to using the built in chip select (even if driven as
a GPIO for the sake of code simplicity) but leave the current method
there as an override.  That way if people are using the IP block in the
"natural" manner they'd have less to set up.
