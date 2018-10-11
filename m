From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 09/11] dt-bindings: spi/spi-pxa2xx: Add ready GPIO signal
Date: Thu, 11 Oct 2018 09:26:39 +0200
Message-ID: <CAMuHMdWJ1YN-_HKbXHH_zhJcG23-9ZnXn3hfV=4bPQHbV6No3g@mail.gmail.com>
References: <20181010170936.316862-1-lkundrak@v3.sk> <20181010170936.316862-10-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, quozl@laptop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010170936.316862-10-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Lubomir,

On Wed, Oct 10, 2018 at 7:10 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> This this is used to let the SPI master know that our FIFO is filled and
> we're ready to service a transfer. Only useful in slave mode.
>
> A signal like this is used by an embedded controller on a OLPC XO 1.75
> machine, that happens to be a SPI master.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> @@ -12,6 +12,8 @@ Optional properties:
>  - cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
>    Documentation/devicetree/bindings/spi/spi-bus.txt
>  - spi-slave: Empty property indicating the SPI controller is used in slave mode.
> +- ready-gpio: GPIO used to signal a SPI master that the FIFO is filled

ready-gpios

Documentation/devicetree/bindings/gpio/gpio.txt:
   "GPIO properties named "[<name>-]gpio" are valid and old
    bindings use it, but are only supported for compatibility reasons
and should not
    be used for newer bindings since it has been deprecated."

> +  and we're ready to service a transfer. Only useful in slave mode.
>
>  Child nodes represent devices on the SPI bus
>    See ../spi/spi-bus.txt

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
