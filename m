From: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: atmel: add PM support to SAMA5D2
Date: Wed, 12 Apr 2017 11:08:50 +0200
Message-ID: <30f4f62b-6fa0-bfd8-a855-8c394fba654b@microchip.com>
References: <20170412070520.29621-1-quentin.schulz@free-electrons.com>
 <20170412070520.29621-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170412070520.29621-2-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Le 12/04/2017 à 09:05, Quentin Schulz a écrit :
> This adds PM support to the ATMEL SAMA5D2 Xplained.

Well not only for this board. The Backup+Self-Refresh PM state is
available for all boards using the SAMA5D2 SoC (and beyond)...

> When suspending, VDDCore is shut down and the SPI registers are lost.

Yes, but only on sama5d2 and only if the Backup+Self-Refresh (or deepest
PM state on sama5d2).

> Thus, the SPI controller needs to be re-initialized after resuming from
> a system suspend.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

I'm okay with the core of the patch but would prefer a modified commit
message.

Best regards,

> ---
>  drivers/spi/spi-atmel.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 247d920..1eb83c9 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1702,8 +1702,17 @@ static int atmel_spi_suspend(struct device *dev)
>  static int atmel_spi_resume(struct device *dev)
>  {
>  	struct spi_master *master = dev_get_drvdata(dev);
> +	struct atmel_spi *as = spi_master_get_devdata(master);
>  	int ret;
>  
> +	ret = clk_prepare_enable(as->clk);
> +	if (ret)
> +		return ret;
> +
> +	atmel_spi_init(as);
> +
> +	clk_disable_unprepare(as->clk);
> +
>  	if (!pm_runtime_suspended(dev)) {
>  		ret = atmel_spi_runtime_resume(dev);
>  		if (ret)
> 


-- 
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
