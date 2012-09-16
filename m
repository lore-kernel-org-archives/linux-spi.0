From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V4] MXS: Implement DMA support into mxs-i2c
Date: Sun, 16 Sep 2012 12:44:36 +0200
Message-ID: <20120916104436.GC933@pengutronix.de>
References: <1345779871-7677-1-git-send-email-marex@denx.de>
 <CAOMZO5CSvP3nXNq4VLYALh+U9OZRnjtgXqTr7zsKdeHpUdJ4cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5CSvP3nXNq4VLYALh+U9OZRnjtgXqTr7zsKdeHpUdJ4cQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2012 at 03:54:30PM -0300, Fabio Estevam wrote:
> On Fri, Aug 24, 2012 at 12:44 AM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> > This patch implements DMA support into mxs-i2c. DMA transfers are now e=
nabled
> > via DT. The DMA operation is enabled by default.
> >
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>=20
> On a mx28evk:
>=20
> Tested-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Thanks, may I ask what your tests were?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBVrZQACgkQD27XaX1/VRvNeQCgtQYwOMMJt10L9ZYsHswJgCVR
aqAAni99bZ4y55Jwh5LUISnSXaZkkdpu
=efSp
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
