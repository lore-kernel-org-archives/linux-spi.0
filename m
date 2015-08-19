From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Wed, 19 Aug 2015 12:29:08 +0200
Message-ID: <CAKor6Tep1jjOnoPn7e5Djird3RVDNP8Gjcb8HOKO6g-_R5++VQ@mail.gmail.com>
References: <CAKor6TdheYM73aqti362bOnP2GZmX60uuDY5v2eow1vqO9tcKw@mail.gmail.com>
	<20150715081224.GN16517@opensource.wolfsonmicro.com>
	<20150715091709.GK11162@sirena.org.uk>
	<CAKor6TcSc7n=Rd9NJAf-6cYXr50Z62cbcsbuaEutRMPAiM=2NQ@mail.gmail.com>
	<20150717085434.GO16517@opensource.wolfsonmicro.com>
	<CAKor6Tcof3PA3JGD2=4X8mtSak8ka9BVD2L4zdYC4M1yEYEXjg@mail.gmail.com>
	<CAKor6TdLkGZbARmV1CfqUiguH8HAD+oC8VSsH_OkNQ6E-7YVAw@mail.gmail.com>
	<20150810081001.GG25225@opensource.wolfsonmicro.com>
	<20150810083540.GE1540@lahna.fi.intel.com>
	<CAKor6Tc26kKG-7ytxBjT41S1h4eORoeTg_T=nZ4dZGM1H0gAMQ@mail.gmail.com>
	<20150810140207.GB1541@lahna.fi.intel.com>
	<CAKor6TdKrQrvXTPU=fzL9LTCBbyc9WAbLnYdObY+Wu73g1w6Fg@mail.gmail.com>
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
In-Reply-To: <CAKor6TdKrQrvXTPU=fzL9LTCBbyc9WAbLnYdObY+Wu73g1w6Fg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi

>> There is acpi_fwnode_handle() in include/acpi/acpi_bus.h. However, if
>> you have Linux device available you should really use devm_gpio_*
>> functions instead.

ok, after some changes I got it compiled, but there seems another
mistake (by me?), it does not find the GPIOs yet.

[    5.851524] sst-acpi 80860F28:00: No matching ASoC machine driver found
[    5.873318] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
[    5.877982] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
[    5.878667] rfkill_gpio BCM2E84:00: GPIO lookup for consumer reset
[    5.878677] rfkill_gpio BCM2E84:00: using ACPI for GPIO lookup
[    5.878683] acpi BCM2E84:00: GPIO: looking up reset-gpios
[    5.878690] acpi BCM2E84:00: GPIO: _DSD returned BCM2E84:00 3 0 0 0
[    5.878836] rfkill_gpio BCM2E84:00: GPIO lookup for consumer shutdown
[    5.878844] rfkill_gpio BCM2E84:00: using ACPI for GPIO lookup
[    5.878850] acpi BCM2E84:00: GPIO: looking up shutdown-gpios
[    5.878857] acpi BCM2E84:00: GPIO: _DSD returned BCM2E84:00 3 1 0 0
[    5.884010] spi spi-WM510205:00: 8333333 Hz actual, PIO
[    5.884019] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
[    5.884102] spi spi-WM510205:00: checking WM510205 with bmp180
[    5.884108] spi spi-WM510205:00: checking WM510205 with bmp181
[    5.884113] spi spi-WM510205:00: modalias WM510205 in id_table not
found, returns NULL
[    5.884140] arizona spi-WM510205:00: arizona_acpi_get_type(), than
via spi_get_device_id().
[    5.884146] arizona spi-WM510205:00: arizona_acpi_get_type matched
[    5.884151] arizona spi-WM510205:00: using 1 as type for arizona audio codec
[    5.884155] arizona spi-WM510205:00: regmap set to wm5102_spi
[    5.884765] rfkill_gpio BCM2E84:00: BCM2E84:00 device registered.
[    5.884831] rfkill_gpio LNV4752:00: GPIO lookup for consumer reset
[    5.884837] rfkill_gpio LNV4752:00: using ACPI for GPIO lookup
[    5.884843] acpi LNV4752:00: GPIO: looking up reset-gpios
[    5.884850] acpi LNV4752:00: GPIO: _DSD returned LNV4752:00 3 0 0 0
[    5.884926] rfkill_gpio LNV4752:00: GPIO lookup for consumer shutdown
[    5.884931] rfkill_gpio LNV4752:00: using ACPI for GPIO lookup
[    5.884936] acpi LNV4752:00: GPIO: looking up shutdown-gpios
[    5.884941] acpi LNV4752:00: GPIO: _DSD returned LNV4752:00 3 1 0 0
[    5.884977] acpi LNV4752:00: GPIO: looking up shutdown-gpio
[    5.884983] acpi LNV4752:00: GPIO: looking up 0 in _CRS
[    5.885019] gpio-411 (reset): gpiod_request: status -16
[    5.889424] arizona spi-WM510205:00: spi_irq = -1
[    5.889435] arizona spi-WM510205:00: arizona_spi_probe done,
calling arizona_dev_init
[    5.889442] arizona spi-WM510205:00: acpi_dev_add_driver_gpios done, 0
[    5.889447] arizona spi-WM510205:00: dev_set_drvdata done for 1
[    5.889774] arizona spi-WM510205:00: GPIO lookup for consumer reset
[    5.889781] arizona spi-WM510205:00: using ACPI for GPIO lookup
[    5.889788] acpi WM510205:00: GPIO: looking up reset-gpios
[    5.889794] acpi WM510205:00: GPIO: looking up reset-gpio
[    5.889798] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    5.891255] arizona spi-WM510205:00: GPIO lookup for consumer ldoena
[    5.891263] arizona spi-WM510205:00: using ACPI for GPIO lookup
[    5.891269] acpi WM510205:00: GPIO: looking up ldoena-gpios
[    5.891274] acpi WM510205:00: GPIO: looking up ldoena-gpio
[    5.891279] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    5.891324] gpio-342 (reset): gpiod_request: status -16
[    5.891330] arizona spi-WM510205:00: Failed to get ldoena line: -16
[    5.891335] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    5.891409] arizona spi-WM510205:00: arizona_of_get_core_pdata
(ACPI) using irq_gpio GPIO = 146
[    5.891415] arizona spi-WM510205:00: arizona_of_get_core_pdata
(ACPI) using ldoena GPIO =  23
[    5.891421] arizona spi-WM510205:00: arizona_of_get_core_pdata
(ACPI) using reset GPIO =  -184850384
[    5.891425] arizona spi-WM510205:00: arizona_of_get_core_pdata for 1
[    5.891430] arizona spi-WM510205:00: regcache_cache_only for 1 set
[    5.891434] arizona spi-WM510205:00: added wm5102_core_supplies for 1
[    5.894845] rfkill_gpio: probe of LNV4752:00 failed with error -16
[    5.906587] LDO1: Failed to request enable GPIO23: -517
[    5.906673] arizona spi-WM510205:00: Failed to register LDO1 supply: -517
[    5.923633] spi-WM510205:00 supply AVDD not found, using dummy regulator
[    5.923687] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
[    5.923718] spi-WM510205:00 supply DCVDD not found, using dummy regulator
[    5.923751] ------------[ cut here ]------------
[    5.923763] WARNING: CPU: 2 PID: 474 at drivers/gpio/gpiolib.c:86
gpio_to_desc+0xbb/0xd0()

in  arizona-spi I try to map these GPIOs, which I want to get in
arizona-core: arizona_dev_init

diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 1e845f6..52872a0 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -18,28 +18,58 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/of.h>
+#include <linux/acpi.h>

 #include <linux/mfd/arizona/core.h>

 #include "arizona.h"

+const struct acpi_gpio_params reset_gpio = { 1, 0, false};
+const struct acpi_gpio_params ldoena_gpio = { 2, 0, false};
+
+const struct acpi_gpio_mapping arizona_acpi_gpios[] = {
+       { "reset_gpio", &reset_gpio, 1,},
+       { "ldoena_gpio", &ldoena_gpio, 1},
+       { },
+};
 static int arizona_spi_probe(struct spi_device *spi)
 {
-       const struct spi_device_id *id = spi_get_device_id(spi);
+       const struct spi_device_id *id;
        struct arizona *arizona;
+       struct acpi_device *adev;
        const struct regmap_config *regmap_config;
        unsigned long type;
+       acpi_handle handle;
        int ret;

        if (spi->dev.of_node)
                type = arizona_of_get_type(&spi->dev);
-       else
-               type = id->driver_data;
+       else {
+               dev_err(&spi->dev, "arizona_acpi_get_type(), than via
spi_get_device_id().\n");
+               if (( type = arizona_acpi_get_type(&spi->dev))) {
+               } else {
+                       id = spi_get_device_id(spi) ;
+                       if (!id || !id->driver_data)
+                               return -ENODEV;
+                       dev_err(&spi->dev, "matched spi\n");
+                       type = id->driver_data;
+               }
+       }
+
+
+       /* check if type is NULL before going on
+        */
+       if (!type) {
+               dev_err(&spi->dev, "type is NULL, unable to get the id
/ type of this device\n");
+               return -ENODEV;
+       } else
+               dev_err(&spi->dev, "using %lu as type for arizona
audio codec\n",type);

        switch (type) {
 #ifdef CONFIG_MFD_WM5102
        case WM5102:
                regmap_config = &wm5102_spi_regmap;
+               dev_err(&spi->dev, "regmap set to wm5102_spi \n");
                break;
 #endif
 #ifdef CONFIG_MFD_WM5110
@@ -66,10 +96,32 @@ static int arizona_spi_probe(struct spi_device *spi)
                return ret;
        }

-       arizona->type = id->driver_data;
+       /*
+        * take the id if it is an spi id,  or take the acpi id
+        * the case that it has no id and no acpi_id is yet open (yes the
+        * openfirmare interface introducted by apple)
+        */
+       arizona->type = type;
+
        arizona->dev = &spi->dev;
        arizona->irq = spi->irq;

+       dev_err(&spi->dev, "spi_irq = %i \n",spi->irq);
+       dev_err(&spi->dev, "arizona_spi_probe done, calling
arizona_dev_init \n");
+
+#ifdef CONFIG_ACPI
+       /*
+        *arizona->dev.fwnode = acpi_fwnode_handle(adev);
+        */
+       handle = ACPI_HANDLE(&spi->dev);
+       if (!handle || acpi_bus_get_device(handle, &adev)) {
+               dev_err(&spi->dev, "unable to get ACPI handle\n");
+               return -ENODEV;
+       }
+       ret = acpi_dev_add_driver_gpios(adev, arizona_acpi_gpios);
+       dev_err(&spi->dev, "acpi_dev_add_driver_gpios done, %i\n",ret);
+
+#endif
        return arizona_dev_init(arizona);
 }

@@ -90,12 +142,22 @@ static const struct spi_device_id arizona_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, arizona_spi_ids);

+static const struct acpi_device_id arizona_acpi_match[] = {
+       {
+               .id = "WM510205",
+               .driver_data = WM5102,
+       },
+       { },
+};
+MODULE_DEVICE_TABLE(acpi, arizona_acpi_match);
+
static struct spi_driver arizona_spi_driver = {
        .driver = {
                .name   = "arizona",
                .owner  = THIS_MODULE,
                .pm     = &arizona_pm_ops,
                .of_match_table = of_match_ptr(arizona_of_match),
+               .acpi_match_table = ACPI_PTR(arizona_acpi_match),
        },
        .probe          = arizona_spi_probe,
        .remove         = arizona_spi_remove,
diff --git a/drivers/mfd/arizona.h b/drivers/mfd/arizona.h
index fbe2843..ba9e9bc 100644
--- a/drivers/mfd/arizona.h
+++ b/drivers/mfd/arizona.h
@@ -55,4 +55,14 @@ static inline unsigned long
arizona_of_get_type(struct device *dev)
 }
 #endif

+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+unsigned long arizona_acpi_get_type(struct device *dev);
+
+extern const struct acpi_gpio_params reset_gpio;
+extern const struct acpi_gpio_params ldoena_gpio;
+
+extern const struct acpi_gpio_mapping arizona_acpi_gpios[];
+#endif
+
 #endif


@@ -812,6 +840,70 @@ EXPORT_SYMBOL_GPL(arizona_of_match);
 #else
 static inline int arizona_of_get_core_pdata(struct arizona *arizona)
 {
+       struct arizona_pdata *pdata = &arizona->pdata;
+       struct gpio_desc *reset, *ldoena;
+       int ret;
+
+       switch (arizona->type) {
+       case WM5102:
+               /* TODO:
+                * get the actual GPIO pins from ACPI namespace
+                * instead of hardcoding it here
+               pdata->reset = 0x03 ;
+               pdata->ldoena = 0x17 ;
+                */
+
+               reset = devm_gpiod_get_optional(arizona->dev,
+                                                       "reset",
+                                                       GPIOD_OUT_LOW);
+               if (IS_ERR(reset)) {
+                       ret = PTR_ERR(reset);
+                       dev_err(arizona->dev, "Failed to get reset
line: %d\n", ret);
+                       pdata->reset = 0x03 ;
+                       /*
+                        *return ret;
+                        */
+               } else {
+                       pdata->reset = (int )reset;
+               }
+
+               ldoena = devm_gpiod_get_optional(arizona->dev,
+                                                       "ldoena",
+                                                       GPIOD_OUT_LOW);
+               if (IS_ERR(ldoena)) {
+                       ret = PTR_ERR(ldoena);
+                       dev_err(arizona->dev, "Failed to get ldoena
line: %d\n", ret);
+                       pdata->ldoena = 0x17 ;
+                       /*
+                        * return ret;
+                       */
+               } else {
+                       pdata->ldoena = (int )ldoena;
+               }
+
+               pdata->irq_flags = IRQF_TRIGGER_RISING|
+                                       IRQF_TRIGGER_FALLING;
+
+               /* get the ACPI GpioInt ressource for this device
+                *
+                */
+               if (ACPI_COMPANION(arizona->dev)) {
+                       pdata->irq_gpio =
acpi_dev_gpio_irq_get(ACPI_COMPANION(arizona->dev), 0);
+               } else {
+                       pdata->irq_gpio = 0x04 ;
+               }
+
+               dev_err(arizona->dev, "arizona_of_get_core_pdata
(ACPI) using irq_gpio GPIO = %i\n",
+                       pdata->irq_gpio);
+               dev_err(arizona->dev, "arizona_of_get_core_pdata
(ACPI) using ldoena GPIO =  %i\n",
+                       pdata->ldoena);
+               dev_err(arizona->dev, "arizona_of_get_core_pdata
(ACPI) using reset GPIO =  %i\n",
+                       pdata->reset);
+               break;
+       default:
+               break;
+       }
+

so far, this are the most important and current testing changes.
Does anybody has some ideas or hints about how to get the annoying
GPIOs ldoena and reset ?

cheers
chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
