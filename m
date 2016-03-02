From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/6] spi: add flow controll support
Date: Wed, 2 Mar 2016 11:46:56 +0900
Message-ID: <20160302024656.GR18327@sirena.org.uk>
References: <56D448E1.6090006@de.bosch.com>
 <1456843400-20696-1-git-send-email-linux@rempel-privat.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wx8toi1bsngWn0tF"
Cc: fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org,
	dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456843400-20696-1-git-send-email-linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wx8toi1bsngWn0tF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 01, 2016 at 03:43:15PM +0100, Oleksij Rempel wrote:

At a high level I think this needs splitting up quite a bit - this is
defining a new DT binding, a new core interface for controlling flow
control and a bitbanging flow control implementation.  At least those
three bits should probably be separate patches, it may make sense to
split up the bitbanging implementation some more too.

> Different HW implement different variants of SPI based flow control (FC).
> To flexible FC implementation a spited it to fallowing common parts:
> Flow control: Request Sequence
> Master CS   |-------2\_____________________|
> Slave  FC   |-----1\_______________________|
> DATA        |-----------3\_________________|

I don't know what these pictures mean since you don't say what "slave
FC" is - I'm assuming you mean a separate pin but you need to specify
that.  It really looks like this would be clearer with words rather than
ASCII art.

In the case above this looks like a normal interrupt from a device, I'm
not clear what is different here or why this is in the core?

> Flow control: ACK End of Data
> Master CS   |______________________/2------|
> Slave  FC   |________________________/3----|
> DATA        |__________________/1----------|

Why would anything care about this case and why is it part of the SPI
protocol rather than something that the device driver would do?

> +	if (atomic_read(&spi->active_rq)) {
> +		if (!spi_fc_equal_cs(spi))
> +			dev_warn(&spi->dev, "Got request, but device is not ready\n");
> +		atomic_set(&spi->active_rq, 0);
> +		return ret;
> +	}

Atomic operations are very hard to use safely, you need to really spell
out what you think this is doing from a synchronization point of view
and why it's safe.

> +	if (spi->mode | SPI_FC_REQUEST &&
> +			!spi->cs_enabled && fc_enabled) {
> +		atomic_set(&spi->active_rq, 1);
> +		if (spi->request_cb)
> +			spi->request_cb(spi);

This logic is all too complicated for me to follow.  Why are we oring
things with spi->mode?

> +	struct device_node *np = spi->dev.of_node;
> +	int ret;
> +
> +	if (!np)
> +		return 0;

We can't support things only for DT, we need a way for things to be used
on other systemms.

--wx8toi1bsngWn0tF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1lQfAAoJECTWi3JdVIfQ5+cH/0rk7/tIlV7KuF54gaAtY4Vi
sjiQPdMyKGfVQdUcAHHPQhs57NDrzUsvcJ+6Wb5eQY0Sh8OtLz/JXNvoUiDyVR76
SnGqqeK4vcsC24UEa88ZWEYrFM2Uzs2+A6P9/DB+a1LEj1qrJeuiuV/0p6GoDbvh
d6hQMA8/Vpul+IA7cih4McLM7AWcltSwA8VhXnMkaayKtn3+vmysUkvmcASwechH
DFucrW+JHl3N/+8+QmjxrBv40BttjyeDt7HhMtiimVmQDsQSlR78SOu2YkZG74AM
FO2UgD7agUZtUcOoCMJnf8JaDK+9PMWW47xXtkTNhtFDdv/vdyAuOEHcKZUShrc=
=J5Tm
-----END PGP SIGNATURE-----

--wx8toi1bsngWn0tF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
