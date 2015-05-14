From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm-mspi: Add support for Broadcom MSPI driver.
Date: Thu, 14 May 2015 11:28:39 -0700
Message-ID: <5554E957.3030809@gmail.com>
References: <1431452293-16697-1-git-send-email-jonathar@broadcom.com> <1431452293-16697-3-git-send-email-jonathar@broadcom.com> <20150512191718.GW3066@sirena.org.uk> <5553E31A.8060309@broadcom.com> <5553E9FA.4070708@broadcom.com> <20150514103144.GO2761@sirena.org.uk> <5554E715.7070203@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5554E715.7070203-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 14/05/15 11:19, Scott Branden wrote:
> Hi Mark,
> 
> On 15-05-14 03:31 AM, Mark Brown wrote:
>> On Wed, May 13, 2015 at 05:19:06PM -0700, Scott Branden wrote:
>>
>>> The purpose of this mspi interface is to connect to NOR flash.  There
>>> are
>>> other SPI interfaces on the devices used to connect to other SPI
>>> devies.  We
>>> don't have any need to support full duplex slaves on this port (NOR
>>> have any
>>> hardware wired this way - pun realized after typing this).
>>
>> Chip vendors often say this sort of thing and then get surprised by what
>> their users choose to do, and even if it only ever gets used with flash
>> all it would take is some new flash command which can use full duplex
>> for something.  Please write the code so it at least tries to handle
>> full duplex operation, if you can't test it fully that's not the end of
>> the world.  It doesn't look like it should be particularly difficult.
>>
> Yes, there is always room for improvements in code.  In this case - it
> really is not worth our time to add code we can't test.  We try to
> deliver code that we can test and actually works.  Yes, if anyone needs
> to use the mspi for full duplex operation code can be added in the
> future - it is software.  This block has gone through many generations
> of our SoCs and has only been used for this purpose - the bootROM boots
> from this SPI only.  It is dedicated for this purpose.
> 
> Also, there are other SPI blocks on the SoC that are used for connect
> other SPI devices.  These SPI blocks are properly designed for
> full-duplex operation.  This mspi block is designed for connecting to
> NOR flash.

This is an implementation detail and architectural choice that is
specific to the Cygnus SoCs where a single MSPI is present, right?

This same MSPI block is instantiated multiple times in BCM7xxx chips to
interface to general purpose SPI slaves, ranging from Ethernet switches
to bluetooth chips etc... those will definitively want full-duplex to be
working.

I would greatly appreciate if some thought to supporting full duplex
transfers was given in this driver drop. If you cannot test that, then
maybe just flag the driver has been half-duplex only for now...

Thank you.
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
