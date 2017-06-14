From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 08/18] spi: qup: Handle v1 dma completion differently
Date: Wed, 14 Jun 2017 12:45:51 +0530
Message-ID: <a0e499a7-8f89-96d6-9463-c2b3f774cd6d@codeaurora.org>
References: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
 <1497419551-21834-9-git-send-email-varada@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497419551-21834-9-git-send-email-varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Varada,

On 6/14/2017 11:22 AM, Varadarajan Narayanan wrote:
> Do not assign i/o completion callbacks while running
> on v1 of QUP.
> 
> Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/spi/spi-qup.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> index 7c22ee4..0f6a4c7 100644
> --- a/drivers/spi/spi-qup.c
> +++ b/drivers/spi/spi-qup.c
> @@ -334,6 +334,7 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
>  			  unsigned long timeout)
>  {
>  	struct spi_qup *qup = spi_master_get_devdata(master);
> +	dma_async_tx_callback done = qup->qup_v1 ? NULL : spi_qup_dma_done;
>  	int ret;
>  
>  	/* before issuing the descriptors, set the QUP to run */
> @@ -346,7 +347,7 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
>  
>  	if (xfer->rx_buf) {
>  		ret = spi_qup_prep_sg(master, xfer, DMA_DEV_TO_MEM,
> -					spi_qup_dma_done, &qup->rxc);
> +					done, &qup->rxc);
>  		if (ret)
>  			return ret;
>  
> @@ -355,7 +356,7 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
>  
>  	if (xfer->tx_buf) {
>  		ret = spi_qup_prep_sg(master, xfer, DMA_MEM_TO_DEV,
> -					spi_qup_dma_done, &qup->txc);
> +					done, &qup->txc);
>  		if (ret)
>  			return ret;
>  
> 

 Not sure why we cannot use dma callback for V1 ?

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
