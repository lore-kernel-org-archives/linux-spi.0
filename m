From: Vegard Nossum <vegard.nossum-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: spidev locking ("spi: spidev: fix possible NULL dereference")
Date: Fri, 13 Nov 2015 16:13:44 +0100
Message-ID: <5645FE28.3070501@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

I was reviewing some stable commits and came across this, which might
not be wrong, but looks weird in any case:

commit a56166134ad739e7448332e2af2aac59a0b6a385
Author: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date:   Thu Sep 10 16:48:13 2015 +0530

     spi: spidev: fix possible NULL dereference

The "weird" part is this:

-               spidev->speed_hz = spidev->spi->max_speed_hz;
+               if (spidev->spi)
+                       spidev->speed_hz = spidev->spi->max_speed_hz;

                 /* ... after we unbound from the underlying device? */
                 spin_lock_irq(&spidev->spi_lock);
                 dofree = (spidev->spi == NULL);
                 spin_unlock_irq(&spidev->spi_lock);

It would seem strange that the second spidev->spi read requires a
spinlock, but the first one doesn't.

spidev_remove() potentially sets spidev->spi to NULL, and this happens
with the spidev->spi_lock taken, but without the device_list_lock mutex,
and spidev_release() only takes the device_list_lock mutex for the
spidev->spi dereference above, so presumably it is possible for a new
caller to set spidev->spi to NULL while spidev_release() is in progress.

I think it would be great if somebody who knows the code could have a
look into this to see if there is indeed a problem, and there could be
some comments added to the code to explain

1) why it is (not?) okay to check spidev->spi without the spinlock there,

2) why the ->spi_lock is not taken inside the device_list_lock mutex in
spidev_remove(),

3) what are the potential interactions between spidev_release() and
spidev_remove(), if any,

to make it easier to review the code in the future.

Thanks,


Vegard
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
