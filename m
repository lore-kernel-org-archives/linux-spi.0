From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RESEND v6  06/13] spi: imx: fix ERR009165
Date: Tue, 10 Mar 2020 08:39:20 +0100
Message-ID: <20200310073920.GR3335@pengutronix.de>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-7-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org,
        l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, martin.fuzzey-X8SyT9posyX3d/wEbhiU/g@public.gmane.org,
        kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-imx-3arQi8VN3Tc@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1583839922-22699-7-git-send-email-yibin.gong-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Mar 10, 2020 at 07:31:55PM +0800, Robin Gong wrote:
> Change to XCH  mode even in dma mode, please refer to the below
> errata:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf
> 
> Signed-off-by: Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>
> Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/spi/spi-imx.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index f4f28a4..842a86e 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -585,8 +585,9 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
>  	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
>  	spi_imx->spi_bus_clk = clk;
>  
> +	/* ERR009165: work in XHC mode as PIO */
>  	if (spi_imx->usedma)
> -		ctrl |= MX51_ECSPI_CTRL_SMC;
> +		ctrl &= ~MX51_ECSPI_CTRL_SMC;

'ctrl' was read from the hardware. In the dma case it was set
explicitly, but it was never cleared for a PIO transfer. This looked
wrong before this patch. Now with this patch it looks even more wrong:
We clear a bit that has never been set and we only do this for DMA, when
for the PIO case it definitly must be cleared. Drop the if clause.

>  
>  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
>  
> @@ -612,12 +613,14 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
>  
>  static void mx51_setup_wml(struct spi_imx_data *spi_imx)
>  {
> +	u32 tx_wml = 0;
> +
>  	/*
>  	 * Configure the DMA register: setup the watermark
>  	 * and enable DMA request.
>  	 */
>  	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
> -		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
> +		MX51_ECSPI_DMA_TX_WML(tx_wml) |

tx_wml is never assigned any other value than 0. Drop the variable.

>  		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
>  		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
>  		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
> @@ -1171,7 +1174,11 @@ static int spi_imx_dma_configure(struct spi_master *master)
>  	tx.direction = DMA_MEM_TO_DEV;
>  	tx.dst_addr = spi_imx->base_phys + MXC_CSPITXDATA;
>  	tx.dst_addr_width = buswidth;
> -	tx.dst_maxburst = spi_imx->wml;
> +	/*
> +	 * For ERR009165 with tx_wml = 0 could enlarge burst size to fifo size
> +	 * to speed up fifo filling as possible.
> +	 */
> +	tx.dst_maxburst = spi_imx->devtype_data->fifo_size;
>  	ret = dmaengine_slave_config(master->dma_tx, &tx);
>  	if (ret) {
>  		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n", ret);
> @@ -1265,10 +1272,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
>  {
>  	int ret;
>  
> -	/* use pio mode for i.mx6dl chip TKT238285 */
> -	if (of_machine_is_compatible("fsl,imx6dl"))
> -		return 0;

So with this patch it becomes possible to do DMA on i.MX6dl, but it is
mentioned nowhere.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
