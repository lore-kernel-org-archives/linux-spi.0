From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] drivers core: allow id match override when manually
 binding driver
Date: Sun, 26 Jun 2016 08:44:00 +0200
Message-ID: <CAOMqctRZ41f3Oiz0uvkyyxsaaM5cs8jdNGS0j5WEwoWaesHnTw@mail.gmail.com>
References: <cover.1466696079.git.hramrach@gmail.com> <5e0397742f887f656d67bb0d61c8e10782c0e5af.1466696079.git.hramrach@gmail.com>
 <CAPcyv4jxU2oBTk-MzH7fepu0zXnTZsAdLbY8eOvpOvZOq_QaRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>,
	Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>,
	Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>,
	Nikolay Aleksandrov <nikolay-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>,
	Dmitry Vyukov <dvyukov-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Adrien Schildknecht <adrien+dev-Yk6CzqVXkG6lnMjI0IkVqw@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPcyv4jxU2oBTk-MzH7fepu0zXnTZsAdLbY8eOvpOvZOq_QaRw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

On 26 June 2016 at 06:14, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Jun 23, 2016 at 10:41 AM, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> This allows binding spidev on any slave device by hand using sysfs
>> without adding superfluous compatibles or any other needless
>> complication.
>>
>> Note that any slave driver that requires configuration will fail to
>> probe anyway. Only a driver that binds to anything can be bound
>> successfully.
>>
>> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/base/Kconfig.debug | 14 +++++++++
>>  drivers/base/bus.c         | 72 +++++++++++++++++++++++++++++++++++++++++++++-
>>  lib/Kconfig.debug          |  2 ++
>>  3 files changed, 87 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/base/Kconfig.debug
>>
>
> Why change the driver core?  The matching policy can be changed with
> the "match" operation of a custom "struct bus_type".

It cannot. Only driver core knows that the match is result of writing
the bind file in sysfs. This is information is discarded at this very
point.

On 26 June 2016 at 03:17, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Jun 23, 2016 at 05:41:20PM -0000, Michal Suchanek wrote:
>
>> This allows binding spidev on any slave device by hand using sysfs
>> without adding superfluous compatibles or any other needless
>> complication.
>
> This says "spidev" but it's a change to the driver core, not something
> that is specific to spidev.  It needs to be explained in terms ofn the
> driver core, especially given that other runtime ID setting is done in a
> particular bus.
>
>> +menuconfig DRIVER_MATCH_OVERRIDE
>> +     bool "Allow manual driver binding to override id match (DANGEROUS)"
>> +     default n
>> +     help
>> +       When binding a driver manually bypass the check of driver id table
>> +       against device id in driver core. This can be useful for development
>> +       or on buses that don't provide reliable device identification.
>> +
>> +config DRIVER_MATCH_OVERRIDE_BUSES
>> +     string "Specify buses for which id matching will be overridden"
>> +     default "spi"
>> +     depends on DRIVER_MATCH_OVERRIDE
>> +     help
>> +       space separated bus names
>
> This doesn't seem at all idomatic for how I'd expect bus features to be
> implemented, or Linux configuration in general.  If we're going to allow
> a feature like this at the core level we should just allow it, if we're
> going to opt buses into any such feature I'd expect it to be done
> unconditionally.

Allowing some control over enabling or disabling this may be more
generally acceptable. I was even considering a sysfs file that would
enable control of this feature at runtime.

The main use case for this is spidev. I am not familiar with all
kernel subsystems so there might be other uses.

The problem with spidev is this:

The SPI bus feature-wise is closest to serial UARTs form the other
buses available in kernel. Serial uart does not even have a bus
driver.

The main hardware difference is that part of SPI specification is CS
which makes it proper bus whereas serial UARTs have no CS which makes
them point to point. You can use gpios to multiplex serial devices too
if you wanted - it's just non-standard setup.

The main kernel difference is that for serial UART a character device
is created which a userspace program can use to send and receive data
in the hope that whatever device is expected on the other side is
actually there. This is the traditional use of serial lines. In
addition there are serial drivers that expect to be driving a device
that is on the mainboard and just happens to be connected by a serial
line to the CPU. These might need additional GPIOs and can probably be
configured by devicetree (iirc IR and Bluetooth devices of this type
exist). For SPI the latter is the traditional use and recently boards
with SPI connectors started to be common and people want to use the
SPI bus the same way serial ports are used - connect some random
device to the pins and try to talk to it from userspace.

Spidev is the driver which allows the use of SPI similar to how serial
ports are used. The boards typically use devicetree for hardware
description. And spidev is not configured anywhere in the devicetree.
The response was to generate random compatible for the SPI port, add
that compatible to spidev, and load it as the driver. Actually, you
were supposed to generate a new compatible for every kind of device.
That does not make any sense. It's like asking people to generate a
new kernel config and reboot just to connect a different kind of modem
to their serial port.

With devicetree overlays you can load an overlay for complicated
devices that need GPIOs or extra settings and happen to have kernel
driver (eg fbtft). Once loading the overlays is possible in mainline.

With less complicated drivers like m25p80 you can get full features
with overlays and limited features with this patch.

And with spidev you cannot use overlays because 'it is not supposed to
be specified in devicetree because it is linux implementation detail
and not hardware'. Another option to do this outside of core is to
generate a compatible for generic SPI external header, add that to
spidev, and be done with it. No-go again.

An alternative approach that has been tried was to probe the SPI slave
and if no driver is found bind spidev automatically in the kernel.
This has two problems. If you cannot specify the external connector in
DT you cannot know which CS to probe and which to leave alone. The
concern is that triggering unused CS could disturb other hardware. The
other problem is you never know if a driver is going to be loaded
later and will be blocked from binding by spidev. It would also mean
that if you unbind spidev you cannot re-bind it because it does not
match.

Just leaving the device without a driver and let userspace decide to
bind it or not seems like more general approach which can be
potentially reused for other cases.

The last option I see is to get rid of separate spidev driver and just
create a character device for every spi slave and bind the spidev
IOCTLs to it when spidev support is enabled. It is specific to spidev
and needs no core changes. It may cause mild conflict with spi slaves
creating their own character devices.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
