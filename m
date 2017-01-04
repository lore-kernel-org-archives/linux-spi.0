From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI: make falcon-spi bool
Date: Wed, 4 Jan 2017 10:46:24 +0000
Message-ID: <20170104104624.z4ijsadskpmd26p5@sirena.org.uk>
References: <20170103170427.26120-1-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="alvbwffhnzzkx5qh"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170103170427.26120-1-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--alvbwffhnzzkx5qh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 03, 2017 at 06:04:27PM +0100, Hauke Mehrtens wrote:
> Falcon spi accesses some ebu functions which are not exported and can
> not be accessed when build as module. Make this module bool instead.

Why is the fix here not to export these functions (or longer term to fix
things so that we're not going through custom APIs)?

--alvbwffhnzzkx5qh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhs0oAACgkQJNaLcl1U
h9DcqAf+NFoqgpCACkCkJ+F5jEdbm3+X7iXidm5ipfkPoFs0xvatoDBZnOanErXo
1k0Lq1seBtRRgdp/XcQso0NIA7dsUHjhZBmrI5Z+8IaCssR89Sq+XJlqrDuUonTX
R3jGjlMo7oTEWwprjuA90tGnKFlJF8BeUWUTp5R9xQNIEAq0n9SO4ihkaDez4DVy
MM+S4pGCGswLbtvp4NAAgy1tliu+loLgwu3ciPZ489gpv1SSRIhI9h1gh42rkw5Y
hT6wh6g2J1+ALl8gtGges4yYC5GGNFpCETbiZqrnJB4VekLUd5cBvYMn+mLTwVzt
4ONFDxHph5tboRlDFE2D0eVDiTDc8Q==
=0E+p
-----END PGP SIGNATURE-----

--alvbwffhnzzkx5qh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
