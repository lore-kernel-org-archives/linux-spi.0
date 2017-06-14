From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH 07/18] spi: qup: Fix transaction done signaling
Date: Wed, 14 Jun 2017 12:43:43 +0530
Message-ID: <4b81a4c7-b85c-a35d-15fb-4aaaec3c7e8c@codeaurora.org>
References: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
 <1497419551-21834-8-git-send-email-varada@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Varadarajan Narayanan <varada@codeaurora.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1497419551-21834-8-git-send-email-varada@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Varada,

On 6/14/2017 11:22 AM, Varadarajan Narayanan wrote:
> Wait to signal done until we get all of the interrupts we are expecting
> to get for a transaction.  If we don't wait for the input done flag, we
> can be inbetween transactions when the done flag comes in and this can
> mess up the next transaction.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  drivers/spi/spi-qup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> index 2124815..7c22ee4 100644
> --- a/drivers/spi/spi-qup.c
> +++ b/drivers/spi/spi-qup.c
> @@ -465,7 +465,8 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
>  	controller->xfer = xfer;
>  	spin_unlock_irqrestore(&controller->lock, flags);
>  
> -	if (controller->rx_bytes == xfer->len || error)
> +	if ((controller->rx_bytes == xfer->len &&
> +		(opflags & QUP_OP_MAX_INPUT_DONE_FLAG)) ||  error)

 Not sure why we need this additional check, because having read all the
 bytes implies transfer complete (or) why not just check only for
 QUP_OP_MAX_INPUT_DONE_FLAG ?

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
