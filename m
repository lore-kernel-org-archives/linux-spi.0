From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: intel-ssc: add support for Intel SSC SPI controller
Date: Tue, 4 Oct 2016 05:13:03 +0200
Message-ID: <20161004031303.mwn6rk54owuu6eto@sirena.org.uk>
References: <20161002214408.30329-1-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="774hq53l46h23dsm"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161002214408.30329-1-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--774hq53l46h23dsm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 02, 2016 at 11:44:08PM +0200, Hauke Mehrtens wrote:
> From: Daniel Schwierzeck <daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> This driver supports the Intel SSC SPI controller in master
> mode. This controller is found on Intel (former Lantiq) SoCs like
> the Danube, Falcon, xRX200, xRX300.

Can we please just call this Lantiq like all the other Lantiq IPs?
Intel has a number of other SPI controllers in use (there's at least the
Intel designed pxa2xx one, plus DesignWare) so just calling it the Intel
SPI controller isn't very clear and most people would assume it's for
x86 chips.

Overall this looks good, most of the comments below are about use of
more modern APIs.

> +config SPI_INTEL_SSC
> +	tristate "Intel SSC SPI controller"
> +	depends on LANTIQ

Why no || COMPILE_TEST?  Not being able to build on other architectures
makes the driver much harder to maintain.  It looks like this is just
for the fpi clock which is exported by the architecture in a very
unusual way.

> +static void hw_chipselect_set(struct intel_ssc_spi *spi, unsigned int cs)
> +{
> +	u32 fgpo =3D (1 << (cs - spi->base_cs + SPI_FGPO_SETOUTN_S));
> +	intel_ssc_spi_writel(spi, fgpo, SPI_FPGO);
> +}
> +
> +static void hw_chipselect_clear(struct intel_ssc_spi *spi, unsigned int =
cs)
> +{
> +	u32 fgpo =3D (1 << (cs - spi->base_cs));
> +	intel_ssc_spi_writel(spi, fgpo, SPI_FPGO);
> +}

We really need separate functions for this?

> +static void chipselect_enable(struct spi_device *spidev)
> +{
> +	struct intel_ssc_spi *spi =3D spi_master_get_devdata(spidev->master);
> +	struct intel_ssc_spi_cstate *cstate =3D spi_get_ctldata(spidev);
> +
> +	if (cstate->cs_gpio >=3D 0)
> +		gpio_set_value(cstate->cs_gpio, spidev->mode & SPI_CS_HIGH);
> +	else
> +		hw_chipselect_clear(spi, spidev->chip_select);

Please use the core support for GPIO chip selects rather than open
coding.

> +
> +	/* CS setup/recovery time */
> +	if (spi->cs_delay)
> +		ndelay(spi->cs_delay);

Please add this to the core, the idea of needing a settling time after
asserting chip select doesn't seem device specific.

> +		err =3D gpio_request(spidev->cs_gpio, dev_name(spi->dev));
> +		if (err)
> +			return err;
> +
> +		gpio_direction_output(spidev->cs_gpio,
> +			!(spidev->mode & SPI_CS_HIGH));

Use gpio_request_one() to combine these.

> +static void hw_finish_message(const struct intel_ssc_spi *spi)
> +{
> +	/* Disable interrupts */
> +	intel_ssc_spi_writel(spi, 0, SPI_IRNEN);
> +
> +	/* Disable transmitter and receiver */
> +	intel_ssc_spi_maskl(spi, 0, SPI_CON_TXOFF | SPI_CON_RXOFF, SPI_CON);
> +}

This needs to be done per message or just when the hardware idles?

> +		switch (spi->bits_per_word) {

> +		default:
> +			WARN_ON(1);
> +		}

The driver hasn't set bits_per_word_mask, it should do so so that we've
got error checking for this further up the stack where it can be
usefully reported and so client drivers can discover what's supported.

> +static irqreturn_t intel_ssc_spi_xmit_interrupt(int irq, void *data)
> +{
> +	struct intel_ssc_spi *spi =3D data;
> +
> +	/* handle possible interrupts after device initialization */
> +	if (!spi->rx && !spi->tx)
> +		return IRQ_HANDLED;

This is broken if the interrupt is ever shared - the driver should
really quiesce the hardware before requesting interrupts.  It also
prevents the interrupt core from handling things if there is ever a
problem which causes lots of spurious interrupts.  Why do we *need* to
do this?  It'd also be clearer if this were part of the if/else chain
below.

> +				goto completed;
> +		} else
> +			goto completed;

Coding style, if one side of the if statement has brackets both should.

> +static int transfer_wait_finished(struct intel_ssc_spi *spi)
> +{
> +	unsigned long timeout;

The core already supports waiting for transfer completion?

> +static int intel_ssc_spi_transfer_one_message(struct spi_master *master,
> +					      struct spi_message *msg)

Why not implement transfer_one()?  This seems to just duplicate the
standard implementation.

> +		status =3D spi->status;
> +		if (status) {
> +			dev_err(spi->dev, "transfer failed\n");
> +			goto done;
> +		}

There's no need to log this, let the generic code do it if it's useful
since we're not adding any detail here (or incuding the error value).

> +static int intel_ssc_spi_prepare_transfer(struct spi_master *master)
> +{
> +	struct intel_ssc_spi *spi =3D spi_master_get_devdata(master);
> +
> +	pm_runtime_get_sync(spi->dev);

Use the core runtime PM support, it avoids duplication and checks the
return values.  auto_runtime_pm.

> +	tx_irq =3D platform_get_irq_byname(pdev, SPI_TX_IRQ_NAME);

I'm not sure the define is helping readabiliy here.

> +	spi->spi_clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(spi->spi_clk)) {
> +		err =3D PTR_ERR(spi->spi_clk);
> +		goto err_master_put;
> +	}
> +	clk_prepare_enable(spi->spi_clk);

Check the return code here.

> +	spi->fpi_clk =3D clk_get_fpi();
> +	if (IS_ERR(spi->fpi_clk)) {
> +		err =3D PTR_ERR(spi->fpi_clk);
> +		goto err_clk_disable;
> +	}

This is pretty horrible, why does the platform not just export the FPI
clock as a normal clock?  clk_get(NULL, "fpi") would work just fine as
an interface and avoid the needless platform dependency here (as would
explicitly mapping it in per device).  It looks like there's only one
existing user so this would be easy to fix.

> +	clk_disable_unprepare(spi->spi_clk);
> +	clk_put(spi->fpi_clk);

You used devm_clk_get() but you're calling clk_put() here.  Not only is
this redundant but if you do explicitly need to free a devm_ allocated
thing you should use the matching devm_ function (devm_clk_put() here)
to ensure that the managed deallocation is removed.

--774hq53l46h23dsm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX8x4+AAoJECTWi3JdVIfQ4d0H/1tfso1u5kVul+pHaAh1k5NO
oL0Mupp+pHdOH1RItUZMlCFQMBSkwkbK4focNF2NtkteiT0GZ7lx/E7SO+ef/3zi
a9GICIAuHaTPJLg9AIM6Vpfk3fMYwIo/ZbjFrwu6h/Pc4wFeYRKNQnThFROTHq/7
z1BhHCM8URYg+NO4zEc2aCHzDqUh8wOvWpwVVilmn9/VYhIIGxT7/xP4wAXAvXI2
7yzVhr0G8hSBvF7Rwb8EW/jMgM5SCgrBIkvEDjm1J8ADg3vb3+umKywihvWjpLdv
w4DOmYXtQkl+5DVaKOYflkoujxNykhFJcEZfNKFyuYMtHRtA3mHVjD2iozQQiio=
=QYJF
-----END PGP SIGNATURE-----

--774hq53l46h23dsm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
