From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: make architecture specific hardware depend on
 the associated hardware
Date: Mon, 21 Nov 2016 19:24:05 +0000
Message-ID: <20161121192405.isghvgat6yjavjgr@sirena.org.uk>
References: <20161120175505.2910-1-pbrobinson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="slbjbr7sk3d3eunu"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161120175505.2910-1-pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--slbjbr7sk3d3eunu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 20, 2016 at 05:55:05PM +0000, Peter Robinson wrote:
> There's not much point enabling hardware specific hardware drivers if the
> actual SoC architecture platforms aren't enabled as they're not much use
> with out it.

To repeat what I said last time please do make an effort to get this
reviewed by the relevant driver maintainers.

--slbjbr7sk3d3eunu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYM0nUAAoJECTWi3JdVIfQbYMH/3nPcdfIdyCV3QTu1MY/rvuC
43n2GZ0M2iKtEnzPfsOPo+Y7tXAmwZ7F2UmT9xp82FpISVYLKh1WJIIgXSxAIlcr
fAtbE+J6q6mufGeX3yUcoBAzFgYS6JU2Gqlos5txsdqLWo1W3N1+RlTpyhVie1sx
QLss0Ounr/cCcxdjupEAQAsYMErBMxsQ55l+SrWCJw5wNlRSSA627yOhJaO/Wffs
N7DEngSYHzdq/uB3YkT1XFQmiBqPOnsTfSqo4xKKAMUXBp8F4CBW2ISU8x29B4AE
Xu91Bb1IymIzWVH88T7RVYnMjz+sdO55x05M2Mxe7Gft1BKX2N1bfzTreP/hwgI=
=UJGy
-----END PGP SIGNATURE-----

--slbjbr7sk3d3eunu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
