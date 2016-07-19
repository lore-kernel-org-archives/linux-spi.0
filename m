From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] spi: spidev: create spidev device for all spi slaves.
Date: Tue, 19 Jul 2016 13:17:52 +0200
Message-ID: <CAOMqctQ7Uq7JEYZovYqzQHLpjgk8HoK8Q2Bei3gEzFboyUxNyg@mail.gmail.com>
References: <cover.1468880530.git.hramrach@gmail.com> <5bfcceff7b6132cf3447f97c24d1646043224164.1468880530.git.hramrach@gmail.com>
 <20160718225952.GW30372@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160718225952.GW30372-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

On 19 July 2016 at 00:59, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jul 19, 2016 at 12:35:40AM +0200, Michal Suchanek wrote:
>
>>  config SPI_SPIDEV
>> -     tristate "User mode SPI device driver support"
>> +     bool "User mode SPI device driver support"
>
> This is a step back, it would require spidev to be built in.

That's a technical problem so it can be addressed.

>
>> -     spin_lock_irq(&spidev->spi_lock);
>> -     spi = spi_dev_get(spidev->spi);
>> -     spin_unlock_irq(&spidev->spi_lock);
>> +     spi = filp->private_data;
>> +     spi = spi_dev_get(spi);
>
> All this refactoring to move spidev about should've been a separate
> patch, it's hard to find the actual content in here.

And re-modularizing will probably need to move thing back, mostly.

Regarding this change

spidev uses device_create to allocate spidev character devices so
these are not part of some struct spidev_device but live separately
which gives needlessly more objects to manage

- the spi device
- the spidev character device
- a link object that points to both spi and spidev and is manually
  managed by the spidev driver

In order to reduce the amount of objects and management I appended
the link object at the end of struct spi_device.

Is there a better way?

>
>> -     mutex_lock(&device_list_lock);
>> +     dev = bus_find_device(&spi_bus_type, NULL, (void *) inode->i_rdev,
>> +                           spidev_devt_match);
>
> ...
>
>> -                     dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
>> +     spi = to_spi_device(dev);
>> +
>> +     mutex_lock(&spi->buf_lock);
>> +     spin_lock_irq(&spi->spidev_lock);
>> +     spi->spidev_users++;
>> +     spin_unlock_irq(&spi->spidev_lock);
>
> This is broken, it will unconditionally create a spidev for any chip
> select regardless of if there's any actual hardware there and (even more
> importantly) regardless if that hardware is actually a SPI device.  This
> is not safe, especially given some of the ideas people seem to have for
> userspaces.

This is as safe as it gets. For the device probe to happen somebody must
have configured the CS as spi slave device somewhere. What this patchset
accomplishes is creating an userspace interface for accessing SPI bus using
the CS regardless of the probe result (at least for devicetree nodes).

In particular it does not create a spidev device for CS lines which are unused.

Looking into SPI more this whole point is mostly moot, anyway. Most of the
time the unused CS lines will not be multiplexed to the SPI controller so
even if the SPI master tries to use them it does nothing. Also most of the
time all the CS lines can be exported as GPIO regardless of their use for SPI.
And set to any possible level using the GPIO userspace API.

>
> I am getting completely fed up of saying this, it's not OK to just
> expose pins to userspace when we have no idea what they are connected
> to.

I am getting fed up with this argument.

First, this patchset only exposes to userspace pins that are configured as SPI
slaves in devicetree.

It does so even in the cases when the driver for the device in question is not
available in the kernel (because it is not loaded or excluded completely) or
in the case you do not specify which SPI slave is connected to those pins.
This is the only change.

So in addition to saying 'load driver XY with parameters Z=BJ' this allows
saying 'there is possibly a SPI device and I may want to talk to it with an
userspace application'. With overlays this can be later amended to 'load
driver ZY with parameters X=XN' or whatever.

The fact that devicetree does not allow talking to a SPI device from userspace
without telling kernel what kind of protocol userspace is using is a regression
from using board files. The kernel has no business knowing that. When you
use a userspace driver it's userspace's job to manage protocols and devices.
The purpose of this patchset is for the userspace applications to continue doing
so with devicetree based systems without the need to fabricate fake hardware
description. And the hardware description will necessarily be fake in the case
when it is in fact userspace implementing and managing the drivers.

It's not to say that userspace drivers that duplicate kernel drivers cannot
examine the devicetree for configuration data. That's up to the userspace
driver writer to decide, however.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
