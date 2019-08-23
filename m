From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/1] Fix shared IRQ behavior in spi-fsl-dspi
Date: Fri, 23 Aug 2019 11:56:49 +0100
Message-ID: <20190823105649.GP23391@sirena.co.uk>
References: <20190822212450.21420-1-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OGLMwEELQbPC02lM"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190822212450.21420-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--OGLMwEELQbPC02lM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2019 at 12:24:49AM +0300, Vladimir Oltean wrote:
> This patch is taken out of the "Poll mode for NXP DSPI driver" series
> and respun against the "for-4.20" branch.
> $(git describe --tags 13aed2392741) shows:
> v4.20-rc1-18-g13aed2392741

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--OGLMwEELQbPC02lM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1fxnEACgkQJNaLcl1U
h9ASIQf/SKt+WpRN4Gf/NlepPXBNfqGFEvuWS2se0FwyKunIaQlk4lzGfX1kEI/4
N+RMdtnCKkjtIcByafumflx4xoBo3AXOh1PV5eVN2wdsBHu1sep+dgNKh5UYVFTs
x9W6ghQaxtkFSecDC1bmvY+m8q2hWnDC3Q0AjbLlqaM7yPh70sXh7SR2fRnekKCE
stJavztU7SumHzpVenm+8zOw+6SPLe6wjUk7KK6tGzMHGLrtwWJnGMtCuBnwfhQU
W9NigLpkbj+DgajGbqz7uG8cqIHmVN8/UECeHXmMdsm2LN+oq138TGLQLGBRFTkD
91hT+SbfV96ycUSDNHYPi4BrH+JHlg==
=XdkG
-----END PGP SIGNATURE-----

--OGLMwEELQbPC02lM--
