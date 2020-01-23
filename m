From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [EXT] Re: [PATCH v6 0/2] spi: cadence-quadpsi: Add support for
 the Cadence QSPI controller
Date: Thu, 23 Jan 2020 13:17:02 +0530
Message-ID: <40ee10f1-0b30-155c-c165-1baa57a22109@ti.com>
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <860aecbc-22d3-c9ce-3570-44115d6e81b2@ti.com>
 <AM0PR0402MB355668F205AD711D2059CDB5E00F0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
To: Kuldeep Singh <kuldeep.singh@nxp.com>,
        "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM0PR0402MB355668F205AD711D2059CDB5E00F0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 23/01/20 12:54 pm, Kuldeep Singh wrote:
> Hi Vignesh,
> 
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
>> owner@vger.kernel.org> On Behalf Of Vignesh Raghavendra
>> Sent: Wednesday, January 15, 2020 11:43 AM
>> To: Ramuthevar,Vadivel MuruganX
>> <vadivel.muruganx.ramuthevar@linux.intel.com>; broonie@kernel.org; linux-
>> spi@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: robh+dt@kernel.org; dan.carpenter@oracle.com;
>> cheol.yong.kim@intel.com; qi-ming.wu@intel.com
>> Subject: [EXT] Re: [PATCH v6 0/2] spi: cadence-quadpsi: Add support for the
>> Cadence QSPI controller
>>
>> Caution: EXT Email
>>
>> Hi,
>>
>> On 12/30/2019 1:11 PM, Ramuthevar,Vadivel MuruganX wrote:
>>> Add support for the Cadence QSPI controller. This controller is
>>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>>> This driver has been tested on the Intel LGM SoCs.
>>>
>>> This driver does not support generic SPI and also the implementation
>>> only supports spi-mem interface to replace the existing driver in
>>> mtd/spi-nor/cadence-quadspi.c, the existing driver only support
>>> SPI-NOR flash memory.
>>>
>>
>>
>>
>> I am finally able to get spi-mem based cadence-quaspi driver working on TI
>> platforms with DMA and DAC mode. I have also incorporated changes to
>> disable DAC and autopolling for your intel SoC:
>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.co
>> m%2Fr-
>> vignesh%2Flinux%2Fcommits%2Fqspi&amp;data=02%7C01%7Ckuldeep.singh%
>> 40nxp.com%7Ccbd14ac527ae4298a28808d7998219e6%7C686ea1d3bc2b4c6fa
>> 92cd99c5c301635%7C0%7C0%7C637146656365872638&amp;sdata=jAR7lmry
>> R9fdqF3e4A2dQzF0Q0fYxMvM7sNhx8lvoy0%3D&amp;reserved=0
>>
>> (Top two patches are of interest)
>>
>> I have tested both DAC and INDAC mode with s25fl flash and everything seems
>> to be fine. Could you re test the driver on your SoC? Feel free to fold it into
>> your series if everything works.
> 
> Is JFFS2/UBIFS a valid use case here? And were you able to test the same?
> I see few issues with Spansion flashes (s25fs) in framework and couldn’t make FS utilities run.
> On the other hand, file systems on other flashes (ex: micron, mt25qu) are showing positive results.
> 

I did test with s25fl512s with UBIFS and did not see any issue. Could
you try with latest linux master or linux next? There were couple of
fixes in the last -rc related to spansion flashes?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=mtd/fixes&id=440b6d50254bdbd84c2a665c7f53ec69dd741a4f
[2]https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=mtd/fixes&id=da2ef8124f20b4ce18d1d3d24fc7b88e687e10bb

> Thanks
> Kuldeep
> 
>>
>> Regards
>> Vignesh
>>
>>
> 

-- 
Regards
Vignesh
