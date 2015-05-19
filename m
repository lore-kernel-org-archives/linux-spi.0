From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Add calls for pinctrl state select
Date: Tue, 19 May 2015 13:12:25 +0100
Message-ID: <20150519121225.GM2761@sirena.org.uk>
References: <1431519316-30989-1-git-send-email-pascal.huerst@gmail.com>
 <20150513181536.GI2761@sirena.org.uk>
 <5559D4BC.6010606@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HanPD1JKBS04/nMk"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5559D4BC.6010606-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HanPD1JKBS04/nMk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2015 at 02:02:04PM +0200, Pascal Huerst wrote:
> On 13.05.2015 20:15, Mark Brown wrote:

> > We should still be checking if we succesfully changed the state when
> > there is a state provided shouldn't we?

> I agree, but if I git grep for such calls, nobody seems to check the
> return values of these functions. Shall I add a check and print a
> message if the call fails?

Yes, please.

--HanPD1JKBS04/nMk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVWyioAAoJECTWi3JdVIfQnfUH/0pfhAxENzpjmFg5ldhq/qUp
5xGqXbtXIRHC3HfuQYr8WHJz19iNUxcOkyQUM5BYTobjR+CfraqRmptvjBu1mN8W
lhQm0lSdMyqbt4WYdpmn01ku4Yg91UKPtbqTvaYHJhfUbR7Kk/41lNFbROKV7isA
swpsNLPfU16iFIKZua6YF8hg2dVdqW45xehzKo3Zcfgii7iBwww06y14Ccmb6ANY
PTy4RuFqOhsKFitrne8qfjmtQ++yFGC/wmDFAVICoHzuK9vrk0OJ9oacr6Z/s+fa
qqc4279Up91dxvrl8H8mm8dvtlVcNDmNPwpREd/pXf1+TzcnY8jI1d6W3lpQebM=
=hK2t
-----END PGP SIGNATURE-----

--HanPD1JKBS04/nMk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
