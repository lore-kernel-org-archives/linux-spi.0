From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Documentation: dt: mtd: replace "nor-jedec" binding with
 "jedec,spi-nor"
Date: Tue, 21 Jul 2015 09:57:21 -0700
Message-ID: <20150721165721.GJ24125@google.com>
References: <1431624773-4165-1-git-send-email-computersforpeace@gmail.com>
 <20150515195541.GL11598@ld-irv-0074>
 <20150518104501.GD3551@leverpostej>
 <20150518183442.GR11598@ld-irv-0074>
 <CAMuHMdUCj2AXk_0mAgRfAStrveHPi=Rp2g-b177zO_ode8NaCw@mail.gmail.com>
 <20150519013415.GV11598@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150519013415.GV11598@ld-irv-0074>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, May 18, 2015 at 06:34:15PM -0700, Brian Norris wrote:
> So how about the following patch? It seems like we'll need to be able to
> ignore useless 'modalias' values in cases like this:
> 
> 	// modalias = "shinynewdevice"
> 	compatible = "myvendor,shinynewdevice", "jedec,spi-nor";
> 
> and also if somebody leaves off the entire shinynewdevice string:
> 
> 	// modalias = "spi-nor"
> 	compatible = "jedec,spi-nor";
> 
> So we rework the spi-nor library to not reject "bad" names, and just
> fall back to autodetection, and we add the .of_match_table to properly
> catch all "jedec,spi-nor".
> 
> Signed-off-by: Brian Norris <computerfsorpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

I realized this conversation ended in essentially an ack from Rafal,
with no other comments. So I've pushed this (with some extra commentary)
to l2-mtd.git. Holler if there are objections.

Thanks,
Brian

> ---
>  drivers/mtd/devices/m25p80.c  | 18 +++++++++++-------
>  drivers/mtd/spi-nor/spi-nor.c |  8 ++++----
>  2 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 3af137f49ac9..30d608775f5a 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -223,8 +223,6 @@ static int m25p_probe(struct spi_device *spi)
>  	 */
>  	if (data && data->type)
>  		flash_name = data->type;
> -	else if (!strcmp(spi->modalias, "spi-nor"))
> -		flash_name = NULL; /* auto-detect */
>  	else
>  		flash_name = spi->modalias;
>  
> @@ -301,19 +299,25 @@ static const struct spi_device_id m25p_ids[] = {
>  	{"w25q128"},	{"w25q256"},	{"cat25c11"},
>  	{"cat25c03"},	{"cat25c09"},	{"cat25c17"},	{"cat25128"},
>  
> -	/*
> -	 * Generic support for SPI NOR that can be identified by the JEDEC READ
> -	 * ID opcode (0x9F). Use this, if possible.
> -	 */
> -	{"spi-nor"},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(spi, m25p_ids);
>  
> +static const struct of_device_id m25p_of_table[] = {
> +	/*
> +	 * Generic compatibility for SPI NOR that can be identified by the
> +	 * JEDEC READ ID opcode (0x9F). Use this, if possible.
> +	 */
> +	{ .compatible = "jedec,spi-nor" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, m25p_of_table);
> +
>  static struct spi_driver m25p80_driver = {
>  	.driver = {
>  		.name	= "m25p80",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = m25p_of_table,
>  	},
>  	.id_table	= m25p_ids,
>  	.probe	= m25p_probe,
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 14a5d2325dac..390d6fa0a53f 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1003,11 +1003,11 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  	if (ret)
>  		return ret;
>  
> -	/* Try to auto-detect if chip name wasn't specified */
> -	if (!name)
> -		id = spi_nor_read_id(nor);
> -	else
> +	if (name)
>  		id = spi_nor_match_id(name);
> +	/* Try to auto-detect if chip name wasn't specified or not found */
> +	if (!id)
> +		id = spi_nor_read_id(nor);
>  	if (IS_ERR_OR_NULL(id))
>  		return -ENOENT;
>  
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
