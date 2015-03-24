From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 1/2] spi: pxa2xx: shift clk_div in one place
Date: Tue, 24 Mar 2015 10:00:09 -0700
Message-ID: <20150324170008.GM17265@sirena.org.uk>
References: <1427211802-217454-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1427211802-217454-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DXTueXWT3Da08pik"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Chen, Alvin" <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427211802-217454-2-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DXTueXWT3Da08pik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 24, 2015 at 05:43:21PM +0200, Andy Shevchenko wrote:
> This patch refactors ssp_get_clk_div() and pxa2xx_ssp_get_clk_div() to align
> clk_div calculations, i.e. ssp_get_clk_div() and quark_x1000_set_clk_regvals()
> will return plain clk_div and it will be shifted to proper position in
> pxa2xx_ssp_get_clk_div().

Applied, thanks.

--DXTueXWT3Da08pik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEZgYAAoJECTWi3JdVIfQPs8H/28g81AAIsunYt801qSjlqLB
0VUmigr/6DQeL/woxO47nY7QMcPnknAML4Jf3zBiXEUq94ALHm0zfDHiZyVafQJI
8sS/yg5BlKGaRZJcAMRCtbu3EIAm331DDAyzbPA/8Xzq1RBDQym+nVPLnWAK1RJY
Kyu+ds5TLBD/CiupCw8x9Fpgo4nhi882wM62YVBDvw24CLGvDmTmWcWmuTiI+Hvi
xr2FzLszuRRkzwuoU0Bj3I3gD4opQZG9uAdZdjebYzCcBU3y9cg2K2Mu/5E/lVpl
JHlrTy4K14w5nLl8uyC+8nqbtfgHLSk/jb6P9zk4gaSBBYTbFlvM7QLDm4V/Owo=
=hEeg
-----END PGP SIGNATURE-----

--DXTueXWT3Da08pik--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
