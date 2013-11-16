From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 23/31] spi: tegra: convert to standard DMA DT bindings
Date: Sat, 16 Nov 2013 10:14:22 +0000
Message-ID: <20131116101422.GK15393@sirena.org.uk>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-24-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j/HO4hzKTNbM1mOX"
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384548866-13141-24-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--j/HO4hzKTNbM1mOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 01:54:18PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> By using dma_request_slave_channel_or_err(), the DMA slave ID can be

Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Is this function introduced earlier in the series?  One of the things
I'm looking at is trying to factor out some DMA code in the SPI
framework so perhaps using this straight off would be good.  But perhaps
the channel request stuff will all be in the drivers and it'll just pass
a handle to the framework code so there'll be no issue.

Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

--j/HO4hzKTNbM1mOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSh0V7AAoJELSic+t+oim9kw4P/0Bunub/JC32A2bxXv/KDk45
0on9EkkbWX5UyHsBINvd/86IPyi7RUc4TPYx+QbrK6yWXu/2/KMBowW7GqidEASU
ep7JKPGjcv2UBQn1h6pvqDjMv3YiQH4NAd7StLxD9qiVD3yiUSYMeFhtDboACxsP
BbiE07noYn7gUvkwE+25B/VacwSsbXHYWH2Fu9GNNEldgEa+W7zpJ+7hhIG+PmXN
pPJehQIfkhjwXWs3EfFFZSIX60bKzmz9polVIBPX1MjMy5Sp9ebdEMhc2JbBeXDQ
Jyt1j5PKdxI+IJP0EJ3psxXg+6A80Rm8Pu22mMVHdu3eLrCo36u/ZXnuEiCj+6Kx
E42bCBSvMUJe7AJGM1z8r/EJZZPTL9x5TjrrC2WMiJCGfuefdBvQ1x+HSZ+q6A3h
K1L/teKpITIzFMFmv6Ny6230QREBICjm+zldHeJaklS935bYR7E5dOvr6S1Yw+ae
YhksSUzxbF1jrKz+0/6PNMA4eKScqVhBE3Z8hh/zxKUsLxQG/itKDTYzBt83X+ct
DL0N2ruW9JnJYaQ2XVzRz3aQCjOjX0NTA2OWRLfLqvrf5dPG+QZ6qAL329uWX+oc
lBd0ZIDkbWaFYvEXynZjKQfpeI+CJv9PdEzrMTep3+LjXF0iaeEXzUlslUiBfDBe
wfWAEUgYrP3j/4UlYmUH
=4H01
-----END PGP SIGNATURE-----

--j/HO4hzKTNbM1mOX--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
