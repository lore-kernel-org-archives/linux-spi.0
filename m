From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: efm32: properly namespace location property
Date: Fri, 14 Mar 2014 20:37:03 +0000
Message-ID: <20140314203703.GK366@sirena.org.uk>
References: <1394829262-28022-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1a+uSzIUoaGmLeog"
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394829262-28022-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1a+uSzIUoaGmLeog
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2014 at 09:34:22PM +0100, Uwe Kleine-K=F6nig wrote:
> While reviewing an i2c driver for efm32 that needs a similar property
> Wolfram Sang pointed out that "location" is a too generic name for
> something that is efm32 specific. So add an appropriate namespace and
> fall back to the generic name in case of failure.

Applied, thanks.

--1a+uSzIUoaGmLeog
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTI2hrAAoJELSic+t+oim93n4P/Ru8eeAOh7aYMjkVSu3ASNfR
jTU8/mY+SIVgTgc//kz+BsjOeiGmsS1ynS05qT4N7EC0SsyDkS0aM2Yyv+4XPNA8
tJpNnDBRKPSIEP5Afe7qO509PnqIRIApJ5VN5aTr7xKBV1lJr+JtqWm54o1CeDtf
/8blMlbJ1c2XRT1QWzp17POQzdgdluCIaHvgjANo/K3/FJmZyWLYFFxDiTRHoNZi
ONfns7sTFaHY/kDEYPMm4qrtNMjQlPxiq/3MeSkw/xFidTGDHtU5EVDNI2VEUVO8
yezG34M/VOKZvUrnH04hVPAEI20HfnI3DkU1CLafHUZd7jrfxAsK+AYr/3GVKMvy
6Q+/9VN6RCr4QtielXBy6CiXZ+5ZF42hxOF+M4bEm0mt6PZyWJz0DoBLG4JiacSK
dFnNV1uIU3BMbVLlb9rc+obdnE87sg/ybxe+XyCCA4hqZqBC2lmxTuBDOVm6VsxO
pi5RVSIxPV7GYDr8IyXAPol0d9dThMkMiiqZG3ErIrgD0U/3Y07+wNy5ENK+/dkp
qm06h2iA9I/r0pitVFtBdaOcLBaqpO9SKAZGUwJ5nM+qxn00VmFTJe1IN6w7QVb8
7sulq6lpzzILLMQkqc9pfeg0g9x8s3lIehkZOHDUYwQzYxKQu1A5mDdN6qOQPeSf
HTE4F8VOg66ZAkVRJr5x
=iw20
-----END PGP SIGNATURE-----

--1a+uSzIUoaGmLeog--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
