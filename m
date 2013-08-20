From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] drivers/spi/spi-tegra114.c clean use of
 devm_ioremap_resource()
Date: Tue, 20 Aug 2013 11:44:27 +0100
Message-ID: <20130820104427.GJ30073@sirena.org.uk>
References: <1368526032-31371-1-git-send-email-laurent.navet@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FgWTvDHj0r903stt"
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1368526032-31371-1-git-send-email-laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--FgWTvDHj0r903stt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2013 at 12:07:12PM +0200, Laurent Navet wrote:
> Check of 'r' and calls to dev_err are already done in devm_ioremap_resource,
> so no need to do them twice.

Applied, thanks.

--FgWTvDHj0r903stt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSE0iIAAoJELSic+t+oim90cAP/jgwvpA7n3C92Y1/ULcQHb84
samV9m0MchaPC7llFvdRhmnN5qdTn7R8y0hz+tjBQzWq1ys5qbV8e49srcUl86Ot
yYOXZNIWQKle30mfMfQXlOGozxCdawfNzqQvTJE4yikMaR4XMP4ggp6dV2IRuHAy
0QFUcZuRMVZs4eR7suyQ4x4mFg2Y2kIbzyVvz96QfBz3Ml/8D3NLEsM/fK5ezJwb
WfzkRHh1nwN+Tjp0tW0KNtzzkOQPibO2lYi+TfgJ02fWNL4XOTbnw7oc85ADlYXA
j293RZguP4M4wTE/4BWrVShi4udzuXZeQUx2GXLKUVlyFQ40664gQhG9p12nmvgv
sb1CYB8iBLvhhNRqkjfqt83Dtl33vhrKpLHESGaVHs0AofDmA4RA4ppunnhQuwaN
nYmxX9Wv+7Zo6R2JJz6GXxTHG1ecPest6naJkVqUihW0dZoSdcgDNRWMvqZ1LsXl
nyYjBIMjyagmo38nACQulkRD1xRe9exG5EfYCHCB0+ER7QRIrCWF804ADTSWLfVE
kMt2193YJV+HIGCQY9lUbjGq4BhQu5x+4RhC0r3iRR8QFrAV5Ub5GX0zR6w2/VQ3
E8ZX67cTHO2xVA9yOfreKS6OfqO5A289zrayoevVkVh47BNHc8RrxVWeaqTllF83
xbhsEktpvuwJBEz2vaqn
=OaPF
-----END PGP SIGNATURE-----

--FgWTvDHj0r903stt--
