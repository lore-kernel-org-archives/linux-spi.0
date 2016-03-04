From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 6/9] spi: imx: remove unnecessary bit clearing in
 mx51_ecspi_config
Date: Fri, 4 Mar 2016 12:47:37 +0100
Message-ID: <20160304114737.GE21869@pengutronix.de>
References: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
 <1456302033-25638-7-git-send-email-s.hauer@pengutronix.de>
 <56D968DF.7000007@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56D968DF.7000007-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Mar 04, 2016 at 12:52:15PM +0200, Vladimir Zapolskiy wrote:
> Hi Sascha,
> 
> On 24.02.2016 10:20, Sascha Hauer wrote:
> > This reverts patch 1476253cef (spi: imx: fix ecspi mode setup)
> > The patch tried to fix something by clearing bits in the cfg variable,
> > but cfg is initialized to zero on function entry. There are no bits to
> > clear.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> I believe here the expected fix should be
> 
> ----8<----
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 6a4ff27..9c9bae0 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -316,9 +316,10 @@ static void __maybe_unused mx51_ecspi_trigger(struct
> spi_imx_data *spi_imx)
>  static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
>  		struct spi_imx_config *config)
>  {
> -	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0, dma = 0;
> +	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, dma = 0;
>  	u32 tx_wml_cfg, rx_wml_cfg, rxt_wml_cfg;
>  	u32 clk = config->speed_hz, delay, reg;
> +	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
> 

With this change applied we would indeed have to clear and not only set the bits,
but why would we do this?

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
