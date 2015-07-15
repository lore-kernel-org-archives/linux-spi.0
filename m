From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Wed, 15 Jul 2015 09:01:49 +0200
Message-ID: <CAKor6Td83zgOS+iHGHGhFW4n26H=tC-QQDuzaHHfybhLeH-jvw@mail.gmail.com>
References: <CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg@mail.gmail.com>
	<20150625145853.GP14071@sirena.org.uk>
	<20150625154407.GE6321@opensource.wolfsonmicro.com>
	<558D3BAA.3080700@linux.intel.com>
	<20150626115823.GY14071@sirena.org.uk>
	<CAKor6Tf20eC1WQSO=AV2b+XoB5Qv-2Oin_nrrTJUiDV4czxLjA@mail.gmail.com>
	<20150629094854.GB11162@sirena.org.uk>
	<CAKor6TdDPb2qOgdHbeX2w+yQa_ioDM5ak9bk+=jF+cKt_twiXw@mail.gmail.com>
	<20150630103404.GI6321@opensource.wolfsonmicro.com>
	<CAKor6TdKk2OUz4o12RiQBSVZyhD=L4JpBJcYkGE=_6X+ZeQY_g@mail.gmail.com>
	<20150713095359.GM16517@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150713095359.GM16517-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2015-07-13 11:53 GMT+02:00 Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>:
> On Tue, Jul 07, 2015 at 09:06:25AM +0200, Christian Hartmann wrote:
>> 2015-06-30 12:34 GMT+02:00 Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>:
>> > On Tue, Jun 30, 2015 at 09:14:37AM +0200, Christian Hartmann wrote:
>> >> Hi,
>> >>
>> >>
>> >> 2015-06-29 11:48 GMT+02:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>> >> > On Mon, Jun 29, 2015 at 09:27:17AM +0200, Christian Hartmann wrote:
>> >> >> [    5.927801] spi-WM510205:00 supply DCVDD not found, using dummy regulator
>> >> >> [    5.928958] arizona spi-WM510205:00: Unknown device ID: ffff
>> >> >> [    5.929098] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00
>> >> >
>> >> > The above is saying that SPI I/O to the device isn't working - the
>> >> > device ID is not being read back successfully.
>> >>
>> >> Ok that is the next problem that must be solved.
>> >> I have yesterday made a patchset where I have added
>> >> the enum type 5, but as you said already,
>> >> that was not needed.
>> >> All what I see the same: : Unknown device ID: ffff
>> >>
>> >> So where I have to look now or what can I do to let this device id
>> >> register correctly?
>> >> I hope the baytrail machine driver is easy peasy to add, but here I
>> >> stuck at the moment.
>> >
>> > As I said in my other emails the next step is to work out what
>> > the reset and ldoena gpio's are. You won't be able to read the
>> > device ID until you have those setup. Unfortunately, finding the
>> > right GPIOs is likely to be a bit of a chore, I will see if I can
>> > find anything out from the Windows guys at this end.
>> >
>> > Also can you check that the arizona-ldo1 regulator is built in I
>> > am surprised that is falling back to the dummy regulator.
>> >
>> > Thanks,
>> > Charles
>>
>> Hi,
>>
>> I just want to ask, if the windows guys have such infos about the
>> gpios in question (reset,ldoena) and of course the irq details.
>>
>> I am thinking actually to get a second device with Win installed, so
>> that I can get more infos which I really need here.
>> Anyway  I can also provide more infos here (if its not against valid laws :) )
>> But indeeed I can need some hints where to put the pdata structure.
>>
>> I have some more questions that I want to ask/discuss later on irc -
>> if its possible
>>
>> cheers
>> Chris
>
> Ok so it does indeed seem the information I got from the Windows
> team was not fully accurate last time. The IRQ pin, reset line
> and LDO enable are actually specified in ACPI. This block here
> has them:
>
> GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone, 0x0000,
>          "\\_SB.GPO2", 0x00, ResourceConsumer, ,)
> {   // Pin list
>         0x0004
> }
> GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>         "\\_SB.I2C7.PMIC", 0x00, ResourceConsumer, ,)
> {   // Pin list
>         0x0003
> }
> GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>         "\\_SB.GPO1", 0x00, ResourceConsumer, ,)
> {   // Pin list
>         0x0017
> }
>
> The order here being:
>
> 1) IRQ
> 2) Reset GPIO
> 3) LDOENA GPIO
>
> Thanks,
> Charles

(email resend to all)
Hello,

@Charles : thank you.

As Charles suggested prior in one of the mails, I have yesterday added
this patch belowe and tried it out, but unfortunately I got some
new/other errors now while the regulator stuff seems not to be working
for the wm5102 device currently


commit 305f33d58632f85730e245df08dc7070789f9789
Author: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Date:   Mon Jul 13 13:29:07 2015 +0200

    mfd/arizona/pdata.h : added wm5102_pdata with structur of type arizona_pdata

    Signed-off-by: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

diff --git a/include/linux/mfd/arizona/pdata.h
b/include/linux/mfd/arizona/pdata.h
index 43db4fa..df9153b 100644
--- a/include/linux/mfd/arizona/pdata.h
+++ b/include/linux/mfd/arizona/pdata.h
@@ -181,4 +181,17 @@ struct arizona_pdata {
        int irq_gpio;
 };

+/* added for the WM510205 case here
+ *
+ */
+
+const static struct arizona_pdata wm5102_pdata = {
+       .reset = 0x03,
+       .ldoena = 0x17,
+       .irq_flags = IRQF_TRIGGER_RISING|
+                       IRQF_TRIGGER_FALLING,
+       .irq_gpio = 0x04,
+
+};
+
 #endif


The dmesg I got in an endless loop is seen below and please note:
the messages below are most of local added dev_err() to be sure which
code path was running here.


[ 5858.229428] spi spi-WM510205:00: checking WM510205 with bmp180
[ 5858.229437] spi spi-WM510205:00: checking WM510205 with bmp181
[ 5858.229443] spi spi-WM510205:00: modalias WM510205 in id_table not
found, returns NULL
[ 5858.229497] arizona spi-WM510205:00: acpi_match_device() first,
than via spi_get_device_id().
[ 5858.229504] arizona spi-WM510205:00: matched ACPI ID and data
[ 5858.229508] arizona spi-WM510205:00: using 1 as type for arizona audio codec
[ 5858.229512] arizona spi-WM510205:00: regmap set to wm5102_spi
[ 5858.230063] arizona spi-WM510205:00: spi_irq = -1
[ 5858.230069] arizona spi-WM510205:00: arizona_irq = -1
[ 5858.230073] arizona spi-WM510205:00: arizona_spi_probe done, call
and return of  arizona_dev_init
[ 5858.230339] spi-WM510205:00 supply AVDD not found, using dummy regulator
[ 5858.230411] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
[ 5858.230451] arizona spi-WM510205:00: Failed to resolve LDOVDD-supply for LDO1
[ 5858.230458] arizona spi-WM510205:00: Failed to request DCVDD: -517
.... repeating now all the time until reboot/power off / energy=0

Did the patch I added here looks good ? or is there an error that I oversight??

cheers
chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
