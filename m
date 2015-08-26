From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Wed, 26 Aug 2015 10:58:06 +0200
Message-ID: <CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
References: <20150819134328.GU1552@lahna.fi.intel.com>
	<CAKor6Tc6RDW+2uuX2yMszk3O69=6QTPdd+emC-m_Cro67VPR8g@mail.gmail.com>
	<20150820094542.GC30005@lahna.fi.intel.com>
	<CAKor6Te-DSDxx711-EQi=fw46nNPGnQNqhj-+6upBxhOOp5XvA@mail.gmail.com>
	<20150820115845.GF30005@lahna.fi.intel.com>
	<CAKor6Teq=Aoa6WYkTEVpjBPsWziL-o5FzQHxJWOMeaTrMzXpMg@mail.gmail.com>
	<20150821074310.GM30005@lahna.fi.intel.com>
	<CAKor6TeJp4ti6_QVCEpz0x7c2NwvUiS5wq_=_WDjM3B7T4=1Yg@mail.gmail.com>
	<20150824085140.GA5647@ck-lbox>
	<CAKor6TcRWgn-Z+Va0JKCBqxVA9HBSLMR_vh-z8MSBZebn9kDVg@mail.gmail.com>
	<20150825062157.GB27431@sirena.org.uk>
	<CAKor6Tf_8J4DVrVRShw2ked-zJzmP6G1P1i=vTcbzWX-J1H6dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKor6Tf_8J4DVrVRShw2ked-zJzmP6G1P1i=vTcbzWX-J1H6dQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi at all,


the current logs shows me, that something else is missing here.
The spi irq is one of the issues I will try to solve today

Looking at the read_regmap() where it reads its device id,
I do not understand why it gots only an ID of 0xffff !

I have (silly or not), added a case for 0xffff in the next switch
statements but anyway this seems not okay.
I do not know what else (other than the wrong or missing spi irq,
which is currently only -1)

[    2.427561] ALSA device list:
[    5.503750] sst-acpi 80860F28:00: No matching ASoC machine driver found
[    5.544365] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
[    5.544449] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
[    5.544646] spi spi-WM510205:00: 8333333 Hz actual, PIO
[    5.544653] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
[    5.544717] spi spi-WM510205:00: checking WM510205 with bmp180
[    5.544723] spi spi-WM510205:00: checking WM510205 with bmp181
[    5.544728] spi spi-WM510205:00: modalias WM510205 in id_table not
found, returns NULL
[    5.544752] arizona spi-WM510205:00: arizona_acpi_get_type(), than
via spi_get_device_id().
[    5.544758] arizona spi-WM510205:00: arizona_acpi_get_type matched
[    5.544763] arizona spi-WM510205:00: using 1 as type for arizona audio codec
[    5.544767] arizona spi-WM510205:00: regmap set to wm5102_spi
[    5.545559] arizona spi-WM510205:00: spi_irq = -1
[    5.545565] arizona spi-WM510205:00: acpi_dev_add_driver_gpios
arizona_acpi_gpios added done, 0
[    5.545570] arizona spi-WM510205:00: arizona_spi_probe done,
calling arizona_dev_init
[    5.545574] arizona spi-WM510205:00: dev_set_drvdata done for 1
[    5.545578] arizona spi-WM510205:00: arizona_of_get_core_pdata for 1
[    5.545583] arizona spi-WM510205:00: regcache_cache_only for 1 set
[    5.545587] arizona spi-WM510205:00: added wm5102_core_supplies for 1
[    5.545841] arizona spi-WM510205:00: mfd_add_devices done for 1
[    5.545849] spi-WM510205:00 supply AVDD not found, using dummy regulator
[    5.545888] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
[    5.545919] arizona spi-WM510205:00: devm_regulator_bulk_get done for 1
[    5.545924] LDO1: supplied by regulator-dummy
[    5.545973] arizona spi-WM510205:00: regulator_get done for 1
[    5.546036] arizona spi-WM510205:00: (ACPI) using irq_gpio GPIO = 146
[    5.546050] arizona spi-WM510205:00: devm_gpio_request_one done for
request reset: 0
[    5.546057] arizona spi-WM510205:00: regulator_bulk_enable done,
enable core supplies: 0
[    5.551362] arizona spi-WM510205:00: regulator_enable done, enable DCVDD: 0
[    5.562754] arizona spi-WM510205:00: arizona_disabe_reset
[    5.562766] arizona spi-WM510205:00: regcache_cache_only
[    5.565842] arizona spi-WM510205:00: regmap_read : read ID
register, return value: 0
[    5.565852] arizona spi-WM510205:00: found device ID: ffff
[    5.609712] arizona spi-WM510205:00: WM5102 revision H
[    5.637683] arizona spi-WM510205:00: Polling reg 23 timed out: ffff
[    5.637953] arizona spi-WM510205:00: arizona_dev_init : Failed to
apply hardware patch: -110
[    5.670927] arizona: probe of spi-WM510205:00 failed with error -110
[    5.670945] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00
[    5.728336] intel_sst_acpi 80860F28:00: No matching machine driver found

any ideas or what I can do next to find out was is the root issue here?
Question about the spi-irq to clarify it for me: does this spi irq
device belongs to the arizona child (the wm5102) or is this irq only
of the spi master ? I much as I understand, this irq is from the spi
master, the arizona spi child , the wm510205, has another irq ,
attachted at the irq_gpio - I am right so far??

in some previous mails it was mentioned, that I should or _must_ use
and irqchip handler?

still encouraged to get this device working as expected :)

cheers
chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
