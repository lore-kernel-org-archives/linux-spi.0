From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: Document option to wake a device by toggling CS
Date: Thu, 30 Jun 2016 21:32:05 -0700
Message-ID: <CAD=FV=U_8aG4VyYEchwBxVdXTDLBmsH+XU2SnWZmbfLP4=Dpxg@mail.gmail.com>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org>
 <1467258867-117727-2-git-send-email-apronin@chromium.org> <CAMuHMdXCeFMXPczi3b=GpUEzUJiz0+sK_299GY8o-iYgP8G9iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXCeFMXPczi3b=GpUEzUJiz0+sK_299GY8o-iYgP8G9iA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Thu, Jun 30, 2016 at 12:12 AM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> CC devicetree

And Rob and Mark...

 ./scripts/get_maintainer.pl -f
Documentation/devicetree/bindings/spi/spi-bus.txt

Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> (maintainer:SPI SUBSYSTEM)
Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> (maintainer:OPEN FIRMWARE AND
FLATTENED DEVICE TREE BINDINGS)
Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> (maintainer:OPEN FIRMWARE AND
FLATTENED DEVICE TREE BINDINGS)
linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SPI SUBSYSTEM)
devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:OPEN FIRMWARE AND FLATTENED
DEVICE TREE BINDINGS)
linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)


> On Thu, Jun 30, 2016 at 5:54 AM,  <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>> From: Andrey Pronin <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>
>> Some SPI devices may go to sleep after a period of inactivity
>> on SPI. For such devices, if enough time has passed since the
>> last SPI transaction, toggle CS and wait for the device to
>> start before communicating with it.
>>
>> Signed-off-by: Andrey Pronin <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/spi/spi-bus.txt | 7 +++++++
>>  1 file changed, 7 insertions(+)

Overall note is that devicetree bindings patches should be _before_
the code that uses them, so you should swap patch #1 and patch #2.

>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> index 42d5954..1b7ffd4 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> @@ -63,6 +63,13 @@ contain the following properties.
>>                        used for MISO. Defaults to 1 if not present.
>>  - spi-rx-delay-us  - (optional) Microsecond delay after a read transfer.
>>  - spi-tx-delay-us  - (optional) Microsecond delay after a write transfer.
>> +- cs-wake-after-sleep - (optional) Device may go to sleep after a period
>> +               of SPI inactivity. If this flag is set, toggle CS and
>> +               wait for it to wake before communicating to it.

You probably also need a property for how long it needs to be asserted
when you "toggle" it?

>> +- cs-sleep-delay  - (optional) Delay after which the device may go to
>> +               sleep if there was no SPI activity (msec).
>> +- cs-wake-duration - (optional) Time it takes the device to wake up after
>> +               toggling CS if it went to sleep (msec).

I believe that from your code the second two properties are both
required if the first property is set.  That should be in the
bindings.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
