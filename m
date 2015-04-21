From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi/pxa2xx: add support for Intel Broxton
Date: Tue, 21 Apr 2015 16:44:49 +0300
Message-ID: <55365451.4010000@linux.intel.com>
References: <1429573714-68828-1-git-send-email-qipeng.zha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, fei.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	jason.cj.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: "qipeng.zha" <qipeng.zha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429573714-68828-1-git-send-email-qipeng.zha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Huiquan and Qipeng

On 04/21/2015 02:48 AM, qipeng.zha wrote:
> From: Huiquan Zhong <huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>
> Broxton have 3 SPI ports, PCI ids are 0x0ac2, 0x0ac4, 0x0ac6.
> The LPSS SSP private register offset is 0x200. iDMA register offset
> is 0x800.
>
> Every Broxton SPI Controller have integrated one dedicated DMA IP.
> Two DMA channels mapping:
> 	channel[0] -> SPI Tx,
> 	channel[1] -> SPI Rx.
>
> BXT SSP SPI does not support DMA burst mode operation. Only iDMA
> M-Size setting equal to 1(Single) is supported for all DMA
> peripherial transfers from the SSP to the DMA and from the DMA
> to the SSP, otherwise RX data corruption will happen.
>
> Use a new parameter(.chip_select) for BXT dedicated cs control.
>
> Signed-off-by: Huiquan Zhong <huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/spi/spi-pxa2xx-pci.c   | 103 ++++++++++++++++++++++++++++++++++++++++
>   drivers/spi/spi-pxa2xx.c       | 105 +++++++++++++++++++++++++++++++++++++++++
>   drivers/spi/spi-pxa2xx.h       |   1 +
>   include/linux/pxa2xx_ssp.h     |   3 ++
>   include/linux/spi/pxa2xx_spi.h |   2 +
>   5 files changed, 214 insertions(+)
>
Can we hold this a bit and join our efforts? We have been cooking a 
support for Skylake recently with a plan to extend to Broxton later.

Major difference to patch here is that we plan to use common code that 
probes PCI and ACPI enumerated individual devices (I2C, SPI and UART) 
and their integrated DMA (which doesn't have its own PCI or ACPI ID and 
not all devices have it) and adds them as platform devices.

That module will take care of reset and clock management so for instance 
this SPI code becomes a bit shorter and avoids similar code in I2C and 
UART too. Our MFD loader has been posted recently but is not merged yet:

https://lkml.org/lkml/2015/3/31/258

-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
