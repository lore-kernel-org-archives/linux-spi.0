From: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: Re: [Nios2-dev] [PATCH] spi: bitbang: Make setup_transfer callback
 optional
Date: Mon, 13 Apr 2015 21:22:49 -0300
Message-ID: <552C5DD9.2030001@vanguardiasur.com.ar>
References: <552B9045.4040709@xelmo.com> <1428919685-14190-1-git-send-email-per.nilsson@xelmo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428919685-14190-1-git-send-email-per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Pelle,

Just some minor nitpicks.

On 04/13/2015 07:08 AM, Pelle Nilsson wrote:
> spi-altera doesn't register this callback, and doesn't have a need for it,
> but currently causes a NULL dereference when callback is called.

This commit needs a Signed-off-by tag.

Also, maybe you can avoid talking about spi-altera in the commit, since
this change is not related to it. Instead you can explain that some SPI
controllers don't register the callback (e.g. spi-altera) and so this
commit makes it optional to prevent a NULL dereference.

You explained in the cover that you are fixing commit 30af9b558a56 so
you probably want to add a Fixes tag (Documentation/SubmittingPatches
explains this procedure). The stable team will use the Fixes tag to
backport the change if needed.

> ---
>  drivers/spi/spi-bitbang.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
> index 5ef6638..d02057d 100644
> --- a/drivers/spi/spi-bitbang.c
> +++ b/drivers/spi/spi-bitbang.c
> @@ -180,7 +180,7 @@ int spi_bitbang_setup(struct spi_device *spi)
>  {
>  	struct spi_bitbang_cs	*cs = spi->controller_state;
>  	struct spi_bitbang	*bitbang;
> -	int			retval;
> +	int			retval = 0;
>  	unsigned long		flags;
>  
>  	bitbang = spi_master_get_devdata(spi->master);
> @@ -197,7 +197,8 @@ int spi_bitbang_setup(struct spi_device *spi)
>  	if (!cs->txrx_word)
>  		return -EINVAL;
>  
> -	retval = bitbang->setup_transfer(spi, NULL);
> +	if (bitbang->setup_transfer)

retval is only used in this scope, so you can declare it only here:

        if (bitbang->setup_transfer) {
                int retval = bitbang->setup_transfer(spi, NULL);
                if (retval < 0)
                        return retval;
        }

> +		retval = bitbang->setup_transfer(spi, NULL);
>  	if (retval < 0)
>  		return retval;
>  
> @@ -295,9 +296,11 @@ static int spi_bitbang_transfer_one(struct spi_master *master,
>  
>  		/* init (-1) or override (1) transfer params */
>  		if (do_setup != 0) {
> -			status = bitbang->setup_transfer(spi, t);
> -			if (status < 0)
> -				break;
> +			if (bitbang->setup_transfer) {
> +				status = bitbang->setup_transfer(spi, t);
> +				if (status < 0)
> +					break;
> +			}
>  			if (do_setup == -1)
>  				do_setup = 0;
>  		}
> 

Other than that, the commit looks good.
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
