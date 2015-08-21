From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Fri, 21 Aug 2015 10:43:10 +0300
Message-ID: <20150821074310.GM30005@lahna.fi.intel.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
To: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKor6Teq=Aoa6WYkTEVpjBPsWziL-o5FzQHxJWOMeaTrMzXpMg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Aug 21, 2015 at 09:31:25AM +0200, Christian Hartmann wrote:
> [    6.169473] spi spi-WM510205:00: modalias WM510205 in id_table not
> found, returns NULL
> [    6.169501] arizona spi-WM510205:00: arizona_acpi_get_type(), than
> via spi_get_device_id().
> [    6.169507] arizona spi-WM510205:00: arizona_acpi_get_type matched
> [    6.169511] arizona spi-WM510205:00: using 1 as type for arizona audio codec
> [    6.169515] arizona spi-WM510205:00: regmap set to wm5102_spi
> [    6.170301] arizona spi-WM510205:00: spi_irq = -1
> [    6.170309] arizona spi-WM510205:00: acpi_dev_add_driver_gpios
> arizona_acpi_gpios added done, 0
> [    6.170313] arizona spi-WM510205:00: arizona_spi_probe done,
> calling arizona_dev_init
> [    6.170317] arizona spi-WM510205:00: dev_set_drvdata done for 1
> [    6.170323] arizona spi-WM510205:00: GPIO lookup for consumer reset
> [    6.170328] arizona spi-WM510205:00: using ACPI for GPIO lookup
> [    6.170333] acpi WM510205:00: GPIO: looking up reset-gpios
> [    6.170340] acpi WM510205:00: GPIO: _DSD returned WM510205:00 3 1 0 0
> [    6.175675] acpi WM510205:00: GPIO: looking up 0 in _CRS

1) You got "reset-gpios" here.

> [    6.175733] arizona spi-WM510205:00: GPIO lookup for consumer ldoena
> [    6.175739] arizona spi-WM510205:00: using ACPI for GPIO lookup
> [    6.175744] acpi WM510205:00: GPIO: looking up ldoena-gpios
> [    6.175750] acpi WM510205:00: GPIO: _DSD returned WM510205:00 3 2 0 0
> [    6.175805] acpi WM510205:00: GPIO: looking up 0 in _CRS
> [    6.175860] arizona spi-WM510205:00: arizona_of_get_core_pdata
> (ACPI) using irq_gpio GPIO = 146
> [    6.175867] arizona spi-WM510205:00: arizona_of_get_core_pdata
> (ACPI) using ldoena GPIO =  405
> [    6.175871] arizona spi-WM510205:00: arizona_of_get_core_pdata
> (ACPI) using reset GPIO =  342
> [    6.175875] arizona spi-WM510205:00: arizona_of_get_core_pdata for 1
> [    6.175880] arizona spi-WM510205:00: regcache_cache_only for 1 set
> [    6.175885] arizona spi-WM510205:00: added wm5102_core_supplies for 1
> [    6.176079] gpio-405 (ldoena): gpiod_request: status -16
> [    6.176084] LDO1: Failed to request enable GPIO405: -16
> [    6.176154] arizona spi-WM510205:00: Failed to register LDO1 supply: -16
> [    6.189631] arizona-ldo1: probe of arizona-ldo1 failed with error -16
> [    6.189656] arizona spi-WM510205:00: mfd_add_devices done for 1
> [    6.189665] spi-WM510205:00 supply AVDD not found, using dummy regulator
> [    6.189721] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
> [    6.189753] arizona spi-WM510205:00: devm_regulator_bulk_get done for 1
> [    6.189757] spi-WM510205:00 supply DCVDD not found, using dummy regulator
> [    6.189786] arizona spi-WM510205:00: regulator_get done for 1
> [    6.189794] gpio-342 (reset): gpiod_request: status -16
> [    6.189799] arizona spi-WM510205:00: Failed to request /RESET: -16

2) and fail here with -EBUSY because you have already requested the GPIO.

So please drop the code in 1) to be able to request the GPIO in the
driver.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
