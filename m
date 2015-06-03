From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: pxa2xx: Prepare for new Intel LPSS SPI type
Date: Wed, 3 Jun 2015 13:14:35 +0100
Message-ID: <20150603121435.GJ14071@sirena.org.uk>
References: <1433328587-20797-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1433328587-20797-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M0++IvaR8xIqBMhe"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433328587-20797-2-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--M0++IvaR8xIqBMhe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2015 at 01:49:46PM +0300, Jarkko Nikula wrote:
> Some of the Intel LPSS SPI properties will be different in upcoming
> platforms compared to existing Lynxpoint and BayTrail/Braswell. LPSS SPI
> private registers will be at different offset and there will be changes in
> individual registers and default FIFO thresholds too.

This looks good.

--M0++IvaR8xIqBMhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbu+qAAoJECTWi3JdVIfQSzgIAIKwcQS6HYlYwM3Hg1ogEVcO
ZmiGXibHxSfiaWjapsJMwpbQG3507u7cKAgFdSRr8xNkEaJatJSkkVeG5S68yjjw
00EPZowg5eTMBOyZfejV9ASQ5VwRRXzOVcm3wflYBSN+74olChMzuNlyBmgNVEhj
gWvwjqHeUi38tieuxgxfOz5dcjSoenvwcms0L6TzG3Op2ibfAFLHUNzdeLLObOfY
NALIZqN8pGYvPIjJ913kPPU3IifvAjtwptqxjJLv+xXLT8iAapivvNnpKqC/BB/4
cijIr5TcYKSGEoz9lfU1SIRqR8zhm4A7wCSD3bZV6FFEbiN0j49smZIZV7pwke0=
=HA9/
-----END PGP SIGNATURE-----

--M0++IvaR8xIqBMhe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
