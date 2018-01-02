From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/5] Rewrite GPIO SPI to use descriptors
Date: Wed, 3 Jan 2018 00:17:07 +0100
Message-ID: <CACRpkdYRJ=jR4B2Ko2P1axwGMKob2vHkY2h8cMc9t9Qi7n52sQ@mail.gmail.com>
References: <20180101133749.29567-1-linus.walleij@linaro.org> <1514918569.26695.151.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1514918569.26695.151.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jan 2, 2018 at 7:42 PM, Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org> wrote:
> On Mon, 2018-01-01 at 14:37 +0100, Linus Walleij wrote:
>> Just as it says, this rewrites the GPIO bit-banged SPI driver to
>> just use GPIO descriptors and pushes the configuration of the GPIO
>> lines down into devices trees and board files.
>
> Any before/after benchmark for speed or code size?

Not really, the main motivation for the change is neither performance
nor object code size, but to get rid of the global GPIO numbers, which
does not scale very well and makes stuff messy. Istead we aim
to make code deal with abstract GPIO handles known as
GPIO descriptors.

The motivation is the same as for moving IRQ numbers to IRQ
descriptors which has been going on for some time: it is easy when
you have just say 64 IRQs or GPIOs. The subsystems were designed
for that. As the number IRQ controllers and GPIO controllers on
a system grows, managing the number space and the hardware
descriptions becomes a pain.

I'd be surprised if either performance or object code size is affected
in a bad way though. I don't have any high-speed SPI devices I can test
really, and loopback would require some special hardware set-up I
don't have.

The last patch in the series remove remnants of an unused mechanism
that seemed to be for performance critical bitbanged SPI, that was never
put to use, I kind of assume noone is really doing performance critical
SPI over GPIO but I've been wrong before.

> Looks like code size is pretty even.

Number of lines yes, readability I would argue is better but it is a matter
of taste. I would hope some bytes have been pushed away from
the core and into the board files (etc) but I could be wrong.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
