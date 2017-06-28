From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/bcm63xx-hspi: Fix checkpatch warnings
Date: Wed, 28 Jun 2017 19:45:07 +0100
Message-ID: <20170628184507.tnl7jc4wvtt5op5q@sirena.org.uk>
References: <1498579630-10109-1-git-send-email-aravind.thk@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k42cjlrrmxvh7iio"
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aravind Thokala <aravind.thk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498579630-10109-1-git-send-email-aravind.thk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--k42cjlrrmxvh7iio
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 27, 2017 at 09:37:10PM +0530, Aravind Thokala wrote:
> This patch fixes the checkpatch.pl warnings on the driver
> file.

This isn't a good changelog, what are the warnings and why are we fixing
them?  The fact that checkpatch complains isn't meaningful in and of
itself - it's OK to say that checkpatch helped identify issues but it's
not perfect and we need to understand what is being changed and why.

--k42cjlrrmxvh7iio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllT+TMACgkQJNaLcl1U
h9DhMgf9FFjJVZ51W+Rv7zcVMA/0clNSR0dEo0Z3UJRaWeCQWeqlSzeZAGoJRNuJ
nAsYuQBocLGOWZO+WlN1MOaFHeNFBiLELxBCsH3Eaz580tb3nWL6LnxYOpxmTuM0
s4nqch0vp5oPLb2kwvSWvP7Fmz3MyptniqyqAEcK4iGtYnYtH8ay4QYiWGRxsxfp
ij4AstREKXLxSYNhThilLNbGkvte5YX1+no17+OG3AjDC2mYRXhUDYVQd8mN69Y2
llCicGsh04WlSZzVHaFrvSBCushodXXCWHJ086mOhaHQfUVS2mFbfoH4f9bdK9++
GsHle0uFdr1XekIBEAxi7omnr8sqUA==
=ySDW
-----END PGP SIGNATURE-----

--k42cjlrrmxvh7iio--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
