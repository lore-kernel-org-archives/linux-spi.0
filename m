From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: qup: Depend on ARM && COMPILE_TEST to avoid build
 error
Date: Mon, 24 Feb 2014 14:46:13 +0900
Message-ID: <20140224054613.GA25940@sirena.org.uk>
References: <1393214871.1099.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SRK8lRENmpuaYFQC"
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>,
	"Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393214871.1099.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SRK8lRENmpuaYFQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2014 at 12:07:51PM +0800, Axel Lin wrote:
> This driver uses writel_relaxed() which does not exist in x86, ppc, etc.
> Make it depend on ARM && COMPILE_TEST to avoid below build error:

Applied, but two things here - one is that it's very surprising that the
zero day tester didn't notice this, the other is that we really need to
get the architectures fixed for this, having to deal with this sort of
pointless platform dependencies is a waste of time.

--SRK8lRENmpuaYFQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCtyiAAoJELSic+t+oim9wXAP/jpODcvJwKGPWb+5sx4cqt6f
JKPqDDc98Bd+QEJk4RYVTiJ+fS9C9sPB5d4whUPnha+S1eyurzRL4BpqjF5yeZ3X
rZ+kAyQU6fnaV8OIwZIAU5u7GAqQvcnykl7NMf0Qdq9dta+YVlctRTb1BAleoYFi
53X7O9vojPTYkdhh9wWZUfjoeraL+5hriSgWt2Omd09n0+uHQ+AA1Zoceh1dLSaI
F680Qa0tVJcUPEjEQ39YRu7wnQZdlW4q6i0TEH42AgKm0KR/EI1foHmkpi8v/H1p
bY8QwDFAGzfzwBQKeMfNFyxIR6l6LHbN/VzIWIFdH/W3A2cuZPuMp6ft01HBjFR0
jQZBv5nuwPhYv8CcR8t8SC+jnFgRhy4x1fmiU+t4BEUMgkZYiDJVh/jIv8w/K/FV
FNwaUR02AIpu3XZCSNVBiqKdnggEvMd9GvIn2ItBDnU3gZFJt8YXDIEwNbAxLdJS
YHCNuIOzDNOIgXQ2U/DJs8lHTiEpzhAv0PIPVY5hnMuZ+gnzzx6Se0hSEDFkFBnw
5G1KrcsxUJfFIDPzYHwqD6Fmr8RRBECsQTFkd4PlVjOOOMBQoHTMdQ6Ribba5T0b
imfTT12j1W7HuSi+ByDWZaMXOalOyn92FGCs2VronsE6tIXIWrAeznloy2SJZRdf
F1jJ7ykubAhaR74KdmiO
=uSuU
-----END PGP SIGNATURE-----

--SRK8lRENmpuaYFQC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
