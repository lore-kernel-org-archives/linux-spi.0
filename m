From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] SPI: bcm2835: move to the transfer_one driver model
Date: Thu, 26 Mar 2015 11:47:24 -0600
Message-ID: <5514462C.7060704@wwwdotorg.org>
References: <550BAA89.5090707@wwwdotorg.org> <20150320095247.GE2869@sirena.org.uk> <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org> <20150325151611.GA3572@sirena.org.uk> <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org> <20150325165441.GI3572@sirena.org.uk> <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA@martin.sperl.org> <20150325185007.GL3572@sirena.org.uk> <561486F6-3580-4884-8A6A-8477D8C3BDC9@martin.sperl.org> <30057D30-6A2D-4517-B374-76FF2448E455@martin.sperl.org> <20150326173511.GW3572@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	notro-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150326173511.GW3572-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/26/2015 11:35 AM, Mark Brown wrote:
> On Thu, Mar 26, 2015 at 11:08:36AM +0100, Martin Sperl wrote:
>> This also allows for GPIO-CS to get used removing the limitation of
>> 2/3 SPI devises on the SPI bus.
>
> This doesn't apply against current code, please check and resend.  As
> previously mentioned please use subject lines matching the style for the
> subsystem.  A few other things below but it's basically all good.
>
>> So the question is if we should depreciate native chip-selects for this
>> driver with one of those future improvements listed below.
>
> Given that this driver is only going to be used with a single SoC (or
> perhaps a very limited set of SoCs, I don't know if it's the same driver
> in the Pi 2) even if the DT specifies a hardware chip select we should
> be able to look up which pin that's brought out to and put it into GPIO
> mode if that's the most sensible thing for the driver.

The Pi and Pi2 are essentially identical with the exception of the CPU, 
so yes this driver should run there too (and the GPIO and pinmux are 
identical too AFAIK, so any interaction there ought to work the same).
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
