From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: Additional SPI-master parameters per SPI-Device in device-tree
Date: Tue, 04 Aug 2015 12:09:52 +0200
Message-ID: <55C08F70.5070303@martin.sperl.org>
References: <55C05E18.600@martin.sperl.org> <20150804095443.GH20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150804095443.GH20873-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 04.08.2015 11:54, Mark Brown wrote:
> On Tue, Aug 04, 2015 at 08:39:20AM +0200, Martin Sperl wrote:
>> Examples for the spi-bcm2835 master for example could be:
>> * set minimum transfer size for dma to something else but the default
>>     (of 96 bytes - setting for something high would disable it)
>> * change polling transfer limits (i.e disable it)
>
> Why would these things be configured in the device tree in the first
> place?  They don't look like things that should be device tree
> properties, they look like something the kernel should figure out at
> runtime - the system tuning may change as the kernel evolves or
> depending on userspace needs.

Sometimes it may be necessary to define different values than the
"kernel" thinks may be necessary (hardcoded).

We just had one issue with fbtft devices where it would have been
nice to change those values on a per device basis (even if it was
just for some testing to see why it was behaving badly
- see the still un-merged patch:
"spi: bcm2835: set up spi-mode before asserting cs-gpio").

So I first thought of adding it as a module parameter for the driver
and then exposing it via sysfs for modification, but now I think it
might be even more beneficial to "tune" the parameters per device.

Say for fbtft devices to use DMA for any xfer-size above 4 bytes.
But that policy may not apply to the corresponding touch screen device
also connected to the same SPI bus.

But then - I now come to realize - that this "dt-property" idea
may again break the "philosophy" of "device-tree only contains
a description of the HW".

So maybe a per device sysfs approach together with udev-rules to
change those settings may be the better approach.

But even those may require those device registration hooks I had
mentioned.

So I was wondering what was feasible/acceptable.

Martin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
