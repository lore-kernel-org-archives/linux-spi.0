From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: spi-fsl-dspi: Enable TCF interrupt mode support
Date: Tue, 2 Jun 2015 20:59:10 +0100
Message-ID: <20150602195910.GL14071@sirena.org.uk>
References: <1432548469-12714-1-git-send-email-haikun.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LzzTjdbJWii8frm0"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432548469-12714-1-git-send-email-haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LzzTjdbJWii8frm0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 25, 2015 at 06:07:49PM +0800, Haikun Wang wrote:

> +		if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE) {
> +			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
> +			message->actual_length += dspi_eoq_write(dspi);
> +		} else if (dspi->devtype_data->trans_mode == DSPI_TCFQ_MODE) {
> +			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_TCFQE);
> +			message->actual_length += dspi_tcfq_write(dspi);
> +		}

Please use switch statements to select between variants (this is more
idiomatic and makes it easier to add any new variants) both here and in
the other place where you do this.  It'd also be better to handle the
default case - what happens if we forgot a mode here?  I'd expect at
least an error message.

Otherwise this looks good.

--LzzTjdbJWii8frm0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbgsNAAoJECTWi3JdVIfQvlAH/3Fo78Yc1Bvi/LFqLyXLBu+a
mQdattn7ZGoLc0p9K1JQkCmwJ4lcJcP2U86npOSTN1ZiJIwC+i4sPwKR+/ybZAn/
uTTasuIgOyKL1ciAPrQRu4q0n5bADUOQWC91GKCYP5Sf7XHDsNHT9GHjc8qUX6M8
PLjSRyeYRE0hqNpeNYJ7IMVvLEA/HPdakx5BFvQx1v8AeAOLkpFb5SYrwSEUdvSR
x9YvvMxdA+sOGz8StI3MpXQ/Qrd4oGeHj+GvU4rYxFyw9yvT9q5TrBL7LoS9Af91
7XXaIqu56KnH2jnX1hWfwNX7JUnPV5frWecTbEjxWxWNaS1XQpU5taZitMmyWLE=
=Or26
-----END PGP SIGNATURE-----

--LzzTjdbJWii8frm0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
