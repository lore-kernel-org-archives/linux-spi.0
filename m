From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: spi-xcomm: Use devm_spi_register_master()
Date: Wed, 04 Dec 2013 12:42:50 +0100
Message-ID: <529F153A.6060402@metafoo.de>
References: <002d01cef0af$5a21f140$0e65d3c0$%han@samsung.com> <003001cef0af$d5c84ce0$8158e6a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <003001cef0af$d5c84ce0$8158e6a0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12/04/2013 06:15 AM, Jingoo Han wrote:
> Use devm_spi_register_master() to make cleanup paths simpler,
> and remove unnecessary remove().
> 
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Looks good, thanks.

Acked-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>

> ---
>  drivers/spi/spi-xcomm.c |   12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
> index 4258c71..24c40b1 100644
> --- a/drivers/spi/spi-xcomm.c
> +++ b/drivers/spi/spi-xcomm.c
> @@ -231,22 +231,13 @@ static int spi_xcomm_probe(struct i2c_client *i2c,
>  	master->dev.of_node = i2c->dev.of_node;
>  	i2c_set_clientdata(i2c, master);
>  
> -	ret = spi_register_master(master);
> +	ret = devm_spi_register_master(&i2c->dev, master);
>  	if (ret < 0)
>  		spi_master_put(master);
>  
>  	return ret;
>  }
>  
> -static int spi_xcomm_remove(struct i2c_client *i2c)
> -{
> -	struct spi_master *master = i2c_get_clientdata(i2c);
> -
> -	spi_unregister_master(master);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id spi_xcomm_ids[] = {
>  	{ "spi-xcomm" },
>  	{ },
> @@ -259,7 +250,6 @@ static struct i2c_driver spi_xcomm_driver = {
>  	},
>  	.id_table	= spi_xcomm_ids,
>  	.probe		= spi_xcomm_probe,
> -	.remove		= spi_xcomm_remove,
>  };
>  module_i2c_driver(spi_xcomm_driver);
>  
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
