From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 06/12] spi: spi-fsl-dspi: Replace interruptible wait
 queue with a simple completion
Date: Mon, 16 Mar 2020 12:26:13 +0000
Message-ID: <20200316122613.GE5010@sirena.org.uk>
References: <20200314224340.1544-1-olteanv@gmail.com>
 <20200314224340.1544-7-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200314224340.1544-7-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 15, 2020 at 12:43:34AM +0200, Vladimir Oltean wrote:

> The wait queue was actually restructured as a completion, after polling
> other drivers for the most "popular" approach.

> Fixes: 349ad66c0ab0 ("spi:Add Freescale DSPI driver for Vybrid VF610 platform")

Fixes should generally go at the start of the series to make sure that
they can be applied without any dependencies on the rest of the series
and sent to mainline before the merge window.

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5vcGQACgkQJNaLcl1U
h9BuGwf/TNkbNlpccB3oDAPTRoqpGwgXMT50uneLIqM+UWYDfTdo503/gwBuVGUZ
Ix/lJF/B9AD4LGk+CJED3A9PB8UahrL+5hl8+bojzSHjpRLyWrGqGg0GDEuH5DFV
fZxWjtf5laBqVYUzAvNi65PTOzLgXhO01FetyFQyToHLdFGQZs6wq0uZcJlq5A55
22ACschvXdQ8k3aOsPXLOwTaNxEIsWex+GpybtDIZdoUMnT6Y7Gf/LaWl9noJzCC
PTqYrePE1pwPUKo+/y2QXdUvao5UzQ/0qcBR7MHt0mjwFWlwikRRiF2dJf7s4Bqn
M/7m7bPS6B2ieiOoQgB2bp02f5FZnQ==
=3FFa
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
