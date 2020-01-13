From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Mon, 13 Jan 2020 10:09:27 +0000
Message-ID: <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
 <20200110193119.GI32742@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, <tudor.ambarus@microchip.com>,
        <linux-kernel@vger.kernel.org>, <chenxiang66@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-spi@vger.kernel.org>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <xuejiancheng@hisilicon.com>, <fengsheng5@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, <liusimin4@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200110193119.GI32742@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 10/01/2020 19:31, Andy Shevchenko wrote:
> On Fri, Jan 10, 2020 at 02:58:54PM +0000, John Garry wrote:
>> On 10/01/2020 14:07, Mark Brown wrote:
>>> On Fri, Jan 10, 2020 at 11:55:37AM +0000, John Garry wrote: >
> 
> ...
> 
>>>> I will note that PRP0001+"jedec,spi-nor" compatible DSD seems to be the
>>>> defacto method to describe the SPI NOR-compat part for ACPI - that's what
>>>> I'm using. We could add properties there, but that seems improper.
>>>
>>> OK, so that's just reusing the DT binding in which case everything
>>> that's valid for the DT binding should also be valid for ACPI - I
>>> thought that actually worked automatically without you having to do
>>> anything in the code but ICBW.
>>
>> I thought that it would be improper as we could be mixing ACPI methods to
>> describe the serial bus (SPI Serial Bus Connection Resource Descriptor) and
>> also DT properties which could conflict, like CS active high.
>>
>> However I do see extra properties than "compatible" being added in DSD for
>> PRP0001:
>> https://patchwork.ozlabs.org/patch/662813/ (see EEPROM part)
> 

Hi Andy,

> PRP method is only for vendors to *test* the hardware in ACPI environment.
> The proper method is to allocate correct ACPI ID.

Yes, that would seem the proper thing to do. So the SPI NOR driver is 
based on micron m25p80 and compatible string is "jedec,spi-nor", so I 
don't know who should or would do this registration.

> 
> Properties (_DSD in ACPI) may be used in the same way as for DT if we have no
> other means in ACPI specification for them.
> 
>> And if we were to do this, I think that we would need to add some
>> device_property_read_u32("spi-rx-bus-width", ...), etc calls in the SPI FW
>> parsing for ACPI path - I couldn't see that.
> 
> It's okay as long as you have ACPI ID.

Well there is none AFAIK.

> 
> P.S. Most of the sensor drivers were updated in order to support ACPI PRP
> method due to DIY hobbyist on IoT sector and embedded devices. This should not
> be an official way how we support hardware on ACPI-based platforms.

Yeah, so we could do this. But, as I mentioned already, this could mean 
that we conflicting properties. For this the kernel driver prob should 
only pay attention to properties which ACPI cannot describe.

Even better would be to update the ACPI spec, especially for something 
general like SPI bus width

BTW, Do any of these sensors you mention have any ACPI standardization?

Thanks,
John
