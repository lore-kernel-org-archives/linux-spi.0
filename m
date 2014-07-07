From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: add driver for Rockchip RK3xxx SoCs
 integrated SPI
Date: Mon, 7 Jul 2014 08:21:40 +0100
Message-ID: <20140707072140.GB30458@sirena.org.uk>
References: <1403582852-9751-1-git-send-email-addy.ke@rock-chips.com>
 <20140704183249.GC14896@sirena.org.uk>
 <53B9FB1C.7080008@rock-chips.com>
 <5578791.jcBVzrGadW@diego>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Cc: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5578791.jcBVzrGadW@diego>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2014 at 09:08:41AM +0200, Heiko St=FCbner wrote:
> Am Montag, 7. Juli 2014, 09:42:52 schrieb addy ke:

> > > Your DT binding defined some additional compatible strings, please add
> > > those to the driver.

> citing Mark Rutland (one of the dt maintainers):

> --
>   That's why I said in addition to the common one. I'd only expect the
>   driver to look for "rockchip,rk3066-spi", but a DTB could have:
>=20
>         compatible =3D "rockchip,rk3188-spi", "rockchip,rk3066-spi";
>=20
>   Seeding the DTBs with the extra strings early makes it more likely that
>   we can rely on them later. If we don't happen to need them they only
>   clutter some DTBs.
> --

> so it looks like the driver is doing the right thing right now

The driver will work but it's better to list the strings that are
supported explicitly if only to document that there's nothing specific
Linux should be doing for them.

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTukqBAAoJELSic+t+oim9y9YP/iBo9058c6SwePOuNDRAUk+N
rXpMex2zepuEd04RRELHgu09VP8haN6A2nnHzP2QLSKgfJLkXfzi1RAIIe+cEMi1
bMacdpvV0fViEEDX6i6RT/ZNCLhVzkLEn/hfyjTOhClEwgUGETDvjr34Sscl/Nzh
6Fli+Iw1Qex3QbtnD4II7QkVpPZcMdZCxRoeERL20I+pQVn9ysMit4hoYXMnp7pi
TIMo6GbtuxT1o1cvBq1fbqgOhgY53UvOmPZ+3RDmmZvrgagE4UMKO7fXRvf9AcjI
qv/C22TjmuvP5OL84f443FGnI+LyEUu6yQFRmjjvsVXNpVJ88oxv1vGnR8DrOlMy
jYtkazqk9+rowgv7zkqxqHR+5lgPp8tmGyaiAemp+jBJrXBbsg/XumGBV7Z1X8V5
4u8GEKaj48/ZYTB89S0kJOWKUJeB3AusY29bh5ttudvnoRRPjtZYCYWYlJOBQCZu
UjSiZD/QYb3dufqKDoCiynQnuMtxNBvmgxnvG83x5O4/jHZZrPsfJjVH9dYww0x3
x6u4p6IIQmpW2ENzEJm1e7cJ76ae2FmFqlfPjCjM0wJDLk6SEZUVEm8dcZ+yEmk+
I1jm/USNsyNGKgINUvHmqBadVlq+6VQMO59D/9LLbCLW7WC5kAL/cOJc+sfL8eiU
FExHYFzpCXOd0FTvG1/S
=lIvz
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
