From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: spi: tests driver to test basic alignment/length issues via loopback
Date: Thu, 26 Nov 2015 10:32:43 +0100
Message-ID: <CAMuHMdVpds0hOD=4uh1ZA+pfk9wHQJiuJodgXJDG0VcmYRXkeQ@mail.gmail.com>
References: <753FCC7B-67D9-495B-A6C1-D49793502C90@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <753FCC7B-67D9-495B-A6C1-D49793502C90-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Martin,

On Wed, Nov 25, 2015 at 7:56 PM, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
> So I had to write a small test driver that allows for generate all sorts
> of spi_messages with different length, rx/tx_buf alignments and more to
> get generated - right now it submits something like 360 distinct
> spi_messages:

Thanks!

> * transfers starting on a page with rx and tx_buf set
>   * length: 1, 16, 32, 64, 128, 256, 1024, 4096, 128k

I think you should add a few lengths that are not powers of two
(e.g. prime numbers).

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
