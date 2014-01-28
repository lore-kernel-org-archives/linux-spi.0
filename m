From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/5] spi: dw: add support for gpio controlled chip
 select
Date: Tue, 28 Jan 2014 15:42:12 +0000
Message-ID: <20140128154212.GN11841@sirena.org.uk>
References: <cover.1390723880.git.baruch@tkos.co.il>
 <b9ce1224f836ec84d5c75636b6838039a7664c89.1390723880.git.baruch@tkos.co.il>
 <20140127185754.GK11841@sirena.org.uk>
 <20140128123506.GY5596@tarshish>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wokcQhA7EZ2KSKVu"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140128123506.GY5596@tarshish>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wokcQhA7EZ2KSKVu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2014 at 02:35:06PM +0200, Baruch Siach wrote:

> So how about doing devm_gpio_request_one() in probe() right after=20
> devm_spi_register_master()? This should be compatible with deferral, and =
yet=20
> avoid open coding the "cs-gpios" property parsing as the pl022 driver doe=
s.

It needs to before otherwise we'll try to instantiate the slaves without
their chip select which isn't going to be a great idea.  The ideal thing
would be for this to be handled in the core rather than in the
individual drivers, the property is standard.

--wokcQhA7EZ2KSKVu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS58/QAAoJELSic+t+oim9TQoP/i8R0AQQ6NNvjf3EnB+12pci
ghHUstUhyJzUj0+V/aHOm1IdWHfdCS4+/2NkkUiVBRbwrwnALssWi4xlxYweSbHM
tGNp0i0Owjs1p5wC+eaooE23a6IN6ojKf+KY+kl7AG7bMkOJ4VZnDj/dy4awkVds
LbvmkIkM2/5PNZwpmmQ0wRke77GIEOArPkP4Wy2LCdvlg9EA9GCg3VGlPnnGoMmL
ijNxK65OjBkihOFWz5MMLdHz9CPY96+dz74jXFVEYeSqWNmCO02WCK2FVqv7qJBf
pTp6oMwHN0ECc+JU9EH1nk8bmbLzQscojaKqh9pMxOI2H8br4KFqOVmiptJIW6n6
Wvq5PODd9HcanLuVSbxlEUiNToLE9on/S+Ou9Za0q31B4v0flWZBCi//iw4zveje
Kxw4KvJbd2nNpQpkDUaqaHWZz+eYMK/EYxuXD6XkqDXqjmYzRkvB7KLIu/63xecT
Ppn80hVe3SHbsxc06psDRAWR1aGFb5VSl03k68e92aLAG3LbW2So2GtdJ/P9n37r
Y54rDsx9Gdo+1IhXsiO4qujIf5yW+pD79PCPpD51lomH5P4z2tPAoe/HtvkEyJPR
oH7TaaR3F6UrqDo/5mMeqLmULGarwC2cDAYDE0kRopV31ixqp5fawgqkB2U4xsT5
ZX/kr5fkfCtON2/6kW+I
=pVSl
-----END PGP SIGNATURE-----

--wokcQhA7EZ2KSKVu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
