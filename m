From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: coldfire-qspi: Fix getting correct address for
 *mcfqspi
Date: Sun, 23 Feb 2014 13:10:31 +0900
Message-ID: <20140223041031.GG25940@sirena.org.uk>
References: <1392342780.22981.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DDsCC8pMoxT831fJ"
Cc: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392342780.22981.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DDsCC8pMoxT831fJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2014 at 09:53:00AM +0800, Axel Lin wrote:
> dev_get_drvdata() returns the address of master rather than mcfqspi.

Applied all, thanks.

--DDsCC8pMoxT831fJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCXSzAAoJELSic+t+oim92EUP/RagUZ3qvgwSKjySapuEuTmu
iw7B36lgw7Yt0bmoJz/BTfQvWl5fiBrPp2PUDZabpI8spXQrkP7oESYhJ/vUav6Y
e594AGzS1PKLWJQFdhNQZypt4OK6fURi5ylz40LbyWiLDk+UlpBY4DyqSKItf+iS
Stz7za54RiFzQlu4s9hn1vuzvaXuxDL7+KIlrzBQ+iHQ0cH8kqH1InXDdzGS6KgV
2WgMlmPeGFSe/UubS8JUTBunxedfQm4m6LIPOq6xzaboMGMXjXVB0MPAmXmmSIop
ojq26CyuKe8Le11gvhGQW7nIEzPp3qjo8dJ8PNucX6UZudMiNZ+jimhyZut+PQTV
oxRwdVU2yrJZGY32h8fmNY+EIVcnSfPwn+ShKzmXXkWmoxiSlfsAP/N2eiYKTu4S
gtrOTXh1ijlrlJh2MbdML8wOsm1dLIKJEDk+sWCy5oOAd+92QZMd5OIVg22BwRBQ
yXjkLlfZj2fUz5Riatx5Dpo1hJyB3YN6b4GHWcs73X8TsZ7fy6qCLvd8eHCmezjk
6QdDGJeIeKI+yXaOmEkheIpIOun/DFNRvPAMsEy4Vif96G1AAKf64rMMl1i/IGBR
rASrtDjRniGlLXK0+pAo2J3zp3Ey7N25MgtB/7HsJ0hB/tmbIebmoYzxYcntQJjz
BjqfJFCdZg9F/qjoyKRp
=Cuvb
-----END PGP SIGNATURE-----

--DDsCC8pMoxT831fJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
