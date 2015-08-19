From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Wed, 19 Aug 2015 16:43:28 +0300
Message-ID: <20150819134328.GU1552@lahna.fi.intel.com>
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
In-Reply-To: <CAKor6Tep1jjOnoPn7e5Djird3RVDNP8Gjcb8HOKO6g-_R5++VQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Aug 19, 2015 at 12:29:08PM +0200, Christian Hartmann wrote:
> Hi
> 
> >> There is acpi_fwnode_handle() in include/acpi/acpi_bus.h. However, if
> >> you have Linux device available you should really use devm_gpio_*
> >> functions instead.
> 
> ok, after some changes I got it compiled, but there seems another
> mistake (by me?), it does not find the GPIOs yet.
> 

...

> [    5.891255] arizona spi-WM510205:00: GPIO lookup for consumer ldoena
> [    5.891263] arizona spi-WM510205:00: using ACPI for GPIO lookup
> [    5.891269] acpi WM510205:00: GPIO: looking up ldoena-gpios
> [    5.891274] acpi WM510205:00: GPIO: looking up ldoena-gpio
> [    5.891279] acpi WM510205:00: GPIO: looking up 0 in _CRS
> [    5.891324] gpio-342 (reset): gpiod_request: status -16
> [    5.891330] arizona spi-WM510205:00: Failed to get ldoena line: -16

It returns -EBUSY so is the GPIO already requested?

> [    5.891335] acpi WM510205:00: GPIO: looking up 0 in _CRS
> [    5.891409] arizona spi-WM510205:00: arizona_of_get_core_pdata
> (ACPI) using irq_gpio GPIO = 146
> [    5.891415] arizona spi-WM510205:00: arizona_of_get_core_pdata
> (ACPI) using ldoena GPIO =  23
> [    5.891421] arizona spi-WM510205:00: arizona_of_get_core_pdata
> (ACPI) using reset GPIO =  -184850384
> [    5.891425] arizona spi-WM510205:00: arizona_of_get_core_pdata for 1
> [    5.891430] arizona spi-WM510205:00: regcache_cache_only for 1 set
> [    5.891434] arizona spi-WM510205:00: added wm5102_core_supplies for 1
> [    5.894845] rfkill_gpio: probe of LNV4752:00 failed with error -16
> [    5.906587] LDO1: Failed to request enable GPIO23: -517
> [    5.906673] arizona spi-WM510205:00: Failed to register LDO1 supply: -517
> [    5.923633] spi-WM510205:00 supply AVDD not found, using dummy regulator
> [    5.923687] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
> [    5.923718] spi-WM510205:00 supply DCVDD not found, using dummy regulator
> [    5.923751] ------------[ cut here ]------------
> [    5.923763] WARNING: CPU: 2 PID: 474 at drivers/gpio/gpiolib.c:86
> gpio_to_desc+0xbb/0xd0()
> 
> in  arizona-spi I try to map these GPIOs, which I want to get in
> arizona-core: arizona_dev_init
> 
> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
> index 1e845f6..52872a0 100644
> --- a/drivers/mfd/arizona-spi.c
> +++ b/drivers/mfd/arizona-spi.c
> @@ -18,28 +18,58 @@
>  #include <linux/slab.h>
>  #include <linux/spi/spi.h>
>  #include <linux/of.h>
> +#include <linux/acpi.h>
> 
>  #include <linux/mfd/arizona/core.h>
> 
>  #include "arizona.h"
> 
> +const struct acpi_gpio_params reset_gpio = { 1, 0, false};
> +const struct acpi_gpio_params ldoena_gpio = { 2, 0, false};
> +
> +const struct acpi_gpio_mapping arizona_acpi_gpios[] = {
> +       { "reset_gpio", &reset_gpio, 1,},
> +       { "ldoena_gpio", &ldoena_gpio, 1},

The correct names are "reset-gpios" and "ldoena-gpios". If you call

        reset = devm_gpiod_get_optional(arizona->dev, "reset", GPIOD_OUT_LOW);

GPIO core will look for "reset-gpios" and then "reset-gpio" not
"reset_gpio" so it will not find the mapping.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
