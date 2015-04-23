From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: use spi_sync instead of spi_async
Date: Thu, 23 Apr 2015 10:34:31 +0100
Message-ID: <20150423093431.GR22845@sirena.org.uk>
References: <20150422194133.GI22845@sirena.org.uk>
 <1429775761-3149-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LZ92CUgs0ha736zO"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429775761-3149-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LZ92CUgs0ha736zO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2015 at 07:56:01AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> This has the benefit that the "optimization" of the framework in regards
> to spi_sync will also benefit spidev users directly and allow running
> spi transfers without a necessary context-switch to message-pump.

Applied, thanks.

--LZ92CUgs0ha736zO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOLynAAoJECTWi3JdVIfQzfAH/0HjX64xsB7PisffNXSxo9UQ
MRYVRxgKr0+DkXzWuMoW1pwAARki264Ome2sDxIid6rrLtJbuIFJQxKBaruU/sjx
Z40mcrt0gJjP/pAq/dltpodTz/zg2corK9X59wGr+HawGiz+4PygZk8o+OQHNFUq
diVNKTdnZdQ+y/kW7YnvCTBqLu7rFaYGGC4g9+1t08KedZ1bLFWu2QO22bXfFv4/
+bQ6ziiID1kc+Gatmc8cEUloijqcIcgJ2qNiwB+wTt329RTCueb4zEflNtorVQt8
/Kso2h7URMaI4ig2UuoJwqjRHayI5AHO7TGsgWbJ9YQ1sygFXc4mK9Uau+1n5JY=
=sO/g
-----END PGP SIGNATURE-----

--LZ92CUgs0ha736zO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
