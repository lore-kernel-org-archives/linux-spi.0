From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi/dln2: Fix for PM_RUNTIME removal
Date: Mon, 29 Dec 2014 16:03:40 +0100
Message-ID: <CAMuHMdUeD4dFAxCgK8JO9MS_BCruCJk4AZ29Qr77XpfcgVpnRg@mail.gmail.com>
References: <1419294557-10632-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1419294557-10632-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Tue, Dec 23, 2014 at 1:29 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/spi/spi-dln2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
> index 7b35454..cede063 100644
> --- a/drivers/spi/spi-dln2.c
> +++ b/drivers/spi/spi-dln2.c
> @@ -850,7 +850,7 @@ static int dln2_spi_resume(struct device *dev)
>  }
>  #endif /* CONFIG_PM_SLEEP */
>
> -#ifdef CONFIG_PM_RUNTIME
> +#ifdef CONFIG_PM
>  static int dln2_spi_runtime_suspend(struct device *dev)
>  {
>         struct spi_master *master = dev_get_drvdata(dev);

You forgot to update the comment for the corresponding #endif a few
lines below:

        #endif /* CONFIG_PM_RUNTIME */

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
