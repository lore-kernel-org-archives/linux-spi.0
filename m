From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: modalias for OF-declared I2C/SPI devices
Date: Fri, 11 Aug 2017 10:14:29 +0200
Message-ID: <20170811081429.GA9957@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>,
        Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Javier,

you proposed an RFC patch a while ago which lets the I2C and SPI core
report an "of:" modalias to user space for devices declared in a
device tree (vs. a legacy machine description), instead of an "i2c:"
or "spi:" modalias:

https://lkml.org/lkml/2014/9/11/458
https://lkml.org/lkml/2015/8/20/98

I justed wanted to ask what the status of the patch is?  Looking at
linux-next I notice that you've been fixing up drivers, machine
descriptions and device trees as recently as July.  Apparently you're
still busy landing all the prep work necessary for the patch, is that
correct?

It seems to be an awful lot of work cleaning up this mess and I assume
there is plenty of out-of-tree stuff that may break once the patch lands,
so I've been wondering if a simpler solution might be to change user
space, given that we already communicate all the OF_COMPATIBLE_* uevent
variables.  So I opened an issue for systemd-udevd but so far Lennart
remains unconvinced:

https://github.com/systemd/systemd/issues/6555

I still think that evaluation of OF_COMPATIBLE_* by user space would be
the best solution since it seems impossible to cram the degrees of
freedom afforded by compatible strings into a single modalias string.

The reason I came across this issue is that module autoloading fails for
drivers/gpio/gpio-74x164.c as it only declares an "of" MODULE_DEVICE_TABLE.
I was going to upstream a GPIO and an IIO driver, both SPI-based, and was
wondering what the current best practice is:  Should I only declare an
"of" MODULE_DEVICE_TABLE or should I also provide an "spi"
MODULE_DEVICE_TABLE?

Thanks!

Lukas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
