From: Javier Martinez Canillas <javierm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: modalias for OF-declared I2C/SPI devices
Date: Fri, 11 Aug 2017 16:11:51 +0200
Message-ID: <1fcd1d99-39ca-6db6-51fc-148c84f66297@redhat.com>
References: <20170811081429.GA9957@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>,
        Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>,
        Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170811081429.GA9957-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

[adding the I2C and SPI subsystem maintainers]

Hello Lukas,

On 08/11/2017 10:14 AM, Lukas Wunner wrote:
> Hi Javier,
> 
> you proposed an RFC patch a while ago which lets the I2C and SPI core
> report an "of:" modalias to user space for devices declared in a
> device tree (vs. a legacy machine description), instead of an "i2c:"
> or "spi:" modalias:
> 
> https://lkml.org/lkml/2014/9/11/458
> https://lkml.org/lkml/2015/8/20/98
> 
> I justed wanted to ask what the status of the patch is?  Looking at
> linux-next I notice that you've been fixing up drivers, machine
> descriptions and device trees as recently as July.  Apparently you're
> still busy landing all the prep work necessary for the patch, is that
> correct?
>

That's partially correct. I'm still pushing the remaining fixes for I2C but I'm
not doing any changes to SPI drivers anymore. It's just too much work and churn
for maintainers.

> It seems to be an awful lot of work cleaning up this mess and I assume

I would also give up on I2C but I'm just keep doing it since we are so close to
finally fix it (only fixes for a couple of drivers are remaining to be merged).

> there is plenty of out-of-tree stuff that may break once the patch lands,

That's correct, but IMHO that's not a problem for mainline. It's the out-of-tree
drivers that were relying on a broken behavior and so what they are doing wasn't
ever expected to work (the fact that works is just due an implementation detail).

Once the I2C and SPI subsystems are fixed to report the proper OF modalias, then
we should document clearly that this may break out-of-tree drivers for courtesy
but I think that's all that mainline should do IMHO.

> so I've been wondering if a simpler solution might be to change user
> space, given that we already communicate all the OF_COMPATIBLE_* uevent
> variables.  So I opened an issue for systemd-udevd but so far Lennart
> remains unconvinced:
> 
> https://github.com/systemd/systemd/issues/6555
> 
> I still think that evaluation of OF_COMPATIBLE_* by user space would be
> the best solution since it seems impossible to cram the degrees of
> freedom afforded by compatible strings into a single modalias string.
>

I agree with Lennart on this. User-space is doing the correct thing and should
not be changed. I'll comment on the Github issue as well.
 
> The reason I came across this issue is that module autoloading fails for
> drivers/gpio/gpio-74x164.c as it only declares an "of" MODULE_DEVICE_TABLE.
> I was going to upstream a GPIO and an IIO driver, both SPI-based, and was
> wondering what the current best practice is:  Should I only declare an
> "of" MODULE_DEVICE_TABLE or should I also provide an "spi"
> MODULE_DEVICE_TABLE?
>

That's a question for Mark Brown. My opinion (since I'm not a maintainer) is
that you should add a SPI device ID table and export it as spi:<foo> aliases
until this is properly fixed.

The correct way to fix this is to move this into the device model instead of
all subsystem types duplicating the same uevent logic and requiring a table
per each firmware interface. But that's a much bigger task...
 
> Thanks!
> 
> Lukas
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
