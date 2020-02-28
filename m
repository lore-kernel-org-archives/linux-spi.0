From: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v11 2/2] spi: cadence-quadspi: Add support for the Cadence
 QSPI controller
Date: Fri, 28 Feb 2020 12:11:09 +0800
Message-ID: <f82e4964-f030-9aac-5895-a715921ed6db@linux.intel.com>
References: <20200227062708.21544-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200227062708.21544-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200227183032.77ef0795@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        marex-ynQEQJNshbs@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        tien.fong.chee-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tudor.ambarus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, richard-/L3Ra7n9ekc@public.gmane.org,
        qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        david.oberhollenzer-S6VGOU4v5edDinCvNWH78Q@public.gmane.org, dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
        cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
To: Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200227183032.77ef0795-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Boris,

      Thank you so much for the review comments...

On 28/2/2020 1:30 AM, Boris Brezillon wrote:
> On Thu, 27 Feb 2020 14:27:08 +0800
> "Ramuthevar, Vadivel MuruganX"
> <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>
>> Add support for the Cadence QSPI controller. This controller is
>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>> This driver has been tested on the Intel LGM SoCs.
>>
>> This driver does not support generic SPI and also the implementation
>> only supports spi-mem interface to replace the existing driver in
>> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
>> flash memory
> Is it really supporting SPI NORs only, or is it just that you only
> tested it with a spi-nor?

The existing drivers/mtd/spi-nor/cadence-quadspi.c supports SPI-NORs 
only, because the driver is developed

such a way that it does not support other SPI based flash memories, also 
never uses SPI/SPI-MEM based framework.

So we Vignesh suggested me to  develop the new driver which supports 
both SPI-NOR and SPI-NAND based on the SPI-MEM framework.

>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Signed-off-by: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
>> Reported-by: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Reported-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> Reported-by? What has been reported?
Sure, will remove it.
>
>> ---
>>   drivers/mtd/spi-nor/Kconfig                        |  11 -
>>   drivers/mtd/spi-nor/Makefile                       |   1 -
>>   drivers/spi/Kconfig                                |  10 +
>>   drivers/spi/Makefile                               |   1 +
>>   .../spi-cadence-quadspi.c}                         | 641 ++++++++++-----------
> Looks like this could be split in several patches to ease the review:
>
> 1/ convert to spi-mem
> 2/ move the driver to drivers/spi
> 3/ add support for intel,lgm-qspi
>
> other than that, that's good to see one more spi-nor controller driver
> converted to spi-mem.

Agreed!, will split as per your suggestions.

Regards
Vadivel
>
