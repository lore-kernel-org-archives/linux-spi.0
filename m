From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Tue, 19 Jul 2016 15:15:49 -0700
Message-ID: <578EA695.1030909@gmail.com>
References: <1466197433-11290-1-git-send-email-kdasu.kdev@gmail.com>
 <1466197433-11290-2-git-send-email-kdasu.kdev@gmail.com>
 <20160622160726.GQ28202@sirena.org.uk>
 <CAKekbevYN3CLvqQs3stUXDFEMREMOJ0g4+w7Zsno1kV-ieYEiw@mail.gmail.com>
 <20160701160753.GX6247@sirena.org.uk>
 <CAC=U0a3WN9TGw7zwwP3qFf5MUsRteUcVLytFgjnP4zScZS0xXA@mail.gmail.com>
 <20160713111053.GG9976@sirena.org.uk> <5786B401.2050306@gmail.com>
 <20160713223638.GI9976@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160713223638.GI9976-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 07/13/2016 03:36 PM, Mark Brown wrote:
> On Wed, Jul 13, 2016 at 02:34:57PM -0700, Florian Fainelli wrote:
>> On 07/13/2016 04:10 AM, Mark Brown wrote:
> 
>>> It's not really about reuse, it's about maintainability.  All the code
>>> for handling this within the driver is quite unusual and makes the
>>> driver harder to understand and review.  That's going to have an impact
>>> now and make things harder to follow in future too.  Fitting in with the
>>> frameworks means that we get the benefit of the structure and support
>>> code that the frameworks provide while minimizing the amount of unusal
>>> code in the driver.
> 
>> This is not unusual at all, there are tons of peripherals that embed a
>> L2/L3 interrupt controller, yet keep the code localized because the
>> interrupt sources are not visible outside of the specific block and it
>> would not make sense to demultiplex these different interrupt sources as
>> individually requestable interrupt lines when the consumer is also local
>> and self contained.
> 
> If it was unconditionally in the perhipheral it'd be fairly normal and
> standard but it's not, it's a completely separate and optional register
> block with a bunch of separate code in a driver which already has above
> average complexity even for the bits that belong in it.

It is not separate nor optional, the fact that the register range seems
discontiguous is just an integration choice here, but it contains bits
that are relevant exclusively to the SPI controller.

> 
>> This is exactly what is going on here, and it this makes the driver more
>> self contained without external dependencies to an irqchip driver to an
>> interrupt controller provider.
> 
> Like I say it just isn't, it's an obviously separate interrupt
> controller.

First of all you cannot make that statement with just looking at the
code and not having access to the datasheet, but I will accept that the
limited view of what you got to see from the driver can make you think that.

It is not exclusively an interrupt controller, there are other bits in
there are do not functionally belong into an interrupt controller driver
per-se, things like a clock enable, arbiter control and a random bit to
control MSPI flush behavior.

Oh, and please don't tell me regmap is the solution here if we need to
control both the interrupt-related bits and the other bits within this
register.

> 
>> The reusability argument is kind of the only one that makes sense here,
>> maintaining two drivers instead of one seems like more maintenance
>> burden imho.
> 
> It's definitely adding to the review complexity as things stand mainly
> due to the obvious disconnect from the actual IP.  It should take very
> little time to refactor and it's really hard to see it ever taking much
> time to maintain in future, though it might be helpful if one of your
> hardware engineers ever tries to reuse that IP.
> 

Considering that this block aggregates interrupt enable bits, but not
just, there is no reason for this block to change over time, and clearly
this won't be handled via a generic interrupt controller driver either.
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
