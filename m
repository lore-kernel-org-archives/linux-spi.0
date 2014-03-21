From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: nuc900: Fix setting multiple bits settings in
 register
Date: Fri, 21 Mar 2014 17:49:29 +0000
Message-ID: <20140321174928.GF552@sirena.org.uk>
References: <1395379454.30136.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Cc: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395379454.30136.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 21, 2014 at 01:24:14PM +0800, Axel Lin wrote:
> The correct way to set multiple bits settings is always clear these
> bit fields before set new settings.

Applied, thanks.

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLHulAAoJELSic+t+oim9DKcP+QGlPxIKupMvIhqKNPm7ggMw
W99WvYrojg2UBRayjssM/nP1LCN91PHwe6WLHxbIe4aOCS/rgC/2kfQtxWDTIlQg
vtjl/gTaIJ6aaWqssTAZCVzYF5jOIinUlyK1Iuu9g6DtR9wpqXz7NwzXem/1g7Vl
ywmVbHvJHBpPNI+TA3x7iHR4vmEPBIpTwfQbwWJuzPXVMQXINmXgi2UjJh6Toub0
hWTWfr5QrmdZ87JYSDM3tWDqZh8odzTbNaUB6vsauSRRrwRldmzBK8R9/5K/e00t
HS9CbuHdik1L09V/1cAtXONaI9tVdffSsPWPARnaS+WEpz9SRh9LDWZ5Zryy6wbZ
fkqv6MVdsiBsZZXCP9gUop5IjNdIQK34R3YRzpXO3LL6pNt3D6kD7y3eiG2XkuQV
flSlbVONEUmAIUwOv6OIxKIanc+KP/icaM3T3CJRZ7Qgnfu0ySkVEiYTNmU7VV04
6kwsc9oooleYVYwrIhP7fMlg7PQLqtCFBkWK4qftycdziRZBYRhriavvaqkASETy
vUynMkX1zUXv/72XrssmyxfYgPF/OgVVNLQ1167WqLciMOOOm9moZddylHOOC/UK
KWVheeHsSYFX7ZVKJyZfgcuCfUctYBMvn7Lt83y58usMiucr5HwYFUb/kF2GMxJk
8xvFpVdtmnpZ17LU/wci
=bySm
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
