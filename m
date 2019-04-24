From: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1 07/15] spi: imx: remove ERR009165 workaround on i.mx6ul
Date: Wed, 24 Apr 2019 08:32:40 +0200
Message-ID: <20190424063240.vr5in5nez6hl2zgr@pengutronix.de>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
 <1556027045-5269-8-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.
To: Robin Gong <yibin.gong@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556027045-5269-8-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Apr 23, 2019 at 01:51:10PM +0000, Robin Gong wrote:
>    ERR009165 fix on i.mx6ul and next chip, such as i.mx6ull/i.mx8mq/i.mx8mm.
> Remove workaround on those chips. Add new i.mx6ul type for that.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/spi/spi-imx.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index eb56eac..2e5e978 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -57,6 +57,7 @@ enum spi_imx_devtype {
>  	IMX35_CSPI,	/* CSPI on all i.mx except above */
>  	IMX51_ECSPI,	/* ECSPI on i.mx51 */
>  	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
> +	IMX6UL_ECSPI,	/* ERR009165 fix from i.mx6ul */
>  };
>  
>  struct spi_imx_data;
> @@ -128,7 +129,8 @@ static inline int is_imx35_cspi(struct spi_imx_data *d)
>  
>  static inline int is_imx51_ecspi(struct spi_imx_data *d)
>  {
> -	return d->devtype_data->devtype == IMX51_ECSPI;
> +	return d->devtype_data->devtype == IMX51_ECSPI ||
> +	       d->devtype_data->devtype == IMX6UL_ECSPI;
>  }
>  
>  static inline int is_imx53_ecspi(struct spi_imx_data *d)
> @@ -585,9 +587,16 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
>  	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
>  	spi_imx->spi_bus_clk = clk;
>  
> -	/* ERR009165: work in XHC mode as PIO */
> -	if (spi_imx->usedma)
> -		ctrl &= ~MX51_ECSPI_CTRL_SMC;
> +	/*
> +	 * ERR009165: work in XHC mode instead of SMC as PIO on the chips
> +	 * before i.mx6ul.
> +	 */
> +	if (spi_imx->usedma) {
> +		if (spi_imx->devtype_data->devtype == IMX6UL_ECSPI)
> +			ctrl |= MX51_ECSPI_CTRL_SMC;
> +		else
> +			ctrl &= ~MX51_ECSPI_CTRL_SMC;
> +	}
>  
>  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
>  
> @@ -615,6 +624,8 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx)
>  {
>  	u32 tx_wml = 0;
>  
> +	if (spi_imx->devtype_data->devtype == IMX6UL_ECSPI)
> +		tx_wml = spi_imx->wml;

This if clause has to be adjusted for every new SoC which doesn't have
this issue. Better introduce a has_err009165 boolean flag to the driver
data and set it where necessary.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
