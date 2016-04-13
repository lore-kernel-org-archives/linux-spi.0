From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: am335x: spi driver and two chip select
Date: Wed, 13 Apr 2016 05:51:41 +0100
Message-ID: <20160413045141.GD14664@sirena.org.uk>
References: <CAF+MRt=ZJP2fssLHRUoR9T9EPfWEPN1LC0CLxZ0CgJQy01S3Rw@mail.gmail.com>
 <CAMuHMdWtHYNLcbX65HzuV6fyPENMR75XrVQ8RkW=y_T=hN44+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Cc: Micka <mickamusset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWtHYNLcbX65HzuV6fyPENMR75XrVQ8RkW=y_T=hN44+g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 12, 2016 at 03:50:21PM +0200, Geert Uytterhoeven wrote:

> AFAIU, spi_master.setup() should not modify registers immediately when
> supporting more than a single CS signal, while omap2_mcspi_setup_transfer()
> seems to do that.

Yes, this is a very common bug.

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDdBcAAoJECTWi3JdVIfQxKYH/A7YOQqd4sNkhiV/wrsFxduZ
Y1nfhah13/Iut9r1qKsQZsNA+10p+AxVWzs38200+KUDIZ8NRLj5fif6cev1EABK
CujyE0DMPD9/43+dOsiYlg9utgvqnmezkMQxXSV5tw5ORklqfi03I5vBvklRUe7a
dpF0xDv5FiTvBPSxwJrdWE+o604/ikAJEg35+sdLkJlsLGQ+HgE9aTakFlIzu9Uh
Y3AfvXCi6mhfLCzb/NLmm2P3noK3bD8QOo+101/X+4STpqLMEoyxrCzdZfbzaJst
/9ICEP6ISJLb7lwN4idzDRx6wF+m4tTZBwIeVjiiTxCAHIAUj+/YjIn9O+0LIwg=
=u+rz
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
