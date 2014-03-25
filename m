From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] spi: efm32: use $vendor,$device scheme for compatible
 string
Date: Tue, 25 Mar 2014 15:27:30 +0100
Message-ID: <20140325142729.GD2863@katana>
References: <1395756019-23989-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395756019-23989-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2014 at 03:00:19PM +0100, Uwe Kleine-K=F6nig wrote:
> Wolfgang Sang pointed out that "efm32,$device" is non-standard. So use the
> common scheme and prefix device with "efm32-". The old compatible string
> is left in place until arch/arm/boot/dts/efm32* is fixed.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Acked too fast. Documentation update is missing.


--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMZJRAAoJEBQN5MwUoCm2zIEP/ijHUBHPhl87FSzZKPDY5h6B
86/M4YfumSCsHH6d0ff3/DemKeybqQlghLR5rqdwRmDzCK4ltScrz6UTUC/4Ki1x
NeDL1fW6B0KlGWBHcCPJTdp5fbrNl39X8PUnKXictdwrdX2vzp4UCLK1GsNo4tH+
850z562zZyfwrQnwJzQ9zAI8EW4SsuDblMFdgV69b2mClZbvHkhX0O5eIJ6ZsG++
LrauHounq2Vp+gMwkltXqavAsFgVWB+qAfHaXiAh/cPIOPmuY6vTCzKucFj8KzEv
zbSVIcZWr91GW54QXTTmY52kgaZHzCKjiYwIhPzPryvF/DtNL/B9T8YJEIGCsJab
0HGzN5lFp/HTiFbmAkZadJix9HaaJw2u5d2I1o7xEPSNGqeZpXwVunNU+nXirHg8
vpk2dCAsvB2oxVkyirvG50yyFPpEFkWTP2xaKcAo09m5pNOrdRDTaF1VZDV7Lpey
iL37R4xCawu7xSrH5gxnN/+GTNAijXJqvjxeN1Ml2uJwz+BX6XYKo/0RLTe/wo+Q
PQBMIffCZHsVWlkRCm9w0wH3S8Cw6T1mapjv9//Ge0eKN2PIQFD8jb7oeYipOOZ0
UjujL3iJMRcQqkhImtN2Sw33o5uhuZxcZcByulpq3FnzmeIUuyGp7FxioM3w3mfM
hzQl6e/usEnfs6kwaKJN
=G7Lf
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
