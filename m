From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: allocate spi_board_info entries one by one
Date: Mon, 27 Feb 2017 20:11:34 -0800
Message-ID: <20170228041134.GA9838@dtor-ws>
References: <20170228040848.9447-1-dmitry.torokhov@gmail.com>
 <20170228040848.9447-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170228040848.9447-2-dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Feb 27, 2017 at 08:08:47PM -0800, Dmitry Torokhov wrote:
> Lists of spi_board_info entries registered with spi_register_board_info()
> can be quite long; instead of forcing memory allocator find contagious
> chunk of memory, let;s allocate them one-by-one, so they can be packed as
> needed.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index b948d8cdbace..029864410a5f 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -686,14 +686,13 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
>  	if (!n)
>  		return -EINVAL;
>  
> -	bi = kzalloc(n * sizeof(*bi), GFP_KERNEL);
> -	if (!bi)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < n; i++, bi++, info++) {
> +	for (i = 0; i < n; i++, info++) {
>  		struct spi_master *master;
>  
> -		memcpy(&bi->board_info, info, sizeof(*info));
> +		bi = kmemdup(info, sizeof(*bi), GFP_KERNEL);

Meh, should not have changed to kmemdup at the 11th hour: different
types. I'll send v2 in a minute.

> +		if (!bi)
> +			return -ENOMEM;
> +
>  		bi->board_info.properties =
>  			property_entries_dup(info->properties);
>  		if (IS_ERR(bi->board_info.properties))
> -- 
> 2.11.0.483.g087da7b7c-goog
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
