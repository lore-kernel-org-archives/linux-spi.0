From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: ep93xx: Repair SPI CS lookup tables
Date: Sun, 1 Sep 2019 22:16:37 +0200
Message-ID: <CACRpkdaSwkRo2kWUMWNrtcLnT=2o5y9UThFZdmSD62pWairUxA@mail.gmail.com>
References: <20190831180402.10008-1-alexander.sverdlin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        stable <stable@vger.kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190831180402.10008-1-alexander.sverdlin@gmail.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Aug 31, 2019 at 8:05 PM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:

> The actual device name of the SPI controller being registered on EP93xx is
> "spi0" (as seen by gpiod_find_lookup_table()). This patch fixes all
> relevant lookup tables and the following failure (seen on EDB9302):
>
> ep93xx-spi ep93xx-spi.0: failed to register SPI master
> ep93xx-spi: probe of ep93xx-spi.0 failed with error -22
>
> Fixes: 1dfbf334f1236 ("spi: ep93xx: Convert to use CS GPIO descriptors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Sorry for the mistakes and thanks for fixing, much appreciated!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
