From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] MTD: spi-nor: check for short writes in spi_nor_write.
Date: Wed, 20 May 2015 16:38:35 -0700
Message-ID: <20150520233835.GX11598@ld-irv-0074>
References: <cover.1430403750.git.hramrach@gmail.com>
 <50c40ef17ab6566f35ef5a4426bf23567f896db7.1430403750.git.hramrach@gmail.com>
Reply-To: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Alison Chaiken <alison_chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Bean Huo =?utf-8?B?6ZyN5paM5paMIChiZWFuaHVvKQ==?= <beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>,
	"grmoore-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org" <grmoore-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBCZ6PSPVXMNBBANW6SVAKGQECDDE33Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50c40ef17ab6566f35ef5a4426bf23567f896db7.1430403750.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

+ linux-spi, Mark

On Thu, Apr 30, 2015 at 03:38:50PM +0200, Michal Suchanek wrote:
> My SPI controller driver does not support DMA so writes are truncated to
> FIFO size.

Which SPI master driver?

> Check the amount of data actually written by the driver.

I'm not sure if we should just reactively use the retlen, or if we
should be communicating such a limitation via the SPI API. Thoughts?

Brian

> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 42 +++++++++++++++++-------------------------
>  1 file changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 14a5d23..75904b5 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -807,7 +807,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>  	size_t *retlen, const u_char *buf)
>  {
>  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
> -	u32 page_offset, page_size, i;
> +	u32 page_offset, page_remainder, page_size, i;
>  	int ret;
>  
>  	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
> @@ -816,36 +816,28 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>  	if (ret)
>  		return ret;
>  
> -	write_enable(nor);
> -
> -	page_offset = to & (nor->page_size - 1);
> -
> -	/* do all the bytes fit onto one page? */
> -	if (page_offset + len <= nor->page_size) {
> -		nor->write(nor, to, len, retlen, buf);
> -	} else {
> -		/* the size of data remaining on the first page */
> -		page_size = nor->page_size - page_offset;
> -		nor->write(nor, to, page_size, retlen, buf);
> +	/* write everything in nor->page_size chunks */
> +	/* check the size of data actually written */
> +	for (i = 0; i < len; i += *retlen) {
> +		page_size = len - i;
> +		page_offset = (to + i) & (nor->page_size - 1);
> +		page_remainder = nor->page_size - page_offset;
> +		if (page_size > nor->page_size)
> +			page_size = nor->page_size;
> +		if (page_remainder && (page_size > page_remainder))
> +			page_size = page_remainder;
>  
> -		/* write everything in nor->page_size chunks */
> -		for (i = page_size; i < len; i += page_size) {
> -			page_size = len - i;
> -			if (page_size > nor->page_size)
> -				page_size = nor->page_size;
> -
> -			ret = spi_nor_wait_till_ready(nor);
> -			if (ret)
> -				goto write_err;
> +		write_enable(nor);
>  
> -			write_enable(nor);
> +		nor->write(nor, to + i, page_size, retlen, buf + i);
>  
> -			nor->write(nor, to + i, page_size, retlen, buf + i);
> -		}
> +		ret = spi_nor_wait_till_ready(nor);
> +		if (ret)
> +			goto write_err;
>  	}
>  
> -	ret = spi_nor_wait_till_ready(nor);
>  write_err:
> +	*retlen = i;
>  	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_WRITE);
>  	return ret;
>  }
