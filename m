From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Fix per-page mapping of unaligned vmalloc-ed buffer
Date: Tue, 30 Jun 2015 17:02:37 +0100
Message-ID: <20150630160237.GR11162@sirena.org.uk>
References: <1435250415-9147-1-git-send-email-andrew_gabbasov@mentor.com>
 <20150626114622.GW14071@sirena.org.uk>
 <000601d0b34a$9fa42170$deec6450$@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="magLDk5D4XGaUXcd"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Gabbasov <andrew_gabbasov-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000601d0b34a$9fa42170$deec6450$@mentor.com>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--magLDk5D4XGaUXcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2015 at 06:37:07PM +0300, Andrew Gabbasov wrote:

> > The caller is supposed to be providing us with aligned memory here.
> > However it could be helpful to do this so...

> Well, actually the rest of spi code does not rely on having a transfer
> buffer
> page-aligned. And I don't see any reason to make such an assumption here.
> Especially that it is not fulfilled, at least by ubifs code.
> Anyway, this fix seems to be useful indeed.

The requirement comes more from the underlying DMA code than from SPI
itself, SPI mostly doesn't care.

--magLDk5D4XGaUXcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVkr2cAAoJECTWi3JdVIfQDRkH/0Rqskda0f38eWcM6a1Qla91
ofAq7nkW1j5eu7WsaUwgTYZof3GK34lylBxZKgiFAvtSodUfGq2UjUS0yebTKzjc
S/5Y70lkkUfhHpBm+tkvmjo7rW7yHER/FTESom1qD4mobjDzbZcl9SKmtCCGnXFV
3qAQkB8IqZgm+FODR5jsQ+Ex35lgO1Kf8bn1H5I598NOnFIBdjXiF8z/X1Aa2I4P
EE/m01muGXguVLHylk2Z9lKQw5L2ZZFS+3dca+7lWZCEnG/476Ax4RU5Pn/qoE72
93AcobCKWLjjqNRYjTY+3vADq68hrdUVlBZXlGC5IbLFiwlaLnMULbJeDgnVBMI=
=43OU
-----END PGP SIGNATURE-----

--magLDk5D4XGaUXcd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
