From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
Date: Mon, 17 Feb 2020 16:31:52 +0000
Message-ID: <20200217163152.GQ9304@sirena.org.uk>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-5-git-send-email-akashast@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9+VnUxDxRuy97YQ+"
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
To: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1581946205-27189-5-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--9+VnUxDxRuy97YQ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2020 at 07:00:03PM +0530, Akash Asthana wrote:
> Get the interconnect paths for SPI based Serial Engine device
> and vote according to the current bus speed of the driver.

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--9+VnUxDxRuy97YQ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Kv/cACgkQJNaLcl1U
h9C0DAf/ZL04JTosjXBLegMQrmn9rjYoKyenucR6bwhVK2SMK73TkxGKO7vjD/vN
it0Qg/z04vrqX/4Z6Nfbcmt0Y7T8RGK9YxWMGU7mVyup19Dqm0wYFc5qkBV2h3DY
k9/tUYoYmc6hddevcpgWwG38oU0eJJ9UoWVWvkOfCXK4VmjYnyxdUTcG4oRfDUFZ
rTjQlYIfYaqZJebjxTYB6cst1z2cvQ3ccOIYLH5PM5Z9V5BUx7mqz6ZsXQ/8qWZG
mVsA6RTuTPKlRsa3Fw++Y6QSIO4r4wLH96Z2JA7Dl8wVzofTtbrSFuel93qWz0Ny
e/uNxPQ+GY/Nx19wFOrfJ1ErkNi0pg==
=f/E0
-----END PGP SIGNATURE-----

--9+VnUxDxRuy97YQ+--
