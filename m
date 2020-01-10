From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Fri, 10 Jan 2020 14:58:54 +0000
Message-ID: <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <tudor.ambarus@microchip.com>, <linux-kernel@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-spi@vger.kernel.org>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <xuejiancheng@hisilicon.com>,
        <fengsheng5@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, <liusimin4@huawei.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200110140726.GB5889@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 10/01/2020 14:07, Mark Brown wrote:

+ Mika, Andy

> On Fri, Jan 10, 2020 at 11:55:37AM +0000, John Garry wrote: >
Hi Mark,

>> I will note that PRP0001+"jedec,spi-nor" compatible DSD seems to be the
>> defacto method to describe the SPI NOR-compat part for ACPI - that's what
>> I'm using. We could add properties there, but that seems improper.
> 
> OK, so that's just reusing the DT binding in which case everything
> that's valid for the DT binding should also be valid for ACPI - I
> thought that actually worked automatically without you having to do
> anything in the code but ICBW.

I thought that it would be improper as we could be mixing ACPI methods 
to describe the serial bus (SPI Serial Bus Connection Resource 
Descriptor) and also DT properties which could conflict, like CS active 
high.

However I do see extra properties than "compatible" being added in DSD 
for PRP0001:
https://patchwork.ozlabs.org/patch/662813/ (see EEPROM part)

And if we were to do this, I think that we would need to add some 
device_property_read_u32("spi-rx-bus-width", ...), etc calls in the SPI 
FW parsing for ACPI path - I couldn't see that.

Thanks,
John
