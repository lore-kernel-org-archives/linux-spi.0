From: Naveen Krishna Ch <naveenkrishna.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Remove redundant OOM message in spi.c
Date: Fri, 13 Jun 2014 10:41:26 +0530
Message-ID: <CAHfPSqCw_iyuBi++5TKooAi3YfUaXfwDmrDrq_WfKXUyseQ5Ag@mail.gmail.com>
References: <1402634862-21783-1-git-send-email-sachin.kamat@samsung.com> <1402634862-21783-2-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, spk.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402634862-21783-2-git-send-email-sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Sachin,

On 13 June 2014 10:17, Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Let memory subsystem handle the error logging.
>
> Signed-off-by: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/spi/spi.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index d4f9670b51bc..8bbbba5b6236 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -352,7 +352,6 @@ struct spi_device *spi_alloc_device(struct spi_master *master)
>
>         spi = kzalloc(sizeof(*spi), GFP_KERNEL);
>         if (!spi) {
> -               dev_err(dev, "cannot alloc spi_device\n");
>                 spi_master_put(master);
>                 return NULL;
>         }
> --
> 1.7.9.5
Reviewed-by: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Shine bright,
(: Nav :)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
