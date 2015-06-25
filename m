From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch] spi: zynq: missing break statement
Date: Thu, 25 Jun 2015 10:32:27 +0200
Message-ID: <558BBC9B.8030004@xilinx.com>
References: <20150624143133.GE1702@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?windows-1252?Q?S=F6ren_Br?= =?windows-1252?Q?inkmann?=
	<soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150624143133.GE1702@mwanda>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 06/24/2015 04:31 PM, Dan Carpenter wrote:
> There is a missing break statement here so selecting both only selects
> upper.
> 
> Fixes: dfe11a11d523 ('spi: Add support for Zynq Ultrascale+ MPSoC GQSPI controller')
> Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> 
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index 87b20a5..f23f36e 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -214,6 +214,7 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
>  	case GQSPI_SELECT_FLASH_CS_BOTH:
>  		instanceptr->genfifocs = GQSPI_GENFIFO_CS_LOWER |
>  			GQSPI_GENFIFO_CS_UPPER;
> +		break;
>  	case GQSPI_SELECT_FLASH_CS_UPPER:
>  		instanceptr->genfifocs = GQSPI_GENFIFO_CS_UPPER;
>  		break;
> 

Acked-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

Thanks,
Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
