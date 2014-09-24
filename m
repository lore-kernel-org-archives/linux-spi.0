From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 05/10] spi: dw: disable all interrupts first when pump
 message
Date: Wed, 24 Sep 2014 09:47:24 +0100
Message-ID: <20140924084724.GH4015@sirena.org.uk>
References: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1411060140-2801-6-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jch8HTrQBXCJArxs"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411060140-2801-6-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Jch8HTrQBXCJArxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2014 at 08:08:55PM +0300, Andy Shevchenko wrote:

> Always disable all interrupts before pump message. Enable them only for P=
IO
> mode.

Why? =20

It's also not very obvious looking at the diff how this actually works,
the connection between DMA based transfer and interrupt disabling is
not clear.

--Jch8HTrQBXCJArxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIoUcAAoJECTWi3JdVIfQ1hwH/jIsGD1LCPkX+aKHwM6s+v4U
859ejpzaWQZWl53HeiXMp7o6WEElo7c6V6661lZIaKg9ahafI+e3Bikbc5O6DWY1
L24whZ7LDZ9ekT1cJ3WeSUZ8Gg7K53/IjRWaB5QUUj11YH1UL4ang5xqhGrC3eJ3
mqMXD9/+646eIxYPNR+Qm0ppv0GbI8ipWdLAoZHlkyOoNDi4g+OqjonY8TrRj8fB
b82A/Zn5flgrEfRA6ETGStB6SBfh0wE8Nf4sTQQHTkZ6yyIlxDWsCvqAOUlKwu29
pLFsQTX0Goyi8vFt2bDg32Ziww8KtsVy0sFMhnJzCpHw0crqg10R9cONxcTeaiY=
=bqVv
-----END PGP SIGNATURE-----

--Jch8HTrQBXCJArxs--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
