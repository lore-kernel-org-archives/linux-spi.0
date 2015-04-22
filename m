From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: spidev and the use of spi_async instead of spi_sync
Date: Wed, 22 Apr 2015 17:55:44 +0200
Message-ID: <AED5BFFC-FF25-4699-9534-AAB3AE285021@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

With the 4.0 kernel there has been a nice improvement for
spi_sync where, when there is nothing in the queue the message
pump will get executed in the context of the caller.

This means reduction in the number of context switches and more,
which is nice.

Unfortunately this does not impact spidev, as it (re)implements
spi_sync on its own.

Here the code as of now:
/*
 * We can't use the standard synchronous wrappers for file I/O; we
 * need to protect against async removal of the underlying spi_device.
 */
static void spidev_complete(void *arg)
{
        complete(arg);
}

static ssize_t
spidev_sync(struct spidev_data *spidev, struct spi_message *message)
{
        DECLARE_COMPLETION_ONSTACK(done);
        int status;

        message->complete = spidev_complete;
        message->context = &done;

        spin_lock_irq(&spidev->spi_lock);
        if (spidev->spi == NULL)
                status = -ESHUTDOWN;
        else
                status = spi_async(spidev->spi, message);
        spin_unlock_irq(&spidev->spi_lock);

        if (status == 0) {
                wait_for_completion(&done);
                status = message->status;
                if (status == 0)
                        status = message->actual_length;
        }
        return status;
}

As this code is from 2008 the situation may be different
now and we can use spi_sync instead?

Maybe a patch along the following lines:
static ssize_t
spidev_sync(struct spidev_data *spidev, struct spi_message *message)
{
        DECLARE_COMPLETION_ONSTACK(done);
        int status;
	struct spi_device *spi;

        spin_lock_irq(&spidev->spi_lock);
	spi = spidev->spi;
        spin_unlock_irq(&spidev->spi_lock);

	if (!spi)
		return -ESHUTDOWN;
	
	status = spi_sync(spi, message);

	if (!status)
		status = message->actual_length;

        return status;
}

would be a working solution, but then I am unsure about the reason why
this locking is in place.

So I just want to point out that this may be a candidate for
improvement.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
