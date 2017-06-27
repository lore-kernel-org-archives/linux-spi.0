From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH linux-next v4 0/4] i.MX ECSPI controller slave mode
 support
Date: Tue, 27 Jun 2017 08:53:14 +0200
Message-ID: <20170627065314.jo63yzikv3cbvi2j@pengutronix.de>
References: <20170608051603.16070-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170608051603.16070-1-jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 08, 2017 at 02:15:59PM +0900, Jiada Wang wrote:
> Changes in v4:
> * rebased to head of linux-next to resolve conflict
> * optimized mx53_ecspi_rx_slave()
> 
> Changes in v3:
> * renamed several variables for for better readability
> * created spi_imx_pio_transfer_slave() for slave pio transfer
> * added fifo_size, has_dmamode and has_slavemode in spi_imx_devtype_data
> 
> Changes in v2:
> * re-workd i.MX ECSPI controller slave mode support based on Geert's work
> 
> Jiada Wang (4):
>   spi: imx: introduce fifo_size and has_dmamode in spi_imx_devtype_data
>   spi: imx: add selection for iMX53 and iMX6 controller
>   ARM: dts: imx: change compatibility for SPI controllers on imx53 later
>     soc
>   spi: imx: Add support for SPI Slave mode

For the series:

Reviewed-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
