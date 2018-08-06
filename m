From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH RESEND 1/5] spi: imx: Remove duplicate variable
 assignments
Date: Mon, 6 Aug 2018 10:56:19 +0200
Message-ID: <20180806085619.zfhrow3pnkcjbjdu@pengutronix.de>
References: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
 <20180717143154.28241-2-maxime.chevallier@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180717143154.28241-2-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 17, 2018 at 04:31:50PM +0200, Maxime Chevallier wrote:
> Some fields in struct spi_imx_data are assigned a different value twice
> in a row, in spi_imx_setupxfer.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/spi/spi-imx.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index d3b21faf6b1f..d75153c995af 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1106,8 +1106,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>  	if (spi_imx->devtype_data->dynamic_burst && !spi_imx->slave_mode) {
>  		u32 mask;
>  
> -		spi_imx->dynamic_burst = 0;
> -		spi_imx->remainder = 0;
>  		spi_imx->read_u32  = 1;
>  
>  		mask = (1 << spi_imx->bits_per_word) - 1;
> -- 
> 2.11.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
