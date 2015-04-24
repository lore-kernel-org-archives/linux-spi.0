From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4] spi: spi-ath79: Devicetree support and misc fixes
Date: Fri, 24 Apr 2015 18:58:27 +0100
Message-ID: <20150424175827.GE22845@sirena.org.uk>
References: <1429885164-28501-1-git-send-email-albeu@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i528gjSbuG1KhLiw"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
To: Alban Bedel <albeu-GANU6spQydw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429885164-28501-1-git-send-email-albeu-GANU6spQydw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--i528gjSbuG1KhLiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 04:19:20PM +0200, Alban Bedel wrote:
> Hello all,
>=20
> this serie add a DT support for the ATH79 SPI controller and fix a few
> trivial bugs. While adding DT support we also remove the unused custom
> controller data in favor of the generic GPIO based chip select.

Applied, thanks.  Please use subject lines reflecting the style for the
subsystem.

--i528gjSbuG1KhLiw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOoRDAAoJECTWi3JdVIfQif0H/0KKbqgnJDCivWhl36IofnCd
HJ0tD5a71yuw1PM12plvUSuwc7DUAy+OxiyIgdsEQ34KAbPlsIFKIqmLNzfpRCpl
x6KSl63VRSTfp3trZm6kgT6lzLJyCcq660yUEXMk+WOYjfl14DEscmcMLxWpClNY
h6ZiAH4wGsJwJRTQmO3rhKMVeVLfGcbZ6iviRLtJSd6SHuvJN03IYz5mOd1LdCvI
9xcx/Mnjyof5NEPZJvfU59fofz/SzFvMTJp3A08a16buxzf0q8cPBakPoGUd1VGp
iOtoQkLl7EmSvk/yaFCoJxxu5Bae1OPm6c7+h5yQeQXSkQtTYflqQL4F2oKkns4=
=evpm
-----END PGP SIGNATURE-----

--i528gjSbuG1KhLiw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
