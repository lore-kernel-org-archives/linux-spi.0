From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: dw: Correct handling of native chipselect
Date: Thu, 28 Nov 2019 09:40:04 +0100
Message-ID: <CACRpkdbSmk0iDBbfCWpsT6FnU6mzynCknfJ8K95VNRqK6=_XyQ@mail.gmail.com>
References: <20191127153936.29719-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191127153936.29719-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 27, 2019 at 4:39 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> This patch reverts commit 6e0a32d6f376 ("spi: dw: Fix default polarity
> of native chipselect").
>
> The SPI framework always called the set_cs callback with the logic
> level it desired on the chip select line, which is what the drivers
> original handling supported. commit f3186dd87669 ("spi: Optionally
> use GPIO descriptors for CS GPIOs") changed these symantics, but only
> in the case of drivers that also support GPIO chip selects, to true
> meaning apply slave select rather than logic high. This left things in
> an odd state where a driver that only supports hardware chip selects,
> the core would handle polarity but if the driver supported GPIOs as
> well the driver should handle polarity.  At this point the reverted
> change was applied to change the logic in the driver to match new
> system.
>
> This was then broken by commit 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH
> setting when using native and GPIO CS") which reverted the core back
> to consistently calling set_cs with a logic level.
>
> This fix reverts the driver code back to its original state to match
> the current core code. This is probably a better fix as a) the set_cs
> callback is always called with consistent symantics and b) the
> inversion for SPI_CS_HIGH can be handled in the core and doesn't need
> to be coded in each driver supporting it.
>
> Fixes: 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks for looking into this Charles!!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I think we should have all regressions covered with
these two patches.

Yours,
Linus Walleij
