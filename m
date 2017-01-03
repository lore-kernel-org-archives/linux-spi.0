From: "Langer, Thomas" <thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] SPI: make falcon-spi bool
Date: Tue, 3 Jan 2017 18:52:52 +0000
Message-ID: <0DAF21CFE1B20740AE23D6AF6E54843F1E6BB984@IRSMSX101.ger.corp.intel.com>
References: <20170103170427.26120-1-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "Mehrtens, Hauke" <hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        "john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org" <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170103170427.26120-1-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> -----Original Message-----
> From: Hauke Mehrtens [mailto:hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org]
> Sent: Tuesday, January 3, 2017 6:04 PM
> To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mehrtens, Hauke <hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>;
> Langer, Thomas <thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org; Hauke Mehrtens
> <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
> Subject: [PATCH] SPI: make falcon-spi bool
> 
> Falcon spi accesses some ebu functions which are not exported and can
> not be accessed when build as module. Make this module bool instead.
> 
> Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>

Acked-by: Thomas Langer <thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/spi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 1abba53c2334..c8356437c512 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -263,7 +263,7 @@ config SPI_EP93XX
>  	  mode.
> 
>  config SPI_FALCON
> -	tristate "Falcon SPI controller support"
> +	bool "Falcon SPI controller support"
>  	depends on SOC_FALCON
>  	help
>  	  The external bus unit (EBU) found on the FALC-ON SoC has SPI
> --
> 2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
