From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v6 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Thu, 23 Jan 2020 13:48:19 +0530
Message-ID: <1b9d00c5-82c4-3dc7-960f-5077040626ae@ti.com>
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <860aecbc-22d3-c9ce-3570-44115d6e81b2@ti.com>
 <1aa6033a-c9e1-579b-0916-25037c07654d@linux.intel.com>
 <3118e6d5-84f3-cbcf-6a42-761b0d23cb72@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: <robh+dt@kernel.org>, <dan.carpenter@oracle.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
To: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3118e6d5-84f3-cbcf-6a42-761b0d23cb72@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 21/01/20 5:17 pm, Ramuthevar, Vadivel MuruganX wrote:
> Hi,
> 
> On 15/1/2020 2:21 PM, Ramuthevar, Vadivel MuruganX wrote:
>> Hi,
>>
>> On 15/1/2020 2:13 PM, Vignesh Raghavendra wrote:
>>> Hi,
>>>
>>> On 12/30/2019 1:11 PM, Ramuthevar,Vadivel MuruganX wrote:
>>>> Add support for the Cadence QSPI controller. This controller is
>>>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>>>> This driver has been tested on the Intel LGM SoCs.
>>>>
>>>> This driver does not support generic SPI and also the implementation
>>>> only supports spi-mem interface to replace the existing driver in
>>>> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
>>>> flash memory.
>>>>
>>>
>>>
>>> I am finally able to get spi-mem based cadence-quaspi driver working on
>>> TI platforms with DMA and DAC mode. I have also incorporated changes to
>>> disable DAC and autopolling for your intel SoC:
>>
>> Thanks! a lot for the confirmation, with your changes it is working on
>> TI platform.
>>
>>> https://github.com/r-vignesh/linux/commits/qspi
>>>
>>> (Top two patches are of interest)
>>>
>>> I have tested both DAC and INDAC mode with s25fl flash and everything
>>> seems to be fine. Could you re test the driver on your SoC? 
> 
> while re-testing QSPI_NOR/NAND both didn't work, after few changes from
> patchV6 followed by your changes,
> 
> now QSPI-NOR started working,  soon will be sending updated patch
> version which includes your changes as well as my changes
> 
> without affecting both the platforms(TI and Intel).
> 
> BTW,  Have you tested QSPI-NAND on your platform ? with our patches.

No, I don't have a platform with QSPI-NAND.

Regards
Vignesh
