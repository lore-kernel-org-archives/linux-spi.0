From: Fabien Lahoudere <fabien.lahoudere-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 1/1] Add devices to spidev device tree compatibility list
Date: Thu, 6 Oct 2016 10:01:30 +0200
Message-ID: <49803380-8bc0-2bfa-1947-e4fcafa15778@collabora.co.uk>
References: <1475230554-5986-1-git-send-email-fabien.lahoudere@collabora.co.uk>
 <CAMuHMdVY78gNfq0FyXTEBxCZy7LqqOL3UqumW9P=46NgW1SASA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVY78gNfq0FyXTEBxCZy7LqqOL3UqumW9P=46NgW1SASA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On 30/09/16 19:35, Geert Uytterhoeven wrote:
> On Fri, Sep 30, 2016 at 12:15 PM, Fabien Lahoudere
> <fabien.lahoudere-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> wrote:
>> Entries are needed in the spidev ID list to configure configure it from a
>> device tree. Add entries for the following devices:
>
>> - "exar,xra1403" : a GPIO expander
>
> Looks like a suitable target for a drivers/gpio/ driver.
> Datasheet available at
> https://www.exar.com/product/interface/bridges/bridging-solutions/spi-gpio-expanders/xra1403
>

Good idea, however we have to measure impact of this change on the project.

Thanks

Fabien

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
