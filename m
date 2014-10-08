From: Thor Thayer <tthayer@opensource.altera.com>
Subject: Re: [PATCH 2/2] arm: dts: socfpga: Add SPI nodes & update copyright.
Date: Wed, 8 Oct 2014 13:07:44 -0500
Message-ID: <54357D70.5000302@opensource.altera.com>
References: <1412711297-31857-1-git-send-email-tthayer@opensource.altera.com> <1412711297-31857-3-git-send-email-tthayer@opensource.altera.com> <20141007203123.GA15799@pengutronix.de> <5434535A.9070101@opensource.altera.com> <20141008080103.GB15799@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <jkosina@suse.cz>, <pawel.moll@arm.com>,
	<robh+dt@kernel.org>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<dinguyen@opensource.altera.com>, <linux-spi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<tthayer.linux@gmail.com>, <tthayer@altera.com>,
	<axel.lin@ingics.com>, <baruch@tkos.co.il>,
	<andriy.shevchenko@linux.intel.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20141008080103.GB15799@pengutronix.de>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 10/08/2014 03:01 AM, Steffen Trumtrar wrote:
> Hi!
>
> On Tue, Oct 07, 2014 at 03:55:54PM -0500, Thor Thayer wrote:
>> On 10/07/2014 03:31 PM, Steffen Trumtrar wrote:
>>> Hi!
>>>
>>> On Tue, Oct 07, 2014 at 02:48:17PM -0500, tthayer@opensource.altera.com wrote:
>>>> From: Thor Thayer <tthayer@opensource.altera.com>
>>>>
>>>> Add 2 SPI nodes to SOCFPGA device tree. Update copyright.
>>>> Update spi-dw.txt with bus-num as an optional property.
>>>>
>>>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/spi/spi-dw.txt |    1 +
>>>>   arch/arm/boot/dts/socfpga.dtsi                   |   52 ++++++++++++++++++----
>>>>   2 files changed, 45 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-dw.txt b/Documentation/devicetree/bindings/spi/spi-dw.txt
>>>> index 7b63ed6..f1d54e6 100644
>>>> --- a/Documentation/devicetree/bindings/spi/spi-dw.txt
>>>> +++ b/Documentation/devicetree/bindings/spi/spi-dw.txt
>>>> @@ -11,6 +11,7 @@ Required properties:
>>>>   Optional properties:
>>>>   - cs-gpios: see spi-bus.txt
>>>> +- bus-num: see spi-bus.txt
>>>>   Example:
>>>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>>>> index 4d77ad6..42855bc 100644
>>>> --- a/arch/arm/boot/dts/socfpga.dtsi
>>>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>>>> @@ -1,15 +1,14 @@
>>>>   /*
>>>> - *  Copyright (C) 2012 Altera <www.altera.com>
>>>> + * Copyright Altera Corporation (C) 2012-2014. All rights reserved.
>>>>    *
>>>>    * This program is free software; you can redistribute it and/or modify
>>>> - * it under the terms of the GNU General Public License as published by
>>>> - * the Free Software Foundation; either version 2 of the License, or
>>>> - * (at your option) any later version.
>>>> + * it under the terms and conditions of the GNU General Public License,
>>>> + * version 2, as published by the Free Software Foundation.
>>>>    *
>>>> - * This program is distributed in the hope that it will be useful,
>>>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> - * GNU General Public License for more details.
>>>> + * This program is distributed in the hope it will be useful, but WITHOUT
>>>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>>>> + * more details.
>>> This shouldn't be in the same patch IMHO.
>> Hi Steffen,
>>
>> Are you saying the socfpga.dtsi changes shouldn't be in the patch or
>> the copyright update?
>>
>> If the copyright update, it seemed like a good time since there were
>> other changes.
>>
> Going with what Mark Brown said: Split it up more.
Hi Steffen!

OK. I will do that.
>>>>    *
>>>>    * You should have received a copy of the GNU General Public License
>>>>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>>> @@ -628,6 +627,43 @@
>>>>   			clock-names = "biu", "ciu";
>>>>   		};
>>>> +		spi0: spi@fff00000 {
>>>> +			compatible = "snps,dw-apb-ssi";
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <0>;
>>>> +			reg = <0xfff00000 0x1000>;
>>>> +			interrupts = <0 154 4>;
>>>> +			num-cs = <4>;
>>>> +			bus-num = <0>;
>>>> +			clocks = <&per_base_clk>;
>>>> +
>>>> +			spidev@0 {
>>>> +				compatible = "spidev";
>>>> +				reg = <0>;	/* chip select */
>>>> +				spi-max-frequency = <100000000>;
>>>> +				enable-dma = <1>;
>>>> +			};
>>>> +		};
>>>> +
>>>> +		spi1: spi@fff01000 {
>>>> +			compatible = "snps,dw-apb-ssi";
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <0>;
>>>> +			reg = <0xfff01000 0x1000>;
>>>> +			interrupts = <0 156 4>;
>>>> +			num-cs = <4>;
>>>> +			bus-num = <1>;
>>>> +			clocks = <&per_base_clk>;
> 				   ^^^^^^^^^^^^
> Shouldn't this be spi_m_clk?
Yes. Thank you!
>>>> +			status = "disabled";
>>>> +
>>>> +			spidev@0 {
>>>> +				compatible = "spidev";
>>>> +				reg = <0>;
>>>> +				spi-max-frequency = <100000000>;
>>>> +				enable-dma = <1>;
>>>> +			};
>>>> +		};
>>>> +
>>> I don't think, this is the right place. Put it in the board dts.
>>> Oh, and why is spi0 not disabled but spi1 is?
>> OK. I can put it in the board dts. I thought the IP would go in the
>> socfpga.dtsi file since it describes the chip.
>>
> Okay, I see that my comment is unclear. What I wanted to say is:
> put the spidev into your board dts. Other boards might have something
> else connected there.
>
>> I understand your point which is why the 2nd SPI is disabled - it is
>> not pinned out on the Development Kit board.
>>
> Okay. Then disable both in the dtsi and enable the one you want to use
> in your board file. The dtsi should only have stuff that is common to
> ALL Socfpgas, so the IPs (if they are the same, which AFAIK they are).
Understood & thanks for explaining. This would be better.

Thanks for reviewing!

Thor
> Regards,
> Steffen
>

