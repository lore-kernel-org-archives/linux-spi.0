From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: txx9: Use devm_ioremap_resource()
Date: Fri, 28 Feb 2014 15:18:14 +0900
Message-ID: <20140228061814.GF29849@sirena.org.uk>
References: <003b01cf3292$fc72f500$f558df00$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Atsushi Nemoto' <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <003b01cf3292$fc72f500$f558df00$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2014 at 10:35:09AM +0900, Jingoo Han wrote:
> Use devm_ioremap_resource() in order to make the code simpler,
> and remove redundant return value check of platform_get_resource()
> because the value is checked by devm_ioremap_resource().

Applied, thanks.

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTECojAAoJELSic+t+oim9lr8P/ic3fJYQqcmOhSgS4zWJe9e8
VoFvpnYzWyNdsqZYzfQjFXK0F9zcZ7bgbJ+vVJgWiUVCV5G+UUeNqESBu6JlgC/I
kZwrkIq8XX3JAfPvJ39IEeq2D01qKJQf1I9MUcYNKIu25+5mrniB10phAm/6/zrg
W0QLqZianb4YbdHN3++uK2O8Zv+jNEFf8S3PfQzE+rKjrRSKWGrQeVoiHu41y6Nb
HW3WVcx/xqccSbBvK9x6eWosigoR7uCGPg4KzpYLybiMzVqkzpZV6mqYqtvFrtGS
Y7c9O6w+HJoKs4/8psUPY1WXQY8tJMRqvOhKmfnapGueS1Vm55eh4p5m7km1d+aE
B2Sc3wyUmjwkMg185EjExCBoqvXvDT2rljTiCwqwso89kUoyAfiQ45P7vaWNhkNd
SQ3dGGCX19LUe3f6OJb2A5ThqEdVPZvyksXSBJYStGJ4DQIEJvCPSTeQ5/VtYXZV
MdUqrupifyFtgzAPidNWcEkgefMu3fmG0w/yiz+TfJrRe/6shlrMpFqvCjG/W7/G
SPidS2JR7heh6BzFU5pR1VeGhgawjEiWqsHxNlee28eib00nlNYU6Ns6FW9AvUgZ
JLu6beBbagNXWhTTk2JKkdBBZ8KZ9zyHHu2Yb+Qq4xXXFN2yuXmNVb9+b94HvH/R
a+/AWffLY5NI9uMQX08C
=8fBZ
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
