From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
Date: Fri, 14 Feb 2020 14:08:44 +0000
Message-ID: <20200214140844.GL4827@sirena.org.uk>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214114618.29704-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cy9Nn4fUvYST66Pl"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        vigneshr-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200214114618.29704-2-vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--cy9Nn4fUvYST66Pl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2020 at 07:46:17PM +0800, Ramuthevar,Vadivel MuruganX wrote:

> +  - compatible : should be one of the following:
> +        Generic default - "cdns,qspi-nor".
> +        For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
> +        For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
> +        For Intel LGM SoC - "intel,lgm-qspi", "cdns,qspi-nor".

There are already existing bindings for several of these compatibles,
we should not be adding a second binding for something which already has
a binding but rather continuing to use the same binding.  This is the
whole point of documenting a binding that's separate to the implementation.

--cy9Nn4fUvYST66Pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5GqewACgkQJNaLcl1U
h9DtBgf/by0nSMwRQT7XWPBJkgVJC41aPF/FnRROHTeX4+E/Wdd1YhmtwwI88q9Q
ys4i+8ZXPV4Nmh0M/L6iX/dgdITH+DGML2hnJijnqyIcAcDElu9QzOge9K+TcpcC
OVDMxxls194MmBJkbe6iRmC9PaPQAucCPHTVBSEzqOsSwLTrKv7ouBPVzvaF8qp7
jjqLoMGhoJa/Y0XcoOqTsAHkSDRldoDx8q8SBcYpraw4o3SkW3Pgvz8uCixh2w3n
f96xeZn42peC559j0dTk/ey1g2oJ6drHxF01G3rpDk9T7EJZogrQXJAJdYre5iIP
lFfsgWm4mmXgMF4nDNp70tZD8dRuog==
=vocF
-----END PGP SIGNATURE-----

--cy9Nn4fUvYST66Pl--
