From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Thu, 20 Aug 2015 13:34:00 +0200
Message-ID: <CAKor6Te-DSDxx711-EQi=fw46nNPGnQNqhj-+6upBxhOOp5XvA@mail.gmail.com>
References: <CAKor6Tcof3PA3JGD2=4X8mtSak8ka9BVD2L4zdYC4M1yEYEXjg@mail.gmail.com>
	<CAKor6TdLkGZbARmV1CfqUiguH8HAD+oC8VSsH_OkNQ6E-7YVAw@mail.gmail.com>
	<20150810081001.GG25225@opensource.wolfsonmicro.com>
	<20150810083540.GE1540@lahna.fi.intel.com>
	<CAKor6Tc26kKG-7ytxBjT41S1h4eORoeTg_T=nZ4dZGM1H0gAMQ@mail.gmail.com>
	<20150810140207.GB1541@lahna.fi.intel.com>
	<CAKor6TdKrQrvXTPU=fzL9LTCBbyc9WAbLnYdObY+Wu73g1w6Fg@mail.gmail.com>
	<CAKor6Tep1jjOnoPn7e5Djird3RVDNP8Gjcb8HOKO6g-_R5++VQ@mail.gmail.com>
	<20150819134328.GU1552@lahna.fi.intel.com>
	<CAKor6Tc6RDW+2uuX2yMszk3O69=6QTPdd+emC-m_Cro67VPR8g@mail.gmail.com>
	<20150820094542.GC30005@lahna.fi.intel.com>
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
In-Reply-To: <20150820094542.GC30005-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

2015-08-20 11:45 GMT+02:00 Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>:
> devm_gpiod_get_optional() returns GPIO descriptor which should not be
> cast to anything else. If you want to get the numberic value for
> logging purposes you can call desc_to_gpio(desc) for the returned
> descriptor.


that done, it looks much better. thank you, Mika

I got a new error instead for the LDO1 as seen below:

[    5.951646] arizona spi-WM510205:00: GPIO lookup for consumer reset
[    5.951650] arizona spi-WM510205:00: using ACPI for GPIO lookup
[    5.951656] acpi WM510205:00: GPIO: looking up reset-gpios
[    5.951663] acpi WM510205:00: GPIO: _DSD returned WM510205:00 3 1 0 0
[    5.951779] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    5.951831] arizona spi-WM510205:00: GPIO lookup for consumer ldoena
[    5.951838] arizona spi-WM510205:00: using ACPI for GPIO lookup
[    5.951843] acpi WM510205:00: GPIO: looking up ldoena-gpios
[    5.951852] acpi WM510205:00: GPIO: _DSD returned WM510205:00 3 2 0 0
[    5.951909] acpi WM510205:00: GPIO: looking up 0 in _CRS
[    5.951975] arizona spi-WM510205:00: arizona_of_get_core_pdata
(ACPI) using irq_gpio GPIO = 146
[    5.951980] arizona spi-WM510205:00: arizona_of_get_core_pdata
(ACPI) using ldoena GPIO =  405
[    5.951985] arizona spi-WM510205:00: arizona_of_get_core_pdata
(ACPI) using reset GPIO =  342
[    5.951989] arizona spi-WM510205:00: arizona_of_get_core_pdata for 1
[    5.951994] arizona spi-WM510205:00: regcache_cache_only for 1 set
[    5.951999] arizona spi-WM510205:00: added wm5102_core_supplies for 1
[    5.952283] arizona spi-WM510205:00: mfd_add_devices done for 1
[    5.952291] spi-WM510205:00 supply AVDD not found, using dummy regulator
[    5.952338] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
[    5.952381] arizona spi-WM510205:00: devm_regulator_bulk_get done for 1
[    5.952387] LDO1: supplied by regulator-dummy
[    5.952452] arizona spi-WM510205:00: regulator_get done for 1
[    5.952457] ------------[ cut here ]------------
[    5.952469] WARNING: CPU: 3 PID: 464 at drivers/gpio/gpiolib.c:86
gpio_to_desc+0xbb/0xd0()
[    5.952472] invalid GPIO -184850384
[    5.952475] Modules linked in: int3400_thermal(+)
int3403_thermal(+) processor_thermal_device(+)
snd_soc_sst_mfld_platform int3402_thermal in
t340x_thermal_zone rfkill_gpio acpi_thermal_rel intel_soc_dts_iosf
acpi_pad spi_pxa2xx_platform(+) i2c_designware_platform(+) rfkill
pwm_lpss_pl
atform snd_soc_sst_acpi pwm_lpss i2c_designware_core ax88179_178a usbnet i2c_hid
[    5.952510] CPU: 3 PID: 464 Comm: systemd-udevd Not tainted 4.2.0.84-rc7 #252
[    5.952513] Hardware name: LENOVO 60072/INVALID, BIOS 02WT18WW 08/01/2014
[    5.952517]  c0e619a7 b4cc43d7 00000000 f3687974 c0b606c4 f36879b4
f36879a4 c044cad8
[    5.952528]  c0d90c73 f36879d4 000001d0 c0d90c84 00000056 c0711d6b
c0711d6b c0ebf250
[    5.952538]  f4fb6830 f4fb6830 f36879c0 c044cb4f 00000009 f36879b4
c0d90c73 f36879d4
[    5.952548] Call Trace:
[    5.952558]  [<c0b606c4>] dump_stack+0x41/0x52
[    5.952565]  [<c044cad8>] warn_slowpath_common+0x88/0xc0
[    5.952570]  [<c0711d6b>] ? gpio_to_desc+0xbb/0xd0
[    5.952575]  [<c0711d6b>] ? gpio_to_desc+0xbb/0xd0
[    5.952579]  [<c044cb4f>] warn_slowpath_fmt+0x3f/0x60
[    5.952584]  [<c0711d6b>] gpio_to_desc+0xbb/0xd0
[    5.952590]  [<c0713f7b>] gpio_request_one+0x1b/0xf0
[    5.952595]  [<c0710da3>] devm_gpio_request_one+0x43/0x80
[    5.952602]  [<c08e6de7>] arizona_dev_init+0x257/0xc90
[    5.952607]  [<c077bf65>] ? acpi_get_data_full+0x68/0x77
[    5.952614]  [<c08c46e9>] ? dev_err+0x39/0x60
[    5.952619]  [<c08e8635>] arizona_spi_probe+0x195/0x240
[    5.952625]  [<c075c016>] ? acpi_dev_pm_attach+0x57/0x79
[    5.952632]  [<c092e286>] spi_drv_probe+0x36/0x60
[    5.952640]  [<c08c7faa>] driver_probe_device+0x1ca/0x410
[    5.952646]  [<c075e61b>] ? acpi_driver_match_device+0x36/0x3f
[    5.952651]  [<c092eab2>] ? spi_match_device+0x22/0x70
[    5.952655]  [<c08c82fb>] __device_attach_driver+0x5b/0x70
[    5.952660]  [<c08c82a0>] ? driver_allows_async_probing+0x30/0x30
[    5.952665]  [<c08c6197>] bus_for_each_drv+0x57/0xa0
[    5.952670]  [<c08c7d02>] __device_attach+0xb2/0x120
[    5.952674]  [<c08c82a0>] ? driver_allows_async_probing+0x30/0x30
[    5.952679]  [<c08c8442>] device_initial_probe+0x12/0x20
[    5.952685]  [<c08c7267>] bus_probe_device+0x67/0x70
[    5.952690]  [<c08c52c0>] device_add+0x3c0/0x5b0
[    5.952695]  [<c092e859>] spi_add_device+0xe9/0x220
[    5.952700]  [<c092da10>] ? spi_drv_shutdown+0x20/0x20
[    5.952706]  [<c06e58a4>] ? strlcpy+0x34/0x50
[    5.952712]  [<c0930db3>] acpi_spi_add_device+0x123/0x170
[    5.952739]  [<c077b7fd>] acpi_ns_walk_namespace+0xba/0x16d
[    5.952745]  [<c077bcd7>] acpi_walk_namespace+0x8d/0xbc
[    5.952750]  [<c0930c90>] ? devm_spi_register_master+0x80/0x80
[    5.952755]  [<c0930a19>] spi_register_master+0x229/0x420
[    5.952760]  [<c0930c90>] ? devm_spi_register_master+0x80/0x80
[    5.952766]  [<c0930c4b>] devm_spi_register_master+0x3b/0x80
[    5.952775]  [<f81cec4a>] pxa2xx_spi_probe+0x24a/0x530 [spi_pxa2xx_platform]
[    5.952781]  [<c075bfd9>] ? acpi_dev_pm_attach+0x1a/0x79
[    5.952786]  [<c08ca01d>] platform_drv_probe+0x2d/0x80
[    5.952792]  [<c08c7802>] ? driver_sysfs_add+0x62/0x80
[    5.952796]  [<c08c7faa>] driver_probe_device+0x1ca/0x410
[    5.952801]  [<c08c8261>] __driver_attach+0x71/0x80
[    5.952806]  [<c08c81f0>] ? driver_probe_device+0x410/0x410
[    5.952811]  [<c08c60d7>] bus_for_each_dev+0x57/0xa0
[    5.952817]  [<c08c79af>] driver_attach+0x1f/0x30
[    5.952821]  [<c08c81f0>] ? driver_probe_device+0x410/0x410
[    5.952826]  [<c08c7557>] bus_add_driver+0x1c7/0x290
[    5.952831]  [<f81d5000>] ? 0xf81d5000
[    5.952835]  [<f81d5000>] ? 0xf81d5000
[    5.952839]  [<c08c8b5a>] driver_register+0x5a/0xe0
[    5.952845]  [<c06ec1c1>] ? kvasprintf+0x41/0x50
[    5.952850]  [<c08c9f83>] __platform_driver_register+0x43/0x50
[    5.952857]  [<f81d5012>] pxa2xx_spi_init+0x12/0x1000 [spi_pxa2xx_platform]
[    5.952863]  [<c0400472>] do_one_initcall+0xc2/0x1f0
[    5.952867]  [<f81d5000>] ? 0xf81d5000
[    5.952873]  [<c0ad0a4f>] ? netlink_broadcast_filtered+0x10f/0x390
[    5.952880]  [<c052fd2e>] ? free_pages_prepare+0x1ce/0x320
[    5.952886]  [<c05718ad>] ? kmem_cache_alloc_trace+0x17d/0x1e0
[    5.952890]  [<c0570b87>] ? kfree+0xe7/0x130
[    5.952897]  [<c0b5c764>] do_init_module+0x54/0x1cd
[    5.952903]  [<c04c7895>] load_module+0x1145/0x17d0
[    5.952910]  [<c04c4549>] ? copy_module_from_fd.isra.53+0x109/0x1a0
[    5.952916]  [<c04c810d>] SyS_finit_module+0x8d/0xd0
[    5.952922]  [<c0544ce3>] ? vm_mmap_pgoff+0x93/0xb0
[    5.952929]  [<c0b6a20f>] sysenter_do_call+0x12/0x12
[    5.952933] ---[ end trace 1e444d913002c55d ]---
[    5.952936] gpiod_request: invalid GPIO
[    5.952941] arizona spi-WM510205:00: Failed to request /RESET: -22
[    5.982461] arizona: probe of spi-WM510205:00 failed with error -22
[    5.982478] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00
[    5.988213] i2c i2c-11: Failed to register i2c client MAGN0001:00
at 0x1d (-16)

the code in arizona-core.c arizona_dev_init looks like

if (arizona->pdata.reset) {
 /* Start out with /RESET low to put the chip into reset */
 ret = devm_gpio_request_one(arizona->dev, arizona->pdata.reset,
}

which fails here. seems that I have to use desc_to_gpio() here too.
Does anybody have an idea whats wrong with LDO1? I try the
desc_to_gpio at first and will report soon

cheers
chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
