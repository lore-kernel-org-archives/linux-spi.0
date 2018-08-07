From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: sprd: Add SPI driver for Spreadtrum SC9860
Date: Tue, 7 Aug 2018 15:24:08 +0100
Message-ID: <20180807142408.GB7958@sirena.org.uk>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <99befd2badc4dffb59662fca1e11d79f18b64755.1533638405.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Cc: robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@spreadtrum.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <99befd2badc4dffb59662fca1e11d79f18b64755.1533638405.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 06:43:38PM +0800, Baolin Wang wrote:
> From: Lanqing Liu <lanqing.liu@spreadtrum.com>
>=20
> This patch adds the SPI controller driver for Spreadtrum SC9860 platform.

This all looks pretty clean, a few comments below but nothing too major:

> +static void sprd_spi_chipselect(struct spi_device *sdev, bool cs)
> +{
> +	struct spi_controller *sctlr =3D sdev->controller;
> +	struct sprd_spi *ss =3D spi_controller_get_devdata(sctlr);
> +	u32 val;
> +	int ret;
> +
> +	ret =3D pm_runtime_get_sync(ss->dev);
> +	if (ret < 0) {
> +		dev_err(ss->dev, "failed to resume SPI controller\n");
> +		return;
> +	}

Something else further up the stack should probably have runtime PM
enabled already - we should only be changing chip select as part of a
bigger operation.  If you use the core auto_runtime_pm feature this will
definitely happen.

> +	bits_per_word =3D bits_per_word > 16 ? round_up(bits_per_word, 16) :
> +		round_up(bits_per_word, 8);

Please

> +	switch (bits_per_word) {
> +	case 8:
> +	case 16:
> +	case 32:

It'd be nice to have a default case, the core should check for you but
it's nice to have defensive programming here.

> +static int sprd_spi_transfer_one(struct spi_controller *sctlr,
> +				 struct spi_device *sdev,
> +				 struct spi_transfer *t)
> +{
> +	struct sprd_spi *ss =3D spi_controller_get_devdata(sctlr);
> +	int ret;
> +
> +	ret =3D pm_runtime_get_sync(ss->dev);
> +	if (ret < 0) {
> +		dev_err(ss->dev, "failed to resume SPI controller\n");
> +		goto rpm_err;
> +	}

Same thing with runtime PM here - the core can do this for you.

> +static int sprd_spi_setup(struct spi_device *spi_dev)
> +{
> +	struct spi_controller *sctlr =3D spi_dev->controller;
> +	struct sprd_spi *ss =3D spi_controller_get_devdata(sctlr);
> +	int ret;
> +
> +	ret =3D pm_runtime_get_sync(ss->dev);
> +	if (ret < 0) {
> +		dev_err(ss->dev, "failed to resume SPI controller\n");
> +		return ret;
> +	}
> +
> +	ss->hw_mode =3D spi_dev->mode;
> +	sprd_spi_init_hw(ss);

This can be called for one chip select while another is in progress so
it's not good to actually configure the hardware here unless the
configuration is in a chip select specific set of registers.  Instead
you should defer to when the transfer is being set up.

> +static int sprd_spi_clk_init(struct platform_device *pdev, struct sprd_s=
pi *ss)
> +{
> +	struct clk *clk_spi, *clk_parent;
> +
> +	clk_spi =3D devm_clk_get(&pdev->dev, "spi");
> +	if (IS_ERR(clk_spi)) {
> +		dev_warn(&pdev->dev, "can't get the spi clock\n");
> +		clk_spi =3D NULL;
> +	}

I suspect some of these clocks are essential and you should probably
return an error if you can't get them (especially if probe deferral
becomes a factor).

> +	if (!clk_set_parent(clk_spi, clk_parent))
> +		ss->src_clk =3D clk_get_rate(clk_spi);
> +	else
> +		ss->src_clk =3D SPRD_SPI_DEFAULT_SOURCE;

Are upstream DTs going to be missing the clock setup needed here?

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltpq4cACgkQJNaLcl1U
h9AVcgf+NxxRSsAAJNVZOh81hcSC5CB7sYJnt2eniKxe6PLdIM4NXBncN13jTSUf
B9wU7JvRS02VGMZiFUi5RA50jN3a5gby3mb9UmjjVZzyQSPNpzeeDUEv67jreyXo
zTSy758kPJxqKwCG7fsHSBIJoT5/zx9sLESNX+3IxgJ1cMco6tZET9qo/gQqxsdH
Zw9SE4DDrAcIrYoc0Q1gBYIyeJ88ljJoytdHyCRPdjzaWColce5TKv6VvfOp8kZP
6JBKb8FPF6XdAHA8qvHobNyub85E836EIaoNSO97QAFi4JLXR8Zekx6y5kxBT84J
Pf2FbnHBP1XRQQX1deSuKEtxt8MYOA==
=UadY
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
