From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Tue, 5 Nov 2019 16:04:09 +0000
Message-ID: <da389dda-ab38-1e68-557e-ac8c83f4ecd8@huawei.com>
References: <1572886297-45400-1-git-send-email-john.garry@huawei.com>
 <1572886297-45400-3-git-send-email-john.garry@huawei.com>
 <20191104192406.GH5238@sirena.co.uk>
 <855a67dc-1356-a763-e374-540f6ac400ab@huawei.com>
 <20191105110504.GA4500@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <marek.vasut@gmail.com>, <tudor.ambarus@microchip.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <xuejiancheng@hisilicon.com>, <fengsheng5@huawei.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191105110504.GA4500@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 05/11/2019 11:05, Mark Brown wrote:
> On Tue, Nov 05, 2019 at 10:58:39AM +0000, John Garry wrote:
>> On 04/11/2019 19:24, Mark Brown wrote:
>>> On Tue, Nov 05, 2019 at 12:51:36AM +0800, John Garry wrote:
> 
>>>> +		if (len) {
>>>> +			u32 val;
>>>> +
>>>> +			val = __raw_readl(host->regbase + CMD_DATABUF(words));
>>>> +
>>>> +			to += words * 4;
>>>> +			for (i = 0; i < len; i++, val >>= 8, to++)
>>>> +				*to = (u8)val;
>>>> +		}
>>>> +	} else {
>>>> +		for (i = 0; i < DIV_ROUND_UP(len, 4); i++) {
>>>> +			u32 val = __raw_readl(host->regbase + CMD_DATABUF(i));
>>>> +			int j;
> 
>>> The more usual pattern for these would be to do some unaligned accesses
>>> for the start/end of the buffer to get to alignment and then transfer
>>> the rest as aligned data.
> 
>> Yeah, I understand you, but for that I would need to generate multiple
>> transactions in the driver, and I wanted to keep 1x transaction per
>> spi_controller_mem_ops.exec_op call.
> 

Hi Mark,

>> So maybe I can do some trickery in my adjust_op_size method to generate
>> these multiple transactions: a. any unaligned start data b. the 32b-aligned
>> data b. unaligned end. I think that the HW should be able to handle that.
> 
> Right, that's what I was expecting.
> 

So that should work for xfer data commands, but generally the read/write 
reg commands in the SPI NOR layer would not use 
spi_mem_adjust_op_size(), like spi-nor.c:spi_nor_read_id(), as an example.

For these, I should be able to guarantee start alignment (since the 
buffer is kmalloc'ed), but not end alignment, so would still require 
4-byte + single byte copies for these.

Thanks,
John
