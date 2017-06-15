From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH 11/18] spi: qup: properly detect extra interrupts
Date: Thu, 15 Jun 2017 10:57:27 +0530
Message-ID: <e3b6bcde-0749-1e8e-431f-a42e9207bbef@codeaurora.org>
References: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
 <1497419551-21834-12-git-send-email-varada@codeaurora.org>
 <bb1469ad-542f-1a47-5ef9-84d7cd02cf49@codeaurora.org>
 <20170614195953.GD32733@hector.wework.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Varadarajan Narayanan <varada@codeaurora.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Matthew McClintock <mmcclint@codeaurora.org>
To: Andy Gross <andy.gross@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170614195953.GD32733@hector.wework.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Andy,

On 6/15/2017 1:29 AM, Andy Gross wrote:
> On Wed, Jun 14, 2017 at 12:57:25PM +0530, Sricharan R wrote:
>> Hi Varada,
>>
>> On 6/14/2017 11:22 AM, Varadarajan Narayanan wrote:
>>> It's possible for a SPI transaction to complete and get another
>>> interrupt and have it processed on the same spi_transfer before the
>>> transfer_one can set it to NULL.
>>>
>>> This masks unexpected interrupts, so let's set the spi_transfer to
>>> NULL in the interrupt once the transaction is done. So we can
>>> properly detect these bad interrupts and print warning messages.
>>>
>>> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
>>> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
>>> ---
>>>  drivers/spi/spi-qup.c | 20 +++++++++++---------
>>>  1 file changed, 11 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
>>> index bd53e82..1a2a9d9 100644
>>> --- a/drivers/spi/spi-qup.c
>>> +++ b/drivers/spi/spi-qup.c
>>> @@ -496,13 +496,13 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
>>>  	struct spi_qup *controller = dev_id;
>>>  	struct spi_transfer *xfer;
>>>  	u32 opflags, qup_err, spi_err;
>>> -	unsigned long flags;
>>>  	int error = 0;
>>> +	bool done = 0;
>>>  
>>> -	spin_lock_irqsave(&controller->lock, flags);
>>> +	spin_lock(&controller->lock);
>>>  	xfer = controller->xfer;
>>>  	controller->xfer = NULL;
>>> -	spin_unlock_irqrestore(&controller->lock, flags);
>>> +	spin_unlock(&controller->lock);
>>
>>  Why change the locking here ?
>>
>>>  
>>>  	qup_err = readl_relaxed(controller->base + QUP_ERROR_FLAGS);
>>>  	spi_err = readl_relaxed(controller->base + SPI_ERROR_FLAGS);
>>> @@ -556,16 +556,19 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
>>>  			spi_qup_write(controller, xfer);
>>>  	}
>>>  
>>> -	spin_lock_irqsave(&controller->lock, flags);
>>> -	controller->error = error;
>>> -	controller->xfer = xfer;
>>> -	spin_unlock_irqrestore(&controller->lock, flags);
>>> -
>>>  	/* re-read opflags as flags may have changed due to actions above */
>>>  	opflags = readl_relaxed(controller->base + QUP_OPERATIONAL);
>>>  
>>>  	if ((controller->rx_bytes == xfer->len &&
>>>  		(opflags & QUP_OP_MAX_INPUT_DONE_FLAG)) ||  error)
>>> +		done = true;
>>> +
>>> +	spin_lock(&controller->lock);
>>> +	controller->error = error;
>>> +	controller->xfer = done ? NULL : xfer;
>>> +	spin_unlock(&controller->lock);
>>> +
>>> +	if (done)
>>>  		complete(&controller->done);
>>>  
>>   Its not clear, why the driver is setting the controller->xfer = NULL
>>   and restoring it inside the irq. This patch seems to fix things on
>>   top of that.
> 
> I think the original intent was to make sure that the irqhandler knew that there
> was no outstanding transaction.  This begs the question of why that would ever
> be necessary.  I think it would suffice to rework all of that to remove that
> behavior and perhaps enable/disable the irq as we need to during transactions.
> 
> I've never been a fan of the controller->xfer being set to NULL.

 Agree, that part needs fixing in the original code. Also patch #10 changing the
 behavior to acknowledge the interrupts only when its spurious does not look
 correct. Trying to fix the original should simplify or avoid the spurious case
 itself.

Regards,
 Sricharan 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
