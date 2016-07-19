From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] spi: spidev: create spidev device for all spi slaves.
Date: Tue, 19 Jul 2016 20:33:12 +0200
Message-ID: <CAOMqctSqkSNHjsGn-qobNknZNM5cY=0SVgrYBFPZE=odWQR=FA@mail.gmail.com>
References: <cover.1468880530.git.hramrach@gmail.com> <5bfcceff7b6132cf3447f97c24d1646043224164.1468880530.git.hramrach@gmail.com>
 <20160718225952.GW30372@sirena.org.uk> <CAOMqctQ7Uq7JEYZovYqzQHLpjgk8HoK8Q2Bei3gEzFboyUxNyg@mail.gmail.com>
 <20160719124409.GC30372@sirena.org.uk> <CAOMqctRTNRTKKLVMXgxzdJEq0giRp5f8ujAUf-gUty9fSjqGXA@mail.gmail.com>
 <20160719171959.GD30372@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160719171959.GD30372-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 19 July 2016 at 19:19, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jul 19, 2016 at 05:32:24PM +0200, Michal Suchanek wrote:
>> On 19 July 2016 at 14:44, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>> >> -       status = register_chrdev(SPIDEV_MAJOR, "spi", &spidev_fops);
>> >> +       status = register_chrdev(SPIDEV_MAJOR, "spidev", &spidev_fops);
>
>> > also looks like a needless ABI change
>
>> ABI change to what?
>
>> The spidev ABI should be the IOCTLs on /dev/spidev*. These are preserved.
>
>> What parts of the kernel or userspace should depend on spidev
>> devices belonging to class spi?
>
> It's a string that's exposed to userspace (via /proc/devices if nothing
> else).

Yes, the change can be detected from userspace. The question is
more like 'Is there any sane reason anyone would rely on seeing
that exact string for something?'

BTW the classes are also exported through /sys so the spidev devices
would look differently there also.

>
>> > If userspace is managing to figure out how to control the device then
>> > providing a description of the hardware is clearly within the bounds of
>> > possibility and there is no need to fake anything.
>
>> However. maintaining the hardware description in multiple places is
>> redundant and error-prone. Since the userspace somehow managed to
>> figure it out on legacy kernels without devicetree it does not need
>> the information in devicetree. Users of such software will not want the
>> hardware description in devicetree and if forced to provide it will stub it out.
>
> Userspace is just as capable of looking at the DT as anything else, I'd
> expect that where this is a viable way of deploying things people would
> be writing udev/systemd magic to fire up userspace drivers automatically
> when they see suitable hardware.  The only way this has ever worked in
> the past has been with system specific hacks which lead to fragile,
> non-portable userpaces that are hard to upgrade.  If we're trying to say
> this is an interface that's there for all devices then we shouldn't be
> defining it in a way that makes it difficult to automatically configure.

Oh sure. Once a device-specific hack turns out to be something
desirable to maintain over long time and deploy on variety of devices we
have infrastructure to automate that.

That does not make device-specific hacks go away. Initially the user
will do only as much as it takes to get the device working right now
and that does not include writing devicetree description of the device
when it is used with userspace driver.

>
>> Also world is not all devicetree so userspace applications should be free
>> to consult devicetree information if present or use whatever other means
>> at their disposal to determine what hardware they are dealing with.
>> When portability is a concern consulting devicetree may be a secondary
>> source at best.
>
> ACPI has similar facilities (it's got a direct translation of DT in it
> these days so most things with a DT binding also have an ACPI one for
> free).

There is even a patch floating around for adding empty DT and some proxy
nodes for existing hardware so dynamically connected devices can be
configured with devicetree overlays on boards without devicetree.

So you can have devicetree description of the hardware. It's just sometimes
not useful.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
