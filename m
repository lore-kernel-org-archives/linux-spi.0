From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCHv2 1/2] Documentation: dt: spi: Add GPIO Slave Select Parameter
Date: Fri, 7 Oct 2016 21:33:15 +0200
Message-ID: <CAMuHMdXuJbc+smiY8DNMYHiCuOxtt44o2N0eJvzq+FKUoZm+Rg@mail.gmail.com>
References: <1475852194-27690-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        jszhang@marvell.com, michael@smart-africa.com, kernel@mseidel.net,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: tthayer@opensource.altera.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475852194-27690-1-git-send-email-tthayer@opensource.altera.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 7, 2016 at 4:56 PM,  <tthayer@opensource.altera.com> wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
>
> Some SPI masters require the slave to be selected before a
> transaction can occur - even in the case of GPIO chip select.
>
> This patch adds a GPIO slave select parameter to indicate
> the slave needs to be selected in the GPIO CS case.
>
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2  Add to SPI framework - add bindings.
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> index 4b1d6e7..3a006bc 100644
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> @@ -24,6 +24,7 @@ support describing the chip select layout.
>  Optional properties:
>  - cs-gpios       - gpios chip select.
>  - num-cs         - total number of chipselects.
> +- gpio-ss        - use internal slave select with gpio chip select.
>
>  If cs-gpios is used the number of chip selects will be increased automatically
>  with max(cs-gpios > hw cs).

To me, this looks more like a new flag the SPI controller driver should
set in spi_master.flags, instead of a DT property.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
