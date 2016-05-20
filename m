From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 10/12] spi: add driver for J-Core SPI controller
Date: Fri, 20 May 2016 11:23:17 +0100
Message-ID: <20160520102317.GH8206@sirena.org.uk>
References: <cover.1463708766.git.dalias@libc.org>
 <2e287ca758002621ef8eed3db9df37678e26af5e.1463708766.git.dalias@libc.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="poemUeGtc2GQvHuH"
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Rich Felker <dalias@libc.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2e287ca758002621ef8eed3db9df37678e26af5e.1463708766.git.dalias@libc.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--poemUeGtc2GQvHuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 20, 2016 at 02:53:04AM +0000, Rich Felker wrote:
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
> My previous post of the patch series accidentally omitted omitted
> Cc'ing of subsystem maintainers for the necessary clocksource,
> irqchip, and spi drivers. Please ack if this looks ok because I want
> to get it merged as part of the arch/sh pull request for 4.7.

This is *extremely* late for a first posting of a driver for v4.7 (you
missed the list as well as the maintainers).

> +static void jcore_spi_chipsel(struct spi_device *spi, bool value)
> +{
> +	struct jcore_spi *hw = spi_master_get_devdata(spi->master);
> +
> +	pr_debug("%s: CS=%d\n", __func__, value);

dev_dbg()

> +
> +	hw->csReg = ( JCORE_SPI_CTRL_ACS | JCORE_SPI_CTRL_CCS | JCORE_SPI_CTRL_DCS )
> +		^ (!value << 2*spi->chip_select);

Why the xor here and not an or?  The coding style is also weird, a mix
of extra spaces around the () and missing ones around *.  I'm finding
the intent of the code confusing here.

> +static int jcore_spi_txrx(struct spi_master *master, struct spi_device *spi, struct spi_transfer *t)

Coding style, please keep lines under 80 columns unless there's a good
reason.

> +#if !USE_MESSAGE_MODE
> +	spi_finalize_current_transfer(master);
> +#endif

I'm not sure what the if is about but it doesn't belong upstream, you
shouldn't be open coding bits of the framework.

> +	/* register our spi controller */
> +	err = spi_register_master(master);

devm_

> +static int jcore_spi_remove(struct platform_device *dev)
> +{
> +	struct jcore_spi *hw = platform_get_drvdata(dev);
> +	struct spi_master *master = hw->master;
> +
> +	platform_set_drvdata(dev, NULL);
> +	spi_master_put(master);
> +	return 0;
> +}

This can be removed entirely.

> +static const struct of_device_id jcore_spi_of_match[] = {
> +	{ .compatible = "jcore,spi2" },
> +	{},
> +};

This is adding a DT binding with no binding document.  All new DT
bindings need to be documented.

> +		.owner = THIS_MODULE,
> +		.pm = NULL,

No need to set either of these.

--poemUeGtc2GQvHuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXPuWUAAoJECTWi3JdVIfQU0IH/0h7Kpf0QWt4VrbUkqd8hFBe
GIz4p92db3MViteCSGLCD7LxYdAZ4g+MAStz6m8O1WCCqcPUnkIRvAloXQuLf0jV
m8kI6R0Pb1wxy6ps2kip3YZNNiOBjWeNU3S27E6wPw8esVldxN58EP6lFFJOoUjT
mK4wwGxJ9Ap3JPyQzElCEoYdUSzQSCcGLWp54amN1/jYiN+OzULAshQs1iF74yZb
SyIUGm5DMP8yy4MhUQLkWoLSQp9krc8rAJEms8T8vTraXL2mBfqw6m23uAo9AMu0
V2jU2LokuvrtvVPOdu2ufXNx4cUkA2D67hH8t9HUHBzE4nPNn8qwurKkaNAwF9Q=
=U3aH
-----END PGP SIGNATURE-----

--poemUeGtc2GQvHuH--
