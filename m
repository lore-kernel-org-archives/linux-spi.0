From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: Delete Atmel AT91 SPI driver
Date: Tue, 4 Sep 2018 14:40:41 +0200
Message-ID: <CACRpkdbd=SQPF0Vi2HP9uAwA27M8a5dZO-r31D5=3j5sjGh+qg@mail.gmail.com>
References: <20180904094922.8131-1-linus.walleij@linaro.org> <20180904121503.GF13888@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904121503.GF13888@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Sep 4, 2018 at 2:15 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 04/09/2018 11:49:22+0200, Linus Walleij wrote:
>
> > This driver depends on the deleted AT91 architecture and cause
> > me headaches from a GPIO point of view. It is unused so delete
> > it.
> >
>
> While AVR32 is gone, AT91 is alive and well.

Gnah sorry guys that's the problem, I mixed up AVR32 and AT91.

Sorry for the screwup :(

OK back to the drawing board, I will work slowly and careful
and try not to do silly mistakes like this.

Yours,
Linus Walleij
