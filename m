From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Fri, 31 Jan 2020 16:26:46 +0000
Message-ID: <c5cfb189-797e-11c4-f77a-61ec35395b15@huawei.com>
References: <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
 <20200110193119.GI32742@smile.fi.intel.com>
 <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
 <20200113114256.GH3897@sirena.org.uk>
 <6dd45da9-9ccf-45f7-ed12-8f1406a0a56b@huawei.com>
 <20200113140627.GJ3897@sirena.org.uk>
 <CAHp75VfepiiVFLLmCwdBS0Z6tmR+XKBaOLg1qPPuz1McLjS=4Q@mail.gmail.com>
 <20200113142754.GL3897@sirena.org.uk>
 <20200113143403.GQ32742@smile.fi.intel.com>
 <0252a76d-7e2b-2c70-8b1b-0d041d972098@huawei.com>
 <CAHp75Ve=ZwJe2XV8Y1UN6sMe1ZHOBwUtRUD=aGqhR4Gc7BNUcg@mail.gmail.com>
 <136bd652-dcb9-3efa-a92f-2263cbf840ad@huawei.com>
 <CAHp75Vd=TY0tPfSHMSLTh1Pgg-E7MCP5Gym1yjpLgH0Tx-2xSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jiancheng Xue <xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>,
        <chenxiang66-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <liusimin4-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        wanghuiqiang <wanghuiqiang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, <fengsheng5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75Vd=TY0tPfSHMSLTh1Pgg-E7MCP5Gym1yjpLgH0Tx-2xSg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 31/01/2020 15:46, Andy Shevchenko wrote:
> On Fri, Jan 31, 2020 at 2:03 PM John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:
>> On 31/01/2020 11:39, Andy Shevchenko wrote:
>>> On Fri, Jan 31, 2020 at 12:08 PM John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:
>>>> On 13/01/2020 14:34, Andy Shevchenko wrote:
> 
> ...
> 
>>>> About this topic of ACPI having no method to describe device buswidth in
>>>> the resource descriptor, it may be an idea for me to raise a Tianocore
>>>> feature request @ https://bugzilla.tianocore.org/
>>>>
>>>
>>> The 19.6.126 describes the SPI resource, in particular:
>>>
>>> ---8<---8<---
>>> DataBitLength is the size, in bits, of the smallest transfer unit for
>>> this connection. _LEN is automatically
>>> created to refer to this portion of the resource descriptor.
>>> ---8<---8<---
>>>

Hi Andy,

>>> Is it what you are looking for? (As far as I know most of the
>>> firmwares simple abuse this field among others)
>>
>> I didn't think so - I thought that there was a distinction between width
>> and length in SPI terms.
> 
> My interpretation of this field is a data width of the slave.
> Basically what we have as transfer->size inside SPI in the Linux
> kernel.
> 
>> So how do you find that most firmwares abuse this field? AFAICS, linux
>> kernel doesn't interpret this field at all.
> 
>>From all tables I have this is the result of appearance (some of the
> tables are like 10x times present in my data base, but nevertheless)
> 
>      140 SpiSerialBusV2(0x0000,PolarityHigh,FourWireMode,0x08,
>     411 SpiSerialBusV2(0x0000,PolarityLow,FourWireMode,0x08,
>       1 SpiSerialBusV2(0x0000,PolarityLow,FourWireMode,0x08,
>      36 SpiSerialBusV2(0x0000,PolarityLow,FourWireMode,0x10,
>      35 SpiSerialBusV2(0x0000,PolarityLow,FourWireMode,0x18,
>      35 SpiSerialBusV2(0x0000,PolarityLow,FourWireMode,0x20,
>       1 SpiSerialBusV2(0x0000,PolarityLow,ThreeWireMode,0x10,
>       8 SpiSerialBusV2(0x0001,PolarityLow,FourWireMode,0x08,
>       1 SpiSerialBusV2(0x0001,PolarityLow,FourWireMode,0x10,
> 
> So, it seems I stand corrected, the field is in right use, although
> cases like 0x10 and 0x20 should be carefully checked.
> 
> We may teach kernel to get something meaningful out of it.
> 

It seems that someone already had a go at that:
https://lore.kernel.org/lkml/20170317212143.bogj6efzyvvf24yd-GFdadSzt00ze9xe1eoZjHA@public.gmane.org/

Thanks,
John
