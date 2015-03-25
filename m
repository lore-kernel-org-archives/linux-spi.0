From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: dw: fix crash on setup stage
Date: Wed, 25 Mar 2015 11:54:57 -0700
Message-ID: <20150325185457.GM3572@sirena.org.uk>
References: <1427307986-112219-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Aaj1jBvBEV7KRjLi"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427307986-112219-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Aaj1jBvBEV7KRjLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2015 at 08:26:26PM +0200, Andy Shevchenko wrote:
> The commit 1a7b7ee72c21 (spi: Ensure that CS line is in non-active state after
> spi_setup()) introduces an unconditional call of spi_set_cs() before ->setup().
> The dw_spi_set_cs() relies on that fact that ->setup() is already called, but
> it doesn't now. This patch fixes the crash by adding an additional check to
> dw_spi_set_cs().

Applied, thanks.

--Aaj1jBvBEV7KRjLi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEwSAAAoJECTWi3JdVIfQcXMH/0xS2Rd/Op7rWdqJ3IHLLicg
qCDtH1vDtCGBv5pUewWhfhH/lvKKCErvOeyV8fNo8UhXjn3+QoLN71tPqy3913iA
j7TJa2y9txEmMHfY9ZYUeS7JPCM2H4j64JLUv/eq2WTo9SjSXaSlcHcFIK3Dvsc3
0zpfylHlAJpfKYgmShfQ01UEAsYxa2+D7AFomlX6bF3jm9cCy1Poiwicjy5Ke9bd
UmzLwj3aIpgh13pZZD5knu9I7VjLKHDqqpQOap0/GdAQINDi9i1Pzz35DkzFwPRf
E91rsd7GiwcImYhHDuV6lsduskACIeSQVPUPKKM1RM/yijaarr3i+pjJQaJ1L9s=
=/pTs
-----END PGP SIGNATURE-----

--Aaj1jBvBEV7KRjLi--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
