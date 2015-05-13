From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: Add option to bind spidev to all chipselects
Date: Wed, 13 May 2015 12:16:25 +0200
Message-ID: <20150513101625.GY10961@lukather>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513093441.80359.qmail@dec59.ruk.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4mUolEm2oNas7DxE"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513093441.80359.qmail-ve7rdfgbAvJ3WEpVTuSGmqVXKuFTiq87@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4mUolEm2oNas7DxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 13, 2015 at 09:34:41AM -0000, Michal Suchanek wrote:
> Bypass the check if CS is in use for spidev devices if CONFIG_SPIDEV_SHAD=
OW is
> set.  Rename spidev devices to avoid sysfs conflict.
>=20
> This allows dynamically loading SPI device overlays or communicating
> with SPI devices configured by a kernel driver from userspace.
>=20
> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Output from checkpatch:
total: 2 errors, 4 warnings, 4 checks, 157 lines checked

=2E..

I told you a few times already to run checkpatch before sending your
patches, apparently you make a point at ignoring me. Fine.

That being said, I'm not sure this is the right approach, or at least,
it doesn't solve anything. If SPIDEV_SHADOW is not set, you will still
have the same issue with addition of new devices on previously unused
chip selects, and where we have an spidev device now.

What I think we should do is, when a new device is created, we just
lookup the modalias of the spi_device associated to it.

If that modalias is "spidev", then unregister the spidev device,
register the new device, you're done. If not, return an error.

On the SPIDEV_SHADOW stuff itself, I'm not sure this is such a good
idea. There's a good chance it will break the driver by doing stuff
behind its back, possibly in a way that will harm the whole kernel,
and it's something we usually try to avoid.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--4mUolEm2oNas7DxE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVUyR5AAoJEBx+YmzsjxAghJgP/R8zxa9HAwfJH5QBMelXWP6h
q2d5iNKem+27Yz18jle98yKojw+K59dZ6PSVhjrlJ9W07bZ3zvadBhs3X3//BJVQ
g8wGPekDVgylpuyBpzmoeB/KPW3Bs9HP4f1XQQhGN28mU1iiM5wIYwP0AW7xdEta
J/Z6BM88LWv6oCUSeaTiIwkNcOoM3SOEbXAkck/JY5r/fZ/lKW7i+0y5L3bjO5S7
e7l3lS1N1/Re72NgFyPSnRRqtm5aaptvct6MJsQEfHssP14zbfCLpkKrB+coPOO9
ZW6gCd22Xk8PKOJQhcZA/EvJPgUW9tQZk2GR3B8ps5y/dmmcaLXdHYaG/p8G1c/D
aWIqFJLLjOjh4h04eK62xiZSIioY6WTIjaEiWPhsxQ7nWkiWDONRlDvzr8tqDGpC
Ikpn90vTbepZENQx9c8aCxRNiSwC2bw8VQm54Sg05djLnntBaC45mM4Qdz7NPqBa
1GezWxtPy39nEe7DWOIxf0OH0LrJ5By1a3SSU4x856vJ+g9TxmjtDJg/ek7Y7pfa
lITpr1xSCnlU2Z4g8c9Uvelkcj6bq/QK9i8EWnQVvxAFgMOiuxpZuguRQIk/mb3s
v1pdO45WJRfSzR3nDxrBUDz8howv1Gma+uthMPYoWBq+maX+f5F1iN58sB9ij8Wa
CBj8q654/tZ9s1g1CJir
=csJs
-----END PGP SIGNATURE-----

--4mUolEm2oNas7DxE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
