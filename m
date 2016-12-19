From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH/RFC v2 3/7] spi: core: Add support for registering SPI
 slave controllers
Date: Mon, 19 Dec 2016 11:02:07 +0100
Message-ID: <CAMuHMdXJu0-iTFu3KMWXbbgidB63Mxy0oAWmTKKt0UUKuPbprA@mail.gmail.com>
References: <1473713446-30366-1-git-send-email-geert+renesas@glider.be>
 <1473713446-30366-4-git-send-email-geert+renesas@glider.be> <20161215175326.tbblqe7kto2qgxwz@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
        Hisashi Nakamura <hisashi.nakamura.ak-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161215175326.tbblqe7kto2qgxwz-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Thu, Dec 15, 2016 at 6:53 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Sep 12, 2016 at 10:50:42PM +0200, Geert Uytterhoeven wrote:
>> TBD:
>>   - s/spi_master/spi_controller/ where appropriate,
>>   - Provide wrappers (e.g. "#define spi_master spi_controller" until all
>>     SPI drivers have been converted),
>>   - Do we want a separate spi_register_slave() instead?
>
> This basically looks fine to me - there's these TBDs so I might be
> missing things and we probably need some GPIO chip select handling but

Given the hard real-time requirements of SPI slave, supporting GPIO chip
select may not be feasible.

> that's a separate thing.  Sorry it took me so long to review this.

Thanks for the review!

As I managed to fix the issue with spi_slave_abort() on MSIOF, I think
the remaining
obstacle is the DT binding.  Do you have any feedback or other
suggestions in that area?

IMHO having the ability to bind to an SPI slave handler either from DT or
by using the sysfs virtual file is useful to have.

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
