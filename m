From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] gpio: of: Support SPI nonstandard GPIO properties
Date: Mon, 8 Jan 2018 15:48:14 +0100
Message-ID: <CAMuHMdXnf8yB1HLc7h8QvzopdNOG6xyFY0nJf7-4pbdZC9F4cw@mail.gmail.com>
References: <20180108124909.32334-1-linus.walleij@linaro.org>
 <CAMuHMdWKO5WcLicMdaa7qKj=h-ddzRqNKvmxqVqRhgO9bTENaQ@mail.gmail.com> <CACRpkdbKoLG5WT5qWD_RTe22TVkbg-SF+e1HOWw91TUGBcjGSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbKoLG5WT5qWD_RTe22TVkbg-SF+e1HOWw91TUGBcjGSg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

On Mon, Jan 8, 2018 at 3:40 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jan 8, 2018 at 2:25 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> +/*
>>> + * The SPI GPIO bindings happened before we managed to establish that GPIO
>>> + * properties should be named "foo-gpios" so we have this special kludge for
>>> + * them.
>>> + */
>>> +#if IS_ENABLED(CONFIG_SPI_MASTER)
>>
>> AFAIU, Rob really meant C "if", not CPP "#ifdef", so the code path is always
>> exercised by the compiler.
>
> But that means increased code footprint for everyone and its dog no matter if

Gcc is (usually) smart enough to compile out all code inside "if (0) { ... }".

> they are using regulators or not.

s/regulators/spi/?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
