From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: mips-lantiq: Use devm_spi_register_master()
Date: Wed, 4 Dec 2013 12:55:19 +0000
Message-ID: <20131204125519.GR29268@sirena.org.uk>
References: <002d01cef0af$5a21f140$0e65d3c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="teKjxxMjPsACTz/N"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Thomas Langer' <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	'John Crispin' <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <002d01cef0af$5a21f140$0e65d3c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--teKjxxMjPsACTz/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 02:11:56PM +0900, Jingoo Han wrote:
> Use devm_spi_register_master() to make cleanup paths simpler,
> and remove unnecessary remove().

Applied, thanks.

--teKjxxMjPsACTz/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnyY0AAoJELSic+t+oim9Ox4P/0eNbB/ppE+4MPel92Y8UtEi
dzsmz7NKPT6ZA/kFlXOkpy78NzZpHpNWR7CCNpYfMmG1Jv1RODbuMnzAlITbpGrR
uKcduSG0Zv10UfUzumk5BOfwozl0xz2c8WsmR/Ryz5Nxj2sul5W0rSOHMv+mp9fe
qpjsH7ePD1oGpc7oR+hiV7LY6PpdvT+VZYJAmhbuQz1v/Bgd2d69d4+lzgrSW+e4
MbzlAaKVG5L/iT/TBwpDxW6qFfPdxlETjiKqCaQFgKoy90HOSse71pOELdaU7SvB
mAy0IWRSaXBza7FyrpOzc/6GeFX7m4x/TAWvS9DKrDShy30hNXGCCpQNZ4NBfKiR
9uIO3DL5ZWXe/ZVfLAjSE+9K30K64eg9N5g5yqTM8HNIe3H4iFGzilMJXtqI/39x
NwgXwQbW5Q/Oo2WMnkTbK976uZfnjiAsNtsAi28+/nqc5TwEeq4Vwch0DXh6D7va
hSpM+dJJQYVvp4g0COTHMBlHWgPVsv9ZBVBdrXDVYpMrKwh3Sg1heZrPaYrJNJ58
OfcN6dJvlbPyYCB4JafBL0/TVIEd/Q2aTKuUIH72aRhlKkTv9k0z6KrO7ncDJ/NC
kosjXzyH5itHlW9uSmc9iMtLf5LMxBCMco6zj1X6D19h6QvEmMo/IyMQbiO44yF8
HcM0yeFV4mN5Y6nOyqWF
=ku+E
-----END PGP SIGNATURE-----

--teKjxxMjPsACTz/N--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
