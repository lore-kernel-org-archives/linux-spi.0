From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/1] Add devices to spidev device tree compatibility list
Date: Fri, 30 Sep 2016 19:35:34 +0200
Message-ID: <CAMuHMdVY78gNfq0FyXTEBxCZy7LqqOL3UqumW9P=46NgW1SASA@mail.gmail.com>
References: <1475230554-5986-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Fabien Lahoudere <fabien.lahoudere-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1475230554-5986-1-git-send-email-fabien.lahoudere-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Sep 30, 2016 at 12:15 PM, Fabien Lahoudere
<fabien.lahoudere-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> wrote:
> Entries are needed in the spidev ID list to configure configure it from a
> device tree. Add entries for the following devices:

> - "exar,xra1403" : a GPIO expander

Looks like a suitable target for a drivers/gpio/ driver.
Datasheet available at
https://www.exar.com/product/interface/bridges/bridging-solutions/spi-gpio-expanders/xra1403

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
