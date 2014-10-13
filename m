From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-dspi: remove useless code for dspi driver.
Date: Mon, 13 Oct 2014 12:38:04 +0200
Message-ID: <20141013103804.GK27755@sirena.org.uk>
References: <1412825265-10221-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E9lJRGffXdNhqRfL"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412825265-10221-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--E9lJRGffXdNhqRfL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2014 at 11:27:45AM +0800, Xiubo Li wrote:
> Since we are using regmap framework's internal locks, so the
> lock_arg for dspi_regmap_config is redundant here.
>=20
> This patch just remove it, and then the dspi_regmap_config could
> be const type.

Applied, thanks.

--E9lJRGffXdNhqRfL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUO6uLAAoJECTWi3JdVIfQfGsH/3ftQoob15I5AC1gYqAmPQL0
1MK2X1+wG5FtIO6VeUUTZCVI65rW6d3Tf0P3EAbhLIu6o3il4qmomI0kp7XrMr87
R1fl+RHJW3yXdjBScBXywZ3KBmhAC01bmKnr4U+3reE6R815jZ8F5hV5f+j1JpJn
oXC/fOSyz9HUuoeYTuB4hQ7MDIevR/gs35O1BzwbwojCQmIQNVA6uRXBx73uYtOm
/zc07DpUqH75kpF1NByitMdNVlITaR+zwnULY+yprHyL6aXxvRqkQrxg0JTYViYJ
Eo04wa2hvLGdQeu5bVoBDY5j/Vv1R9iLu21KMEFQ6Sw3FhsQ18t7hypYhKyQYOw=
=HXX6
-----END PGP SIGNATURE-----

--E9lJRGffXdNhqRfL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
