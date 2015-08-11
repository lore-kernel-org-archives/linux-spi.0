From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [RESEND][PATCH 3/4] ARM: davinci: Set proper SPI prescale limit
 value
Date: Tue, 11 Aug 2015 14:54:33 +0530
Message-ID: <55C9BF51.5080401@ti.com>
References: <1437568344-18889-1-git-send-email-fcooper@ti.com> <1437568344-18889-4-git-send-email-fcooper@ti.com> <55B22681.3060000@ti.com> <55C9380D.1060802@ti.com> <55C99D0D.9050605@ti.com> <20150811090342.GG10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>,
	<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-arm-kernel-xBCQruHUn5ppWr+L1FloEB2eb7JE58TQ@public.gmane.org>, <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150811090342.GG10748-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday 11 August 2015 02:33 PM, Mark Brown wrote:
> On Tue, Aug 11, 2015 at 12:28:21PM +0530, Sekhar Nori wrote:
>> On Tuesday 11 August 2015 05:17 AM, Franklin S Cooper Jr. wrote:
> 
>>> ping. Patches 1 and 2 have already been pulled into Mark's spi tree and are currently in in linux-next.
> 
>> Mark, can you apply this patch to your tree as well? Thats the preferred
>> route for me.
> 
>> If thats not an option for you, can you confirm that the topic/davinci
>> branch of your spi tree is an immutable commit I can base my pull
>> request to ARM-SoC on?
> 
> Why would there be any interdependency between the the two trees, that
> would be very unusual?  Adding a new value to DT doesn't need the kernel
> to understand it and the driver should be compatible with existing DTs.
> If there *is* some dependency that suggests the driver update has
> problems...

The dependency is because of platform data. Patch 2/4 adds a new
platform data member 'prescaler_limit' which this patch populates for
DaVinci devices using legacy booting.

> In any case I don't have a copy of the patch any more.

I can resend this patch to you with my ack included.

Thanks,
Sekhar

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
