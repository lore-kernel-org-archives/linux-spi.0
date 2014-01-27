From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: nuc900: Set SPI_LSB_FIRST for master->mode_bits if
 hw->pdata->lsb is true
Date: Mon, 27 Jan 2014 20:31:34 +0000
Message-ID: <20140127203134.GW11841@sirena.org.uk>
References: <1390231327.11756.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PnL8HyO6hCYZ2Glf"
Cc: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390231327.11756.3.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PnL8HyO6hCYZ2Glf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2014 at 11:22:07PM +0800, Axel Lin wrote:
> Otherwise, spi_setup() fails with unsupported mode bits message.

Applied, thanks.

--PnL8HyO6hCYZ2Glf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5sIjAAoJELSic+t+oim9rwIP/1RS2sfjTW2IMjBT3X+csRID
j8d1NfvtovwoqhGnFde0w01TbV4caw99aLh5BWQvcjRivWJoM7jsOeZ0vu/bqFCn
CpiCcQBUn1Cmf1XMyNxNMxkMccplIRNuGA0arWvarlTXuEfGLUrWHOCuoWEg68AY
Ma+BvUHVF6n4x9FFV/haTe9YD1OOq432bBdaxDHrA5FpE1PHVU6V0cun/2a/5C1+
seNrXfAFiCb1aHvlVzac7v/Z/+O9PcL8aowmWy/BZbPvyFZ2wmIZurcR5RA/c/jf
eLHe9DOszYcN0cNnARJXVv4YzUd9ZUaA0qjZq4oKhTt3SILkCjwVg3ue/AKaGPYH
AP3Axh4KBzoIQlGQVAixmSNhBcfRJrHtStSj7Kzr8HcLkQpft+xqP6zD95//LISp
Bv/TxNyoeyq3bQo6BZ3S9CqwTxmQWOjr0RGaYdSFpMnCSxOCXu4ioK9iVIdMkZlR
9bAkghX1fwgsySF+/7aHmJLSOxIYa0NA/PSJmu5Z0F/tStSDeAXnazeL5k/ZdxxU
cPb6KAks7De2+61r+Yh7+Uf0vyK4yO3dIxYCmjLdEaZuK6C112JcHweIrl67Fn3E
OocKsugHPVXW6fEPqY+omlLjhOPbtkP6VCApLCyN+Ni4xCLgirsz0zuDgnkuu+1M
124a2PZK0gmgSK4zZsWT
=4S7i
-----END PGP SIGNATURE-----

--PnL8HyO6hCYZ2Glf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
