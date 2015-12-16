From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Add builtin_spi_driver() to avoid registration
 boilerplate
Date: Wed, 16 Dec 2015 13:23:57 +0000
Message-ID: <20151216132357.GK5727@sirena.org.uk>
References: <1450040037-28334-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kdFpxm//39tBKx/r"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1450040037-28334-1-git-send-email-paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kdFpxm//39tBKx/r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 13, 2015 at 03:53:57PM -0500, Paul Gortmaker wrote:

> Here we use that support and extend it to SPI driver registration, so where
> a driver is clearly non-modular and builtin-only, we can register it in a
> similar fashion.  Existing code that is clearly non-modular can be updated
> with the simple mapping of

>   module_spi_driver(...)  ---> builtin_spi_driver(...)

> We've essentially cloned the former to make the latter, and taken out the
> remove/module_exit parts since those never get used in a non-modular build
> of the code.

Why would it be sensible to have a SPI driver that can't be built as a
module?

--kdFpxm//39tBKx/r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWcWXsAAoJECTWi3JdVIfQRdcH/j2mVFu/Cl2chuIB3wP/QfA9
yauV/HzfB86C3lAG3U/PBfMKw+9JtfoC+sC7FtvJtmAp9LKssyGYl2ufd2OdSDyn
08FOvsQjeSnr1lLFpyyCQ8ESCgheW2BYF36WzfcVugbF8kvP1Dkh0tEPPQ+EOyJ3
OZh/9jDqQiB2l8iAcz9bq0o+ViqMr5VB/EQoJ/qWIZ9SUKOIFi+i/H7V2rGhRS+e
DZaWx91SpExkIuyEM2bCL1hGRp70UQYbvUASprCqmOS4Gfl9u+GjoEn6FfY2/P8h
gTZDCLgbmDcMDpb8rB3IPhN/FNbzxnsBq/vQjpMVDXkkQdZjV91EaOcR90ULCyM=
=JE3S
-----END PGP SIGNATURE-----

--kdFpxm//39tBKx/r--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
