From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [spi-devel-general] [PATCH] trivial: some fixes in spi
	documentation
Date: Mon, 2 Nov 2009 13:13:34 +0100
Message-ID: <20091102121334.GA4696@pengutronix.de>
References: <1256938094-8137-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Cc: trivial@kernel.org,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@xenotime.net>,
	spi-devel-general@lists.sourceforge.net
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1256938094-8137-1-git-send-email-cascardo@holoscopio.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the typo fixes look good, still...

On Fri, Oct 30, 2009 at 07:28:14PM -0200, Thadeu Lima de Souza Cascardo wro=
te:
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> ---
>  Documentation/spi/spi-summary |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
> index deab51d..607aa97 100644
> --- a/Documentation/spi/spi-summary
> +++ b/Documentation/spi/spi-summary
> @@ -121,7 +121,7 @@ active.  So the master must set the clock to inactive=
 before selecting
>  a slave, and the slave can tell the chosen polarity by sampling the
>  clock level when its select line goes active.  That's why many devices
>  support for example both modes 0 and 3:  they don't care about polarity,
> -and alway clock data in/out on rising clock edges.
> +and always clock data in/out on rising clock edges.
> =20
> =20
>  How do these driver programming interfaces work?
> @@ -236,7 +236,7 @@ And SOC-specific utility code might look something li=
ke:
>  		struct mysoc_spi_data *pdata2;
> =20
>  		pdata2 =3D kmalloc(sizeof *pdata2, GFP_KERNEL);
> -		*pdata2 =3D pdata;
> +		*pdata2 =3D *pdata;

=2E.. this looks correct, because a few lines above it is stated:

        static struct mysoc_spi_data __initdata pdata =3D { ... };

No pointer here. But yeah, pretty confusing for an example.

>  		...
>  		if (n =3D=3D 2) {
>  			spi2->dev.platform_data =3D pdata2;
> @@ -427,8 +427,8 @@ any more such messages.
>      it, should only be used with small amounts of data where the
>      cost of an extra copy may be ignored.  It's designed to support
>      common RPC-style requests, such as writing an eight bit command
> -    and reading a sixteen bit response -- spi_w8r16() being one its
> -    wrappers, doing exactly that.
> +    and reading a sixteen bit response -- spi_w8r16() being one of
> +    its wrappers, doing exactly that.
> =20
>  Some drivers may need to modify spi_device characteristics like the
>  transfer mode, wordsize, or clock rate.  This is done with spi_setup(),
> --=20
> 1.6.3.3
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay=
=20
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkruzO4ACgkQD27XaX1/VRttcACgq+6NGGvxtwflQt3uVs5LbyDx
2FMAn3JhWqcmdr8hDzA+AJctZ07HxPVW
=BOYp
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
