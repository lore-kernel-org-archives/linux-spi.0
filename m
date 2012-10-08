From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V4] MXS: Implement DMA support into mxs-i2c
Date: Mon, 8 Oct 2012 11:25:30 +0200
Message-ID: <20121008092530.GA22051@pengutronix.de>
References: <1345779871-7677-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1345779871-7677-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 24, 2012 at 05:44:31AM +0200, Marek Vasut wrote:
> This patch implements DMA support into mxs-i2c. DMA transfers are now ena=
bled
> via DT. The DMA operation is enabled by default.
>=20
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Thanks, applied to -next.

I am meanwhile thinking the driver needs massive changes, probably
dropping PIOQUEUE entirely. This is probably best done via incremental
patches to this one. I have sketches which were sadly not ready for this
merge-window :(

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBynAoACgkQD27XaX1/VRtW6ACfR22kz24hN6WbJrGR+Xvkh2K1
cO0AoJIf+FP5M0g/ffsrhDLzd6sVpyyZ
=Ah5l
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
