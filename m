From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: rspi: Add configuration for LSB/MSB
Date: Tue, 18 Feb 2020 11:56:52 +0100
Message-ID: <CAMuHMdXQvjWDNh+qogw+3a4=U97rq_GPnYYJNqHiDZNPWJU4sA@mail.gmail.com>
References: <1554282541-8952-1-git-send-email-na-hoan@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        =?UTF-8?B?56iy5ZCJ?= <h-inayoshi-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>,
        =?UTF-8?B?44Kr44Kq44O744O044Kh44Oz44O744OJ44Oz?=
        <cv-dong-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
To: Nguyen An Hoan <na-hoan-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1554282541-8952-1-git-send-email-na-hoan-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Hoan-san,

On Wed, Apr 3, 2019 at 11:09 AM Nguyen An Hoan <na-hoan-HEF513clHfp3+QwDJ9on6Q@public.gmane.org> wrote:
> From: Hoan Nguyen An <na-hoan-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
>
> SPI controllers can support LSB or MSB depending on
> the structure of the message that Slave requires,
> Add support.
>
> Signed-off-by: Hoan Nguyen An <na-hoan-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>

Thanks for your patch!

> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -950,6 +950,8 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
>                 rspi->spcmd |= SPCMD_CPOL;
>         if (spi->mode & SPI_CPHA)
>                 rspi->spcmd |= SPCMD_CPHA;
> +       if (spi->mode & SPI_LSB_FIRST)
> +               rspi->spcmd |= SPCMD_LSBF;
>
>         /* CMOS output mode and MOSI signal from previous transfer */
>         rspi->sppcr = 0;

Unfortunately this is not sufficient.  The driver should also inform the
SPI core that it supports this flag. Will fix.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
