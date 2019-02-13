From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] spi: sprd: spi: sprd: Add DMA mode support
Date: Wed, 13 Feb 2019 12:20:12 +0000
Message-ID: <20190213122012.GE7540@sirena.org.uk>
References: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
 <3f9d23d4b250c5046f8c3411606aa9ffe807edd8.1550043082.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Cc: robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3f9d23d4b250c5046f8c3411606aa9ffe807edd8.1550043082.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 13, 2019 at 03:36:11PM +0800, Baolin Wang wrote:

> +enum sprd_spi_dma_channel {
> +	SPI_RX,
> +	SPI_TX,
> +	SPI_MAX,
> +};

It'd have been better to namespace these (SPRD_SPI_ or something) in
case of conflicts.  That's really minor though and everything else looks
good so I'll go ahead and apply, thanks!

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxkC3sACgkQJNaLcl1U
h9CuBAf/dxGjyh/qcii3tgS/K0gNwj7+wo5ZZcI1DGGxewwd6fBiFLO0RRjy2Twz
M/+PxIm4IZyYuCRDhhgSym5gE5LpJQZCPtIKaEladCecjWcYiOTNPwpvZwTxI/jy
QgyfOn3qfQllW/xnUrvKffxxBFX30a3qwui9glhJmpmsxvMHau49wEAgOEDql+KO
TiFNAckqKlBrLQagonHd36kfp2zncx1Pp4drhk0SaKJ03wu7R5Gl0LpheQDt97Ae
Hs+6XbjKYjDZZmiTV1PmHUxzrHp9AHv+mgW36SDh0b4rd0JJTsaMf7Tsny3MWU0t
tTZYrk5YCvvzQOcTAR4FYykSY/GrkQ==
=x+WH
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
