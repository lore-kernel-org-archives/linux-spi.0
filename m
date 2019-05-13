From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Applied "dt-bindings: mfd: atmel-usart: add DMA bindings for
 USART in SPI mode" to the spi tree
Date: Mon, 13 May 2019 09:04:54 +0200
Message-ID: <CAMuHMdUOwff68bSjvG3vo5+HUjtRCNXLbAiUc7et4m+yfSCoFA@mail.gmail.com>
References: <20190505180646.1442-2-radu_nicolae.pirea@upb.ro>
 <20190508090857.B7CB344003F@finisterre.sirena.org.uk> <20190508105105.GN3995@dell>
 <20190512075223.GF21483@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190512075223.GF21483@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Sun, May 12, 2019 at 7:05 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 08, 2019 at 11:51:05AM +0100, Lee Jones wrote:
> > > Signed-off-by: Mark Brown <broonie@kernel.org>
> > > ---
> > >  .../devicetree/bindings/mfd/atmel-usart.txt   | 20 ++++++++++++++-----
>
> > Interesting!
>
> For some reason the bindings for the SPI function got put in the MFD
> directory, dunno why.

Because this is a block that can do either SPI or USART, hence MFD?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
