From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2 - RESEND] SPI: BCM2835: allow arbitrary GPIO to act as SPI-chip_select
Date: Wed, 25 Mar 2015 20:43:36 +0100
Message-ID: <561486F6-3580-4884-8A6A-8477D8C3BDC9@martin.sperl.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <1426755714-28130-2-git-send-email-kernel@martin.sperl.org> <550BAA89.5090707@wwwdotorg.org> <20150320095247.GE2869@sirena.org.uk> <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org> <20150325151611.GA3572@sirena.org.uk> <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org> <20150325165441.GI3572@sirena.org.uk> <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA@martin.sperl.org> <20150325185007.GL3572@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150325185007.GL3572-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 25.03.2015, at 19:50, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> This sounds like you're trying to work aroud the core rather than work
> with the core - enhance the core so that it can express what you need.
> 

Working in a single driver makes things more local without having
a "moving" target with lots of other patches. If done right most of it
then can get moved to the core - if needed...

>> From my perspective I want to minimize the dependencies while I create
>> this proof of concept.
>> And for my testing this with several different devices I need support
>> for multiple devices and for that I need this patch go in first.
>> Taking baby steps here.
> 
> I had been under the impression that you had already done a lot of proof
> of concept work with this stuff?

I had an Idea - that specific one has not been tested yet, but from the
measurements on interrupt and scheduling latencies these seem low hanging
fruit.

> 
>> Also there is another point here, that Stephen pointed out:
>> Would not a switch from the use of the "native-cs" to "gpio-only" mean
>> a required change in Device-tree? And isn't DT assumed to be a stabe API?
> 
> Can you be more specific about what change you think might be required?
> Currently the driver doesn't support GPIOs as chip selects at all so
> anything enabling them is going to be new.
Well, if we say we "need" gpio_cs to be set in DT of the master, then
that might be assumed an API change that might break some custom 
device-trees - I was mostly referring to that.

So how would that situation be with the requirement to use the GPIO_CS 
explicitly?

>> So to summarize: do you want me to move to transfer_one instead and
>> then revert back for the optimizations?
> 
> Drivers should in general be moving to use modern APIs.  If current APIs
> need enhancing then look into doing that.
OK, so I will try to take the "modernization" approach, but a quick look
shows some headaches, that the current driver is hiding behind scheduling
latencies...

Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
