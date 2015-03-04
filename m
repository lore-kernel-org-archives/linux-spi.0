From: Thor Thayer <tthayer@opensource.altera.com>
Subject: Re: [RFC/PATCH 0/2] spi: spi-dw: Select 16b or 32b register access
Date: Wed, 4 Mar 2015 16:01:02 -0600
Message-ID: <54F7809E.2010307@opensource.altera.com>
References: <1425501075-17081-1-git-send-email-tthayer@opensource.altera.com> <1425501868.14897.178.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <grant.likely@linaro.org>, <jkosina@suse.cz>,
	<pawel.moll@arm.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <dinguyen@opensource.altera.com>,
	<linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <tthayer.linux@gmail.com>,
	<axel.lin@ingics.com>, <baruch@tkos.co.il>, <jg1.han@samsung.com>,
	<galak@codeaurora.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1425501868.14897.178.camel@linux.intel.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Andy,

On 03/04/2015 02:44 PM, Andy Shevchenko wrote:
> On Wed, 2015-03-04 at 14:31 -0600, tthayer@opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> The Altera Arria10 SoC requires 32 bit accesses to peripherals. The
>> DesignWare SPI peripheral registers are on 32bit boundaries so this
>> patch is minimal. Function pointers are used to select 32bit access
>> or 16bit accesses.
>
>
> So, what is exactly the issue when we read only half of the register?
> Bus lock, or what?
>

The read actually works on our chip but I changed both read and write to 
be consistent. For Arria10, on a 16 bit write the data isn't written 
into the DesignWare register.

In reply to your other email, yes it does support the DW_apb_ssi but the 
Arria10 architecture requires 32 bit access (actually as you point out, 
32 bit writes). We're using the original driver on our older chips but 
Arria10 requires upstream changes.

>>
>> Thor Thayer (2):
>>    dt-binding: spi: spi-dw: Select 16b or 32b access for Designware SPI
>>    spi: dw-spi: Pointers select 16b vs. 32b DesignWare access
>>
>>   Documentation/devicetree/bindings/spi/spi-dw.txt |    1 +
>>   drivers/spi/spi-dw-mmio.c                        |    7 +++-
>>   drivers/spi/spi-dw.c                             |   38 +++++++++++++---------
>>   drivers/spi/spi-dw.h                             |   10 +++---
>>   4 files changed, 35 insertions(+), 21 deletions(-)
>>
>
>
