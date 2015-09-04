From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Fri, 4 Sep 2015 15:32:03 +0200
Message-ID: <CAKor6TdaRqi0+a0ZHkdJngE2LPKHk0PUFrdQQ2-x59cxUa8cXA@mail.gmail.com>
References: <20150825062157.GB27431@sirena.org.uk>
	<CAKor6Tf_8J4DVrVRShw2ked-zJzmP6G1P1i=vTcbzWX-J1H6dQ@mail.gmail.com>
	<CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
	<20150826100155.GA1513@lahna.fi.intel.com>
	<CAKor6TeH32hd0QUCPowzrjp54iJjGKiJ8jVT994y2O29dfk=QA@mail.gmail.com>
	<20150827115914.GF28428@lahna.fi.intel.com>
	<20150827145614.GC5313@sirena.org.uk>
	<CAKor6Tf8kB0WPXLTBFmCzUJkMVEDu-xTEyw0-_NZvBdFSyQSFA@mail.gmail.com>
	<CAKor6TfW4reRz3m-xkCr_ZUfHQkfqT3q+S7JCpO-9F+k1QW38g@mail.gmail.com>
	<CAKor6Tf7_Hiyc1v_TGvdVAU+G84Gp+KgKeSGi8EQJRoq9rhMuw@mail.gmail.com>
	<20150902081334.GB15505@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150902081334.GB15505@ck-lbox>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,


2015-09-02 10:13 GMT+02:00 Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>:
> On Tue, Sep 01, 2015 at 11:45:31AM +0200, Christian Hartmann wrote:
>> hi
>>
>> 2015-08-28 11:50 GMT+02:00 Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>:
>> >
>> >  and thats what I got:
>> >
>> > [    6.182903] pxa2xx-spi 80860F0E:00: bus_num = -1
>> > [    6.182909] pxa2xx-spi 80860F0E:00: num_chipselect = 2
>> > [    6.182928] pxa2xx-spi 80860F0E:00: IRQ 194
>> > [    6.183049] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
>> > [    6.183111] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
>> > [    6.192761] spi spi-WM510205:00: 8333333 Hz actual, PIO
>> > .... the rest of the dmesg is currently the same....

> The chip select being wrong could well be the issue, perhaps the
> Windows driver supports multiple chipselects where as the Linux
> one doesn't? Do you have access to any datasheets for the SPI on
> the AP? Alternatively you could try hacking it to use chip select
> 0 and see if that makes the system work, seems like a long shot
> but perhaps worth a quick go.
>
> Thanks,
> Charles

ok, that was a one-shot, in effect nothing changed .
I did set the num_chipsselect = 1 (as in vanilla kernels, so its more
a revert) and
changed the cs value from 1 to 0 (as a testpatch).
as soon as the SPI device WM510205:00 is allocated,
it tries to add the acpi_resource and in the case of the wrong SPI
chip_select with the value 1 from the DSDT ACPI table entry, but here
I set it again to 0.

expected : chip id register can be read, but
nothing changed. the logs are the same in the end.
I saw also that acpi_add_resource tries to add an irq (init with -1), but fails

[    5.966307] acpi INT33FD:00: GPIO: looking up 0 in _CRS
[    5.966806] intel_soc_pmic_i2c i2c-INT33FD:00: using lookup tables
for GPIO lookup
[    5.966814] intel_soc_pmic_i2c i2c-INT33FD:00: lookup for GPIO
intel_soc_pmic failed
[    5.975702] sst-acpi 80860F28:00: No matching ASoC machine driver found
[    5.986039] pxa2xx-spi 80860F0E:00: bus_num = -1
[    5.986047] pxa2xx-spi 80860F0E:00: num_chipselect = 1
[    5.986076] pxa2xx-spi 80860F0E:00: IRQ 194
[    5.986368] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
[    5.987011] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
[    5.987123] spi_master spi32766: allocated SPI device for WM510205:00
[    5.987172] spi (null): acpi_spi_add_resource : chip_select = 1
[    5.987177] spi (null): acpi_spi_add_resource : new chip_select = 0
[    5.987182] spi (null): acpi_spi_add_resource : irq = -1
[    5.987186] spi (null): acpi_spi_add_resource : irq < 0,
acpi_dev_resource_interrupt
[    5.987189] spi (null): acpi_spi_add_resource : irq = -1
[    5.987193] spi (null): acpi_spi_add_resource : irq < 0,
acpi_dev_resource_interrupt
[    5.987197] spi (null): acpi_spi_add_resource : irq = -1
[    5.987201] spi (null): acpi_spi_add_resource : irq < 0,
acpi_dev_resource_interrupt
[    5.987204] spi (null): acpi_spi_add_resource : irq = -1
[    5.987208] spi (null): acpi_spi_add_resource : irq < 0,
acpi_dev_resource_interrupt
[    5.987212] spi (null): acpi_spi_add_resource : irq = -1
[    5.987217] pxa2xx-spi 80860F0E:00: cs0 < max 1
[    5.987243] spi spi-WM510205:00: 8333333 Hz actual, PIO
[    5.987249] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
[    5.991261] spi spi-WM510205:00: checking WM510205 with bmp180
[    5.991271] spi spi-WM510205:00: checking WM510205 with bmp181
[    5.991276] spi spi-WM510205:00: modalias WM510205 in id_table not
found, returns NULL
[    5.991310] arizona spi-WM510205:00: arizona_acpi_get_type(), than
via spi_get_device_id().
[    5.991316] arizona spi-WM510205:00: arizona_acpi_get_type matched
[    5.991323] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    5.991401] arizona spi-WM510205:00: using 1 as type for arizona audio codec
[    5.991406] arizona spi-WM510205:00: regmap set to wm5102_spi
[    5.991980] arizona spi-WM510205:00: acpi_dev_add_driver_gpios
arizona_acpi_gpios added done, 0
[    5.991986] arizona spi-WM510205:00: spi_irq = 146
[    5.991990] arizona spi-WM510205:00: arizona_spi_probe done,
calling arizona_dev_init
[    5.991994] arizona spi-WM510205:00: dev_set_drvdata done for 1
[    5.991999] arizona spi-WM510205:00: arizona_of_get_core_pdata for 1
[    5.992004] arizona spi-WM510205:00: regcache_cache_only for 1 set
[    5.992008] arizona spi-WM510205:00: added wm5102_core_supplies for 1
[    5.994493] arizona spi-WM510205:00: mfd_add_devices done for 1
[    5.994505] spi-WM510205:00 supply AVDD not found, using dummy regulator
[    5.994553] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
[    6.007337] arizona spi-WM510205:00: devm_regulator_bulk_get done for 1
[    6.007348] LDO1: supplied by regulator-dummy
[    6.007419] arizona spi-WM510205:00: regulator_get done for 1
[    6.007427] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    6.007517] arizona spi-WM510205:00: (ACPI) using irq_gpio GPIO = 146
[    6.007534] arizona spi-WM510205:00: devm_gpio_request_one done for
request reset: 0
[    6.007541] arizona spi-WM510205:00: regulator_bulk_enable done,
enable core supplies: 0
[    6.010032] arizona spi-WM510205:00: regulator_enable done, enable DCVDD: 0
[    6.017864] arizona spi-WM510205:00: arizona_disabe_reset
[    6.017875] arizona spi-WM510205:00: regcache_cache_only
[    6.019067] arizona spi-WM510205:00: regmap_read : read ID
register, return value: 0
[    6.019077] arizona spi-WM510205:00: found device ID: ffff


I asked to get more technical docs / datasheets from lenovo , but I do
not think, that I will get them.

Has anybody directions and hints / some tools known to get started
with win8.1 to get such hardware details extracted? I mean, it must
work under windows, why to not look there and write down / dump whats
needed.

Any hints or suggestions for me ?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
