From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/xlp: SPI controller driver for Netlogic XLP SoCs
Date: Wed, 19 Aug 2015 10:48:43 -0700
Message-ID: <20150819174843.GW10748@sirena.org.uk>
References: <1439960957-4213-1-git-send-email-kamlakant.patel@broadcom.com>
 <1439960957-4213-2-git-send-email-kamlakant.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OM3frZe47dgZ1O53"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439960957-4213-2-git-send-email-kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--OM3frZe47dgZ1O53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2015 at 10:39:16AM +0530, kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org wrote:

> +config SPI_XLP
> +        tristate "Netlogic XLP SPI controller driver"
> +        depends on CPU_XLP

Can we not have an || COMPILE_TEST here?  There's no headers included
that look like a problem.

It also looks like you have tab/space damage here.

> +static int xlp_spi_setup(struct spi_device *spi)
> +{
> +	struct xlp_spi_priv *xspi;
> +	u32 fdiv, cfg;
> +	int cs;
> +
> +	if (!spi->bits_per_word)
> +		spi->bits_per_word = 8;

The core will ensure that bits_per_word is always set, there is no need
to duplicate core functionality.

> +	/*
> +	 * The value of fdiv must be between 4 and 65535.
> +	 */
> +	fdiv = DIV_ROUND_UP(xspi->spi_clk, spi->max_speed_hz);
> +	fdiv = fdiv < XLP_SPI_FDIV_MIN ? XLP_SPI_FDIV_MIN : fdiv;
> +	fdiv = fdiv > XLP_SPI_FDIV_MAX ? XLP_SPI_FDIV_MAX : fdiv;

Please write if statements using the standard if construct, it's much
better for legibility.

> +	while (rxfifo_cnt) {
> +		rx_data = xlp_spi_reg_read(xspi, xspi->cs, XLP_SPI_RXDATA_FIFO);
> +		j = 0;
> +		nbytes = xspi->rx_len > 4 ? 4 : xspi->rx_len;

This is another (probably more serious) example of the problems with the
ternery operator.

> +	txfifo_cnt = xlp_spi_reg_read(xspi, xspi->cs, XLP_SPI_FIFO_WCNT);
> +	txfifo_cnt >>= XLP_SPI_TXFIFO_WCNT_SHIFT;
> +	txfifo_cnt &= XLP_SPI_FIFO_WCNT_MASK;

This is a bit surprising - I'd expect a _MASK define to define the mask
for the register field so we'd mask then shift rather than shift then
mask.

> +static irqreturn_t xlp_spi_interrupt(int irq, void *dev_id)
> +{
> +	struct xlp_spi_priv *xspi = dev_id;
> +	u32 stat;
> +
> +	stat = xlp_spi_reg_read(xspi, xspi->cs, XLP_SPI_STATUS);
> +	if (xspi->tx_len) {
> +		if (stat & XLP_SPI_TX_TH_OV)
> +			xlp_spi_fill_txfifo(xspi);
> +		if (stat & XLP_SPI_TX_UF)
> +			xspi->txerrors++;
> +	}
> +	if (xspi->rx_len) {
> +		if (stat & XLP_SPI_RX_TH_OV)
> +			xlp_spi_read_rxfifo(xspi);
> +		if (stat & XLP_SPI_RX_OF)
> +			xspi->rxerrors++;

We should tell the user about errors more noticably to aid debugging -
I'd expect to see us printing an error message here.

> +	}
> +	/* ACK all interrupts */
> +	xlp_spi_reg_write(xspi, xspi->cs, XLP_SPI_STATUS,
> +				(stat & XLP_SPI_STAT_MASK));

This unconditionally acknowledges all interrupts even if we didn't
handle them.

> +	if (stat & XLP_SPI_XFR_DONE)
> +		complete(&xspi->done);
> +
> +	return IRQ_HANDLED;
> +}

We're also unconditionally reporting that we handled an interrupt even
if we didn't which will break if the interrupt is ever shared and
prevent the kernel interrupt subsystem error handling working.

> +	xlp_spi_send_cmd(xs, xfer_len, cmd_cont);
> +	if (xs->tx_len)
> +		xlp_spi_reg_write(xs, xs->cs, XLP_SPI_INTR_EN,
> +				XLP_SPI_INTR_MASK);
> +	else
> +		xlp_spi_reg_write(xs, xs->cs, XLP_SPI_INTR_EN,
> +				XLP_SPI_RXINTR_MASK);

So the device is single duplex?

> +static int xlp_spi_transfer_one(struct spi_master *master,
> +					struct spi_message *msg)
> +{

This is called transfer_one() but it's actually a transfer_one_message()
operation.  Though it looks like we should be able to convert it into a
transfer_one() operation and make greater use of core functionality.

> +		if (t->transfer_list.next == &msg->transfers)
> +			xspi->cmd_cont = 0;
> +		else
> +			xspi->cmd_cont = 1;

This is spi_tansfer_is_last() (and should've been using list_is_last()
anyway AFAICT).

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "can't get IOMEM resource\n");
> +		return -ENODEV;
> +	}
> +	xspi->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(xspi->base))
> +		return PTR_ERR(xspi->base);

Just pass the resource to devm_ioremap_resource(), it'll handle a lookup
failure for you.

> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get IRQ\n");
> +		return irq;
> +	}

Print any error codes you get to help users trying to fix problems.

--OM3frZe47dgZ1O53
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1MF6AAoJECTWi3JdVIfQzHsH/AucQlLinJOMzWbsR631SpuV
zjF0wQT9shd65K3T8F7QKO0Sc+f9ZFHO4JH41ZrY9Nf5+Uvrxbyj3zKKRKYWvABR
ohJwemJj+1mWohgd5eVHFjCYzdCdQKLsbtjNljbPVWhrl/Bg7fT9LZI90x6dXAo/
S6qdCitkBKSDqgYIUUzU8Bzpk+JqIk2ana9+z/1DnwTqXJCWqrx3zFuconyeZmza
HT0fWbHrhge7ipi+hjuzgWg8zOaOUsuJlLWZG9rqZ1BM4sUfFY7UNL3EUCa/fQxa
g+bbmiraxr19uKT7logH3kvm1MMYnuZZ6eXS3JLma09q5XCPcYVESn4FjMUq8Rc=
=tfCw
-----END PGP SIGNATURE-----

--OM3frZe47dgZ1O53--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
