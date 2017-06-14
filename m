From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH 10/18] spi: qup: Fix DMA mode interrupt handling
Date: Wed, 14 Jun 2017 12:51:11 +0530
Message-ID: <66ba7dfb-6ff3-884e-6db0-8d5191f87c93@codeaurora.org>
References: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
 <1497419551-21834-11-git-send-email-varada@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Varadarajan Narayanan <varada@codeaurora.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1497419551-21834-11-git-send-email-varada@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Varada,

On 6/14/2017 11:22 AM, Varadarajan Narayanan wrote:
> This is needed for v1, where the i/o completion is not
> handled in the dma driver.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  drivers/spi/spi-qup.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> index 872de28..bd53e82 100644
> --- a/drivers/spi/spi-qup.c
> +++ b/drivers/spi/spi-qup.c
> @@ -510,9 +510,9 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
>  
>  	writel_relaxed(qup_err, controller->base + QUP_ERROR_FLAGS);
>  	writel_relaxed(spi_err, controller->base + SPI_ERROR_FLAGS);
> -	writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
>  
>  	if (!xfer) {
> +		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);

 This does look correct to remove acknowledging the QUP in normal case and
  do it conditionally only when xfer = NULL.

>  		dev_err_ratelimited(controller->dev, "unexpected irq %08x %08x %08x\n",
>  				    qup_err, spi_err, opflags);
>  		return IRQ_HANDLED;
> @@ -540,7 +540,15 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
>  		error = -EIO;
>  	}
>  
> -	if (!spi_qup_is_dma_xfer(controller->mode)) {
> +	if (spi_qup_is_dma_xfer(controller->mode)) {
> +		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
> +		if (opflags & QUP_OP_IN_SERVICE_FLAG &&
> +		    opflags & QUP_OP_MAX_INPUT_DONE_FLAG)
> +			complete(&controller->rxc);
> +		if (opflags & QUP_OP_OUT_SERVICE_FLAG &&
> +		    opflags & QUP_OP_MAX_OUTPUT_DONE_FLAG)
> +			complete(&controller->txc);
> +	} else {

 Is this because in patch #8 that we do not populate the dma callback
 for v1. If that is done, this should not be required at all, as the
 complete would be signalled from the dma callback.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
