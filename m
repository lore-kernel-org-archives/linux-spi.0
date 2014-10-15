From: Karl Beldan <karl.beldan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [v3] spi: orion: support armada extended baud rates
Date: Wed, 15 Oct 2014 15:10:54 +0200
Message-ID: <20141015131054.GA3243@gobelin>
References: <20141011144857.GA17350@gobelin>
 <543C8460.1060508@uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <543C8460.1060508-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Oct 14, 2014 at 12:03:12PM +1000, Greg Ungerer wrote:
> Hi Karl,
> 
> On 12/10/14 00:52, Karl Beldan wrote:
> > On 28/09/14 23:24:04, Greg Ungerer wrote:
> >> @@ -378,6 +452,10 @@ static int orion_spi_probe(struct platform_device *pdev)
> >>  	spi = spi_master_get_devdata(master);
> >>  	spi->master = master;
> >>  
> >> +	of_id = of_match_device(orion_spi_of_match_table, &pdev->dev);
> >> +	devdata = of_id->data;
> >> +	spi->devdata = devdata;
> >> +
> > Won't of_match_device return NULL on non-DT systems, and further
> > references oops ?
> 
> Yes, sure enough.
> 
> So I propose to fix with this change.
> 
> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> index acf8e48..c069ccd 100644
> --- a/drivers/spi/spi-orion.c
> +++ b/drivers/spi/spi-orion.c
> @@ -453,7 +453,7 @@ static int orion_spi_probe(struct platform_device *pdev)
>         spi->master = master;
>  
>         of_id = of_match_device(orion_spi_of_match_table, &pdev->dev);
> -       devdata = of_id->data;
> +       devdata = (of_id) ? of_id->data : &orion_spi_dev_data;
>         spi->devdata = devdata;
>  
I am not aware of the policy in the DT subsystem, I see some drivers
bailing out when not getting any match, some remove non-DT support and
add a dependency on OF, yet a message would feel appropriate.
Other than that ok, it should fix df59fa7f4bca.
 
Karl
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
