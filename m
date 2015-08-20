From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Thu, 20 Aug 2015 11:38:13 +0200
Message-ID: <CAKor6Tc6RDW+2uuX2yMszk3O69=6QTPdd+emC-m_Cro67VPR8g@mail.gmail.com>
References: <CAKor6TcSc7n=Rd9NJAf-6cYXr50Z62cbcsbuaEutRMPAiM=2NQ@mail.gmail.com>
	<20150717085434.GO16517@opensource.wolfsonmicro.com>
	<CAKor6Tcof3PA3JGD2=4X8mtSak8ka9BVD2L4zdYC4M1yEYEXjg@mail.gmail.com>
	<CAKor6TdLkGZbARmV1CfqUiguH8HAD+oC8VSsH_OkNQ6E-7YVAw@mail.gmail.com>
	<20150810081001.GG25225@opensource.wolfsonmicro.com>
	<20150810083540.GE1540@lahna.fi.intel.com>
	<CAKor6Tc26kKG-7ytxBjT41S1h4eORoeTg_T=nZ4dZGM1H0gAMQ@mail.gmail.com>
	<20150810140207.GB1541@lahna.fi.intel.com>
	<CAKor6TdKrQrvXTPU=fzL9LTCBbyc9WAbLnYdObY+Wu73g1w6Fg@mail.gmail.com>
	<CAKor6Tep1jjOnoPn7e5Djird3RVDNP8Gjcb8HOKO6g-_R5++VQ@mail.gmail.com>
	<20150819134328.GU1552@lahna.fi.intel.com>
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
In-Reply-To: <20150819134328.GU1552-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi again,

>> in  arizona-spi I try to map these GPIOs, which I want to get in
>> arizona-core: arizona_dev_init
>>
>> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
>> index 1e845f6..52872a0 100644
>> --- a/drivers/mfd/arizona-spi.c
>> +++ b/drivers/mfd/arizona-spi.c
>> @@ -18,28 +18,58 @@
>>  #include <linux/slab.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/of.h>
>> +#include <linux/acpi.h>
>>
>>  #include <linux/mfd/arizona/core.h>
>>
>>  #include "arizona.h"
>>
>> +const struct acpi_gpio_params reset_gpio = { 1, 0, false};
>> +const struct acpi_gpio_params ldoena_gpio = { 2, 0, false};
>> +
>> +const struct acpi_gpio_mapping arizona_acpi_gpios[] = {
>> +       { "reset_gpio", &reset_gpio, 1,},
>> +       { "ldoena_gpio", &ldoena_gpio, 1},
>
> The correct names are "reset-gpios" and "ldoena-gpios". If you call
>
>         reset = devm_gpiod_get_optional(arizona->dev, "reset", GPIOD_OUT_LOW);
>
> GPIO core will look for "reset-gpios" and then "reset-gpio" not
> "reset_gpio" so it will not find the mapping.

yes you are right, I had fixed it yesterday by changing the names.

+const struct acpi_gpio_params reset_gpios = { 1, 0, false};
+const struct acpi_gpio_params ldoena_gpios = { 2, 0, false};
+
+const struct acpi_gpio_mapping arizona_acpi_gpios[] = {
+       { "reset-gpios", &reset_gpios, 1,},
+       { "ldoena-gpios", &ldoena_gpios, 1},
+       { },
+};



Today I can see that the mapping is working as seen below.
But for unknown reasons I got wrong values read
via devm_gpiod_get_optional() in the arizona_dev_init ->
arizona_of_get_core_pdata()

[    6.387993] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
[    6.389258] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
[    6.389416] spi spi-WM510205:00: 8333333 Hz actual, PIO
[    6.389424] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
[    6.389567] spi spi-WM510205:00: checking WM510205 with bmp180
[    6.389574] spi spi-WM510205:00: checking WM510205 with bmp181
[    6.389578] spi spi-WM510205:00: modalias WM510205 in id_table not
found, returns NULL
[    6.405723] arizona spi-WM510205:00: arizona_acpi_get_type(), than
via spi_get_device_id().
[    6.405735] arizona spi-WM510205:00: arizona_acpi_get_type matched
[    6.405740] arizona spi-WM510205:00: using 1 as type for arizona audio codec
[    6.405744] arizona spi-WM510205:00: regmap set to wm5102_spi
[    6.406557] arizona spi-WM510205:00: spi_irq = -1
[    6.406565] arizona spi-WM510205:00: acpi_dev_add_driver_gpios
arizona_acpi_gpios added done, 0
[    6.406569] arizona spi-WM510205:00: arizona_spi_probe done,
calling arizona_dev_init
[    6.406574] arizona spi-WM510205:00: dev_set_drvdata done for 1
[    6.406580] arizona spi-WM510205:00: GPIO lookup for consumer reset
[    6.406585] arizona spi-WM510205:00: using ACPI for GPIO lookup
[    6.406590] acpi WM510205:00: GPIO: looking up reset-gpios
[    6.406597] acpi WM510205:00: GPIO: _DSD returned WM510205:00 3 1 0 0
[    6.406673] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    6.406724] arizona spi-WM510205:00: GPIO lookup for consumer ldoena
[    6.406729] arizona spi-WM510205:00: using ACPI for GPIO lookup
[    6.406733] acpi WM510205:00: GPIO: looking up ldoena-gpios
[    6.406739] acpi WM510205:00: GPIO: _DSD returned WM510205:00 3 2 0 0
[    6.406790] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    6.406844] arizona spi-WM510205:00: arizona_of_get_core_pdata
(ACPI) using irq_gpio GPIO = 146
[    6.406850] arizona spi-WM510205:00: arizona_of_get_core_pdata
(ACPI) using ldoena GPIO =  -185173228
[    6.406855] arizona spi-WM510205:00: arizona_of_get_core_pdata
(ACPI) using reset GPIO =  -184741840
[    6.406859] arizona spi-WM510205:00: arizona_of_get_core_pdata for 1
[    6.406864] arizona spi-WM510205:00: regcache_cache_only for 1 set
[    6.406868] arizona spi-WM510205:00: added wm5102_core_supplies for 1
[    6.407100] spi-WM510205:00 supply AVDD not found, using dummy regulator
[    6.407131] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
[    6.407162] LDO1: supplied by regulator-dummy
[    6.407214] ------------[ cut here ]------------
[    6.407226] WARNING: CPU: 0 PID: 472 at drivers/gpio/gpiolib.c:86
gpio_to_desc+0xbb/0xd0()


did I cast the values wrong?

cheers
chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
