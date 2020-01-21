From: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v6 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Tue, 21 Jan 2020 19:47:13 +0800
Message-ID: <3118e6d5-84f3-cbcf-6a42-761b0d23cb72@linux.intel.com>
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <860aecbc-22d3-c9ce-3570-44115d6e81b2@ti.com>
 <1aa6033a-c9e1-579b-0916-25037c07654d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1aa6033a-c9e1-579b-0916-25037c07654d-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On 15/1/2020 2:21 PM, Ramuthevar, Vadivel MuruganX wrote:
> Hi,
>
> On 15/1/2020 2:13 PM, Vignesh Raghavendra wrote:
>> Hi,
>>
>> On 12/30/2019 1:11 PM, Ramuthevar,Vadivel MuruganX wrote:
>>> Add support for the Cadence QSPI controller. This controller is
>>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>>> This driver has been tested on the Intel LGM SoCs.
>>>
>>> This driver does not support generic SPI and also the implementation
>>> only supports spi-mem interface to replace the existing driver in
>>> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
>>> flash memory.
>>>
>>
>>
>> I am finally able to get spi-mem based cadence-quaspi driver working on
>> TI platforms with DMA and DAC mode. I have also incorporated changes to
>> disable DAC and autopolling for your intel SoC:
>
> Thanks! a lot for the confirmation, with your changes it is working on 
> TI platform.
>
>> https://github.com/r-vignesh/linux/commits/qspi
>>
>> (Top two patches are of interest)
>>
>> I have tested both DAC and INDAC mode with s25fl flash and everything
>> seems to be fine. Could you re test the driver on your SoC? 

while re-testing QSPI_NOR/NAND both didn't work, after few changes from 
patchV6 followed by your changes,

now QSPI-NOR started working,  soon will be sending updated patch 
version which includes your changes as well as my changes

without affecting both the platforms(TI and Intel).

BTW,  Have you tested QSPI-NAND on your platform ? with our patches.

Thanks! for your review and support.

Regards
Vadivel
>> Feel free to
>> fold it into your series if everything works.
> sure, I will test on Intel SoC with your changes .
>
> Regards
> Vadivel
>> Regards
>> Vignesh
>>
>>
>>
