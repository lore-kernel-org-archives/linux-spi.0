From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Applied "spi: imx: dynamic burst length adjust for PIO mode" to
 the spi tree
Date: Fri, 30 Jun 2017 14:14:33 +0200
Message-ID: <20170630121433.piznjqtmhy35zty6@pengutronix.de>
References: <20170613083402.22324-1-jiada_wang@mentor.com>
 <E1dQub0-0008Ep-Hf@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1dQub0-0008Ep-Hf@finisterre>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Fri, Jun 30, 2017 at 01:00:22PM +0100, Mark Brown wrote:
> The patch
> 
>    spi: imx: dynamic burst length adjust for PIO mode
> 
> has been applied to the spi tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

Argh, I wasn't fast enough. I just ran spi-loopback-test.ko with this
patch and it doesn't work properly.

> +	if (spi_imx->count == spi_imx->remainder) {
> +		ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
> +		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
> +		if (spi_imx->count > MX51_ECSPI_CTRL_MAX_BURST) {
> +			spi_imx->remainder = spi_imx->count %
> +					     MX51_ECSPI_CTRL_MAX_BURST;
> +			val = MX51_ECSPI_CTRL_MAX_BURST;

This is wrong. MX51_ECSPI_CTRL_MAX_BURST contains the burst length in
bytes, but the register 'val' is written to takes the burst length in
bits - 1, so this should be:

			val = MX51_ECSPI_CTRL_MAX_BURST * 8 - 1;

instead.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
