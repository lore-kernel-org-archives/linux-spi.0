From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/5] spi: armada-3700: Add support for the FIFO mode
Date: Mon, 5 Dec 2016 13:37:28 +0000
Message-ID: <20161205133728.sza2pt4tfkywu35k@sirena.org.uk>
References: <20161201102719.4291-1-romain.perier@free-electrons.com>
 <20161201102719.4291-3-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="obzqvbfammgcqot2"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
        Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
        Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org,
        dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
To: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161201102719.4291-3-romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--obzqvbfammgcqot2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2016 at 11:27:16AM +0100, Romain Perier wrote:

> Changes in v3:
>  - Don't enable the fifo mode based on the compatible string, we introduce
>    a module parameter "pio_mode". By default this option is set to zero, =
so
>    the fifo mode is enabled. Pass pio_mode=3D1 to the driver enables the =
PIO
>    mode.

Why?  If the hardware supports a more efficient mode of operation it
doesn't seem sensible not to use it.

> -	int i;
> +	int i, ret =3D 0;

Coding style - don't combine initialized and non-initalized variables on
one line.

>  static int a3700_spi_transfer_one(struct spi_master *master,
>  				  struct spi_device *spi,
>  				  struct spi_transfer *xfer)
>  {
>  	struct a3700_spi *a3700_spi =3D spi_master_get_devdata(master);
> -	int ret =3D 0;
> +	int ret;
> =20
>  	a3700_spi_transfer_setup(spi, xfer);
> =20
> @@ -505,6 +737,151 @@ static int a3700_spi_transfer_one(struct spi_master=
 *master,
>  	return ret;
>  }

This appears to be a random unrelated change, should probably be part of
the initial driver commit.

> +static int a3700_spi_fifo_transfer_one(struct spi_master *master,
> +				       struct spi_device *spi,
> +				       struct spi_transfer *xfer)
> +{
> +	struct a3700_spi *a3700_spi =3D spi_master_get_devdata(master);
> +	int ret =3D 0, timeout =3D A3700_SPI_TIMEOUT;
> +	unsigned int nbits =3D 0;
> +	u32 val;
> +
> +	a3700_spi_transfer_setup(spi, xfer);
> +
> +	a3700_spi->tx_buf  =3D xfer->tx_buf;
> +	a3700_spi->rx_buf  =3D xfer->rx_buf;
> +	a3700_spi->buf_len =3D xfer->len;
> +
> +	/* SPI transfer headers */
> +	a3700_spi_header_set(a3700_spi);
> +
> +	if (xfer->tx_buf)
> +		nbits =3D xfer->tx_nbits;
> +	else if (xfer->rx_buf)
> +		nbits =3D xfer->rx_nbits;
> +
> +	a3700_spi_pin_mode_set(a3700_spi, nbits);
> +
> +	if (xfer->rx_buf) {
> +		/* Set read data length */
> +		spireg_write(a3700_spi, A3700_SPI_IF_DIN_CNT_REG,
> +			     a3700_spi->buf_len);
> +		/* Start READ transfer */
> +		val =3D spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
> +		val &=3D ~A3700_SPI_RW_EN;
> +		val |=3D A3700_SPI_XFER_START;
> +		spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
> +	} else if (xfer->tx_buf) {
> +		/* Start Write transfer */

So this only supports single duplex transfers but there doesn't seem to
be anything that enforces this.

--obzqvbfammgcqot2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhFbZQACgkQJNaLcl1U
h9DcYQf+JaNE9P02XaPMFWRuBoPXFQWGUxBXOoNGTb34vWTVDyqP+ZDSB+o+OKwG
qcVgToPrWM16sk8xxJ1k1sVKU7qQ8h/vsxPEJ/QQF57JJCU3ny38aBNa8vWWkt00
RFYWXDaYdxpKJyZQBNKb9YCEGEgrrjJkdtpXppnSgi+1HVeIgtktTCY8vtsHNPCX
THqlRdO479WVU+UgyaQ8DMK2onD769lcbdCETE4YC2Spyi4xWmKjokPd/nITKUNj
4Fyzq0fLoT5Jnzf1ON//i6cTRoxt0ytqx01qeNYkvfSzHeEZ9QG6Nm6PENNYYJba
hfm3jfOFGsAL/q1vCObUf/RUCyewCw==
=ElTh
-----END PGP SIGNATURE-----

--obzqvbfammgcqot2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
