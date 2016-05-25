From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus number.
Date: Wed, 25 May 2016 09:31:25 -0700
Message-ID: <5745D35D.5090405@gmail.com>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se> <20160524174140.GE11605@leverpostej> <5745C3F8.4020909@gmail.com> <20160525160633.GC30956@leverpostej>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christer Weinigel <christer@weinigel.se>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525160633.GC30956@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 5/25/2016 9:06 AM, Mark Rutland wrote:
> On Wed, May 25, 2016 at 08:25:44AM -0700, Frank Rowand wrote:
>> On 5/24/2016 10:41 AM, Mark Rutland wrote:
>>> On Tue, May 24, 2016 at 06:39:20PM +0200, Christer Weinigel wrote:
>>>> +Normally SPI buses are assigned dynamic bus numbers starting at 32766
>>>> +and counting downwards.  It is possible to assign the bus number
>>>> +statically using devicetee aliases.  For example, on the MPC5200 the
>>>> +"spi@f00" device above is connected to the "soc" bus.  To set its
>>>> +bus_num to 1 add an aliases entry like this:
>>>
>>> As Mark Brown pointed out, this is very Linux-specific (at least in the
>>> wording of the above).
>>>
>>> Generally, aliases are there to match _physical_ identifiers (e.g. to
>>> match physical labels for UART0, UART1, and on).
>>
>> Can you point to anything in the specification or any other place that
>> states that aliases are for matching physical identifiers?
>>
>> Can you point to anything in the specification or any other place that
>> states that aliases are not to be used for anything else?
> 
> You have me there; I cannot find any wording to that effect, and I am
> evidently going by my understanding alone.

There seems to be a fair amount of things about devicetree that are tribal
knowledge.  I try to take note of these things as I see them and would
like to convert them from tribal knowledge to knowledge that is
explicitly stated in our documentation.  The documented knowledge may end
up being the same as the tribal lore, or we may find that it needs to be
modified as we document it.


> IEEE 1275 simply states that there may be predefined aliases for a
> machine, or that users can create and use them dynamically. ePAPR (and
> the devicetree specification) only states that aliases exist, and that a
> client program might use them (through some means which is never
> described).
> 
> Thanks,
> Mark.
> .
> 
