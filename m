From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 04/18] spi: fsl-espi: pre-allocate message buffer
Date: Wed, 7 Sep 2016 19:56:14 +0100
Message-ID: <20160907185614.GD3950@sirena.org.uk>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
 <cabc3522-8ca9-516a-e0ef-5a2ed9ad8507@gmail.com>
 <14371aa8-17f2-69a2-99d4-cd095a87545c@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AgVde/5+edhW42SA"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <14371aa8-17f2-69a2-99d4-cd095a87545c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--AgVde/5+edhW42SA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 07, 2016 at 07:46:33AM +0200, Heiner Kallweit wrote:
> Currently the driver allocates a 64kb buffer for each single message.
> On systems with little and fragmented memory this can result in
> memory allocation errors. Solve this by pre-allocating a buffer.

This is flagged as patch 4/18 but I only have this as a single patch.
As previously discussed the purpose of the numbering in a patch series
is to order things, if you're just sending a single patch it doesn't
need numbering and if you're sending a series you need to send either
the whole thing or at least a cover letter to everyone so they know
what's going on.

--AgVde/5+edhW42SA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJX0GLNAAoJECTWi3JdVIfQSeIH/25A9nUJqyQqrDsyrUXbXv4P
xkgPu6X91MYQGp9Y1qJSnrAnSC1CPRq6KWmcy84Vd0MsriZCAxQrOy+Fi8LEXIcr
x8Hy7L9o0KbrIYFV9l98hogmdjrziVqXPAOR1CWRDm2EoDDHAatlOs0TyGVpPAiu
jxOp6mIlixPMk+5oqFUbnF2mpzDpZUepg/j+rLmwVIcqAHZv1lMTffWamIR3o0hx
8yqsUfn6QpYEWjdh2TR749ZkRDueYnJyma5m+Ll7xy7IjfnmAUe894WyqL405q8j
OzRBvIIMqzaf7nrI3sATRGqrkaw7Z/rzO6wF9dF4yEP99JAstg0Py68/k09K8RU=
=DUwY
-----END PGP SIGNATURE-----

--AgVde/5+edhW42SA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
