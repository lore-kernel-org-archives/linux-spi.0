From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Tue, 29 Apr 2014 23:31:49 +0200
Message-ID: <24BF05CB-35FF-42E8-BE5C-A5E4E3D0C52A@martin.sperl.org>
References: <1398705774-12361-1-git-send-email-maxime.ripard@free-electrons.com> <20140429183758.GH15125@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140429183758.GH15125-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 29.04.2014, at 20:37, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Mon, Apr 28, 2014 at 10:22:54AM -0700, Maxime Ripard wrote:
> 
>> spidev device registration has always been a controversial subject since the
>> move to DT.
> 
> Why can we not handle this by using sysfs to bind spidev to the device?



I think the question is actually more generic than just "spidev" related.

A solution should also help all those users of development boards like 
raspberry pi, beagle board,... where people want to add spi devices without
having to know too much about the fine details of the kernel configuration
/kernel compiling/creating a new device tree or similar.... 
They just want their device to work with the existing kernel 
with minimal effort!

For just this purpose I got an out of tree module called spi-config that 
- as of now - allows to define the binding of spi devices (not solely 
focused on spidev) as per module argument while loading the driver.

This could easily get extended to work also via sysfs.

The problem here is mostly around the "passing" of driver specific platform 
data, which this module currently handles in a sort of "binary blob" way, 
which is suboptimal (as it is very architecture specific),
but at least it works...

Some examples of what is there:

Bind spidev to spi0.1 with a speed of 2MHz and SPI mode 3:
modprobe spi-config bus=0:cs=1:modalias=spidev:speed=2000000:mode=3

Bind an mcp2515 CAN-bus controller to spi0.0 with 10MHz speed and 
IRQ triggered via GPIO25:
modprobe spi-config bus=0:cs=0:modalias=mcp2515:speed=10000000:gpioirq=25:\
mode=0:pd=20:pdu32-0=16000000:pdu32-4=0x2002

The extra "pd...=" args are the ones describing platform data that is needed
by the mcp251x driver to set up the device correctly. 
In the above example we define:
* pd=20: the platform data size is 20 bytes (zero filled)
* pdu32-0: a u32 at offset 0 with a value of 16MHz Quarz speed
* pdu32-4: a u32 at offset 4 the interrupt flags used by the driver
           (=IRQF_TRIGGER_FALLING|IRQF_ONESHOT)

The above mcp2515 device now configured via sysfs could look like this:
echo "cs=0:modalias=mcp2515:speed=10000000:gpioirq=25:mode=0:\
pd=20:pdu32-0=16000000:pdu32-4=0x2002" > /sys/class/spi_master/spi0/register

Unregistering the device:
echo "cs=0" > /sys/class/spi_master/spi0/unregister

As said: the trickiest part is "platform data", all the "spi-parameters"
are well-defined and are easily parseable.

Options that come to my mind to increase "readability" are:
* "const char *extra_parameters" 
  in spi_device containing all "unhandled" parameters left for the driver
  to parse during probing.
* "int (*config)(struct spi_device *,const char *key,const char *value)"
  in spi_driver that sets the corresponding parameters
  (creating platform data if it is not already set/allocated) 
  and which is called prior to calling spi_driver->probe(spi)

So with those "readability" options the sysfs interface could 
look like this:
echo "cs=0:modalias=mcp2515:speed=10000000:gpioirq=25:mode=0:\
can_oscillator_hz=16000000:interrupt_flags=0x2002" \
> /sys/class/spi_master/spi0/register

When using the second option the framework could fall back to the
voodoo-"pd...=" approach that I have show above to avoid having to touch 
all spi drivers immediately to make use of this interface.

The biggest pitfall I see is that if a device driver expects platform
data but none is provided, then loading the driver could crash the kernel.
But that is something that probably should get fixed in the driver 
itself and not in the framework.

A totally different approach could be the use of device-tree overlays, 
which is also not included in the kernel, but would allow for similar
config schemes.
But that would leave systems not using device tree without this option.

So it seems as if we need to find an approach that is acceptable...

Ciao,
	Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
