From: Mark Brown <broonie@kernel.org>
Subject: Re: [Fixes: PATCH v1] spi: dw: fix kernel crash due to NULL pointer
 dereference
Date: Wed, 27 Aug 2014 17:33:39 +0100
Message-ID: <20140827163339.GJ17528@sirena.org.uk>
References: <1409156768-28461-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/goR4nZoqCKYqIm7"
Cc: Baruch Siach <baruch@tkos.co.il>, linux-spi@vger.kernel.org,
	stable@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409156768-28461-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--/goR4nZoqCKYqIm7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 27, 2014 at 07:26:08PM +0300, Andy Shevchenko wrote:
> The obvious fix after the commit d9c73bb8a3a5 "spi: dw: add support for gpio
> controlled chip select". This patch fixes the issue by using locally defined
> temporary variable.

Applied, thanks.

--/goR4nZoqCKYqIm7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/ghgAAoJELSic+t+oim9lwMP/1zQKPxrPAWzZRTGOwyvdUbp
PaIMlHl154MgJlRqmAK32sHUgXBiqDJXK0nbcVx/AxW2HR5ZA3x/1WCUbisK4Y6Z
8OI8FBCxJGHoGFELTC6DeEx/A85EfxcpHIO+Ck2F2D419BqrDIIP7NlOxsAJSKwh
Z9VTjUj/4O24iKpaThzp43FhncXpaHSp1ID0H1+GV6D6/e1GVfa003DOgS8RtoYP
DM+8Q7ps3vCg2mE5fGnlrqfiegUhhVtIriO/rG/CiATdDktrHQSKqZwhIKciJT1f
jntjiDuObDh8efrDQVZm6FPnED7oEVybzE7XVIAD8oOAqMt3ExruRNZFcnayEby9
XJpaiazN1jfJMmIzSXTsgInK/wbvHIRFcR32qHVRTK7kQIcd6ozFoDph4jjSEmMA
8y9Wx5Ky5CV9jLMz0uwElAwObRURCLlyPjy8wK2cxDFaU7SbNG3+LYo1H2HLLgIl
ZbezNFBdM2pQw2nh53y6exRzWFztQkOsx9deYMWgwPAQXgQO1jldJvPN411LblSe
R5sDISznoLf5Av2ZT9OYxB07HvtvQKsQ+knVX9Nf92VWRJP15xoPIlLyhjhVeJ5Z
8vmydas3oSGSXdBEq8yzNj9qFc68Xm0c4KWV9oHKkVnaVseP3Y1+elqREEsqs3so
PD4E3umnOwY/QO7GJwml
=4qRS
-----END PGP SIGNATURE-----

--/goR4nZoqCKYqIm7--
