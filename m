From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device buswidth
Date: Mon, 2 Mar 2020 19:51:29 +0100
Message-ID: <CAMuHMdW7Xu6EzfmVFx1+i1byy3KOS5A+h2GuMb8nkZ+-jD1=BA@mail.gmail.com>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com> <1582903131-160033-2-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1582903131-160033-2-git-send-email-john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi John,

On Fri, Feb 28, 2020 at 4:23 PM John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:
> Currently ACPI firmware description for a SPI device does not have any
> method to describe the data buswidth on the board.
>
> So even through the controller and device may support higher modes than
> standard SPI, it cannot be assumed that the board does - as such, that
> device is limited to standard SPI in such a circumstance.
>
> As a workaround, allow the controller driver supply buswidth override bits,
> which are used inform the core code that the controller driver knows the
> buswidth supported on that board for that device.

Just wondering: can't the controller just override this (e.g. in the .setuup()
callback) without having to touch the generic code?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
