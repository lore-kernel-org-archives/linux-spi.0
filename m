From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: pl022: Specify 'num-cs' property as required in
 devicetree binding
Date: Mon, 11 May 2015 18:22:52 +0100
Message-ID: <20150511172252.GT3458@sirena.org.uk>
References: <1431357618-6829-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FT/vNgDLxVq4t/AU"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431357618-6829-1-git-send-email-ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--FT/vNgDLxVq4t/AU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 12:20:18PM -0300, Ezequiel Garcia wrote:
> Since commit 39a6ac11df65 ("spi/pl022: Devicetree support w/o platform data")
> the 'num-cs' parameter cannot be passed through platform data when probing
> with devicetree. Instead, it's a required devicetree property.

Applied, thanks.

--FT/vNgDLxVq4t/AU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUOVrAAoJECTWi3JdVIfQrEgH/jNw3DXiy2LDulPzANEC9+zv
o4HAyUBvc6wabXRWJnHhIocAD/rt1LqxrKedaAN9syN8opNihAbprYlq5D/qYBkB
2n4GsCG+OJ00JgYSyicmvanQgEbvFQ+aun3g2IH1/XGAmxEYan+DvpfItLAMXTnV
DHJtY70GNBFwpiknXojV6q7IqJT38KYGPSzSUfkLiOb8y/Lt/nVUEWGRUFo8+bL+
j0xlZ7D2oOEvgi15l+9TZLfiOAzzUpL9PYNSiFtslZ8VINmYOb2TQYNjxzTTvlzk
YPOP15bhAl2t6LC34IiC+xJX7mUnORjjy45Uaj1I/UoMyb4XB95yc3UyVDXcZ3A=
=MiF2
-----END PGP SIGNATURE-----

--FT/vNgDLxVq4t/AU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
