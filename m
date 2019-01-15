From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] spi: sprd: Add the SPI irq function for the SPI DMA
 mode
Date: Tue, 15 Jan 2019 14:24:52 +0000
Message-ID: <20190115142452.GA5522@sirena.org.uk>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
 <ec1741f29c44c436c1086877ff5b208e6b8af45d.1547559542.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Cc: robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ec1741f29c44c436c1086877ff5b208e6b8af45d.1547559542.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 09:46:51PM +0800, Baolin Wang wrote:

This looks good, just one small issue and a thing to check:

> +static irqreturn_t sprd_spi_handle_irq(int irq, void *data)
> +{
> +	struct sprd_spi *ss = (struct sprd_spi *)data;
> +	u32 val = readl_relaxed(ss->base + SPRD_SPI_INT_MASK_STS);
> +
> +	if (val & SPRD_SPI_MASK_TX_END) {
> +		writel_relaxed(SPRD_SPI_TX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
> +		if (!(ss->trans_mode & SPRD_SPI_RX_MODE))
> +			complete(&ss->xfer_completion);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (val & SPRD_SPI_MASK_RX_END) {
> +		writel_relaxed(SPRD_SPI_RX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
> +		complete(&ss->xfer_completion);
> +	}
> +
> +	return IRQ_HANDLED;
> +}

This will return IRQ_HANDLED no matter if there was an interrupt
actually handled.  That means that if something goes wrong due to some
bug or a hardware change (eg, a new version of the IP) and there's
another interrupt fired we won't clear it and the interrupt core won't
be able to detect that it's a spurious interrupt and use its own error
handling.  It's better to return IRQ_NONE in that case.

> +	ret = devm_request_irq(&pdev->dev, ss->irq, sprd_spi_handle_irq,
> +				0, pdev->name, ss);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to request spi irq %d, ret = %d\n",
> +			ss->irq, ret);

Are you sure it's safe to use devm_request_irq(), especially when
unloading the driver?  Using it means that we will only disable the
interrupt after the driver's remove function has finished so there's a
danger of an interrupt firing when some of the resources the hander has
used are still in use.  I didn't spot any issues, just something to
check especially with the later patches building on top of this.

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw97TMACgkQJNaLcl1U
h9BFNwf9HP3Z+bpkgsUNL5XdG5PvKTnwIdDpVQSXq4JNtppq2ITkJ7VxbDbJ3+1l
8dK4dnT6wX3+/dib9ky626PIovD+WkchDpQYKud/tb4ZsKwmhJ5OhfxLd/2rQOOF
eeYdFPiKHai0NzIdZpOga6orkDvjgM860VSh7Ylfl2iJ13cZGoR8Jnxo+Sa+huPg
lxphZAUJWUjFVeU0fetbyVb8iY89ovgBUMtzJ5xcWzdLXiLi3yT2s8NGrTtDxS2u
QVhJulPTxjxJ694mGH2mPz8hda+7uw/IT8sjk8bd3MmK/efl6CEZ5B1frzIm85Jg
pDm8Fno1/aJOZ339cLVOo5pjwxtJ2g==
=cuso
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
