From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] spi: Add QuadSPI driver for Atmel SAMA5D2
Date: Tue, 19 Jun 2018 16:15:06 +0100
Message-ID: <20180619151506.GG11230@sirena.org.uk>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com>
 <20180618162124.21749-2-bugalski.piotr@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O8XZ+2Hy8Kj8wLPZ"
Cc: linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <pbu@cryptera.com>
To: Piotr Bugalski <bugalski.piotr@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180618162124.21749-2-bugalski.piotr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--O8XZ+2Hy8Kj8wLPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 18, 2018 at 06:21:23PM +0200, Piotr Bugalski wrote:

> +static int atmel_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> +{
> +	return 0;
> +}

If this can be empty should we adjust the callers to allow it to just be
omitted?

> +static int atmel_qspi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctrl = platform_get_drvdata(pdev);
> +	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
> +
> +	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
> +	clk_disable_unprepare(aq->clk);
> +
> +	spi_unregister_controller(ctrl);
> +
> +	return 0;
> +}

You should unregister the controller before disabling the hardware,
otherwise something could come in and try to start an operation on the
controller (or already be running one) while the hardware is disabled
which might blow up.

--O8XZ+2Hy8Kj8wLPZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlspHfkACgkQJNaLcl1U
h9Cymgf+MbrO5iP90HOZ4RRfuC7+k40zc4d09EiG7izyzvJ2/tYUEuSN13tnVCnS
kLf/EzOTei8n+cWU4jsetP27cVnhFSwAWAlnFQFYtd7yUV/e9bkoLIhuNTPs8RA7
pDtsc8bwrYqfxq0G/KoH2kUqa60fFnCRxxRkcTkaldu7oKe8m4i8pEdYVp52CSkl
1KHxfemgHnx40BFB9Aw2jS1UR5S812PVth6m9XV+qwphuUvlSkquORFe0uv0rNum
4AOK+w4QXvcZp/B9W1nEcwcsccDBJ082oMsI/kUj1rbCy7DlE8gI2OHufN9AlM/R
UXvlT50vdrssQaiicBHXd8Riqf18CA==
=2QLs
-----END PGP SIGNATURE-----

--O8XZ+2Hy8Kj8wLPZ--
