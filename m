From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: spi-gpio: Fix compiler warning when building
 for 64 bit systems
Date: Sat, 8 Nov 2014 09:13:06 +0000
Message-ID: <20141108091306.GA2722@sirena.org.uk>
References: <1415380318-2065-1-git-send-email-torfl6749@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Torsten Fleischer <torfl6749-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415380318-2065-1-git-send-email-torfl6749-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2014 at 06:11:58PM +0100, Torsten Fleischer wrote:
> From: Torsten Fleischer <torfl6749-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> The assignment of SPI_GPIO_NO_CHIPSELECT to cs_gpios[0] causes the follow=
ing
> compiler warning, when building for 64 bit systems:
> "warning: overflow in implicit constant conversion [-Woverflow]".

Applied, thanks.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXd6hAAoJECTWi3JdVIfQQsUH/0m/2WUprZGi84dUf3wvAcve
DCmv+/TVuZJaSP1bEV9Hg5URga+mf0HxLIHG3aeqV98aAqfsNk8U1mi0d30KIGsx
3FvIMQmgrb21qPqfF+PFHK/K0NJuw34UoB1pXD1u0zPY6oAw8EbZjHPWeSgfaSDN
m+nnFKblD5dvZx2TG60DrX2mMofcX6QQHCDvmQUyvApoLQmxBvc43BgSCQ2Md4+/
Owqk3sPTQ14dzmXNhJt7Ou0fiBPtxeSL1L/SFkVdYVo+U2qpalFpCWO3AKqVBq2B
jcULR3IIhdwqrHKX31htU/b8WxhPSKMcfeQlMBYKMPVnOeNu8iQOitum54eEiWE=
=9s+C
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
