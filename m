From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] spi: efm32: use $vendor,$device scheme for compatible
 string
Date: Tue, 25 Mar 2014 15:26:17 +0100
Message-ID: <20140325142617.GC2863@katana>
References: <1395756019-23989-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395756019-23989-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2014 at 03:00:19PM +0100, Uwe Kleine-K=F6nig wrote:
> Wolfgang Sang pointed out that "efm32,$device" is non-standard. So use the
> common scheme and prefix device with "efm32-". The old compatible string
> is left in place until arch/arm/boot/dts/efm32* is fixed.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMZIJAAoJEBQN5MwUoCm2KHMQAJJ8z41sgi3DL2A9sO0MZ3G5
KW1wPV8LFQRn+TMCpD0OMgIL6WJf0VogDNkUbHs7k24lpNpVXxb6+P4h2WwM/+Kg
R8krgIIHgbOo4noIdlh8jAXq4iPjnEAITIp0wJAIOlYat4LX+FAIj3K8dqE3OAE3
OnM8vHT89dLl3f+cd1nw52pKHaVX52KHU/ltwq1dZIR4o9okIV8Q3s51vB296XO4
UAETjTatXN/gfA0ptp8xJSe9YCYjVFUe+U/61h+g9D9AgPpy7/OTb/9/wF/Cjoto
tNYleeduuYtn0N72PkoYzvkDTcxx36Q2+9tS2/zBeP/4PApWObM/ETU5SIZNUwUN
c+q2bjVSbbC2pLYwJKI7guMsyGesN6JYWq6jDSidCpdhw+MlmarixAtiQeiorOv6
RBI0lYLe1noKzLvAe9nHOs6WRw0lD8y/lmH3OAKarK2JFrJXI7SquknKelWmUCbJ
xsalPhPd/9TFqihOhdkFtHQbjlSrLwpmFAnMUtaBruJtBf8CraPHlcB2UuN4rNyE
c0YkZ0JniF5lrodQMUeGqGSpW5Fxq6IXOR9WEYm/D5A8MzPM/da9J4rhtWIwBN8m
zrJqDKU48chIVKOHGITomD6wtRUM8aMizyBAnWYl1/pBl7lHeqYeR+1PrEHraPtD
UkSNbFfueTeZssU7rfeu
=Iv5X
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
