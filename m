From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: coldfire-qspi: Prevent NULL pointer dereference
Date: Mon, 10 Mar 2014 16:05:35 +0000
Message-ID: <20140310160535.GL28112@sirena.org.uk>
References: <1394345470.15686.1.camel@phoenix>
 <201403100848.41186.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pD8O0zBcP3Ir3iZ5"
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201403100848.41186.sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--pD8O0zBcP3Ir3iZ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2014 at 08:48:40AM -0700, Steven King wrote:
> On Saturday 08 March 2014 10:11:10 pm Axel Lin wrote:

> > If pdata->cs_control is NULL, we will hit NULL pointer dereference in
> > mcfqspi_cs_select() and mcfqspi_cs_deselect(). Thus add NULL test for
> > pdata->cs_control in probe().

> NAK.

>  I suggest you read the code again.  There is no NULL pointer dereference=
 and=20
> further, by returning an error if cs_control is NULL, you've now broken t=
he=20
> design which was that cs_control is optional.

So, you've sent this after I'd applied the patch (having ignored prior
patches as well, the last activity was in 2012), that's a bit
unfortunate.  I've reverted the patch but please if you're reviewing
changes to the driver can you indicate if things are OK when you do so -
if patches aren't getting any review from people working on the driver
the tendency is to assume that the driver has been abandoned.

--pD8O0zBcP3Ir3iZ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHeLMAAoJELSic+t+oim9rpoP/3oCzzMgqU1yBBaF1C4m307O
hUzBiXbbmzIHjRhDOBSP9l+/NVOBUGV50A0EOM8EsB0+odpF82WKBvkOJ+RNO7Zp
CRzg5kCgMXRYbztxuspJTngsCqA6z+nY9mMrgveQGdEdytB8fVIC9T4O7V4uR5Yj
4QY2B6hiNaG6QROJ8JmjCRFuVPQjVBoKMJtlUkR3Xg/FHKbnVr2fdlvCkitU8cW6
6l7ygpem+atmcTi4cTV07LPk3iGJO+VploEHO9/W1vW8MTYXV41plp7ijd0C65qU
9XqpkPYZbYshtzHLE8LDXEGB0Ajqq4Xz5MXrjBskhueGoXmnruKpsZ+hc38CBiOS
x9hF+4oeZTCOpbz9cSYlB2+h3UjxrWBQhn8SNs6yjhSEm2CqiyYZ992YYUHSbAP2
tv8qc+7jH+13FkZy/7gDjNcSJRXuNuAd4ZR/h0AC7Av/auSpwux+mdLe+qhMkm/E
Faw7YE27woZIje2rIZgeCRN3fQIcuj+cx78QFrUtnnwXd40S4lPK3ZyxaxcD/aZ3
YlPdRtlStoOJUlqFx2XAJmZ/osyEH+V1YSXKH4+L9i4ice/IyJxQeGxZ8r6qu4pK
A0BKQuCdiCtTNYqVGF6JAoX+Hx60y4sYLGsnCoMGu9IX+bbKwuYuqKiFV2LAGzOu
tuWf0ZPViZeD0LAl098e
=HAw0
-----END PGP SIGNATURE-----

--pD8O0zBcP3Ir3iZ5--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
