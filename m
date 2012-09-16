From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V4] MXS: Implement DMA support into mxs-i2c
Date: Sun, 16 Sep 2012 13:12:23 +0200
Message-ID: <20120916111223.GD933@pengutronix.de>
References: <1345779871-7677-1-git-send-email-marex@denx.de>
 <20120916102342.GA933@pengutronix.de>
 <201209161251.41895.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201209161251.41895.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Unsurprisingly, I also couldn't get the mode switching between DMA and
> > PIOQUEUE to work :(
>=20
> I'd say more work should be invested into this.

I ran out of ideas. Next thing I'd do is to ask FSL if this is possible
at all. Yet, I'd like to have some solution for 3.7.

> Besides, what about rather > trying PIO + DMA instead of PIOQ + DMA?

That could also be a solution.

> > However, I did come up with an idea how to select DMA or PIOQUEUE per
> > bus via devicetree. If we change the view from "I want PIOQUEUE" to "I
> > don't want DMA", we could simply override the default DMA configuration
> > in the devicetree with, e.g.:
> >=20
> > 			i2c0: i2c@80058000 {
> > 				...
> > 				fsl,i2c-dma-channel =3D <>;
> > 			};
> >=20
> > So, no DMA channel set up will fall back to PIOQUEUE. This is more
> > generic than a custom binding, because if one doesn't want DMA, don't
> > configure it. That should also work with other devices which can fall
> > back to something. I think this is worth trying, another advantage is
> > that it doesn't expose something new to the user. So, there is no legacy
> > support needed in case there will be a better way of configuration.
>=20
> Ewww ... that's such an ad-hoc hack.

Please give reasons.

> Besides, someone might simply forget to add the binding, you'd need to
> print a warning.

? It is "on" by default because of the entry in the dtsi. And the status
of DMA will be printed.

> > +	dev_info(dev, "registered. DMA: %s\n", i2c->dma_mode ? "on" : "off");
>=20
> dev_debug() ?

Yup.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBVtBcACgkQD27XaX1/VRsQVQCgqaxxZ5HzQbz2dVfO4tKfv5e/
UEcAnicuycJJuPmMJDcZmcDc0FXS2PXV
=PpbR
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
