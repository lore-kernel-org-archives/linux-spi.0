From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Add Cadence XSPI driver
Date: Mon, 10 Feb 2020 19:16:20 +0000
Message-ID: <20200210191620.GE14166@sirena.org.uk>
References: <20200128124212.12298-1-konrad@cadence.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Konrad Kociolek <konrad-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200128124212.12298-1-konrad-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2020 at 01:41:57PM +0100, Konrad Kociolek wrote:

>  	  Enables Xilinx GQSPI controller driver for Zynq UltraScale+ MPSoC.
> =20
> +config SPI_CADENCE_XSPI
> +	tristate "Cadence XSPI controller"
> +	depends on (OF || COMPILE_TEST) && HAS_IOMEM
> +	help
> +	  Enable support for the Cadence XSPI Flash controller.
> +
> +	  Cadence XSPI is a specialized controller for connecting an SPI
> +	  Flash over upto 8bit wide bus. Enable this option if you have a
> +	  device with a Cadence XSPI controller and want to access the
> +	  Flash as an MTD device.
> +
>  #
>  # Add new SPI master controllers in alphabetical order above this line
>  #

Please keep Kconfig and Makefile alphabetically sorted as the comment in
the context from the diff says.  :/

> --- /dev/null
> +++ b/drivers/spi/spi-cadence-xspi.c
> @@ -0,0 +1,895 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Cadence XSPI flash controller driver

Please make the entire comment a C++ so things look more intentional.

> +	dev_info(cdns_xspi->dev,
> +		"Running PHY training for read_dqs_delay parameter\n");

This print is just noise, please remove it.

> +static int cdns_xspi_setup(struct spi_device *spi_dev)
> +{
> +	if (spi_dev->chip_select > spi_dev->master->num_chipselect) {
> +		dev_err(&spi_dev->dev,
> +			"%d chip-select is out of range\n",
> +			spi_dev->chip_select);
> +		return -EINVAL;
> +	}

If this isn't already being validated by the core it should be and this
function can be removed.

> +	irq_status =3D readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
> +	if (irq_status) {
> +		writel(irq_status,
> +			cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);

This unconditionally acknowledges everything, even things we don't
understand.  If the hardware is generating unexpected interrupt statuses
we should probably warn.

> +static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
> +{
> +	struct device *dev =3D cdns_xspi->dev;
> +
> +	dev_info(dev, "PHY configuration\n");
> +	dev_info(dev, "   * xspi_dll_phy_ctrl: %08x\n",
> +		readl(cdns_xspi->iobase + CDNS_XSPI_DLL_PHY_CTRL));
> +	dev_info(dev, "   * phy_dq_timing: %08x\n",
> +		readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQ_TIMING));
> +	dev_info(dev, "   * phy_dqs_timing: %08x\n",
> +		readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQS_TIMING));
> +	dev_info(dev, "   * phy_gate_loopback_ctrl: %08x\n",
> +		readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL));
> +	dev_info(dev, "   * phy_dll_slave_ctrl: %08x\n",
> +		readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
> +}

This seems pretty verbose for an individual device...  If this is needed
for diagnostics perhaps put it in sysfs or debugfs where it'll be
accessible even if the log wraps?

> +err_no_mem:
> +	dev_err(dev, "Failed to probe Cadence XSPI controller driver\n");

Not sure this is adding anything over the individual error messages on
specific failures.

> +#ifdef CONFIG_OF
> +static const struct of_device_id cdns_xspi_of_match[] =3D {
> +	{
> +		.compatible =3D "cdns,xspi-nor-fpga",
> +	},

Why -fpga?

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5BrAQACgkQJNaLcl1U
h9A6LQf/UrbTnsfpM4lH00Lpeib7qpGynQclD/2ULSlyAy5O9lqqjlEhNqjPAxkI
bQYFW3mUqokT4aRwnSNFvLp4XnPnqgJHr6j7BrElfBTyYMTkC3PwAyuWCIRtyy8f
hJ7NQEW+JWLbk7r0rSwJMpLEAdY+080r1w/MH053rxw2CazYnveKGUML/d6Va7zx
fw4LPswxMJDqL3Mb1lfe+i5C/OtHqyG0pOXrSqnLSoyYOV6Xi5gAvxTwm/chm/IU
MAPcjCammNo3ryR2jzytSGYBWwKuDh8loAw1fFo0KXf+FOhCMFMQ/WRgQqUM+7sH
S5Cqk6+GSZroF0hFuVNCiqMR0hW7OQ==
=aLYf
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
