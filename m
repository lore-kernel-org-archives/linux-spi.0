From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-pxa2xx: remove legacy PXA DMA bits
Date: Tue, 9 Jun 2015 12:11:22 +0100
Message-ID: <20150609111122.GB14071@sirena.org.uk>
References: <1433795557-18036-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rIkTV52V9g01js4a"
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433795557-18036-1-git-send-email-robert.jarzmik-GANU6spQydw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rIkTV52V9g01js4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2015 at 10:32:37PM +0200, Robert Jarzmik wrote:
> From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> Generic DMA support was already implemented by commit cd7bed003404
> ("spi/pxa2xx: break out the private DMA API usage into a separate file")
> which moved all the legacy PXA DMA implementation code into its own
> file.

Applied, thanks.

--rIkTV52V9g01js4a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdsnaAAoJECTWi3JdVIfQwn0H+gOYUCrckmV3MHZ1X0H960yZ
E7e9PrCgY7B2f/cysoatoTKi9l173bcsaSqWshCrtb7nUOiO5rpI4ktQGcOYhqGl
GzFLB2zFSw6z9CfpG7jl2ULtRPZvyVVVfV8AfXqh4SgykOsdZa/+7cXl2N0sB8bA
/w+JX2oO/wcCMlUfy/DKTv4iANKQZB9LsaFd2a7QKzVDiKRcx5RafMQaVON82xx5
05H/R8Cn5Y30z/WGTbzS+eSWy0J4X2ECFw16J7VOmWqcaYa3MAST92x+PXBS+P91
Jbv/OgdF/c3F4/Hi667HzQMy2E4egKhSME6fxh1f/iAR2h/QfzIa+gy4Glm4mAU=
=YLTV
-----END PGP SIGNATURE-----

--rIkTV52V9g01js4a--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
