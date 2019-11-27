From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: cadence: Correct handling of native chipselect
Date: Wed, 27 Nov 2019 12:59:34 +0100
Message-ID: <CACRpkdah5V7jDMUkDtdOb3RbR6mTsj5zs6g=Sb6KBZFRfme0rQ@mail.gmail.com>
References: <20191126164140.6240-1-ckeepax@opensource.cirrus.com>
 <CACRpkdYc=2vWte+gFp0m6RvWSu=+qT=WWUzag0N1FUBmbSCOOw@mail.gmail.com> <20191127115419.GA10451@ediswmail.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Gregory Clement <gregory.clement@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191127115419.GA10451@ediswmail.ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 27, 2019 at 12:54 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Wed, Nov 27, 2019 at 11:42:47AM +0100, Linus Walleij wrote:
> > On Tue, Nov 26, 2019 at 5:41 PM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > The original patch
> > f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> > came with the assumption that native chip select handler needed
> > was to be converted to always expect a true (1) value to their
> > ->set_cs() callbacks for asserting chip select, and this was one of
> > the drivers augmented to expect that.
> >
>
> Which is fine, I am not greatly invested in either symantics
> of the set_cs callback although if we were changing that we
> should have probably updated the kerneldoc comments for it.
>
> Although I do have a question if that is that case what is the
> expected way to handle the polarity of the chip select? Because
> it seems to me you would end up with each driver checking the
> SPI_CS_HIGH flag in set_cs and doing the invert locally, whereas
> with the pass the logic level system the core can centralise that
> inversion.

I guess I thought it was logical (hah!) that the core provide
a signal that is true if a condition is asserted, and then the
driver decides whether that drives the line low or high.

But just saying that the callback sets the physical level out
to the device works too, so the patch as-is:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

> > As
> > 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
> > essentially undo that semantic change and switches back to
> > the old semantic, all the drivers that were converted to expect
> > a high input to their ->set_cs() callbacks for asserting CS need
> > to be reverted back as well, but that didn't happen.
> >
> > So we need to fix not just cadence but also any other driver setting
> > ->use_gpio_descriptors() and also supplying their own
> > ->set_cs() callback and expecting this behaviour, or the fix
> > will have fixed broken a bunch of drivers.
> >
> > But we are lucky: there aren't many of them.
> > In addition to spi-cadence.c this seems to affect only spi-dw.c
> > and I suppose that is what Gregory was using? Or
> > something else?
> >
>
> I will go do some digging and see what I can find.

Thanks.

Yours,
Linus Walleij
