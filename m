From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: imx: Add pm-runtime autosuspend
Date: Thu, 28 Apr 2016 12:22:49 +0100
Message-ID: <20160428112249.GL3217@sirena.org.uk>
References: <1461841411-26529-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Scih7unjikL75S6V"
Cc: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461841411-26529-1-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Scih7unjikL75S6V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 28, 2016 at 01:03:31PM +0200, Markus Pargmann wrote:
> Currently for each transfer the two clocks are enabled and disabled. For
> heavy SPI usage this can lead to a significant overhead.

Really?  If the system is loaded the normal effect is that we will get
an equivalent effect from the SPI message thread - I'm curious what the
numbers are here.  This doesn't seem like something we should be doing
in individual drivers if it makes a difference.

--Scih7unjikL75S6V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXIfKIAAoJECTWi3JdVIfQZDAH/2sLywFqRhtz4sJ/Xz6lAIBT
loB44IuPMi1rFxXVPYqiJflrEEE8nLNa7ZsKvrhZTo8ifW4Y5ZmWtCyPKASZHswF
iwJEPM0hPDtx2Jf1G1M1LLhaM2HeK6Fttv7kR4pE5QZCxpPrupOHJ4Z/gvEcVtoE
AlWYIlj6FyOCx5rEwPajg/JCIAbDvGe8h0sz8FUQ923s1SAZNGkn00NqhFU/y5WK
+4LwdtLU1p2+5ptaviNapMOI7l82xOzkHjie5cybilOaPNv/l+MfkS5vfY5Xo5pe
xVwf1QZiAu+HP/E02aYQ9VLKxHipoSpvW0JyFcNylJVtPm5cz8uHCKy737VwcGI=
=uSGo
-----END PGP SIGNATURE-----

--Scih7unjikL75S6V--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
