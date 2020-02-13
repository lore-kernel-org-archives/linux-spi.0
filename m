From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: spidev_test: Remove break after exit statement
Date: Thu, 13 Feb 2020 09:23:12 +0100
Message-ID: <CAMuHMdWEUkdMWFDRt3G_HQTAMpnbrmFdBd8jcH4oAhtMoYch-g@mail.gmail.com>
References: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Tiezhu Yang <yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1581567368-8055-1-git-send-email-yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Feb 13, 2020 at 5:17 AM Tiezhu Yang <yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org> wrote:
> When call print_usage() in parse_opts(), it will exit directly.
> Since break is not useful after exit statement, remove it.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
