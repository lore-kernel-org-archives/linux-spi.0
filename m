From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] spi: spidev: create spidev device for all spi
 slaves.
Date: Mon, 18 Jul 2016 23:59:52 +0100
Message-ID: <20160718225952.GW30372@sirena.org.uk>
References: <cover.1468880530.git.hramrach@gmail.com>
 <5bfcceff7b6132cf3447f97c24d1646043224164.1468880530.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rUGnr7B6Y4qPBmNO"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5bfcceff7b6132cf3447f97c24d1646043224164.1468880530.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rUGnr7B6Y4qPBmNO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 19, 2016 at 12:35:40AM +0200, Michal Suchanek wrote:

>  config SPI_SPIDEV
> -	tristate "User mode SPI device driver support"
> +	bool "User mode SPI device driver support"

This is a step back, it would require spidev to be built in.

> -	spin_lock_irq(&spidev->spi_lock);
> -	spi = spi_dev_get(spidev->spi);
> -	spin_unlock_irq(&spidev->spi_lock);
> +	spi = filp->private_data;
> +	spi = spi_dev_get(spi);

All this refactoring to move spidev about should've been a separate
patch, it's hard to find the actual content in here.

> -	mutex_lock(&device_list_lock);
> +	dev = bus_find_device(&spi_bus_type, NULL, (void *) inode->i_rdev,
> +			      spidev_devt_match);

...

> -			dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
> +	spi = to_spi_device(dev);
> +
> +	mutex_lock(&spi->buf_lock);
> +	spin_lock_irq(&spi->spidev_lock);
> +	spi->spidev_users++;
> +	spin_unlock_irq(&spi->spidev_lock);

This is broken, it will unconditionally create a spidev for any chip
select regardless of if there's any actual hardware there and (even more
importantly) regardless if that hardware is actually a SPI device.  This
is not safe, especially given some of the ideas people seem to have for
userspaces.

I am getting completely fed up of saying this, it's not OK to just
expose pins to userspace when we have no idea what they are connected
to.

--rUGnr7B6Y4qPBmNO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXjV9mAAoJECTWi3JdVIfQ2t8H/i2kXUfb6Gx/DK445oaNOSAk
qpbYGPhZyLmK3phAfLbMlxvFy9m5bOy/HuouuyTkZEGmkZc2KTj0dK8lyQdWAtQk
IvpZu1XmEK2QfhyLhdlCsv6nqmOIqG+NR2sUIsJxS9XRgqs5x7q/R2fifrjBxZqZ
rQpgxBrUFeTr53Dlu7G+AUreQX4gfCB7fQQk01jLetwPLknumidjoSe15Yqidtik
YTeFS/JZDJmohtbe3/VPKFbk6H3mMgI/2VTXFj7FJ0qfpbhX+KAfo5VIUFleJyNj
lAEeY78pa7Oe9rJqtrHYfCtc+CUZx7SasB4wOWni8BicL2HV6PC4ASstjinWdac=
=ARz4
-----END PGP SIGNATURE-----

--rUGnr7B6Y4qPBmNO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
