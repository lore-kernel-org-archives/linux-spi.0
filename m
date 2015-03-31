From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH/RFC 6/6] spi: bcm2835: set gpio-cs to high state prior
 to any
Date: Mon, 30 Mar 2015 21:35:45 -0600
Message-ID: <551A1611.1090708@wwwdotorg.org>
References: <DA037FBB-56A7-4379-88F0-650367BBB822@martin.sperl.org> <20150330042821.GD1568@sirena.org.uk> <F17E5383-B75E-4884-9673-0C9E95750E4A@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F17E5383-B75E-4884-9673-0C9E95750E4A-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/30/2015 01:25 PM, Martin Sperl wrote:
> 
>> On 30.03.2015, at 06:28, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>
>> On Sun, Mar 29, 2015 at 04:03:28PM +0200, Martin Sperl wrote:
>>
>>> A variation of this probably should get moved into spi_register_master
>>> to fix this for other spi-controller as well.
>>
>> Yes, this is the wrong place to solve this.
> 
> So should we move that into spi_register_master?
> My question for completeness remains: how do we get the devices
> from dt or whatever while we are still registering the master?
> 
> Also I am still missing a bit of the big picture and vision how
> to implement it taking all different HW/setup cases into account.
> 
> That is why I have put it as an RFC - mostly to get the issue some
> exposure and some ideas.

I suspect the solution is simply not to have the pinctrl node set the CS
pins to GPIO_OUT, but rather rely on gpio_request() ->
bcm2835_gpio_request() -> bcm2835_pmx_gpio_set_direction() setting up
the pinmux function for any GPIOs that are requested. Presumably, the CS
GPIO for each chip is only requested when the DT node for the SPI device
(not SPI controller device) has been parsed, so the correct GPIO CS
value can be passed to gpio_request()/gpio_direction_output()?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
