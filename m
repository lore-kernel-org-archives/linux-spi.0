From: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus number.
Date: Wed, 25 May 2016 08:32:51 -0700
Message-ID: <5745C5A3.6060202@gmail.com>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se> <20160524174140.GE11605@leverpostej> <5744BC76.9090403@gmail.com> <20160525092034.GE1337@leverpostej>
Reply-To: frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160525092034.GE1337@leverpostej>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 5/25/2016 2:20 AM, Mark Rutland wrote:
> On Tue, May 24, 2016 at 01:41:26PM -0700, Frank Rowand wrote:
>> On 5/24/2016 10:41 AM, Mark Rutland wrote:
>>> On Tue, May 24, 2016 at 06:39:20PM +0200, Christer Weinigel wrote:
>>>> Document how to use devicetree aliases to assign a stable
>>>> bus number to a spi bus.
>>>>
>>>> Signed-off-by: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
>>>>
>>>> ---
>>>>
>>>> Trivial documentation change.
>>>>
>>>> Not having used devicetree that much it was surprisingly hard to
>>>> figure out how to assign a stable bus number to a spi bus.  Add a
>>>> simple example that shows how to do that.
>>>>
>>>> Mark Cced as the SPI maintainer.  Or should trivial documentation
>>>> fixes like this be addressed to someone else?
>>>>
>>>>   /Christer
>>>>
>>>>  Documentation/devicetree/bindings/spi/spi-bus.txt | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
>>>> index 42d5954..c35c4c2 100644
>>>> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
>>>> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
>>>> @@ -94,3 +94,13 @@ SPI example for an MPC5200 SPI bus:
>>>>  			reg = <1>;
>>>>  		};
>>>>  	};
>>>> +
>>>> +Normally SPI buses are assigned dynamic bus numbers starting at 32766
>>>> +and counting downwards.  It is possible to assign the bus number
>>>> +statically using devicetee aliases.  For example, on the MPC5200 the
>>>> +"spi@f00" device above is connected to the "soc" bus.  To set its
>>>> +bus_num to 1 add an aliases entry like this:
>>>
>>> As Mark Brown pointed out, this is very Linux-specific (at least in the
>>> wording of the above).
>>
>> Yes, Linux-specific.  So the Linux documentation of bindings is the
>> correct place for it.
> 
> I don't entirely agree. Which is not to say that I disagree as such, but
> rather that this is not a black-and-white affair.
> 
> While bindings do happen to live in the kernel tree, we try to keep them
> separate from Linux internals or Linux API details that are outside of
> the scope of the HW/kernel interface. There are certainly reasons to
> describe Linux-specific bindings (e.g. things under /chosen).

Where should this be documented?


> Mark Brown's comments imply that there is a better mechanism which does
> not rely on this binding, so even if we must retain support for it in
> Linux for legacy reasons, documenting it as a binding is not necessarily
> in anyone's best interest. If we want to document it, we may want to
> mark it as deprecated, with a pointer to better alternatives.

Lack of documentation and bad documentation are a MAJOR problem for
devicetree.

Refusing to accept documentation of existing behavior makes no
sense to me.


>>> Generally, aliases are there to match _physical_ identifiers (e.g. to
>>> match physical labels for UART0, UART1, and on).
>>>
>>> I'm not sure whether that applies here.
>>
>> The code and behavior is in the Linux kernel. It should be visible in
>> the documentation instead of being a big mystery of how it works.
> 
> As above, I don't entirely agree. Mindlessly documenting existing Linux
> behaviour can have the unfortuante effect of moving people towards the
> wrong tool for the job.
> 
> Thanks,
> Mark.
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
