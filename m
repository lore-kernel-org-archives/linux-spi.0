From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Fri, 21 Aug 2015 09:31:25 +0200
Message-ID: <CAKor6Teq=Aoa6WYkTEVpjBPsWziL-o5FzQHxJWOMeaTrMzXpMg@mail.gmail.com>
References: <20150810081001.GG25225@opensource.wolfsonmicro.com>
	<20150810083540.GE1540@lahna.fi.intel.com>
	<CAKor6Tc26kKG-7ytxBjT41S1h4eORoeTg_T=nZ4dZGM1H0gAMQ@mail.gmail.com>
	<20150810140207.GB1541@lahna.fi.intel.com>
	<CAKor6TdKrQrvXTPU=fzL9LTCBbyc9WAbLnYdObY+Wu73g1w6Fg@mail.gmail.com>
	<CAKor6Tep1jjOnoPn7e5Djird3RVDNP8Gjcb8HOKO6g-_R5++VQ@mail.gmail.com>
	<20150819134328.GU1552@lahna.fi.intel.com>
	<CAKor6Tc6RDW+2uuX2yMszk3O69=6QTPdd+emC-m_Cro67VPR8g@mail.gmail.com>
	<20150820094542.GC30005@lahna.fi.intel.com>
	<CAKor6Te-DSDxx711-EQi=fw46nNPGnQNqhj-+6upBxhOOp5XvA@mail.gmail.com>
	<20150820115845.GF30005@lahna.fi.intel.com>
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
In-Reply-To: <20150820115845.GF30005-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,


2015-08-20 13:58 GMT+02:00 Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>:
> On Thu, Aug 20, 2015 at 01:34:00PM +0200, Christian Hartmann wrote:
>
> I don't think passing the converted GPIO numbers in pdata is good idea.
> Instead you can just get the GPIO descriptors in the driver itself using
> devm_gpiod_get*().
>
> For example you can try following:
>
>         if (arizona->pdata.reset) {
>                 /* Start out with /RESET low to put the chip into reset * */
>                 ret = devm_gpio_request_one(arizona->dev, arizona->pdata.reset,
>                                             GPIOF_DIR_OUT | GPIOF_INIT_LOW,
>                                             "arizona /RESET");
>                 if (ret != 0) {
>                         dev_err(dev, "Failed to request /RESET: %d\n", ret);
>                         goto err_dcvdd;
>                 }
>         } else {
>                 struct gpio_desc *desc;
>
>                 desc = devm_gpiod_get(arizona->dev, "reset",
>                                       GPIOF_DIR_OUT | GPIOF_INIT_LOW);
>                 if (!IS_ERR(desc))
>                         arizona.pdata.reset = desc_to_gpio(desc);
>         }
>
> Eventually it might be good idea to convert the driver to use GPIO
> descriptors. The above can be intermediate step to that.

I have just changed the code as you suggested, and I got no bug,
excepting that the
WM5102 codec does not initialize at all yet.


[    6.169473] spi spi-WM510205:00: modalias WM510205 in id_table not
found, returns NULL
[    6.169501] arizona spi-WM510205:00: arizona_acpi_get_type(), than
via spi_get_device_id().
[    6.169507] arizona spi-WM510205:00: arizona_acpi_get_type matched
[    6.169511] arizona spi-WM510205:00: using 1 as type for arizona audio codec
[    6.169515] arizona spi-WM510205:00: regmap set to wm5102_spi
[    6.170301] arizona spi-WM510205:00: spi_irq = -1
[    6.170309] arizona spi-WM510205:00: acpi_dev_add_driver_gpios
arizona_acpi_gpios added done, 0
[    6.170313] arizona spi-WM510205:00: arizona_spi_probe done,
calling arizona_dev_init
[    6.170317] arizona spi-WM510205:00: dev_set_drvdata done for 1
[    6.170323] arizona spi-WM510205:00: GPIO lookup for consumer reset
[    6.170328] arizona spi-WM510205:00: using ACPI for GPIO lookup
[    6.170333] acpi WM510205:00: GPIO: looking up reset-gpios
[    6.170340] acpi WM510205:00: GPIO: _DSD returned WM510205:00 3 1 0 0
[    6.175675] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    6.175733] arizona spi-WM510205:00: GPIO lookup for consumer ldoena
[    6.175739] arizona spi-WM510205:00: using ACPI for GPIO lookup
[    6.175744] acpi WM510205:00: GPIO: looking up ldoena-gpios
[    6.175750] acpi WM510205:00: GPIO: _DSD returned WM510205:00 3 2 0 0
[    6.175805] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    6.175860] arizona spi-WM510205:00: arizona_of_get_core_pdata
(ACPI) using irq_gpio GPIO = 146
[    6.175867] arizona spi-WM510205:00: arizona_of_get_core_pdata
(ACPI) using ldoena GPIO =  405
[    6.175871] arizona spi-WM510205:00: arizona_of_get_core_pdata
(ACPI) using reset GPIO =  342
[    6.175875] arizona spi-WM510205:00: arizona_of_get_core_pdata for 1
[    6.175880] arizona spi-WM510205:00: regcache_cache_only for 1 set
[    6.175885] arizona spi-WM510205:00: added wm5102_core_supplies for 1
[    6.176079] gpio-405 (ldoena): gpiod_request: status -16
[    6.176084] LDO1: Failed to request enable GPIO405: -16
[    6.176154] arizona spi-WM510205:00: Failed to register LDO1 supply: -16
[    6.189631] arizona-ldo1: probe of arizona-ldo1 failed with error -16
[    6.189656] arizona spi-WM510205:00: mfd_add_devices done for 1
[    6.189665] spi-WM510205:00 supply AVDD not found, using dummy regulator
[    6.189721] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
[    6.189753] arizona spi-WM510205:00: devm_regulator_bulk_get done for 1
[    6.189757] spi-WM510205:00 supply DCVDD not found, using dummy regulator
[    6.189786] arizona spi-WM510205:00: regulator_get done for 1
[    6.189794] gpio-342 (reset): gpiod_request: status -16
[    6.189799] arizona spi-WM510205:00: Failed to request /RESET: -16
[    6.189805] arizona spi-WM510205:00: GPIO lookup for consumer reset
[    6.189809] arizona spi-WM510205:00: using ACPI for GPIO lookup
[    6.189815] acpi WM510205:00: GPIO: looking up reset-gpios
[    6.189821] acpi WM510205:00: GPIO: _DSD returned WM510205:00 3 1 0 0
[    6.189883] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    6.189957] gpio-342 (reset): gpiod_request: status -16
[    6.189963] arizona spi-WM510205:00: Failed to request /RESET: -16
[    6.190221] arizona: probe of spi-WM510205:00 failed with error -16
[    6.190230] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00

as we can see in  the current dmesg the driver is still unable to get
the reset line, I tried at first the old way,
than via devm_gpiod_get(), if this fails to, than it goes to err_dcvdd....

I do need help here, do not know how to fix this at the moment.

cheers
chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
