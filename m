From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Mon, 10 Aug 2015 14:43:01 +0200
Message-ID: <CAKor6TfP7pw+U539oQE_zUYMFd9X1zBdJH9wH-hD0Qsc7D9NAg@mail.gmail.com>
References: <CAKor6TdheYM73aqti362bOnP2GZmX60uuDY5v2eow1vqO9tcKw@mail.gmail.com>
	<20150715081224.GN16517@opensource.wolfsonmicro.com>
	<20150715091709.GK11162@sirena.org.uk>
	<CAKor6TcSc7n=Rd9NJAf-6cYXr50Z62cbcsbuaEutRMPAiM=2NQ@mail.gmail.com>
	<20150717085434.GO16517@opensource.wolfsonmicro.com>
	<CAKor6Tcof3PA3JGD2=4X8mtSak8ka9BVD2L4zdYC4M1yEYEXjg@mail.gmail.com>
	<CAKor6TdLkGZbARmV1CfqUiguH8HAD+oC8VSsH_OkNQ6E-7YVAw@mail.gmail.com>
	<20150810081001.GG25225@opensource.wolfsonmicro.com>
	<20150810083540.GE1540@lahna.fi.intel.com>
	<CAKor6TfZC3AY0p-85mFAUJJYQ360NoDu6AppipSqAD73S_EkzQ@mail.gmail.com>
	<20150810092632.GA1541@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150810092632.GA1541-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2015-08-10 11:26 GMT+02:00 Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>:
> On Mon, Aug 10, 2015 at 11:20:04AM +0200, Christian Hartmann wrote:
>> @Mika: I actually view a patch by you from 6. May 2015 where you
>> added dev_gpio_irq_get() and the acpi_dev_gpio_irq_get() functions,
>> seems to be related here to, right??
>
> That's right if you have GpioInt -resource somewhere you need to
> translate to Linux IRQ number (and use it via irqchip instead of gpiolib
> API).
>
> What was done for I2C core with addition of acpi_dev_gpio_irq_get() is
> that now it automatically takes first GpioInt of an I2C device and
> assigns the translated IRQ number to client->irq if it is not yet
> assigned to a valid IRQ.


Hi,

@Mika

some feedback to the first patch today

I have patched it to use the acpi_dev_gpio_irq_get()
and after reboot I have a message seen below, it seems the irq uses
actually the gpio pin 146 .


[    6.195479] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    6.195560] arizona spi-WM510205:00: arizona_of_get_core_pdata
(ACPI) using irq 146

So I go on and patching again to have also the ldoena and reset lines
getting via acpi...

cheers
chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
