From: Han Xu <han.xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v6 06/10] mtd: spi-nor: simplify write loop
Date: Tue, 15 Dec 2015 14:22:17 -0600
Message-ID: <20151215202216.GA11742@chopperman.am.freescale.net>
References: <cover.1449052427.git.hramrach@gmail.com>
 <2236d87ad516f118f58eb5df232d441f970c4499.1449052427.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Bean Huo <beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>,
	Furquan Shaikh <furquan-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2236d87ad516f118f58eb5df232d441f970c4499.1449052427.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Dec 02, 2015 at 10:38:20AM +0000, Michal Suchanek wrote:
> The spi-nor write loop assumes that what is passed to the hardware
> driver write() is what gets written.
> 
> When write() writes less than page size at once data is dropped on the
> floor. Check the amount of data writen and exit if it does not match
> requested amount.
> 
> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> ---
> 
>  - add warning when writing incomplete pages
>  - refuse to continue writing when full page was not written
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 58 +++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 3d02803..115c123 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1005,8 +1005,8 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>  	size_t *retlen, const u_char *buf)
>  {
>  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
> -	u32 page_offset, page_size, i;
> -	int ret;
> +	size_t page_offset, page_remain, i;
> +	ssize_t ret;
>  
>  	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
>  
> @@ -1014,45 +1014,37 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>  	if (ret)
>  		return ret;
>  
> -	write_enable(nor);
> -
> -	page_offset = to & (nor->page_size - 1);
> +	for (i = 0; i < len; ) {
> +		ssize_t written;
>  
> -	/* do all the bytes fit onto one page? */
> -	if (page_offset + len <= nor->page_size) {
> -		ret = nor->write(nor, to, len, buf);
> -		if (ret < 0)
> -			goto write_err;
> -		*retlen += ret;
> -	} else {
> +		page_offset = to & (nor->page_size - 1);
> +		WARN_ONCE(page_offset,
> +			  "Writing at offset %zu into a NOR page. Writing partial pages may decrease reliability and increase wear of NOR flash.",
> +			  page_offset);
>  		/* the size of data remaining on the first page */
> -		page_size = nor->page_size - page_offset;
> -		ret = nor->write(nor, to, page_size, buf);
> +		page_remain = min_t(size_t,
> +				    nor->page_size - page_offset, len - i);
> +
> +		write_enable(nor);
> +		ret = nor->write(nor, to + i, page_remain, buf + i);

Previous implementation was trying to write nor->page_size byte data in
each loop, except the first and last loop, if possible. But this change
may write only (nor->page_size - page_offset) in each loop, for the
worst case, if page_offset equals nor->page_size -1, it writes byte by
byte.

>  		if (ret < 0)
>  			goto write_err;
> -		*retlen += ret;
> -
> -		/* write everything in nor->page_size chunks */
> -		for (i = ret; i < len; ) {
> -			page_size = len - i;
> -			if (page_size > nor->page_size)
> -				page_size = nor->page_size;
> -
> -			ret = spi_nor_wait_till_ready(nor);
> -			if (ret)
> -				goto write_err;
> +		written = ret;
>  
> -			write_enable(nor);
> -
> -			ret = nor->write(nor, to + i, page_size, buf + i);
> -			if (ret < 0)
> -				goto write_err;
> -			*retlen += ret;
> -			i += ret;
> +		ret = spi_nor_wait_till_ready(nor);
> +		if (ret)
> +			goto write_err;
> +		*retlen += written;
> +		i += written;
> +		if (written != page_remain) {
> +			dev_err(nor->dev,
> +				"While writing %zu bytes written %zd bytes\n",
> +				page_remain, written);
> +			ret = -EIO;
> +			goto write_err;
>  		}
>  	}
>  
> -	ret = spi_nor_wait_till_ready(nor);
>  write_err:
>  	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_WRITE);
>  	return ret;
> -- 
> 2.6.2
> 

-- 
Best Regards,

Han "Allen" Xu

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
