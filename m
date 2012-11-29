From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] of/spi: Honour "status=disabled" property of device
Date: Thu, 29 Nov 2012 11:11:26 -0600
Message-ID: <50B7973E.20607@gmail.com>
References: <50B715E1.3010501@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	alexander sverdlin <alexander.sverdlin.ext-OYasijW0DpE@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Barry.Song-kQvG35nSl+M@public.gmane.org
To: Alexander Sverdlin <asv-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <50B715E1.3010501-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 11/29/2012 01:59 AM, Alexander Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>
> 
> of/spi: Honour "status=disabled" property of device
> 
> Currently of_register_spi_devices() function registers all SPI devices,
> independetly from their status property in device tree. According to
> "ePAPR 1.1" spec, device should only be registered if there is no
> "status" property, or it has "ok" (or "okay") value (see
> of_device_is_available()). In case of "platform devices",
> of_platform_device_create_pdata() checks for "status" and ensures
> that disabled devices are not pupulated. But such check for SPI buses
> was missing until now. Fix it.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>
> ---

This is under spi, but I've applied with the rest of the series (mdio
and i2c). It all goes to Grant anyway.

BTW, there's a problem that the subject line is duplicated in your
patches. I've fixed that up.

Rob

> --- linux.orig/drivers/spi/spi.c
> +++ linux/drivers/spi/spi.c
> @@ -819,7 +819,7 @@ static void of_register_spi_devices(stru
>  	if (!master->dev.of_node)
>  		return;
>  
> -	for_each_child_of_node(master->dev.of_node, nc) {
> +	for_each_available_child_of_node(master->dev.of_node, nc) {
>  		/* Alloc an spi_device */
>  		spi = spi_alloc_device(master);
>  		if (!spi) {
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 


------------------------------------------------------------------------------
Keep yourself connected to Go Parallel: 
VERIFY Test and improve your parallel project with help from experts 
and peers. http://goparallel.sourceforge.net
