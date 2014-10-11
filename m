From: Karl Beldan <karl.beldan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [v3] spi: orion: support armada extended baud rates
Date: Sat, 11 Oct 2014 16:52:04 +0200
Message-ID: <20141011144857.GA17350@gobelin>
References: <1411910644-7174-1-git-send-email-gerg@uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411910644-7174-1-git-send-email-gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 28/09/14 23:24:04, Greg Ungerer wrote:
> @@ -378,6 +452,10 @@ static int orion_spi_probe(struct platform_device *pdev)
>  	spi = spi_master_get_devdata(master);
>  	spi->master = master;
>  
> +	of_id = of_match_device(orion_spi_of_match_table, &pdev->dev);
> +	devdata = of_id->data;
> +	spi->devdata = devdata;
> +
Won't of_match_device return NULL on non-DT systems, and further
references oops ?
 
Karl
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
