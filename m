From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/pxa2xx: change default supported DMA burst size to 1
Date: Fri, 6 Jun 2014 10:52:56 +0100
Message-ID: <20140606095256.GA2520@sirena.org.uk>
References: <1401990309-12492-1-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F4Dl6XKrV7PH8SJF"
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	LKML-GFdadSzt00ze9xe1eoZjHA@public.gmane.org
To: Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401990309-12492-1-git-send-email-chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--F4Dl6XKrV7PH8SJF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2014 at 01:45:09AM +0800, Chew Chiau Ee wrote:
> From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>=20
> This is to fix the SPI DMA transfer failure for speed less than 1M.
> If using current DMA burst size setting (16), the Rx data bytes are
> invalid due to each data byte is multiplied according to the burst
> size setting.

Applied, thanks.

--F4Dl6XKrV7PH8SJF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkY91AAoJELSic+t+oim9pEwP/j/jsE02FPPEzbmJNk44Qvzk
asnjs6ergTGMvyseIjfDzMYTcPlQQyFheORoYPh+N59JltV8CGa6YWiFVwg+8QlS
Qp/BLsKNX5NAU+BtL2NdQ/PJCAD9QPj4A9iImmWI3hdfFVWfJBTniQaVPIICbCkX
JrvU6S12cDQ5aDdKxReArHUN4VIX1K+Zt/4+dWWiRnR9LRuf13GxTImMUyGpwgxF
XVdxj6w+uk4/kVjQ/aBVdrAp0ftF3du+UmQAkbHgSXKFq/PAS008F9VKNP454W5p
14Qljlc7lGVUsMblBPdvagC8KKjvvgdUZTD4mube2slMUSUxK5upF4AcX1pVutlu
A7r6fP17v69Gq+c6Bv1d5x/z4vi+oxDQq/9OuFLdLQBDxyozTuoe4KbB+QcWeCqz
/fZ0bXjdcteIChPC41WBmFAoAxBdvyf1nIpNHyidTyJU/EZUpeXN7MYsYx4bGwNS
KmYBzLXEJiyAIfAqheqebsgTFdpqfk+sz9ROFbBP7HblwowS1bSMChbomk71ENa7
h7yfws22BatVT0UiOT+1WS27401Kvz4WPXkdHmTB5bVXma0XSwRl6GXqsM4Exlp2
v/pcOLQZy2rev7U6JG0edmkVmJyGzEZhrhgSeMlGhS2YGmbtwPWGdp8u3Rvqyv8o
+fMWaJkkxWGIYkufS67q
=GbJC
-----END PGP SIGNATURE-----

--F4Dl6XKrV7PH8SJF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
