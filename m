From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] spi: sprd: Add DMA mode support
Date: Tue, 15 Jan 2019 14:30:42 +0000
Message-ID: <20190115143042.GB5522@sirena.org.uk>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
 <324f3106dbff2f28baae098b05219f1384fda97a.1547559542.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Cc: robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <324f3106dbff2f28baae098b05219f1384fda97a.1547559542.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 09:46:53PM +0800, Baolin Wang wrote:
> From: Lanqing Liu <lanqing.liu@spreadtrum.com>
>=20
> Add DMA mode support for the Spreadtrum SPI controller, and we will enable
> SPI interrupt to help to complete the SPI transfer work in DMA mode.

Again this looks good, one thing to check though:

> +static bool sprd_spi_can_dma(struct spi_controller *sctlr,
> +			     struct spi_device *spi, struct spi_transfer *t)
> +{
> +	struct sprd_spi *ss =3D spi_controller_get_devdata(sctlr);
> +
> +	return ss->dma.enable;
> +}

Is it always a benefit to use DMA?  One reason this is a function rather
than just a property is that even if the device can DMA any size of
transfer often for short transfers the performance is better if you use
PIO since the overhead of setting up the DMA controller, waiting and
then taking the interrupt when it finishes ends up being more than the
cost of just reading and writing directly to the FIFOs for PIO.

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw97pEACgkQJNaLcl1U
h9A9nAf+P9t2LyV+tEMCXlBQkjp0a/mBHna6R0+O2ldyqMIHvFWCYcTrED5sYgFq
ijPCK+i2c5VdbhxEtOfSgyijaElF1E4GT5rqHMGpcBOsnGHvx0CbLYniyg1WE1xB
nary/yQzFekPVbGunZnSQNcrIsgiKxBl5RuWhvzJH24X4uXNywQy0nr/ul3xgOcA
jIOvRfmPOz3M7Rus9RdD+f7pJpIfsgskY58QTR8xid+DyIUH7f2PttbcsAKwSHfB
Mq2EcAc9nDLP87ubjLGVc/E0JlSxeh5vunO5F/pmnJ1+2RPOvOBRXzYuexWG+uKN
B0jSxQRAynE4YApO1KR6NUFk3DU/JQ==
=1wSg
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
