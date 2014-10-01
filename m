From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: orion: support armada extended baud rates
Date: Wed, 1 Oct 2014 19:22:34 +0100
Message-ID: <20141001182234.GK4273@sirena.org.uk>
References: <1411910644-7174-1-git-send-email-gerg@uclinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fVx4YFaxe8of50Zh"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411910644-7174-1-git-send-email-gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fVx4YFaxe8of50Zh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2014 at 11:24:04PM +1000, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org wrote:
> From: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
>=20
> The Armada SoC family implementation of this SPI hardware module has
> extended the configuration register to allow for a wider range of SPI
> clock rates. Specifically the Serial Baud Rate Pre-selection bits in the
> SPI Interface Configuration Register now also use bits 6 and 7 as well.

Applied, thanks.

--fVx4YFaxe8of50Zh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULEZpAAoJECTWi3JdVIfQhfQH/ipU7M0HgrjQ9KESRMBHBu3K
FyrffsZIU+opj2S16xu7SLsrqKbUHnGO9Ue41/xXOuh9vH4SpeqeqrT39QBN4GDn
j1/pkG9hFvTD2B4iD7ve2ggE0vzUOwNVrb9UjdY6VbMVBPo+m42u/xKdIGS1akob
DPiC0l7OYBAmu8/N2Ct2R3h1qyyF8jSm7Qo/xPKP37k7XVqT8EyXYDX5Sis47Vul
qg9p50DddEa+9GuaOQoMdM15IRFhBDR3amYnuTkDMvYxtLSASpz8UWZpGwRpjwSL
IZidh20mRj+b0mg3syghh2IxVHZy6vBchC7DIHvtqXdt36IJUU3swy7Rb0xXQe4=
=qB2B
-----END PGP SIGNATURE-----

--fVx4YFaxe8of50Zh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
