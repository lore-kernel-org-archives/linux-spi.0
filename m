From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: Fix compilation warning.
Date: Mon, 5 Jun 2017 15:07:31 +0200
Message-ID: <CAMuHMdU-o1zw5ETY3d7tV4kQ7K5wf4KuPBhZL3akQwiKj3+cHQ@mail.gmail.com>
References: <b6b0d421633c6ea51cdaf3e582f8bebd2034251c.1496664791.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b6b0d421633c6ea51cdaf3e582f8bebd2034251c.1496664791.git.arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Arvind,

On Mon, Jun 5, 2017 at 2:14 PM, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> If CONFIG_OF is disable, it'll through compilation warning.
>
> drivers/spi/spi-davinci.c: In function =E2=80=98spi_davinci_get_pdata=E2=
=80=99:
> drivers/spi/spi-davinci.c:880:2: warning: return makes pointer from integ=
er without a cast [enabled by default]
>   return -ENODEV;
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-davinci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index 2b0805d..93a4009 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -877,7 +877,7 @@ static int spi_davinci_get_pdata(struct platform_devi=
ce *pdev,
>         *spi_davinci_get_pdata(struct platform_device *pdev,
>                 struct davinci_spi *dspi)
>  {
> -       return -ENODEV;
> +       return ERR_PTR(-ENODEV);
>  }
>  #endif

And you don't get a warning for spi_davinci_probe() doing

    int ret;

    ret =3D spi_davinci_get_pdata(pdev, dspi);

?

spi_davinci_get_pdata() returns int if CONFIG_OF, else a pointer.
I guess it always should return int instead.

It's been like this since the function was introduced, in commit
aae7147dfc522062 ("spi/davinci: add OF support for the spi controller").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
