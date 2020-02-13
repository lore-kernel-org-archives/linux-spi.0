From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: spidev_test: Check input_tx and input_file first
 after parse options
Date: Thu, 13 Feb 2020 09:26:19 +0100
Message-ID: <CAMuHMdXi4ieMvZY1J8RjuOeR+vKrTmASq-40MK27xutZPv4deQ@mail.gmail.com>
References: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn> <1581567368-8055-2-git-send-email-yangtiezhu@loongson.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Tiezhu Yang <yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1581567368-8055-2-git-send-email-yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Tiezhu,

On Thu, Feb 13, 2020 at 5:17 AM Tiezhu Yang <yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org> wrote:
> It is better to check input_tx and input_file first after parse options.
> Otherwise, it will do some useless operations when both -p and --input
> are selected.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

> --- a/tools/spi/spidev_test.c
> +++ b/tools/spi/spidev_test.c
> @@ -404,6 +404,9 @@ int main(int argc, char *argv[])
>
>         parse_opts(argc, argv);
>
> +       if (input_tx && input_file)
> +               pabort("only one of -p and --input may be selected");
> +

Alternatively, this check could be moved to the end of parse_opts().

>         fd = open(device, O_RDWR);
>         if (fd < 0)
>                 pabort("can't open device");

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
