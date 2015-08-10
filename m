From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
	of WM510205 codec via ACPI (resend)
Date: Mon, 10 Aug 2015 08:53:00 +0100
Message-ID: <20150810075300.GF25225@opensource.wolfsonmicro.com>
References: <20150630103404.GI6321@opensource.wolfsonmicro.com> <CAKor6TdKk2OUz4o12RiQBSVZyhD=L4JpBJcYkGE=_6X+ZeQY_g@mail.gmail.com> <20150713095359.GM16517@opensource.wolfsonmicro.com> <CAKor6Td83zgOS+iHGHGhFW4n26H=tC-QQDuzaHHfybhLeH-jvw@mail.gmail.com> <CAKor6TdheYM73aqti362bOnP2GZmX60uuDY5v2eow1vqO9tcKw@mail.gmail.com> <20150715081224.GN16517@opensource.wolfsonmicro.com> <20150715091709.GK11162@sirena.org.uk> <CAKor6TcSc7n=Rd9NJAf-6cYXr50Z62cbcsbuaEutRMPAiM=2NQ@mail.gmail.com> <20150717085434.GO16517@opensource.wolfsonmicro.com> <CAKor6Tcof3PA3JGD2=4X8mtSak8ka9BVD2L4zdYC4M1yEYEXjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
To: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKor6Tcof3PA3JGD2=4X8mtSak8ka9BVD2L4zdYC4M1yEYEXjg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Aug 10, 2015 at 09:00:50AM +0200, Christian Hartmann wrote:
> [    7.269430] LDO1: Failed to request enable GPIO23: -517
> [    7.269506] arizona spi-WM510205:00: Failed to register LDO1 supply: -517
> [    7.289191] spi-WM510205:00 supply AVDD not found, using dummy regulator
> [    7.289246] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
> [    7.289366] spi-WM510205:00 supply DCVDD not found, using dummy regulator
> [    7.289415] arizona spi-WM510205:00: Failed to request /RESET: -517
> [    7.289690] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00
> 
> ... arizona spi-wm510202 tries to init the device 2 times again ....
> 
> side-note: added a lot of dev_err to see whats going on, so the most
> messages are not in master, only in my local branch (today its
> 4.2.0-rc6)
> 
> Instead of hardcoding and finding the correct GPIOs by Try&Error I
> want as mentioned above already by Charles Keepax, to pull them from
> ACPI.
> 
> currently I am not using the the gpiolib.h and its functions to get
> the named and relevant GPIOs in question,
> failing yet searching for examples which fits into the arizona mfd code easily.

Yes this driver has not been converted over to use gpiod yet.

> 
> I saw the drivers/gpio/gpio-arizona.h, which is also not using the
> gpiolib.h, too.also it is not clear to me, if I should use
> gpio-arizona at all (or extend it for using it with the wm5102).

The gpio-arizona driver is the driver that provides support for
the GPIOs on the actual CODEC (it has 5 GPIO pins of its own) and
has nothing to do with the GPIOs that are controlling the RESET
and LDOENA.

> 
> 
> zitat from Charles:
> 
> "I suspect we still have some issues with the GPIO lookups, I
> suspect we want to actually pull them from ACPI rather than
> putting them into the pdata, as I don't know if the number will
> translate directly over."
> 
> What I have understand today :  the three values (irq_gpio, reset,
> ldoena) have different 'parents' as seen in the dsdt.dsl
> irq_gpio = _SB.GPO2 -> 0x0004
> reset = _SB.I2C7.PMIC

The point here is that although the GPIOs are defined as 0x0004,
0x0003 and 0x0017 in the ACPI that doesn't necessarily mean those
will be the GPIO numbers in Linux.

Alas my knowledge of how things are done in ACPI is not up to
telling you how to translate the numbers but for example with
device tree we are calling the function of_get_named_gpio to pull
the actual GPIO number, I would expect there would be some
loosely equivalent function for ACPI.

If such functions are only available through gpiod then we could
look at upgrading the driver to use gpiod it is something I have
been intending to do for a while but it pretty annoying because
the gpiod stuff assumes the DT bindings for gpios will have the
suffix "-gpios" or "-gpio" (which "wlf,reset" and "wlf,ldoena"
obviously don't have) so moving to it necessitates a change of
the device tree binding which is far from ideal.

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
