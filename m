From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [spi-devel-general] [PATCH 1/2] spi/spi_s3c64xx: Make probe
	more robust against missing board config
Date: Sat, 21 Aug 2010 11:08:56 +0100
Message-ID: <20100821100855.GA5545@opensource.wolfsonmicro.com>
References: <1282321028-32196-1-git-send-email-broonie@opensource.wolfsonmicro.com> <AANLkTimggbZqgv=eKe+wx8YvUX5vOppDfmwpLwTgxJFM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimggbZqgv=eKe+wx8YvUX5vOppDfmwpLwTgxJFM@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Aug 21, 2010 at 10:45:56AM +0900, Jassi Brar wrote:
> On Sat, Aug 21, 2010 at 1:17 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > The S3C64xx SPI driver requires the machine to call s3c64xx_spi_set_info()
> > to select a few options, including the clock to use for the SPI controller.
> > If this is not done then a NULL will be passed as the clock name for
> > clk_get(), causing an obscure crash. Guard against this and other missing
> > configuration by validating that the clock name has been filled in in
> > the platform data that ets passed in.

>      The movement of sci assignment and check doesn't make any
> difference because
>       we already check for presence of platform_data and DMA-Tx,Rx and
> IO base is
>       set irrespective of calling s3c64xx_spi_set_info()

While it does check for those things for at least the 6410 they're all
unconditionally set up by dev-spi.c so the tests all pass and we make it
down into to the clk_get() which then falls over horribly.

>     Also, I think !sci->num_cs might be an even better check because
> the samsung clock
>    api might be changed (IIRC Ben was already working it out) to make
> it redundant
>    to pass clock name strings to clk_get. If that is the case, we might end up
>    adding another foolproof check like !sci->num_cs

The problem with num_cs is that it gets interpreted by a custom function
provided by the board driver so we really can't say anything about what
it does.  If the clock API gets enhanced then we can always cope with
things then, but given the pace of development there I'd expect that
we'd need to continue checking for a while.

TBH I'm a bit surprised that the driver has to do custom stuff to
support gpiolib chip selects - my first thought when I saw that stuff
was that it seemed like something that lots of SPI controllers would be
able to share but I didn't look at the overall SPI code for long enough
to figure out what was going on there.
