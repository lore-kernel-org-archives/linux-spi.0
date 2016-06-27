From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/3] spi: of: allow instantiating slaves without a
 driver
Date: Mon, 27 Jun 2016 22:14:59 +0100
Message-ID: <20160627211459.GJ17217@sirena.org.uk>
References: <cover.1467053363.git.hramrach@gmail.com>
 <a85f91bf364bd6e1681f5973ac92c2bb7f9a8999.1467053363.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iRjOs3ViPWHdlw/I"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a85f91bf364bd6e1681f5973ac92c2bb7f9a8999.1467053363.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--iRjOs3ViPWHdlw/I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 27, 2016 at 09:02:31PM +0200, Michal Suchanek wrote:

> SPI slave devices are not created when looking up driver for the slave
> fails. Create a device anyway so it can be manually bound to a driver.

That's not what of_modalias_node() does, of_modalias_node() just mangles
a compatible string into a format for consumption by modutils.  It makes
no effort to find a driver in doing this, it just does a simple string
transformation on the compatible.

> This allows manually binding a driver to slave devices for which the
> driver specified by compatible is not available of for which no driver
> is specified at all. Drivers like spidev or m25p80 that require no
> configuratiom can be bound to such node.

As ever spidev should never appear directly in a DT because it is not a
description of hardware, the DT should describe whatever device is there
and then we need to work out in Linux how to bind spidev to it if that's
what we want to do.  m25p80 does represent real hardware and that
hardware should be described, for example by using the jedec,spi-nor
compatible which says that a non-specific JEDEC enumerable flash is
present.

> Since this allows slave DT nodes without specifying a slave driver make
> speed also optional. It makes no sense to specify speed when the device
> is not specified. The value is only advisory anyway and the slave
> driver can try to set arbitrary transfer speed.

This appears to be at best marginally related to the rest of the patch.
That means that it should be a separate patch.

--iRjOs3ViPWHdlw/I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcZdSAAoJECTWi3JdVIfQBYMH/RO3cfj4JDSI/pDHq3LSqNHQ
hFyqAKPizJG0GFyDDVPZs82Dc7w4UqF9leBCXnkSccSFtfU4dgUy4ML1B6Q//RQO
rz0nvVNnXcW44Y1WlqN1Xv3jfGEODkXtg4e6/BqFhxR+lkFEVpLW/lBGDwDUJSbV
dJAhHCWZgpxCg8X1NhsVQQff73KyYD2wMHTl4HMIDHzxLiKG/DgO8JkXT9PoAp7A
gEqDRfL9OUGpKPiU02TsGqX6MXCoa6rj0Oga+gP4FYFjXPZdrAdCMeLsvoSqPMvM
cDXcbOlRxCWae6/3vi1bmaJ9F3NAGCZkwM2DNKhH5fkKEqqpQwCSUkEPdYfzQCk=
=n2ur
-----END PGP SIGNATURE-----

--iRjOs3ViPWHdlw/I--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
