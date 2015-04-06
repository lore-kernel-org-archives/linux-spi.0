From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6] spi: Add SPI driver for Mikrotik RB4xx series boards
Date: Mon, 6 Apr 2015 17:39:05 +0100
Message-ID: <20150406163905.GL6023@sirena.org.uk>
References: <1428285263-15135-1-git-send-email-bert@biot.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/0D4jGRsNl8cPNu/"
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org
To: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428285263-15135-1-git-send-email-bert-Nh2F35Ii2RQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/0D4jGRsNl8cPNu/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 06, 2015 at 03:54:23AM +0200, Bert Vermeulen wrote:

> +	for (i = 0; i < t->len; ++i) {
> +		out = tx_buf ? tx_buf[i] : 0x00;

This looks like the driver needs to set SPI_MASTER_MUST_TX.

> +/* Deselect CS0 and CS1. */
> +static int rb4xx_unprepare_transfer_hardware(struct spi_master *master)
> +{
> +       struct rb4xx_spi *rbspi = spi_master_get_devdata(master);
> +
> +       rb4xx_write(rbspi, AR71XX_SPI_REG_IOC,
> +                   AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1);
> +
> +       return 0;
> +}

This seems broken - if chip select needs to be deasserted it should be
be deasserted before we get to unprepare, otherwise if more than one
SPI message is queued at once then presumably chip select won't be
deasserted between them which would break things.  This is what the
set_cs() operation is for...

> +		if (spi->chip_select == 1 && t->cs_change) {
> +			/* CPLD in bulk write mode gets two bits per clock */
> +			do_spi_byte_fast(rbspi, spi_ioc, out);
> +			/* Don't want the real CS toggled */
> +			t->cs_change = 0;
> +		} else {
> +			do_spi_byte(rbspi, spi_ioc, out);
> +		}

This is making very little sense to me and the fact that the driver is
messing with cs_change is definitely buggy, it'll mean that repeated use
of the same transfer will be broken.  What is the above code supposed to
do, both with regard to selecting "fast" mode (why would you want slow
mode?) and with regard to the chip select?

I queried this on a previous version and asked for the code to be better
documented...

> +static int rb4xx_spi_setup(struct spi_device *spi)
> +{
> +	if (spi->bits_per_word != 8 && spi->bits_per_word != 0) {
> +		dev_err(&spi->dev, "bits_per_word %u not supported\n",
> +			spi->bits_per_word);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

This should be removed, the driver should be setting bits_per_word_mask.

> +	ahb_clk = devm_clk_get(&pdev->dev, "ahb");
> +	if (IS_ERR(ahb_clk))
> +		return PTR_ERR(ahb_clk);
> +
> +	err = clk_prepare_enable(ahb_clk);
> +	if (err)
> +		return err;

There's no error handling (or indeed any other code) disabling the
clock, probably this enable should happen later and those disables
definitely need adding.  I'd also expect to see runtime PM to keep the
clock disabled when the controller isn't in use in order to save power.

> +static int rb4xx_spi_remove(struct platform_device *pdev)
> +{
> +	struct rb4xx_spi *rbspi = platform_get_drvdata(pdev);
> +
> +	spi_master_put(rbspi->master);

devm_spi_register_master().

--/0D4jGRsNl8cPNu/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIraoAAoJECTWi3JdVIfQYHkH/0003QIxxS5ZoezKuN4DZGvj
nEQVunmHx9KRdsp7wdzrxOVi/ZWW2SS7ijlLQFhYp6RDc9WujEqH7az77OayVl7c
CMaF0G3iTjV9RkfOM3eHIfVt4rL0glkPilCPTUMslqmLOeCM7/m3/fXhNq0gLi6F
Qp90zRKDpwAwPv6ldEUroAS5MplNtELimi5/hIS7h34Mc9aegmiFaRU8zWd0UME8
aHdv9Glq8QufliAThP3JmhyUXScC6h4y7/IA7uO9ZEQDLGJjyukyY8tQggx3w187
2br7zLtBtA89uuU5yEhlZGrGmMmd/wVS4jMAv69H5AGdU2TLP1Ov90IljaGPfBk=
=l5gX
-----END PGP SIGNATURE-----

--/0D4jGRsNl8cPNu/--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
