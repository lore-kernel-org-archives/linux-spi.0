From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: jcore: disable clock when registering spi conroller
 failed
Date: Thu, 7 Dec 2017 11:55:09 +0000
Message-ID: <20171207115509.xm7vjrwd5qningcf@sirena.org.uk>
References: <1512641503-6098-1-git-send-email-takuo.koguchi.sw@hitachi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lz6n2vpbve3uyjwh"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khoroshilov-ufN2psIa012HXe+LvDLADg@public.gmane.org,
        takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takuo Koguchi <takuo.koguchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1512641503-6098-1-git-send-email-takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lz6n2vpbve3uyjwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 07:11:41PM +0900, Takuo Koguchi wrote:
>  When probe function fails in registering the spi controller, the clock
>  should remain disabled.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).

I seem to have got three copies of this from you in a very short time?

--lz6n2vpbve3uyjwh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlopLBwACgkQJNaLcl1U
h9DeGAf9Hjq16BG0Nxi+5uNSMvvqdJ/KlPzizg9KrsNi3REqjLOWcYtaOVOXYR6q
KVYHpkuqLU4odKK68OCCRri+OmqB2TciEbfcA7MZHe6MhczJinega3rs5JB2DOXx
PcfOIPjy4yeNqxOYKR1FNFYJXSSAIXlRooefJM+3HU0m5AkIv38y2LKlJ1T3iL8I
MSsW3fRlpYGSmHu38UzulXa/eP4jxL3m+DAxVrr67986N2REHg4dYmsvck/Ys5UY
+xkhEazubdwJ1EhtC33meA7+M/JUkiEGd4PsYO5UEIWmlqMvV3x+ZEf3Gk7Tkz3u
mUW/JKmriNUYdHWnXdWzaQYcjKlBuw==
=i2O6
-----END PGP SIGNATURE-----

--lz6n2vpbve3uyjwh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
