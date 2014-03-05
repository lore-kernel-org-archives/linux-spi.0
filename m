From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-dspi: Fix getting correct address for master
Date: Wed, 5 Mar 2014 11:54:03 +0800
Message-ID: <20140305035403.GB13126@sirena.org.uk>
References: <1392353352.19487.1.camel@phoenix>
 <CAFRkauD3WFBw9VC6h+2bxcnuky7175G47+7tP8=5f4D2PeLpEQ@mail.gmail.com>
 <20140303014608.GL2411@sirena.org.uk>
 <CAFRkauC7z4UepyK-oH861OEo62+4b82idWPAkK99vmY0=T3w9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VOAkKSXG6MhRWuAn"
Cc: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFRkauC7z4UepyK-oH861OEo62+4b82idWPAkK99vmY0=T3w9A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--VOAkKSXG6MhRWuAn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 03, 2014 at 04:42:19PM +0800, Axel Lin wrote:

> And I think a similar patch for coldfire-qspi needs for 3.14 to make
> runtime suspend/resume work.

> commit  80467f761b01a2df5284661e9bf9876eee6a9573
> spi: coldfire-qspi: Fix getting correct address for *mcfqspi

> dev_get_drvdata() returns the address of master rather than mcfqspi.

Yes, looks like it.

--VOAkKSXG6MhRWuAn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFp/YAAoJELSic+t+oim9mb4P/3Jrv+LxZvrqoMQxT2QkoYLj
1rLAld2rsdnTXbNx7NnCmahzF0bG7mhhvNInfZeTNm3e7Qo3QiVMwuZWGwka9l8C
5oaWeotYXC3mI4Zp6YuienYnM73D7RDqOZu1rP5EZQemxA61ZIL/D/hYiJ42UkYp
jnE4FweskgI5/2Xxs14jN9aT71hvyVQ1QJlmHge1PYjwpDWWAlG889+dI6y3Xqwr
50+goiASDcapsFENk3hmBxMcmDfmEmXjQjraBfUItM5ALqRVuj5FcUgzPJq4LIP4
9fXkIi1nSrNi35hj0UtW3+JfohxLpbNZZBvmaaBqYcuwkqBqR7HJfUCx99UHMPbE
6R9nP5kTXv2nxskQ16Y5+p9XPImG6CEQIhdJWa7xRgWCBVZFPy9umjesGwRCpYUe
mm5+unEQhO+6b8a4k9i/UhycA4BbSYBqU3HsOdg79z0uB7C7oukt0BDqXOeT58ci
tO7q5iCuKmJsCThvoV2VxPbwBRSELtCaZYLy6gwqY+zPGlft1/r+CDrAED8aN6Bx
NLCb+DXUT41KUMC8BLtuJ+VK/nUMsc05cNEvKjsolBmml06FvV+UfLMQRYJg/19p
o7XKOzy/4Ri7UHsS5FQLRBO9JLqD5FE8JTUZDiqD0YZu4aubAPFkFQALm+IcgGJ5
HGqevGY9BI0BqVd0Z/go
=+Y81
-----END PGP SIGNATURE-----

--VOAkKSXG6MhRWuAn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
