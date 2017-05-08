From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: use memdup_user
Date: Mon, 8 May 2017 11:28:21 +0200
Message-ID: <CAMuHMdV9sLR9RqHpXFb_ZGMVzUMGaUVBDH3ZF6OH_iUbxWro+w@mail.gmail.com>
References: <df8091d4c64a0d5a7ab0a5989f34552a5eebd15e.1493778999.git.geliangtang@gmail.com>
 <1028812604e64cd8e1ca2e25b119200fdbec2049.1493781496.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geliang Tang <geliangtang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1028812604e64cd8e1ca2e25b119200fdbec2049.1493781496.git.geliangtang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, May 6, 2017 at 5:42 PM, Geliang Tang <geliangtang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Use memdup_user() helper instead of open-coding to simplify the code.
>
> Signed-off-by: Geliang Tang <geliangtang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -325,7 +325,6 @@ static struct spi_ioc_transfer *
>  spidev_get_ioc_message(unsigned int cmd, struct spi_ioc_transfer __user *u_ioc,
>                 unsigned *n_ioc)
>  {
> -       struct spi_ioc_transfer *ioc;
>         u32     tmp;
>
>         /* Check type, command number and direction */
> @@ -342,14 +341,7 @@ spidev_get_ioc_message(unsigned int cmd, struct spi_ioc_transfer __user *u_ioc,
>                 return NULL;
>
>         /* copy into scratch area */
> -       ioc = kmalloc(tmp, GFP_KERNEL);
> -       if (!ioc)
> -               return ERR_PTR(-ENOMEM);
> -       if (__copy_from_user(ioc, u_ioc, tmp)) {

Note that as memdup_user() calls copy_from_user(), it repeats the access_ok()
check already done by spidev_ioctl().

> -               kfree(ioc);
> -               return ERR_PTR(-EFAULT);
> -       }
> -       return ioc;
> +       return memdup_user(u_ioc, tmp);

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
