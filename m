From: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus number.
Date: Wed, 25 May 2016 09:21:13 -0700
Message-ID: <5745D0F9.9000807@gmail.com>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se> <20160524174140.GE11605@leverpostej> <5744BC76.9090403@gmail.com> <20160525092034.GE1337@leverpostej> <5745C5A3.6060202@gmail.com> <20160525155949.GB30956@leverpostej>
Reply-To: frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160525155949.GB30956@leverpostej>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 5/25/2016 8:59 AM, Mark Rutland wrote:
> On Wed, May 25, 2016 at 08:32:51AM -0700, Frank Rowand wrote:
>> On 5/25/2016 2:20 AM, Mark Rutland wrote:
>>> On Tue, May 24, 2016 at 01:41:26PM -0700, Frank Rowand wrote:
>>>> On 5/24/2016 10:41 AM, Mark Rutland wrote:
>>>>> On Tue, May 24, 2016 at 06:39:20PM +0200, Christer Weinigel wrote:
>>>>>> Document how to use devicetree aliases to assign a stable
>>>>>> bus number to a spi bus.
>>>>>>
>>>>>> Signed-off-by: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> Trivial documentation change.
>>>>>>
>>>>>> Not having used devicetree that much it was surprisingly hard to
>>>>>> figure out how to assign a stable bus number to a spi bus.  Add a
>>>>>> simple example that shows how to do that.
>>>>>>
>>>>>> Mark Cced as the SPI maintainer.  Or should trivial documentation
>>>>>> fixes like this be addressed to someone else?
>>>>>>
>>>>>>   /Christer
>>>>>>
>>>>>>  Documentation/devicetree/bindings/spi/spi-bus.txt | 10 ++++++++++
>>>>>>  1 file changed, 10 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
>>>>>> index 42d5954..c35c4c2 100644
>>>>>> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
>>>>>> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
>>>>>> @@ -94,3 +94,13 @@ SPI example for an MPC5200 SPI bus:
>>>>>>  			reg = <1>;
>>>>>>  		};
>>>>>>  	};
>>>>>> +
>>>>>> +Normally SPI buses are assigned dynamic bus numbers starting at 32766
>>>>>> +and counting downwards.  It is possible to assign the bus number
>>>>>> +statically using devicetee aliases.  For example, on the MPC5200 the
>>>>>> +"spi@f00" device above is connected to the "soc" bus.  To set its
>>>>>> +bus_num to 1 add an aliases entry like this:
>>>>>
>>>>> As Mark Brown pointed out, this is very Linux-specific (at least in the
>>>>> wording of the above).
>>>>
>>>> Yes, Linux-specific.  So the Linux documentation of bindings is the
>>>> correct place for it.
>>>
>>> I don't entirely agree. Which is not to say that I disagree as such, but
>>> rather that this is not a black-and-white affair.
>>>
>>> While bindings do happen to live in the kernel tree, we try to keep them
>>> separate from Linux internals or Linux API details that are outside of
>>> the scope of the HW/kernel interface. There are certainly reasons to
>>> describe Linux-specific bindings (e.g. things under /chosen).
>>
>> Where should this be documented?
> 
> That is a very good question, and one with no good or general answer.
> There are distinct answers for new and existing bindings.
> 
> New bindings should not rely on Linux internals, and should be framed in
> terms of hardware or system design properties (there's some wiggle room
> for intent and configuration, in the case of things like watchdog
> timeouts).
> 
> Existing cases should (almost always) be documented in the usual places,
> but caveats apply:
> 
> (a) If they only exist as a workaround for legacy erroneous DT usage,
> then documenting them does not make sense. They are Linux-specific
> kludges.

When there is no other documentation, the kernel source is the
documentation.  If there is no mention that a case is for legacy
use only then someone will attempt to use it.  So I prefer that
the case be documented and noted to be legacy.


> (b) If they exist, but are discouraged, we must mark them deprecated,
> and point at the encouraged way of doing things. I expect that many
> Linux-specific bindings fall in this case.
> 
> (c) If they exist, and there is no other mechanism to provide equivalent
> functionality, then we must document them extremely carefully, with
> rationale and caveats. These cases highlight a hole in our ability to
> describe and/or abstract hardware, and we'd like to move these into
> category b.
> 
> Regardless, if we can frame them as hardware properties and get rid of
> any reliance on Linux internal details, that is preferable.
> 
>>> Mark Brown's comments imply that there is a better mechanism which does
>>> not rely on this binding, so even if we must retain support for it in
>>> Linux for legacy reasons, documenting it as a binding is not necessarily
>>> in anyone's best interest. If we want to document it, we may want to
>>> mark it as deprecated, with a pointer to better alternatives.
>>
>> Lack of documentation and bad documentation are a MAJOR problem for
>> devicetree.
> 
> I certainly agree.
> 
>> Refusing to accept documentation of existing behavior makes no
>> sense to me.
> 
> To be clear: I am not refusing to document this.
> 
> I am trying to ensure that we document this _appropriately_, with any
> caveats that apply, and (as far as possible) framed so as to not
> describe Linux internals.

I am glad to hear that.

But I have not seen any attempt by anyone in this thread to provide
any help to Christer with how to change his documentation patch so
that it is appropriately documenting the existing code and will be
accepted.  (The following "e.g." is maybe such an attempt.)


> e.g. stating that this describes a well-defined system-specific bus
> number as documented in a manual, with a note regarding Linux behaviour
> is better simply describing the Linux behaviour.
> 
> Thanks,
> Mark.
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
