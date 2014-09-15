From: Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] spi-nor: Remove spi_nor::read_id operation
Date: Mon, 15 Sep 2014 22:55:24 +0800
Message-ID: <20140915145523.GA1963@localhost.localdomain>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714676.3040.40.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410714676.3040.40.camel-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Sep 14, 2014 at 06:11:16PM +0100, Ben Hutchings wrote:
> There is currently no useful way to override the default
> implementation of this operation.  The returned struct spi_device_id
> must have a pointer to struct flash_info in its private data, but this
> structure is defined inside spi-nor.
> 
> Signed-off-by: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 4 +---
>  include/linux/mtd/spi-nor.h   | 3 ---
>  2 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 6b1bda2..6f699c5 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -902,8 +902,6 @@ static int spi_nor_check(struct spi_nor *nor)
>  		return -EINVAL;
>  	}
>  
> -	if (!nor->read_id)
> -		nor->read_id = spi_nor_read_id;
>  	if (!nor->wait_till_ready)
>  		nor->wait_till_ready = spi_nor_wait_till_ready;
>  
> @@ -952,7 +950,7 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
>  	if (info->jedec_id) {
>  		const struct spi_device_id *jid;
>  
> -		jid = nor->read_id(nor);
> +		jid = spi_nor_read_id(nor);
>  		if (IS_ERR(jid)) {
>  			return PTR_ERR(jid);
>  		} else if (jid != id) {
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 5ec84cc..66af67a 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -139,8 +139,6 @@ enum spi_nor_ops {
>   * @write_xfer:		[OPTIONAL] the writefundamental primitive
>   * @read_reg:		[DRIVER-SPECIFIC] read out the register
>   * @write_reg:		[DRIVER-SPECIFIC] write data to the register
> - * @read_id:		[REPLACEABLE] read out the ID data, and find
> - *			the proper spi_device_id
If we remove this hook, i guess we will add it back in the later.
Other new drivers will use this hook.

so i suggest to keep it as it is.

thanks
Huang Shijie
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
