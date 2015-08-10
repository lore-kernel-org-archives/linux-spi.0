From: Christian Hartmann <cornogle@googlemail.com>
Subject: Re: Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
 of WM510205 codec via ACPI (resend)
Date: Mon, 10 Aug 2015 09:00:50 +0200
Message-ID: <CAKor6Tcof3PA3JGD2=4X8mtSak8ka9BVD2L4zdYC4M1yEYEXjg@mail.gmail.com>
References: <20150629094854.GB11162@sirena.org.uk>
 <CAKor6TdDPb2qOgdHbeX2w+yQa_ioDM5ak9bk+=jF+cKt_twiXw@mail.gmail.com>
 <20150630103404.GI6321@opensource.wolfsonmicro.com>
 <CAKor6TdKk2OUz4o12RiQBSVZyhD=L4JpBJcYkGE=_6X+ZeQY_g@mail.gmail.com>
 <20150713095359.GM16517@opensource.wolfsonmicro.com>
 <CAKor6Td83zgOS+iHGHGhFW4n26H=tC-QQDuzaHHfybhLeH-jvw@mail.gmail.com>
 <CAKor6TdheYM73aqti362bOnP2GZmX60uuDY5v2eow1vqO9tcKw@mail.gmail.com>
 <20150715081224.GN16517@opensource.wolfsonmicro.com>
 <20150715091709.GK11162@sirena.org.uk>
 <CAKor6TcSc7n=Rd9NJAf-6cYXr50Z62cbcsbuaEutRMPAiM=2NQ@mail.gmail.com>
 <20150717085434.GO16517@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, mika.westerberg@linux.intel.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, jarkko.nikula@linux.intel.com,
 Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 dan.carpenter@oracle.com
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150717085434.GO16517@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org

Hi,

> That implies the pdata is not set for the device when you are
> entering arizona_dev_init, also might be worth checking if it is
> calling the stub version of the full version (basically is
> CONFIG_OF turned on).
# CONFIG_OF is not set here, so the current code as in arizona_dev_init()

...
if (dev_get_platdata(arizona->dev,0)) {
/* currently not working... */
else
 arizona_of_get_core_pdata(arizona);

which returns only '0' in this case  because the config option
CONFIG_OF is disabled.

Today I am back at this device and I have changed the above function
(arizona_of_get_core_pdata) where I set
currently the pdata with its values for the arizona type = WM5102.

So the pdata is at the moment hardcoded, that is not the way I want to
go on, but
it seems the code works so far, except the LDO1 makes trouble with the
current GPIO value 0x17 (extracted from dsdt.dsl as seen above).

[    5.790655] systemd-journald[434]: Received request to flush
runtime journal from PID 1
[    7.263225] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
[    7.263339] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
[    7.263482] spi spi-WM510205:00: 8333333 Hz actual, PIO
[    7.263490] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
[    7.263551] spi spi-WM510205:00: checking WM510205 with bmp180
[    7.263557] spi spi-WM510205:00: checking WM510205 with bmp181
[    7.263562] spi spi-WM510205:00: modalias WM510205 in id_table not
found, returns NULL
[    7.263610] arizona spi-WM510205:00: acpi_match_device() first,
than via spi_get_device_id().
[    7.263617] arizona spi-WM510205:00: matched ACPI ID and data
[    7.263621] arizona spi-WM510205:00: using 1 as type for arizona audio codec
[    7.263625] arizona spi-WM510205:00: regmap set to wm5102_spi
[    7.264424] arizona spi-WM510205:00: spi_irq = -1
[    7.264432] arizona spi-WM510205:00: arizona_irq = -1
[    7.264436] arizona spi-WM510205:00: arizona_spi_probe done, call
and return of  arizona_dev_init
[    7.264440] arizona spi-WM510205:00: dev_set_drvdata done for 1
[    7.264445] arizona spi-WM510205:00: arizona_of_get_core_pdata for 1
[    7.264450] arizona spi-WM510205:00: regcache_cache_only for 1 set
[    7.264454] arizona spi-WM510205:00: added wm5102_core_supplies for 1
[    7.269430] LDO1: Failed to request enable GPIO23: -517
[    7.269506] arizona spi-WM510205:00: Failed to register LDO1 supply: -517
[    7.289191] spi-WM510205:00 supply AVDD not found, using dummy regulator
[    7.289246] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
[    7.289366] spi-WM510205:00 supply DCVDD not found, using dummy regulator
[    7.289415] arizona spi-WM510205:00: Failed to request /RESET: -517
[    7.289690] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00

... arizona spi-wm510202 tries to init the device 2 times again ....

side-note: added a lot of dev_err to see whats going on, so the most
messages are not in master, only in my local branch (today its
4.2.0-rc6)

Instead of hardcoding and finding the correct GPIOs by Try&Error I
want as mentioned above already by Charles Keepax, to pull them from
ACPI.

currently I am not using the the gpiolib.h and its functions to get
the named and relevant GPIOs in question,
failing yet searching for examples which fits into the arizona mfd code easily.

I saw the drivers/gpio/gpio-arizona.h, which is also not using the
gpiolib.h, too.also it is not clear to me, if I should use
gpio-arizona at all (or extend it for using it with the wm5102).


zitat from Charles:

"I suspect we still have some issues with the GPIO lookups, I
suspect we want to actually pull them from ACPI rather than
putting them into the pdata, as I don't know if the number will
translate directly over."

What I have understand today :  the three values (irq_gpio, reset,
ldoena) have different 'parents' as seen in the dsdt.dsl
irq_gpio = _SB.GPO2 -> 0x0004
reset = _SB.I2C7.PMIC

Looking in other wmXXXX drivers how they get and set there gpios, but
nothing found what I can adapt or reuse here at the moment.

Does anybody has a clue??

cheers
chris
