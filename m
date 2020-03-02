From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device
 buswidth
Date: Mon, 2 Mar 2020 09:30:08 +0000
Message-ID: <07bb2213-5543-0ef0-9585-be83026c1199@huawei.com>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-2-git-send-email-john.garry@huawei.com>
 <52ecb988-d842-c04b-a0e8-93e8850009c4@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Cc: <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linuxarm@huawei.com>,
        <linux-spi@vger.kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52ecb988-d842-c04b-a0e8-93e8850009c4@cogentembedded.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 01/03/2020 10:04, Sergei Shtylyov wrote:
> Hello!
> 

Hi Sergei,

> On 28.02.2020 18:18, John Garry wrote:
> 
>> Currently ACPI firmware description for a SPI device does not have any
>> method to describe the data buswidth on the board.
>>
>> So even through the controller and device may support higher modes than
>            ^^^^^^^
>     Though?
> 

right

>> standard SPI, it cannot be assumed that the board does - as such, that
>> device is limited to standard SPI in such a circumstance.
>>
>> As a workaround, allow the controller driver supply buswidth override 
>> bits,
>> which are used inform the core code that the controller driver knows the
>> buswidth supported on that board for that device.
>>
>> A host controller driver might know this info from DMI tables, for 
>> example.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/spi/spi.c       | 4 +++-
>>   include/linux/spi/spi.h | 3 +++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> index 38b4c78df506..292f26807b41 100644
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -510,6 +510,7 @@ struct spi_device *spi_alloc_device(struct 
>> spi_controller *ctlr)
>>       spi->dev.bus = &spi_bus_type;
>>       spi->dev.release = spidev_release;
>>       spi->cs_gpio = -ENOENT;
>> +    spi->mode = ctlr->buswidth_override_bits;
>>       spin_lock_init(&spi->statistics.lock);
>> @@ -2181,9 +2182,10 @@ static acpi_status 
>> acpi_register_spi_device(struct spi_controller *ctlr,
>>           return AE_NO_MEMORY;
>>       }
>> +
> 
>     What for?

slipped through the net

> 
>>       ACPI_COMPANION_SET(&spi->dev, adev);
>>       spi->max_speed_hz    = lookup.max_speed_hz;
>> -    spi->mode        = lookup.mode;
>> +    spi->mode        |= lookup.mode;
>>       spi->irq        = lookup.irq;
>>       spi->bits_per_word    = lookup.bits_per_word;
>>       spi->chip_select    = lookup.chip_select;
> [...]

TBH, I did not think that this series would be applied since I tagged it 
as RFC, hence the typos which would have been caught. Indeed, this also 
exposes an issue with enabling quad SPI for a spansion SPI NOR part, 
which I need to debug now in the SPI NOR driver.

Hi Mark,

Do you want me to do anything about the above superfluous newline?

Thanks,
John

> 
> MBR, Sergei
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> .
