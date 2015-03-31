From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH/RFC 6/6] spi: bcm2835: set gpio-cs to high state prior to any
Date: Tue, 31 Mar 2015 07:56:59 +0200
Message-ID: <18CE4830-9283-4650-9069-17140765EFA7@martin.sperl.org>
References: <DA037FBB-56A7-4379-88F0-650367BBB822@martin.sperl.org> <20150330042821.GD1568@sirena.org.uk> <F17E5383-B75E-4884-9673-0C9E95750E4A@martin.sperl.org> <551A1611.1090708@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <551A1611.1090708-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 31.03.2015, at 05:35, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> 
> I suspect the solution is simply not to have the pinctrl node set the CS
> pins to GPIO_OUT, but rather rely on gpio_request() ->
> bcm2835_gpio_request() -> bcm2835_pmx_gpio_set_direction() setting up
> the pinmux function for any GPIOs that are requested. Presumably, the CS
> GPIO for each chip is only requested when the DT node for the SPI device
> (not SPI controller device) has been parsed, so the correct GPIO CS
> value can be passed to gpio_request()/gpio_direction_output()?

I will investigate that and create a patch to spi_register_master that
does that for any GPIO-chipselect - this still leaves the question of
how to iterate over all the configured devices early to detect if they
hace cspol set and then setting it low instead of high.

Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
