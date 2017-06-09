From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH linux-next v3 1/1] spi: imx: dynamic burst length adjust
 for PIO mode
Date: Thu, 8 Jun 2017 22:09:07 -0700
Message-ID: <593A2D73.4070800@mentor.com>
References: <1495774962-2981-1-git-send-email-jiada_wang@mentor.com> <20170529095043.mytrgtyfne4dfmae@pengutronix.de> <59300177.5030908@mentor.com> <20170602053852.7w4c35tn5daq7omy@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170602053852.7w4c35tn5daq7omy-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 06/01/2017 10:38 PM, Sascha Hauer wrote:
> On Thu, Jun 01, 2017 at 04:58:47AM -0700, Jiada Wang wrote:
>> Hi Sascha
>>
>> On 05/29/2017 02:50 AM, Sascha Hauer wrote:
>>> Hi,
>>>
>>> On Thu, May 25, 2017 at 10:02:42PM -0700, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org wrote:
>>>> From: Jiada Wang<jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>>>>
>>>> previously burst length (BURST_LENGTH) is always set to equal
>>>> to bits_per_word, causes a 10us gap between each word in
>>>> transfer, which significantly affects performance.
>>>>
>>>> This patch uses 32 bits transfer to simulate lower bits transfer,
>>>> and adjusts burst length runtimely to use biggeest burst length
>>>> as possible to reduce the gaps in transfer for PIO mode.
>>>>
>>> First let me say that I'm not really looking forward to have this patch
>>> in the driver. It adds quite some code to already hairy code pathes in
>>> the imx-spi driver and I saw you have the same patch for DMA mode
>>> aswell.
>>>
>>> The driver has different function hooks for the different controllers.
>>> This patch breaks that. In some places it assumes that dynamic burst
>>> is only possible on i.MX51 type controllers and also that in case
>>> dynamic burst is enabled it must be an i.MX51 type controller.
>>>
>>> We should really see how this patch can be better integrated into the
>>> driver, or, how the driver can be changed to better support the dynamic
>>> burst usecase.
>>   Yes, I can understand your concern, as this patch brings in a bunch of
>> change,
>> and changes the behaviour of data transfer.
>> how about introduce a new DTS property like "fsl,spi-dynamic-burst",
>> and only enables dynamic burst when this property is added.
> This will only reduce the testing coverage of the feature, not a good
> option.
As an improvement, I am thinking about the following
1. introduce a 'fsl,spi-dynamic-burst' property in dts as mentioned before
2. remove all change in specific functions hooks, for example 
"mx51_ecspi_config"
3. introduce spi_imx_pio_dynamic_burst_transfer(), which will handle 
actual swapped data transfer,
     and burst length adjustment.


What do you think ?
> Sascha
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
