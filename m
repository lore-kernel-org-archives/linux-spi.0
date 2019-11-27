From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: cadence: Correct handling of native chipselect
Date: Wed, 27 Nov 2019 11:42:47 +0100
Message-ID: <CACRpkdYc=2vWte+gFp0m6RvWSu=+qT=WWUzag0N1FUBmbSCOOw@mail.gmail.com>
References: <20191126164140.6240-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191126164140.6240-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Charles!

Thanks for finding this!

On Tue, Nov 26, 2019 at 5:41 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> To fix a regression on the Cadence SPI driver, this patch reverts
> commit 6046f5407ff0 ("spi: cadence: Fix default polarity of native
> chipselect").
>
> This patch was not the correct fix for the issue. The SPI framework
> calls the set_cs line with the logic level it desires on the chip select
> line, as such the old is_high handling was correct. However, this was
> broken by the fact that before commit 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH
> setting when using native and GPIO CS") all controllers that offered
> the use of a GPIO chip select had SPI_CS_HIGH applied, even for hardware
> chip selects. This caused the value passed into the driver to be inverted.
> Which unfortunately makes it look like a logical enable the chip select
> value.
>
> Since the core was corrected to not unconditionally apply SPI_CS_HIGH,
> the Cadence driver, whilst using the hardware chip select, will deselect
> the chip select every time we attempt to communicate with the device,
> which results in failed communications.
>
> Fixes: 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

I kind of get it... I think.

I see it fixes a patch that I was not CC:ed on, which is a bit unfortunate
as it tries to fix something I wrote, but such things happen.

The original patch
f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
came with the assumption that native chip select handler needed
was to be converted to always expect a true (1) value to their
->set_cs() callbacks for asserting chip select, and this was one of
the drivers augmented to expect that.

As
3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
essentially undo that semantic change and switches back to
the old semantic, all the drivers that were converted to expect
a high input to their ->set_cs() callbacks for asserting CS need
to be reverted back as well, but that didn't happen.

So we need to fix not just cadence but also any other driver setting
->use_gpio_descriptors() and also supplying their own
->set_cs() callback and expecting this behaviour, or the fix
will have fixed broken a bunch of drivers.

But we are lucky: there aren't many of them.
In addition to spi-cadence.c this seems to affect only spi-dw.c
and I suppose that is what Gregory was using? Or
something else?

Yours,
Linus Walleij
