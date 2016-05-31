From: Jean-Jacques Hiblot <x0248073-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: spi-ti-qspi: Suspend the queue before removing the
 device
Date: Tue, 31 May 2016 16:45:53 +0200
Message-ID: <574DA3A1.9020307@ti.com>
References: <1463486227-6110-1-git-send-email-x0248073@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <vigneshr-l0cyMroinI0@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463486227-6110-1-git-send-email-x0248073-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

gentle ping.

Any objection to fix this particular issue in this way ? Should it be 
fixed at the core level ?

Thanks,

Jean-Jacques


On 17/05/2016 13:57, Jean-Jacques Hiblot wrote:
> From: Jean-Jacques Hiblot <jjhiblot-l0cyMroinI0@public.gmane.org>
>
> Before disabling the pm_runtime, we must ensure that there is no transfer
> in progress nor will a new one be started. Otherwise the message pump will
> fail and in the end, the process requesting the transfer will be stuck.
> This behavior has been observed when transferring data from a SPI flash
> with dd while removing the module on a DRA7x-evm.
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/spi/spi-ti-qspi.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index 443f664..29ea8d2 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -646,6 +646,13 @@ free_master:
>   
>   static int ti_qspi_remove(struct platform_device *pdev)
>   {
> +	struct ti_qspi *qspi = platform_get_drvdata(pdev);
> +	int rc;
> +
> +	rc = spi_master_suspend(qspi->master);
> +	if (rc)
> +		return rc;
> +
>   	pm_runtime_put_sync(&pdev->dev);
>   	pm_runtime_disable(&pdev->dev);
>   

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
