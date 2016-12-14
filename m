From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: lantiq-ssc: add support for Lantiq SSC SPI
 controller
Date: Wed, 14 Dec 2016 15:34:07 +0000
Message-ID: <20161214153407.du2f63irwl2fi72h@sirena.org.uk>
References: <20161211200350.13590-1-hauke@hauke-m.de>
 <20161211200350.13590-3-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ngmimpbrtnwqq7o2"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161211200350.13590-3-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ngmimpbrtnwqq7o2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 11, 2016 at 09:03:50PM +0100, Hauke Mehrtens wrote:

> +config SPI_LANTIQ_SSC
> +	tristate "Lantiq SSC SPI controller"
> +	depends on LANTIQ

No || COMPILE_TEST?

> +	if (t->speed_hz)
> +		speed_hz = t->speed_hz;
> +	else
> +		speed_hz = spidev->max_speed_hz;

The core will ensure the transfers are always initialized.

> +static int lantiq_ssc_unprepare_message(struct spi_master *master,
> +					struct spi_message *message)
> +{
> +	struct lantiq_ssc_spi *spi = spi_master_get_devdata(master);
> +
> +	/* Disable transmitter and receiver while idle */
> +	lantiq_ssc_maskl(spi, 0, SPI_CON_TXOFF | SPI_CON_RXOFF, SPI_CON);
> +
> +	return 0;
> +}

Why is this done per message and not when the device actually goes idle?

> +		default:
> +			WARN_ON(1);
> +			data = 0;
> +		}

Missing break.

> +		case 24:
> +		case 32:
> +			rx32 = (u32 *) spi->rx;
> +			*rx32 = data;
> +			spi->rx_todo -= 4;
> +			spi->rx += 4;
> +			break;

This looks like the device doesn't actually support 24 bits per word or
at least is expecting the data to be in memory with pad bytes which
isn't what Linux expects.  You'd need to repack the data for the
hardware or just not support it.

> +static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
> +{
> +	struct lantiq_ssc_spi *spi = data;
> +	u32 stat = lantiq_ssc_readl(spi, SPI_STAT);
> +
> +	if (stat & SPI_STAT_RUE)
> +		dev_err(spi->dev, "receive underflow error\n");
> +	if (stat & SPI_STAT_TUE)
> +		dev_err(spi->dev, "transmit underflow error\n");
> +	if (stat & SPI_STAT_RE)
> +		dev_err(spi->dev, "receive overflow error\n");
> +	if (stat & SPI_STAT_TE)
> +		dev_err(spi->dev, "transmit overflow error\n");
> +	if (stat & SPI_STAT_ME)
> +		dev_err(spi->dev, "mode error\n");
> +
> +	/* Clear error flags */
> +	lantiq_ssc_maskl(spi, 0, SPI_WHBSTATE_CLR_ERRORS, SPI_WHBSTATE);
> +
> +	/* set bad status so it can be retried */
> +	spi->status = -EIO;
> +	spi_finalize_current_transfer(spi->master);
> +
> +	return IRQ_HANDLED;
> +}

This unconditionally returns IRQ_HANDLED even if nothing was flagged.

--ngmimpbrtnwqq7o2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhRZm4ACgkQJNaLcl1U
h9B0sgf+MUjsq2XEGC4pUJCqf/W0w/GIxcVgDToYg9SeVeNCg0+sNKucH5FWf5XT
R4CbE+WCgalRTeUMSRGlpoVkan0XLeKuIJMCRYhxLMr7Di9Iez5ROvtCNw8AE4f6
urGQ4KUoSl7nWLH5pMw6ZhvDkawIjorBvrgSMFj2VN0rp0nP3RElb/jtFkD/CdXJ
xRwPJ4Y+oljNdpZzYi8WlYROKFakmCmHg4JuYP/T3wKOHg9gI1RFa1Ja2fVh3mPP
moII/k4MfTHbt3okMocRxrRSC50ALqxR+JCmhy23pY/odKHxK2cCLWHy+VtieNR+
7Ye6t6Nxfcx2lT6rL0LUyEmWg0yCbg==
=CkND
-----END PGP SIGNATURE-----

--ngmimpbrtnwqq7o2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
