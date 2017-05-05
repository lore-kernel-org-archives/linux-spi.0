From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: remove unused completion
Date: Fri, 5 May 2017 15:08:45 +0200
Message-ID: <CAMuHMdXu+xfJmW6sReaURUf1kXxpCuO9TzMwv=J0UVeCOWj23Q@mail.gmail.com>
References: <20170505123049.7500-1-kirkseraph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Seraphime Kirkovski <kirkseraph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170505123049.7500-1-kirkseraph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, May 5, 2017 at 2:30 PM, Seraphime Kirkovski
<kirkseraph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> This removes an unused completion from spidev_sync.
>
> It was introduced in
>
>         commit 25d5cb4b0375e ("spi: remove some spidev oops-on-rmmod paths")
>
> and it was no longer used after:
>
>         commit 98d6f47958001 ("spi: spidev: use spi_sync instead of spi_async")
>
> Signed-off-by: Seraphime Kirkovski (Haapie) <kirkseraph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

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
