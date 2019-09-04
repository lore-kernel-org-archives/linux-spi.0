From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] gpiolib: of: fix fallback quirks handling
Date: Wed, 4 Sep 2019 15:34:20 +0300
Message-ID: <20190904123420.GK2680@smile.fi.intel.com>
References: <20190903231856.GA165165@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903231856.GA165165@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Sep 03, 2019 at 04:18:56PM -0700, Dmitry Torokhov wrote:
> We should only try to execute fallback quirks handling when previous
> call returned -ENOENT, and not when we did not get -EPROBE_DEFER.
> The other errors should be treated as hard errors: we did find the GPIO
> description, but for some reason we failed to handle it properly.
> 
> The fallbacks should only be executed when previous handlers returned
> -ENOENT, which means the mapping/description was not found.
> 
> Also let's remove the explicit deferral handling when iterating through
> GPIO suffixes: it is not needed anymore as we will not be calling
> fallbacks for anything but -ENOENT.
> 

I would rather leave extra parenthesis and comments untouched,
nevertheless, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: df451f83e1fc ("gpio: of: fix Freescale SPI CS quirk handling")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/gpio/gpiolib-of.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index b034abe59f28..b45b39c48a34 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -457,36 +457,27 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
>  
>  		desc = of_get_named_gpiod_flags(dev->of_node, prop_name, idx,
>  						&of_flags);
> -		/*
> -		 * -EPROBE_DEFER in our case means that we found a
> -		 * valid GPIO property, but no controller has been
> -		 * registered so far.
> -		 *
> -		 * This means we don't need to look any further for
> -		 * alternate name conventions, and we should really
> -		 * preserve the return code for our user to be able to
> -		 * retry probing later.
> -		 */
> -		if (IS_ERR(desc) && PTR_ERR(desc) == -EPROBE_DEFER)
> -			return desc;
>  
> -		if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
> +		if (!IS_ERR(desc) || PTR_ERR(desc) != -ENOENT)
>  			break;
>  	}
>  
> -	/* Special handling for SPI GPIOs if used */
> -	if (IS_ERR(desc))
> +	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT) {
> +		/* Special handling for SPI GPIOs if used */
>  		desc = of_find_spi_gpio(dev, con_id, &of_flags);
> -	if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER) {
> +	}
> +
> +	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT) {
>  		/* This quirk looks up flags and all */
>  		desc = of_find_spi_cs_gpio(dev, con_id, idx, flags);
>  		if (!IS_ERR(desc))
>  			return desc;
>  	}
>  
> -	/* Special handling for regulator GPIOs if used */
> -	if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER)
> +	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT) {
> +		/* Special handling for regulator GPIOs if used */
>  		desc = of_find_regulator_gpio(dev, con_id, &of_flags);
> +	}
>  
>  	if (IS_ERR(desc))
>  		return desc;
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
> 
> -- 
> Dmitry

-- 
With Best Regards,
Andy Shevchenko
