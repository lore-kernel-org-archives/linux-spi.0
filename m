From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: spi-ti-qspi: Handle truncated frames properly
Date: Wed, 13 Apr 2016 08:13:24 +0100
Message-ID: <20160413071324.GP14664@sirena.org.uk>
References: <1460462185.32355.7.camel@codethink.co.uk>
 <1460462294.32355.9.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6sj9mcRtP+pTWLOo"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
To: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460462294.32355.9.camel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6sj9mcRtP+pTWLOo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 12, 2016 at 12:58:14PM +0100, Ben Hutchings wrote:

> -		ret = qspi_transfer_msg(qspi, t);
> +		wlen = t->bits_per_word >> 3;

I did ask you to fix this to just / 8 so it's more readable :/

--6sj9mcRtP+pTWLOo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDfGMAAoJECTWi3JdVIfQSgQH/0J0Iwia6NBfSnakT41o/+rK
WE73HCwYyQODOIkmMkoQj42+mYHgsUmzkJe/2teoikSZ+m7yrDYYF80ul2xAK6JE
x+CpZJbH5rSaZRG1NhBsEAsDZJWUCNX1KoIdH4lWoCvxv+YHWS4eJWaZEeBP2gJ2
VpmTBjzS2roZBe/dhWHqPiDp4FbUEJKhExq0a/+nJBZSDnaLb9eB0DBrpOI2nM9f
34sQpuagJgJ+5dW3+/nsnUwUg85nYSjClTRsAzIfmWBJ+xZk779MTCB/Dzna0qPc
DzZTSXmdQjsMUGyMAyKmkDiZRCPKps/b+nZyb+D7qPRMmyXLPkOvMHsNs7SUhN4=
=TdLR
-----END PGP SIGNATURE-----

--6sj9mcRtP+pTWLOo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
