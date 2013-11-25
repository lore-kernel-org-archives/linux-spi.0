From: martin sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: Subject: [PATCH] Fix long standing chip select issue for non-default
 CS-polarity setups
Date: Mon, 25 Nov 2013 13:35:44 +0100
Message-ID: <52934420.1040603@martin.sperl.org>
References: <A4EEA261-22E6-41A7-82C4-68E8606E0863@martin.sperl.org> <20131125111603.GC14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131125111603.GC14725-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 25.11.2013 12:16, Mark Brown wrote:
> You can't do this safely, setup() may be called while another transfer
> is active so reprogramming the hardware during setup() may disrupt an
> ongoing transfer.  Remember, setup() can be triggered by client drivers
> calling spi_setup().
> 
We are not reprogramming the HW there.

We just filling in the "template" value for the register used the next
time the control-register needs to get configured for a transfer.

If you look exactly you will find that
bcm2835_spi_start_transfer makes use of:
  bs->cs_device_flags[spi->chip_select]
and bcm2835_spi_transfer_one uses the:
  bs->cs_device_flags_idle
to fill in the "flags" and then writes to the control-register.

So if there would be a race between spi_setup and the functions above,
then the worsted case situation is that:
bs->cs_device_flags[spi->chip_select] and/or bs->cs_device_flags_idle
still contains the "old" flags.

But if this is a race, then it exists regardless of if there is a
spinlock protecting access of those variables or not, because then
it is a race between spi_transfer and spi_setup which is totally outside
of the driver.

If this is not safe enough, then we can wrap this structure in a spinlock.

To elaborate on the race: the way the problem presents itself the issue
is that if there is already a SPI message that is getting processed for
a device while there is a device with reverse polarity that has not been
set up yet, then both devices would assume they are being "addressed".
So until spi_setup is called for the device with reverse polarity, both
devices would be (potentially) changing the MISO line concurrently.

See also the comment in spi_add_device:
        /* Drivers may modify this initial i/o setup, but will
         * normally rely on the device being setup.  Devices
         * using SPI_CS_HIGH can't coexist well otherwise...
         */
        status = spi_setup(spi);

and this call in spi_add_device is "protected" by the spi_add_lock mutex.

Any subsequent calls to spi_setup by a device driver should not
impact SPI_CS_HIGH so we do not change anything in these fields
at a later time anyway.

Martin

P.s: Maybe I miss something else?

Maybe that a device may change spi->mode while the driver is working?

If so then such an action would require a full bus-lock to avoid running
into a race with other device-drivers. Then the driver could reconfigure
the polarity settings on the device itself and then it can change
spi->mode and can call spi_setup and then finally release the bus lock.

Following the argument above we open up another can of worms:

As spi_async will fail on bus_lock there are drivers (as far as I have
seen) that would stop working if they were confronted with a short-term
bus_lock situation assuming the device itself went away.

And that in itself would be a rare race-condition that would only show
under certain circumstances.

So maybe instead of "failing" spi_async for this locked-bus case, we
should queue the messages in a separate queue in such a situation
instead to avoid the "error-handling" bugs in the drivers and schedule
those messages when releasing the bus-lock?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
