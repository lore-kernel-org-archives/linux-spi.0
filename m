From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller
 documentation
Date: Tue, 7 Aug 2018 14:41:21 +0100
Message-ID: <20180807134121.GA7958@sirena.org.uk>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Cc: robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@spreadtrum.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 07, 2018 at 06:43:37PM +0800, Baolin Wang wrote:

> +Optional properties:
> +- sprd,spi-interval: Specify the intervals of two SPI frames, which can be
> +	converted to the delay clock cycles = interval number * 4 + 10.

What's a frame here, and does it overlap with any of the existing delay
configuration we have?  In general it's better for this stuff to be
configured at runtime by the device rather than at DT time by the
controller since that way if the device needs the delays we always do
them if we can and if they are only needed some of the time (eg, for
only one device on the bus or for only some operations) then we don't
take the performance hit when we don't need to.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltpoYAACgkQJNaLcl1U
h9AipAf8C3BTJ+JtWaUjns2mJPPiv5Ck30ahWS7xkS4zheh+pLz7a689zgEGwCfW
zqlaNz0G2RPcPmOG6Erur6AM4H1p13ymRNPEY9HDdOyGaiLyuYx3LhL7cCTcAdvY
3TbWIuEWTMxaOj8LTubqA9JGuWWcHsfAqqJxj/4a1GX/mFKWFh11K2utNEybziNt
1daiNHmNEsGf09Oz37PHpCm5q+zjD0ZfA4OkIknFY9x9ey/kt8eMkROtQjxwDSNR
D0/QmkL/OQ5nLGDohgl3MvwwNMJI1tP0iTs1eZSIHECGsfchVTpWjRsUYYy2DTCJ
lgLJ/7Yc2oFh5HZxACtltPVYBxmX+w==
=58R/
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
