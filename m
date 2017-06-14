From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 11/18] spi: qup: properly detect extra interrupts
Date: Wed, 14 Jun 2017 12:57:25 +0530
Message-ID: <bb1469ad-542f-1a47-5ef9-84d7cd02cf49@codeaurora.org>
References: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
 <1497419551-21834-12-git-send-email-varada@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthew McClintock <mmcclint-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497419551-21834-12-git-send-email-varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Varada,

On 6/14/2017 11:22 AM, Varadarajan Narayanan wrote:
> It's possible for a SPI transaction to complete and get another
> interrupt and have it processed on the same spi_transfer before the
> transfer_one can set it to NULL.
> 
> This masks unexpected interrupts, so let's set the spi_transfer to
> NULL in the interrupt once the transaction is done. So we can
> properly detect these bad interrupts and print warning messages.
> 
> Signed-off-by: Matthew McClintock <mmcclint-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/spi/spi-qup.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> index bd53e82..1a2a9d9 100644
> --- a/drivers/spi/spi-qup.c
> +++ b/drivers/spi/spi-qup.c
> @@ -496,13 +496,13 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
>  	struct spi_qup *controller = dev_id;
>  	struct spi_transfer *xfer;
>  	u32 opflags, qup_err, spi_err;
> -	unsigned long flags;
>  	int error = 0;
> +	bool done = 0;
>  
> -	spin_lock_irqsave(&controller->lock, flags);
> +	spin_lock(&controller->lock);
>  	xfer = controller->xfer;
>  	controller->xfer = NULL;
> -	spin_unlock_irqrestore(&controller->lock, flags);
> +	spin_unlock(&controller->lock);

 Why change the locking here ?

>  
>  	qup_err = readl_relaxed(controller->base + QUP_ERROR_FLAGS);
>  	spi_err = readl_relaxed(controller->base + SPI_ERROR_FLAGS);
> @@ -556,16 +556,19 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
>  			spi_qup_write(controller, xfer);
>  	}
>  
> -	spin_lock_irqsave(&controller->lock, flags);
> -	controller->error = error;
> -	controller->xfer = xfer;
> -	spin_unlock_irqrestore(&controller->lock, flags);
> -
>  	/* re-read opflags as flags may have changed due to actions above */
>  	opflags = readl_relaxed(controller->base + QUP_OPERATIONAL);
>  
>  	if ((controller->rx_bytes == xfer->len &&
>  		(opflags & QUP_OP_MAX_INPUT_DONE_FLAG)) ||  error)
> +		done = true;
> +
> +	spin_lock(&controller->lock);
> +	controller->error = error;
> +	controller->xfer = done ? NULL : xfer;
> +	spin_unlock(&controller->lock);
> +
> +	if (done)
>  		complete(&controller->done);
>  
  Its not clear, why the driver is setting the controller->xfer = NULL
  and restoring it inside the irq. This patch seems to fix things on
  top of that.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
