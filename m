From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Fri, 21 Aug 2015 14:09:46 +0200
Message-ID: <CAKor6TeJp4ti6_QVCEpz0x7c2NwvUiS5wq_=_WDjM3B7T4=1Yg@mail.gmail.com>
References: <CAKor6Tc26kKG-7ytxBjT41S1h4eORoeTg_T=nZ4dZGM1H0gAMQ@mail.gmail.com>
	<20150810140207.GB1541@lahna.fi.intel.com>
	<CAKor6TdKrQrvXTPU=fzL9LTCBbyc9WAbLnYdObY+Wu73g1w6Fg@mail.gmail.com>
	<CAKor6Tep1jjOnoPn7e5Djird3RVDNP8Gjcb8HOKO6g-_R5++VQ@mail.gmail.com>
	<20150819134328.GU1552@lahna.fi.intel.com>
	<CAKor6Tc6RDW+2uuX2yMszk3O69=6QTPdd+emC-m_Cro67VPR8g@mail.gmail.com>
	<20150820094542.GC30005@lahna.fi.intel.com>
	<CAKor6Te-DSDxx711-EQi=fw46nNPGnQNqhj-+6upBxhOOp5XvA@mail.gmail.com>
	<20150820115845.GF30005@lahna.fi.intel.com>
	<CAKor6Teq=Aoa6WYkTEVpjBPsWziL-o5FzQHxJWOMeaTrMzXpMg@mail.gmail.com>
	<20150821074310.GM30005@lahna.fi.intel.com>
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
In-Reply-To: <20150821074310.GM30005-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi

2015-08-21 9:43 GMT+02:00 Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>:
> So please drop the code in 1) to be able to request the GPIO in the
> driver.

[    6.129664] spi spi-WM510205:00: 8333333 Hz actual, PIO
[    6.129675] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
[    6.129759] spi spi-WM510205:00: checking WM510205 with bmp180
[    6.129765] spi spi-WM510205:00: checking WM510205 with bmp181
[    6.129797] spi spi-WM510205:00: modalias WM510205 in id_table not
found, returns NULL
[    6.129825] arizona spi-WM510205:00: arizona_acpi_get_type(), than
via spi_get_device_id().
[    6.129831] arizona spi-WM510205:00: arizona_acpi_get_type matched
[    6.129836] arizona spi-WM510205:00: using 1 as type for arizona audio codec
[    6.129840] arizona spi-WM510205:00: regmap set to wm5102_spi
[    6.130630] arizona spi-WM510205:00: spi_irq = -1
[    6.130638] arizona spi-WM510205:00: acpi_dev_add_driver_gpios
arizona_acpi_gpios added done, 0
[    6.130642] arizona spi-WM510205:00: arizona_spi_probe done,
calling arizona_dev_init
[    6.130647] arizona spi-WM510205:00: dev_set_drvdata done for 1
[    6.130653] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    6.130703] arizona spi-WM510205:00: arizona_of_get_core_pdata
(ACPI) using irq_gpio GPIO = 146
[    6.130708] arizona spi-WM510205:00: arizona_of_get_core_pdata for 1
[    6.130713] arizona spi-WM510205:00: regcache_cache_only for 1 set
[    6.130717] arizona spi-WM510205:00: added wm5102_core_supplies for 1
[    6.131255] arizona spi-WM510205:00: mfd_add_devices done for 1
[    6.131267] spi-WM510205:00 supply AVDD not found, using dummy regulator
[    6.131301] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
[    6.131332] arizona spi-WM510205:00: devm_regulator_bulk_get done for 1
[    6.131338] LDO1: supplied by regulator-dummy
[    6.131389] arizona spi-WM510205:00: regulator_get done for 1
[    6.131397] arizona spi-WM510205:00: GPIO lookup for consumer reset
[    6.131401] arizona spi-WM510205:00: using ACPI for GPIO lookup
[    6.131407] acpi WM510205:00: GPIO: looking up reset-gpios
[    6.131414] acpi WM510205:00: GPIO: _DSD returned WM510205:00 3 1 0 0
[    6.131498] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    6.131543] no flags found for reset
[    6.131549] arizona spi-WM510205:00: devm_gpiod_get done to request
/RESET: -1
[    6.131556] arizona spi-WM510205:00: regulator_bulk_enable done,
enable core supplies: 0
[    6.131561] arizona spi-WM510205:00: regulator_enable done, enable DCVDD: 0
[    6.141803] arizona spi-WM510205:00: arizona_disabe_reset
[    6.141813] arizona spi-WM510205:00: regcache_cache_only
[    6.144796] arizona spi-WM510205:00: regmap_read : read ID
register, return value: 0
[    6.144806] arizona spi-WM510205:00: found device ID: ffff
[    6.175352] arizona spi-WM510205:00: Unknown device ID ffff
[    6.175584] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00
[    6.177870] sst-acpi 80860F28:00: No matching ASoC machine driver found

as you said, I removed the code in 1) so the EBUSY error is gone.

What is with the spi_irq = -1 ?? is this a problem here?

the message "no flags found for reset" seems also ok, but it does not
read the device id yet,
 what else can be wrong here?

In previous mails I added the _CRS for this device WM510202, is the
gpio-mapping, with its indexes ok so far??

The last two messages are clear to me.
I will add the machine driver if the device id was read correctly etc.

cheers
chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
