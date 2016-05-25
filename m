From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus number.
Date: Wed, 25 May 2016 11:06:46 -0700
Message-ID: <5745E9B6.5090204@gmail.com>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se> <20160524172045.GN8206@sirena.org.uk> <57449784.4070108@weinigel.se> <20160524183256.GP8206@sirena.org.uk> <5744E51A.1040506@gmail.com> <20160525174932.GA10753@rob-hp-laptop>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
	Christer Weinigel <christer@weinigel.se>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525174932.GA10753@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 5/25/2016 10:49 AM, Rob Herring wrote:
> On Tue, May 24, 2016 at 04:34:50PM -0700, Frank Rowand wrote:
>> On 5/24/2016 11:32 AM, Mark Brown wrote:
>>> On Tue, May 24, 2016 at 08:03:48PM +0200, Christer Weinigel wrote:
>>>> On 05/24/2016 07:20 PM, Mark Brown wrote:
>>>
>>>>> I'm not sure this is something we want to support at all, I can't 
>>>>> immediately see anything that does this deliberately in the SPI
>>>>> code and obviously the "bus number" is something of a Linux
>>>>> specific concept which would need some explanation if we were going
>>>>> to document it.  It's something I'm struggling a bit to see a
>>>>> robust use case for that isn't better served by parsing sysfs,
>>>>> what's the goal here?
>>>
>>>> If this isn't something that should be in the Documentation/devicetree
>>>>  because it's not generig enough, where should Linux-specific
>>>> interpretations such as this be documented?
>>>
>>> I'm not clear that we want to document this at all since I am not clear
>>> that there is a sensible use case for doing it.  I did ask for one but
>>> you've not articulated one in this reply.  I am much less gung ho than
>>> Grant on this one, even as a Linux specific interface it seems very
>>> legacy.
> 
> No, we don't.
> 
>>>
>>
>> The time for the use case was when the patch was accepted.
> 
> Ideally, yes, but things getting missed in review or later deciding 
> things were a bad idea can always be debated again.
> 
>> It is in the kernel, it is appropriate to document it.
> 
> Things get undocumented all the time when we deprecate them.

If it is deprecated then it should be documented as deprecated so
people do not attempt to use it.

> 
> Rob
> 
