From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 3/3] spi: HiSilicon v3xx: Use DMI quirk to set
 controller buswidth override bits
Date: Fri, 28 Feb 2020 16:20:57 +0000
Message-ID: <20200228162057.GC4956@sirena.org.uk>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-4-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
        linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
To: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1582903131-160033-4-git-send-email-john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2020 at 11:18:51PM +0800, John Garry wrote:
> The Huawei D06 board (and variants) can support Quad mode of operation.
>=20
> Since we have no current method in ACPI SPI bus device resource descripti=
on
> to describe this information, use DMI to detect the board, and set the
> controller buswidth override bits.

Hopefully this is something that the ACPI people will be looking to
address going forwards :/

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5ZPekACgkQJNaLcl1U
h9BxUwf/TDuNgCXr7WDgjO72Sd8M518jpCW63B2SJ/nhlOul+uSQtPp38AvFbOKG
xdPHKVoh82UV1cn6w79H71fMVmDy3y9uPlIB+GTxvnGze9F03HHo0ybJuAD6pvmb
gW4TsG3xZ9TatTMfM5n3sc0APvcfxXe3DjqWOhsdw9zlGddgfpObtyTApRiScQWK
UBZQnih2B8Fkgfbb5QSCjMEuxd4Hwp6lz/EkxKbBvgG3m8H41ONev6XKRkPCNagd
8tS65tJb0nhEuP6X8F0NpkkyQaDwsWSybWp06Zo8X1f5E2yxdhgc0qCbPThGFnil
f30KtWcvkDjZRu0eymnJ+Zab1jvEHQ==
=T+F5
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
