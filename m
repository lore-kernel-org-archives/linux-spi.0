From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpiolib: of: fix fallback quirks handling
Date: Tue, 10 Sep 2019 11:33:32 +0100
Message-ID: <CACRpkdYrSt7R8tA+zfN21DZpkz=1KaV5QihzHw7-KPCrUZhA-Q@mail.gmail.com>
References: <20190903231856.GA165165@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903231856.GA165165@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 4, 2019 at 12:18 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> We should only try to execute fallback quirks handling when previous
> call returned -ENOENT, and not when we did not get -EPROBE_DEFER.
> The other errors should be treated as hard errors: we did find the GPIO
> description, but for some reason we failed to handle it properly.
>
> The fallbacks should only be executed when previous handlers returned
> -ENOENT, which means the mapping/description was not found.
>
> Also let's remove the explicit deferral handling when iterating through
> GPIO suffixes: it is not needed anymore as we will not be calling
> fallbacks for anything but -ENOENT.
>
> Fixes: df451f83e1fc ("gpio: of: fix Freescale SPI CS quirk handling")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Patch applied with Andy's review tag.

Sorry for not catching this before, the reasoning with the patch
is correct and I should have noticed. Overload I guess.

Yours,
Linus Walleij
