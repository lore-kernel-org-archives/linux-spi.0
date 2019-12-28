From: kongxinwei <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH] spi: dw: use "smp_mb()" to avoid sending spi data error
Date: Sat, 28 Dec 2019 16:31:53 +0800
Message-ID: <afad8a97-6159-bf7e-466a-fdbaf0a07d4a@hisilicon.com>
References: <1577352088-35856-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <20191227002239.GH27497@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, fengsheng <fengsheng5@huawei.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191227002239.GH27497@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 2019/12/27 8:22, Mark Brown wrote:
> On Thu, Dec 26, 2019 at 05:21:28PM +0800, Xinwei Kong wrote:
>> this patch will add memory barrier to ensure this "struct dw_spi *dws"
>> to complete data setting before enabling this SPI hardware interrupt.
>> eg:
>> it will fix to this following low possibility error in testing environment
>> which using SPI control to connect TPM Modules
> 
>> --- a/drivers/spi/spi-dw.c
>> +++ b/drivers/spi/spi-dw.c
>> @@ -288,6 +288,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>>  	dws->rx_end = dws->rx + transfer->len;
>>  	dws->len = transfer->len;
>>  
>> +	smp_mb();
>> +
>>  	spi_enable_chip(dws, 0);
> 
> I'd be much more comfortable here if I understood what this was
> supposed to be syncing - what exactly gets flushed here and why
> is a memory barrier enough to ensure it's synced?  A comment in
> the code would be especially good so anyone modifying the code
> understands this in future.
> 
Because of out-of-order execution about some CPU architecture,
In this debug stage we find Completing spi interrupt enable ->
prodrucing TXEI interrupt -> running "interrupt_transfer" function
will prior to set "dw->rx and dws->rx_end" data, so it will result
in SPI sending error
