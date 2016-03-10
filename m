From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 2/3] spi/spi-xilinx:  Add clock support
Date: Thu, 10 Mar 2016 10:29:48 +0700
Message-ID: <20160310032948.GI3898@sirena.org.uk>
References: <1457513242-11202-1-git-send-email-shubhraj@xilinx.com>
 <1457513242-11202-2-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SdaPbLtAangIkrMZ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1457513242-11202-2-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SdaPbLtAangIkrMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 09, 2016 at 02:17:21PM +0530, Shubhrajyoti Datta wrote:

> +       xspi->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(xspi->clk)) {

As someone pointed out on the previous version of the series this will
cause the driver to fail to probe with existing DTs.  We probably need
to explicitly handle a -ENOENT as a "this clock will never appear" or
something.

This also requests a single nameless clock but someone pointed out on
the previous version there are multiple clocks into the IP.  Even if
you only want to add one clock right now the clock should probably be
named so we can scale up.

> +	}
> +	ret = clk_prepare_enable(xspi->clk);

Missing blank line here.

> +	if (ret)
> +		dev_err(&pdev->dev, "Unable to enable clock.\n");
> +

This isn't really checking the return code - if we failed to enable the
clock we should be failing the probe, not just carrying on.

--SdaPbLtAangIkrMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW4OooAAoJECTWi3JdVIfQiRcH/28LbOoPCxnkc9ODT0g6cg6c
q2ZnGLfXbPcbtzzi4rIu0b3GEhkHi24J/qs1RHnLyqsbkbJsdOpy06dzACaGJ8r2
O5N9bt3YNJo0CNkdkzs6BmvFv2agKztyLBO5FAl3g0fuyoGWqDaO2ButVjWa9Oy/
WJxSsrrzIP0Yz2Bi1eI+ExX9KLt8mK0CJSMgUz3gNkAIEVTyqOCBF+mJMO+unCsO
91AVFXWsZ0ofpAYDP528rAq7DS+k938QmID3ZYFT/fPMclt2NWKTCuGYysQAD8ck
jeanuWSf/BGMd1iAiquh5bdDR3stpNrpoWYg7u5YOLK3sjGGxApZahtpkdBVAk8=
=FdtR
-----END PGP SIGNATURE-----

--SdaPbLtAangIkrMZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
