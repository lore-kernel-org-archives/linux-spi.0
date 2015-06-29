From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Mon, 29 Jun 2015 09:46:41 +0200
Message-ID: <CAKor6TdzzAqG1yNtqkWftdvNo8_bxC=qnU+60rgiM=38qrJ2yQ@mail.gmail.com>
References: <CAKor6TfKws63jh6f3VzyYpmTffL4-DHWDTdJ6GSgDC08C5W=8w@mail.gmail.com>
	<20150625073618.GH827@lahna.fi.intel.com>
	<CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg@mail.gmail.com>
	<20150625145853.GP14071@sirena.org.uk>
	<20150625154407.GE6321@opensource.wolfsonmicro.com>
	<558D3BAA.3080700@linux.intel.com>
	<20150626115823.GY14071@sirena.org.uk>
	<CAKor6Tf20eC1WQSO=AV2b+XoB5Qv-2Oin_nrrTJUiDV4czxLjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKor6Tf20eC1WQSO=AV2b+XoB5Qv-2Oin_nrrTJUiDV4czxLjA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

Thank you so far at all.

I have sent an email about the Bug in this firmware to lenovo.
So I can work on with thhe custom DSDT and will try again to get ACPI
working with the WM5102.

As soon as Lenovo has a new BIOS available, I will report that but for
the case their will not be a new BIOS update in the near future, what
should we do with the patch??
As some suggested, its a firmware bug workaround.

If some Intel developers have some ideas or better some patches in the
right directions to let this device initialize correctly and to bind
this with the Baytrail (intel_sst_acpi) sound system, than I would be
happy to test these patches (or to know the infos I got from you).

cheers
chris


2015-06-29 9:27 GMT+02:00 Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>:
> Hi,
>
> @all
>
> FYI: I can confirm that with the changed DSDT.dsl file and loading
> the new custom DSDT table, I do not need this patch mentioned above.
>
> So the patch is indeed only needed, as long as there is no
> BIOS (DSDT change by manufacturer) update available.
>
> In this case special case a custom DSDT table is loaded to
>  fix the by ACPI wrongly set of SPIController to  1, which must be 0.
>
> On the other hand I have now an tained kernel too :/ cause of the unset
> "Select only drivers that don't need compile-time external firmware" and
>  the ''Include Custom DSDT' options.
>
>
> The dmesg message seems to be the same as with the patch applied but
> with the current system DSDT table: here
>
> [    0.000000] Linux version 4.1.0.60-rc0
> (b23-/dWd7jAXU0ArCNBCT51S8nv7hrKZn54GTYPjME8WTGQ@public.gmane.org) (gcc version 4.8.3 20140911 (Red Hat
> 4.8.3-9) (GCC) ) #199 SMP Fri Jun 26
> 13:47:46 CEST 2015
> ...
> [    0.000000] ACPI: Early table checksum verification disabled
> ...
> [    5.916597] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
> [    5.916733] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
> [    5.926671] spi spi-WM510205:00: 8333333 Hz actual, PIO
> [    5.926681] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
> [    5.926805] spi spi-WM510205:00: checking WM510205 with bmp180
> [    5.926812] spi spi-WM510205:00: checking WM510205 with bmp181
> [    5.926816] spi spi-WM510205:00: modalias WM510205 in id_table not
> found, returns NULL
> [    5.926843] arizona spi-WM510205:00: acpi_match_device() first,
> than via spi_get_device_id().
> [    5.926849] arizona spi-WM510205:00: matched ACPI ID and data
> [    5.926853] arizona spi-WM510205:00: using 1 as type for arizona audio codec
> [    5.926857] arizona spi-WM510205:00: regmap set to wm5102_spi
> [    5.927665] arizona spi-WM510205:00: arizona_spi_probe done, call
> and return of  arizona_dev_init
> [    5.927759] spi-WM510205:00 supply AVDD not found, using dummy regulator
> [    5.927782] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
> [    5.927801] spi-WM510205:00 supply DCVDD not found, using dummy regulator
> [    5.928958] arizona spi-WM510205:00: Unknown device ID: ffff
> [    5.929098] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00
>
> notice : some of these messages above are coming from local added dev_err();
>
> cheers
> chris
>
>
> 2015-06-26 13:58 GMT+02:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>> On Fri, Jun 26, 2015 at 01:46:50PM +0200, Pierre-Louis Bossart wrote:
>>> On 6/25/15 5:44 PM, Charles Keepax wrote:
>>
>>> >I think from the Linux side we can safely ignore those last two
>>> >digits. I expect that all systems of the same make and model
>>> >would report the same last two digits but that it might change
>>> >between models if the Windows driver is expected to something
>>> >differently for that model.
>>
>>> Here's the summary of what a valid _HID  should look like. It took me a
>>> couple of days to gather the rules from different sources, I hope it helps
>>> others figure things out.
>>
>> None of which really affact the matching that the kernel does since
>> whatever form the string is generated in we need to do a full string
>> match (nor do they correspond to what it seems the Wolfson drivers have
>> invented but that's a separate issue).  Yay standards.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
