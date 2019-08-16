From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: of: fix Freescale SPI CS quirk handling
Date: Sat, 17 Aug 2019 00:29:14 +0200
Message-ID: <CACRpkdaVHPFgw9g8D=zrYECO5Syk1kMT3VgL+wq2ebKQxg_FGA@mail.gmail.com>
References: <20190816165000.32334-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
To: Andreas Kemnade <andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816165000.32334-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Aug 16, 2019 at 6:50 PM Andreas Kemnade <andreas@kemnade.info> wrote:

> On the gta04 we see:
> spi_gpio: probe of spi_lcd failed with error -2
>
> The quirk introduced in
> commit e3023bf80639 ("gpio: of: Handle the Freescale SPI CS")
> can also be triggered by a temporary -EPROBE_DEFER and
> so "convert" it to a hard -ENOENT.
>
> Disable that conversion by checking for -EPROBE_DEFER.
>
> Fixes: e3023bf80639 ("gpio: of: Handle the Freescale SPI CS")
> Suggested-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Good catch! Patch applied for fixes.

Yours,
Linus Walleij
