From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: add statistics gathering and reporting methods
Date: Mon, 4 May 2015 14:42:26 +0100
Message-ID: <20150504134226.GY15510@sirena.org.uk>
References: <1430741564-2849-1-git-send-email-kernel@martin.sperl.org>
 <1430741564-2849-2-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RLVVO53zhS75EYih"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430741564-2849-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--RLVVO53zhS75EYih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2015 at 12:12:43PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> the statistics are available:
> for each master via:
>   /sys/class/spi_master/spi*/stat
> for each device via:
>   /sys/class/spi_master/spi32766/spi32766.4/stat
>   /sys/bus/spi/devices/spi32766.*/stat

This is unsuitable for sysfs as it is, sysfs is strictly one value per
file.  debugfs would be a more suitable place for a file like this, or
if they are going to go into sysfs they should go in as a directory of
files with one value per file like the network device statistics
directory.  I'm ambivalent about which is the best place, both have
their merits.

> transfer-len-log2-histogram: 0 33 3 9 1 2 0 0 0 0 0 0 0 30 0 0 0
>=20
> Note that log2-histogram is defined for bin n as:
> spi_transfer.len in the range: [ 2^n : 2^(n+1) [
> with n=3D0 for spi_transfer.len =3D 0

It would be more friendly to print this out as an actual histogram with
pretty printing, that's definitely a debugfs thing though.

> +/* helper macros to help updating statistics (locked and unlocked) */
> +#define SPI_STATS_FIELD_ADD_NOLOCK(master, spi, key, value) \
> +	do {						    \
> +		master->stats.key +=3D value;		    \
> +		spi->stats.key +=3D value;		    \
> +	} while (0)

It's a bit unclear to me that we need to collect the stats on both a
per device and a per master basis, if we've got device statistics we can
add up the various devices to get the master values easily enough when
we need them.  It does mean that removing devices would discard some of
the statistics but it's not clear to me that this is actually going to
concern anyone.

It'd be good to have a better name too - _FIELD_ADD makes it sound like
it's adding a new field which is obviously not what we're doing here.
Perhaps just SPI_STATS_ADD?

> +#define SPI_STATS_FIELD_ADD(master, spi, key, value)			\
> +	do {								\
> +		unsigned long flags;					\
> +									\
> +		spin_lock_irqsave(&master->stats_spinlock, flags);	\
> +		SPI_STATS_FIELD_ADD_NOLOCK(master, spi, key, value);	\
> +		spin_unlock_irqrestore(&master->stats_spinlock, flags);	\
> +	} while (0)

Do we really need the locked version with a separate lock?  I know
you're very concerned about performance for some of your applications
and the fact that we're going to be spending a lot of time taking a
separate spinlock (with interrupt disabling... ) seems like it's going
to be adding overhead we could live without.

> +		/* update statistics */
> +		l2size =3D (xfer->len) ? fls(xfer->len - 1) + 1 : 0;
> +		l2size =3D min(l2size, SPI_STATISTICS_L2HISTO_SIZE - 1);
> +
> +		spin_lock_irqsave(&master->stats_spinlock, flags);
> +		SPI_STATS_FIELD_ADD_NOLOCK(master, msg->spi, transfers, 1);
> +		SPI_STATS_FIELD_ADD_NOLOCK(master, msg->spi,
> +					   bytes, xfer->len);
> +		if (xfer->tx_buf)
> +			SPI_STATS_FIELD_ADD_NOLOCK(master, msg->spi,
> +						   bytes_tx, xfer->len);
> +		if (xfer->rx_buf)
> +			SPI_STATS_FIELD_ADD_NOLOCK(master, msg->spi,
> +					           bytes_rx, xfer->len);
> +		SPI_STATS_FIELD_ADD_NOLOCK(master, msg->spi,
> +					   bytes_l2histo[l2size], 1);
> +		spin_unlock_irqrestore(&master->stats_spinlock, flags);

I can't help but feel that this would be a bit more legible without the
macro for adding to a field - just a function that takes the transfer
and a stats buffer to add to.

--RLVVO53zhS75EYih
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR3dBAAoJECTWi3JdVIfQ6F0H/jdjcAXHFWywu4DiPw/dTyDi
DS/YccwJvr/JwIW0ziw/+uHKkgDeZGIOkVLGWa6yXsM4xzQHyAsiFScXwL2VBndZ
tvg+i+uTAHa+4M6W4SAfKdjBF7vgO8OPMK5/zfigZ2vD3yez6SpMBE5q/dx96auO
QMEuFhd0h/xzse6Glw/HkhdI+ED1aNvo/+UNLSVHooP4J8+pmFhaoIDZJiZENXcC
Eanrs9qYlcOzsc0Aoei1g3DaqhLEWU1dEY31BUnkD+J3wUV1XGyP5NGbIn932g1y
/m8LZv/+Wu9CmpjqeEGkZ1onJCFdAqLAlNMCFRdzRiCLuoyqJhUwY/LMjRUMcrk=
=rIFy
-----END PGP SIGNATURE-----

--RLVVO53zhS75EYih--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
