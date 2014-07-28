From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: orion: fix incorrect handling of cell-index
 DT property
Date: Mon, 28 Jul 2014 08:27:28 +0200
Message-ID: <53D5ED50.2070809@gmail.com>
References: <1406498000-13079-1-git-send-email-thomas.petazzoni@free-electrons.com> <1406498000-13079-2-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406498000-13079-2-git-send-email-thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 07/27/2014 11:53 PM, Thomas Petazzoni wrote:
> In commit f814f9ac5a81 ("spi/orion: add device tree binding"), Device
> Tree support was added to the spi-orion driver. However, this commit
> reads the "cell-index" property, without taking into account the fact
> that DT properties are big-endian encoded.
> 
> Since most of the platforms using spi-orion with DT have apparently
> not used anything but cell-index = <0>, the problem was not
> visible. But as soon as one starts using cell-index = <1>, the problem
> becomes clearly visible, as the master->bus_num gets a wrong value
> (actually it gets the value 0, which conflicts with the first bus that
> has cell-index = <0>).
> 
> This commit fixes that by using of_property_read_u32() to read the
> property value, which does the appropriate endianness conversion when
> needed.
> 
> Fixes: f814f9ac5a81 ("spi/orion: add device tree binding")
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.6+
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

For MVEBU,

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/spi/spi-orion.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> index d018a4a..c206a4a 100644
> --- a/drivers/spi/spi-orion.c
> +++ b/drivers/spi/spi-orion.c
> @@ -346,8 +346,6 @@ static int orion_spi_probe(struct platform_device *pdev)
>  	struct resource *r;
>  	unsigned long tclk_hz;
>  	int status = 0;
> -	const u32 *iprop;
> -	int size;
>  
>  	master = spi_alloc_master(&pdev->dev, sizeof(*spi));
>  	if (master == NULL) {
> @@ -358,10 +356,10 @@ static int orion_spi_probe(struct platform_device *pdev)
>  	if (pdev->id != -1)
>  		master->bus_num = pdev->id;
>  	if (pdev->dev.of_node) {
> -		iprop = of_get_property(pdev->dev.of_node, "cell-index",
> -					&size);
> -		if (iprop && size == sizeof(*iprop))
> -			master->bus_num = *iprop;
> +		u32 cell_index;
> +		if (!of_property_read_u32(pdev->dev.of_node, "cell-index",
> +					  &cell_index))
> +			master->bus_num = cell_index;
>  	}
>  
>  	/* we support only mode 0, and no options */
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
