From: "Xiao, Jin" <jin.xiao@intel.com>
Subject: Re: [PATCH] spi-pxa2xx.c: modify the chip selection timing when spi
 transfer
Date: Thu, 7 Mar 2019 14:47:31 +0800
Message-ID: <8f83eb75-d557-13b0-b2d0-1efb98d6688d@intel.com>
References: <20190306030519.10746-1-jin.xiao@intel.com>
 <ed09063c-00cc-a1a5-2a93-2b3361d531bf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: "he, bo" <bo.he@intel.com>, jin.xiao@intel.com
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ed09063c-00cc-a1a5-2a93-2b3361d531bf@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Jarkko,

On 3/6/2019 3:52 PM, Jarkko Nikula wrote:
> Hi
>
> On 3/6/19 5:05 AM, xiao jin wrote:
>> From: "he, bo" <bo.he@intel.com>
>>
>> We find spi can't work on board. More debug shows it's related
>> to the following patch that changed the chip selection assert and
>> deassert timing.
>>
> ^^ timing caught my attention. More below.
>
>> @@ -610,6 +596,7 @@ static void int_transfer_complete(struct 
>> driver_data *drv_data)
>>       if (!pxa25x_ssp_comp(drv_data))
>>           pxa2xx_spi_write(drv_data, SSTO, 0);
>>   +    cs_deassert(drv_data);
>>       spi_finalize_current_transfer(drv_data->master);
>
> This
>
>> @@ -1070,6 +1057,7 @@ static int pxa2xx_spi_transfer_one(struct 
>> spi_controller *master,
>>               pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
>>       }
>>   +    cs_assert(drv_data);
>
> and this is not correct with core message loop. It will cause the chip 
> select is toggled with each transfer in PIO mode. If there is no 
> cs_change flag set then there shouldn't be CS toggling between the 
> transfers if SPI message consists of multiple transfers.
>
> More over this patch also will regress with DMA mode since there won't 
> be CS deassert at all.
>
> Timing reminded me I've seen two cases where there was a timing 
> related glitch in CS output:
>
> d0283eb2dbc1 ("spi: pxa2xx: Add output control for multiple Intel LPSS 
> chip selects")
> 7a8d44bc89e5 ("spi: pxa2xx: Fix too early chipselect deassert")
>
> Do you have a possibility to measure with an oscilloscope what goes 
> wrong with the CS after d5898e19c0d7 ("spi: pxa2xx: Use core message 
> processing loop")?
>
> Can you share your setup if I can reproduce it here? E.g. SPI clock 
> frequency, single or multiple CS, frequency of occurrence, etc
>
In our setup the pxa_ssp_type is LPSS_BXT_SSP.  With more debug we find 
that the problem is caused in the case of "restart the SSP" when 
pxa2xx_spi_transfer_one.

We will send another RFC patch.

Thanks.
