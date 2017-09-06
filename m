From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add ADI driver for Spreadtrum platform
Date: Wed, 6 Sep 2017 16:04:46 +0100
Message-ID: <20170906150446.v7qqc24wxeykcwwk@sirena.co.uk>
References: <ccbb0641fa123021249c7a51cbe2dcd975c41f39.1504677110.git.baolin.wang@spreadtrum.com>
 <c2faf18e6bbdac631963b22e5a4b5ee9be7f9e31.1504677110.git.baolin.wang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4tchu7st2cttvbs6"
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c2faf18e6bbdac631963b22e5a4b5ee9be7f9e31.1504677110.git.baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--4tchu7st2cttvbs6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 06, 2017 at 02:10:44PM +0800, Baolin Wang wrote:

This looks like a nice, clean driver.  A few fairly small issues though:

> +config SPI_SPRD_ADI
> +	tristate "Spreadtrum ADI controller"
> +	depends on ARCH_SPRD
> +	help
> +	  ADI driver based on SPI for Spreadtrum SoCs.
> +

I can't see any hard dependencies on the architecture - can you add an
|| COMPILE_TEST for more coverage?

> +	ret = devm_spi_register_controller(&pdev->dev, ctlr);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register SPI controller\n");
> +		goto free_hwlock;
> +	}

> +	spi_controller_put(ctlr);

You used devm_ to register the controller, no need to free it
explicitly.

> +static int __init sprd_adi_init(void)
> +{
> +	return platform_driver_register(&sprd_adi_driver);
> +}
> +subsys_initcall(sprd_adi_init);

Why is this subsys_initcall() and not module_platform_driver()?

--4tchu7st2cttvbs6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmwDo0ACgkQJNaLcl1U
h9DaYgf9EOBNwYrHO9asL8MOK8KUv4oCBn1wJmmIusPBq+aeOJ2NTRS+2ayPQo01
M069x6KAgNHzUoZSOz6oT6FbkUGkoPhz++IGEz63lmRC12hGRQ5X/mnV2//clbEJ
PyuzjSUAciAta66GcPMgqjJ4Qo77sjM213WBX9ArE4rRnJ246ldLkMOUU9hk0orc
E1zVElUN6jQ5tuLLUIWd1dG330ZXQKki3GJ6XUYMm1ZzarkTOH3e/DvmUyZCQTbO
zbSmsyv0WoLWlZLE45NZXVa2LirZxQGQTG0TC5GustCnJwnc/KGmzcqyrbbPOqLz
ZBjr4l8YRjOZ3iIaYrgGvTMJAh4CYA==
=8yjE
-----END PGP SIGNATURE-----

--4tchu7st2cttvbs6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
