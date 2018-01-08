From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] gpio: of: Support SPI nonstandard GPIO properties
Date: Mon, 8 Jan 2018 15:40:47 +0100
Message-ID: <CACRpkdbKoLG5WT5qWD_RTe22TVkbg-SF+e1HOWw91TUGBcjGSg@mail.gmail.com>
References: <20180108124909.32334-1-linus.walleij@linaro.org> <CAMuHMdWKO5WcLicMdaa7qKj=h-ddzRqNKvmxqVqRhgO9bTENaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWKO5WcLicMdaa7qKj=h-ddzRqNKvmxqVqRhgO9bTENaQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 8, 2018 at 2:25 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>> +/*
>> + * The SPI GPIO bindings happened before we managed to establish that GPIO
>> + * properties should be named "foo-gpios" so we have this special kludge for
>> + * them.
>> + */
>> +#if IS_ENABLED(CONFIG_SPI_MASTER)
>
> AFAIU, Rob really meant C "if", not CPP "#ifdef", so the code path is always
> exercised by the compiler.

But that means increased code footprint for everyone and its dog no matter if
they are using regulators or not.

If people think that the #ifdeffery is such a horrible ugliness I can create
gpiolib-of-spi.c and compile it conditionally and put the ifdefs for
stubs in gpiolib-of-spi.h but I just think it is a bit over the top for a single
function like this.

Yours,
Linus Walleij
