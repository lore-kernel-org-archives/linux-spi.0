From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/23] spi: fsl-espi: remove unused elements n_rx and
 n_tx in struct fsl_espi_transfer
Date: Thu, 1 Sep 2016 21:14:29 +0100
Message-ID: <20160901201429.GR5967@sirena.org.uk>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
 <b5777cc4-1ab7-d7cb-00be-c597060e7af6@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OiITrshLgfui8fEl"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b5777cc4-1ab7-d7cb-00be-c597060e7af6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--OiITrshLgfui8fEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 25, 2016 at 06:44:19AM +0200, Heiner Kallweit wrote:
> Both elements are not used, so remove them.

Mechanical changes like this are better done before more substantial
optimisations and enhancements like the previous patch, that way they
won't get blocked if there's a problem with the previous patch as is the
case here.

--OiITrshLgfui8fEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXyIwlAAoJECTWi3JdVIfQk40H/2QaeIYaa1rTUJxgYOk+x8ye
OA+RENgZAt4Kt76kQC890o4KAmYS1DO0KmdjJSE+CsSQAS0A7DdkhSFN/MHKnWb9
mCo0CxMCHOZvtMa0zNagweVADTuaxTJ4THwPvkrzTzkt41tkXhfEMkZPz79hzlpT
c6T5O5zNKlNzCji/bIaEujzhsqPK4UZ8y90XMPh0MTSV4edwiz1KZa058V6LoTBc
d9laFdyxJZTQW5DaeXJ5d2h9QAtGlRi0qquapgrl8bYI638br378yHdPKqaLHVJX
d5Caf7l+f+WAQQMmT7wTwXvHc7wYVH+Hy284CuJMMvHhFO2S3TWcxS7ZGiFtnEU=
=lP6f
-----END PGP SIGNATURE-----

--OiITrshLgfui8fEl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
