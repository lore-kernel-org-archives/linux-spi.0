From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Thu, 27 Aug 2015 13:44:45 +0200
Message-ID: <CAKor6TeH32hd0QUCPowzrjp54iJjGKiJ8jVT994y2O29dfk=QA@mail.gmail.com>
References: <CAKor6Te-DSDxx711-EQi=fw46nNPGnQNqhj-+6upBxhOOp5XvA@mail.gmail.com>
	<20150820115845.GF30005@lahna.fi.intel.com>
	<CAKor6Teq=Aoa6WYkTEVpjBPsWziL-o5FzQHxJWOMeaTrMzXpMg@mail.gmail.com>
	<20150821074310.GM30005@lahna.fi.intel.com>
	<CAKor6TeJp4ti6_QVCEpz0x7c2NwvUiS5wq_=_WDjM3B7T4=1Yg@mail.gmail.com>
	<20150824085140.GA5647@ck-lbox>
	<CAKor6TcRWgn-Z+Va0JKCBqxVA9HBSLMR_vh-z8MSBZebn9kDVg@mail.gmail.com>
	<20150825062157.GB27431@sirena.org.uk>
	<CAKor6Tf_8J4DVrVRShw2ked-zJzmP6G1P1i=vTcbzWX-J1H6dQ@mail.gmail.com>
	<CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
	<20150826100155.GA1513@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150826100155.GA1513-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hey,

2015-08-26 12:01 GMT+02:00 Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>:
> The master should already have IRQ. This is about assigning IRQ for the
> SPI childe device.
ok, *saved*
>
> You probably want to do same to SPI core that was done for I2C:
>
> 845c877009cf014b9 ("i2c / ACPI: Assign IRQ for devices that have GpioInt automatically")
I looked at this log and have added or better set spi->irq now in
arizon-spi.c arizona_spi_probe()
and its that what I have already via local patches added:
(ACPI) using irq_gpio GPIO = 146
The question for me is, this looks like an GPIO number, not like an IRQ number.
Also it seems better to look again into pxa2xx.c or spi.c (not done
yet) and get the irq there.

>
> Then it will automatically assign first found GpioInt to the SPI device
> in question.

I again saw also the following files, which are not used under this
device or they need some attention

drivers/gpio/gpio-arizona.c
and drivers/extcon/extcon-arizona.c

I have already CONFIG_GPIO_ARIZONA=y, but it does not be used at all.
Is it save to ignore ?? Or should I use them as well ??

cheers
chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
