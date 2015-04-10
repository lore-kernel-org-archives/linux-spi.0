From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: transform native-cs to gpio-cs on first
 spi_setup
Date: Fri, 10 Apr 2015 19:49:18 +0100
Message-ID: <20150410184918.GS6023@sirena.org.uk>
References: <1428340592-3196-2-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zLc9K0ic+N31mz/B"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428340592-3196-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zLc9K0ic+N31mz/B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2015 at 05:16:31PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> Transforms the bcm-2835 native SPI-chip select to their gpio-cs equivalen=
t.

This doesn't apply against current code, please check and resend.

--zLc9K0ic+N31mz/B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVKBstAAoJECTWi3JdVIfQNVAH/jf7AIi+aJKYjtMlg2ffVQ+B
czpEFYSVe1NfrJetJV+BtYwk94v5pHIUwx1DO49jApdFXKwJl1CQJlucZT5EHrT2
m34blpadBGgNu1WG6AKHAy4xtr9L+01Ge8i6zK+qit9LyR8cdDu+e/Xb3s1gdWvg
h7KLp6z+qXMjKaUmR7I1i8h4zLV3oKH86ZWNQsFJszk3UddTea47Pl5yuLgTyeqj
XftoXBkpL9zCNbm9M3qXtMydPrMetmeWEvQ9xFCgOT0OZINHOyTJXOZ4rRHfYK4L
N4L/RrUNEdLIr3coiF6OttUdLlMa1L4qyCgXTm8kwtyL+zrAgyKON84rE8VIMmg=
=A5ob
-----END PGP SIGNATURE-----

--zLc9K0ic+N31mz/B--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
