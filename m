From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: s3c64xx: Don't request/release DMA channels for
 each SPI transfer
Date: Mon, 9 Jan 2017 10:00:09 +0000
Message-ID: <20170109100009.22r7bjqsiaoerhgj@sirena.org.uk>
References: <CGME20161229121937eucas1p11cd0bb98b21699b0f773ecaeb7c29d26@eucas1p1.samsung.com>
 <1483013971-26446-1-git-send-email-m.szyprowski@samsung.com>
 <20161231182615.tuukfj5fa4wwkwvj@sirena.org.uk>
 <4bff51ce-2856-88dd-2518-ef8fa0c179e2@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opldwiwzbju2auj4"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4bff51ce-2856-88dd-2518-ef8fa0c179e2-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--opldwiwzbju2auj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 09, 2017 at 08:43:16AM +0100, Marek Szyprowski wrote:
> On 2016-12-31 19:26, Mark Brown wrote:
> > On Thu, Dec 29, 2016 at 01:19:31PM +0100, Marek Szyprowski wrote:
> > > Requesting a DMA channel might be a time consuming operation, so there is
> > > no need to acquire and release DMA channel for each SPI transfer.
> > This doesn't apply against current code, please check and resend.

> It fails to apply because of missing commit
> 6f8dc9d481759b428a8cb6a17b83821451415ba9
> ("spi: s3c64xx: Do not use platform_data for DMA parameters") in your
> spi-next,

When I said "please check and resend" the resend part was important...

--opldwiwzbju2auj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhzXyUACgkQJNaLcl1U
h9B/qQf/c3D0uBCtMY4NDLsbQWiDWcxehgh+dnHpiy+SUP7e61fsWRsK0ARdZ51O
AhSvjg2oc7EY2OgdGnnq3KO38YQyTJpAK0n0dsnNqABoEicUlUfzJ/BkEHSli4O0
GcLp20S2xPTb1YIsL7N58bqdALD1gLeaTaz50PwpI7EwMHaooIEE25ykNWKG3vka
ybg/8tzUwPHU74dC51fmJhUvOT+oFKrlaPj0t7/YfJi2SXYYKRQPUCB3NBXrzWw2
oRPZBo+mrzMzAeDyc57VWzyPu2OQSCsAsxKn0q8fFhpnpT1N8gQs+eBGgpqprPE8
lTYTrILW1ygXKZ8z3PVYf7Z0UdjgOg==
=JfWH
-----END PGP SIGNATURE-----

--opldwiwzbju2auj4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
