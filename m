From: Jeremiah Mahler <jmmahler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: 0002-Spi-spi-gpio-fixed-spaces-coding-style-issue.patch
Date: Sat, 3 Jan 2015 18:00:39 -0800
Message-ID: <20150104020039.GA15893@hudson.localdomain>
References: <20150103195740.GB20435@suse.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nizam Haider <nizamhaider786-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150103195740.GB20435-75nwtSnco8WzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Nizam,

You made a lot of mistakes in this patch submission :(

Specifically, you should never include a patch as an attachment [2],
and your subject line should say [PATCH] [2].

If you want to learn how to correctly submit patches I recommend
watching this [1], reading this [2], and signing up for this [3].

  [1]: https://www.youtube.com/watch?v=LLBrBBImJt4

  [2]: https://www.kernel.org/doc/Documentation/SubmittingPatches

  [3]: http://www.eudyptula-challenge.org/

On Sun, Jan 04, 2015 at 01:27:40AM +0530, Nizam Haider wrote:
> 
> From 00454f12a304489125bbdfbc2f50de3c2b9d49d3 Mon Sep 17 00:00:00 2001
> From: Nizam Haider <nizamhaider786-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Date: Sun, 4 Jan 2015 00:24:38 +0530
> Subject: [PATCH 2/2] Spi: spi-gpio: fixed spaces coding style issue
> 
> Fixed a coding style issue.
> 
> Signed-off-by: Nizam Haider <nizamhaider786-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-gpio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
> index aee4e75..702b0b8 100644
> --- a/drivers/spi/spi-gpio.c
> +++ b/drivers/spi/spi-gpio.c
> @@ -92,7 +92,7 @@ struct spi_gpio {
>  
>  /*----------------------------------------------------------------------*/
>  
> -static inline struct spi_gpio * __pure
> +static inline struct spi_gpio *__pure
>  spi_to_spi_gpio(const struct spi_device *spi)
>  {
>  	const struct spi_bitbang	*bang;
> @@ -103,7 +103,7 @@ spi_to_spi_gpio(const struct spi_device *spi)
>  	return spi_gpio;
>  }
>  
> -static inline struct spi_gpio_platform_data * __pure
> +static inline struct spi_gpio_platform_data *__pure
>  spi_to_pdata(const struct spi_device *spi)
>  {
>  	return &spi_to_spi_gpio(spi)->pdata;
> -- 
> 1.8.1.4
> 


-- 
- Jeremiah Mahler
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
