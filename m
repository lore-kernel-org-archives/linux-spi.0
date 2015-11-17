From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/8] Documentation/spi/spidev_test.c: clean up input_tx
Date: Tue, 17 Nov 2015 22:52:00 +0000
Message-ID: <20151117225200.GG31303@sirena.org.uk>
References: <cover.1447773299.git.stillcompiling@gmail.com>
 <7f2139b27013d77993c6bc2b0a6c94fab01add98.1447773299.git.stillcompiling@gmail.com>
 <20151117174333.GY31303@sirena.org.uk>
 <5345436.HCqatbevmx@jclayton-pc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="evOcBaiMpN7OEvsd"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5345436.HCqatbevmx@jclayton-pc>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--evOcBaiMpN7OEvsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2015 at 11:21:12AM -0800, Joshua Clayton wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> It takes some clutter out of main() whose scope is limited to that little=
 block of code,=20
> and because in the next patch we add another (larger)function to the if/e=
lse block.

> I don't know if it is valid to say "look at the next commit" for justific=
ation, but
> That is the reason.

That's totally fine - just say that it's to support future changes in
this area.  It's good to split out mechanical changes like this from the
more complex changes, you just need to say why they're happening.

--evOcBaiMpN7OEvsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWS6+QAAoJECTWi3JdVIfQK3gH/j4r+L97rMWJifWz880RJpGL
5WAfFpq4A2Exo1pc6BwOwaO6TJ/JvVtv7LCX1cv0hXxDlPBaLdYADNxpwVpPknrL
JcXm8R5SqRwN//SYt4x9xIKjL6ePdsNdTV9OucDqH+efClObPbEbSPBaQp3Xu/G9
0LCdOEKEpXWtYnBCJ/+dmPdmBLuYRc6GYgfb0xb0iOS+tQDl+gK/JTaHwsU0HZ2I
yilmDZG4e8KtnAfnbTpTga7yRfg1rxHVwz6TQ+flkBy0GJhGUIrYZJ3wKAfUqcgB
i/YrStNSkkXRBYeeUA0RKoYl3coCvVn5UfJSZX5C9bKykOc88wkWibNxEGrjaw8=
=70UV
-----END PGP SIGNATURE-----

--evOcBaiMpN7OEvsd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
