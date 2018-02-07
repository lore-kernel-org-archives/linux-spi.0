From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] pinctrl: mcp23s08: spi: Add HW address to gpio_chip.label
Date: Wed, 7 Feb 2018 14:44:19 +0100
Message-ID: <CACRpkdYwQB_6YNpQPc_rhpx=D=_xh-kWnQ+-pXX6ef_LmgYqiA@mail.gmail.com>
References: <cover.1516997103.git.jan.kundrat@cesnet.cz> <03c5ea4d98804e4ea6b0927e5bf103106e438142.1516997103.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-gpio@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>,
        Phil Reid <preid@electromag.com.au>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <03c5ea4d98804e4ea6b0927e5bf103106e438142.1516997103.git.jan.kundrat@cesnet.cz>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 26, 2018 at 8:16 PM, Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz> w=
rote:

> When several devices are sharing one hardware SPI CS, there is no visual
> clue in `lsgpio` or in /sys/kernel/debug/gpio about which one is which
> one. Stuff depends on the enumeration order, and therefore lower chip
> addresses always go first, but that's just an implementation detail.
> This change includes the device-specific address in the debug output:
>
>   gpiochip4: GPIOs 464-479, parent: spi/spi1.1, mcp23s17.2, can sleep:
>   gpiochip3: GPIOs 480-495, parent: spi/spi1.1, mcp23s17.1, can sleep:
>
> Signed-off-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>

Patch applied.

Yours,
Linus Walleij
