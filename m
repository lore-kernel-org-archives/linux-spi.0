From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Tue, 5 Nov 2019 10:58:39 +0000
Message-ID: <855a67dc-1356-a763-e374-540f6ac400ab@huawei.com>
References: <1572886297-45400-1-git-send-email-john.garry@huawei.com>
 <1572886297-45400-3-git-send-email-john.garry@huawei.com>
 <20191104192406.GH5238@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <marek.vasut@gmail.com>, <tudor.ambarus@microchip.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <xuejiancheng@hisilicon.com>, <fengsheng5@huawei.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191104192406.GH5238@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/11/2019 19:24, Mark Brown wrote:
> On Tue, Nov 05, 2019 at 12:51:36AM +0800, John Garry wrote:
> 

Hi Mark,

>> Only ACPI firmware is supported.
> 
> There's no ACPI dependency though?  If the driver only works with ACPI
> I'd expect to see one with an || COMPILE_TEST like the architecture
> dependency.

Yeah, you're right. So the driver can build for !ACPI and !COMPILE_TEST, 
but there's no point really. I'll update.

> 
>> @@ -0,0 +1,287 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * HiSilicon SPI NOR V3XX Flash Controller Driver for hi16xx chipsets
>> + *
> 
> Please make the entire comment a C++ one for neatness.

ok

> 
>> + * Copyright (c) 2019 HiSilicon Technologies Co., Ltd.
>> + * Author: John Garry <john.garry@huawei.com>
>> + */
>> +//#define DEBUG 1
> 
> Please remove this.

ok

> 
>> +#define GLOBAL_CFG (0x100)
>> +
>> +#define BUS_CFG1 (0x200)
>> +#define BUS_CFG2 (0x204)
>> +#define BUS_FLASH_SIZE (0x210)
>> +
>> +#define VERSION (0x1f8)
> 
> These could use some namespacing, especially the last one - it seems
> quite likely there'll be some collisions at some point.

ok

> 
>> +#define HISI_SFC_V3XX_WAIT_TIMEOUT_US		1000000
>> +#define HISI_SFC_V3XX_WAIT_POLL_INTERVAL_US	10
> 
> Plus if we've got these long prefixes here it'd be good to be
> consistent.

sure

> 
>> +	if (IS_ALIGNED((uintptr_t)to, 4)) {
>> +		int words = len / 4;
>> +
>> +		__ioread32_copy(to, host->regbase + CMD_DATABUF(0), words);
>> +
>> +		len -= words * 4;
>> +		if (len) {
>> +			u32 val;
>> +
>> +			val = __raw_readl(host->regbase + CMD_DATABUF(words));
>> +
>> +			to += words * 4;
>> +			for (i = 0; i < len; i++, val >>= 8, to++)
>> +				*to = (u8)val;
>> +		}
>> +	} else {
>> +		for (i = 0; i < DIV_ROUND_UP(len, 4); i++) {
>> +			u32 val = __raw_readl(host->regbase + CMD_DATABUF(i));
>> +			int j;
> 
> The more usual pattern for these would be to do some unaligned accesses
> for the start/end of the buffer to get to alignment and then transfer
> the rest as aligned data.
> 

Yeah, I understand you, but for that I would need to generate multiple 
transactions in the driver, and I wanted to keep 1x transaction per 
spi_controller_mem_ops.exec_op call.

So maybe I can do some trickery in my adjust_op_size method to generate 
these multiple transactions: a. any unaligned start data b. the 
32b-aligned data b. unaligned end. I think that the HW should be able to 
handle that.

Thanks,
John
