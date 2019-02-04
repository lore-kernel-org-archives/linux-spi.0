From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5] ARM: dspi: Provide support for DSPI slave mode
 operation (Vybryd vf610)
Date: Mon, 4 Feb 2019 11:30:01 +0100
Message-ID: <20190204113001.77d59570@jawa>
References: <20180927150709.17010-1-lukma@denx.de>
        <20190109082644.14941-1-lukma@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/W4Esgja4AsQbHE3sTBx7r6y"; protocol="application/pgp-signature"
Cc: Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109082644.14941-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/W4Esgja4AsQbHE3sTBx7r6y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear All,

> The NXP's Vybryd vf610 can work as a SPI slave device (the CS and
> clock signals are provided by master).
>=20
> It is possible to specify a single device to work in that mode. As we
> do use DMA for transferring data, the RX channel must be prepared for
> incoming data.
> Moreover, in slave mode we just set a subset of control fields in
> configuration registers (CTAR0, PUSHR).
>=20
> For testing the spidev_test program has been used.
> Test script for this patch can be found here:
> https://github.com/lmajewski/tests-spi/blob/master/tests/spi/spi_tests.sh
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v5:
>=20
> - Rebase to v5.0-rc1 (no code changes needed)

Is there any interest in adding new code (or fixes) to VF610 ?=20

The first version of this patch was posted more than 4 months ago with
no feedback on the VF610 dspi controller part (after I've rewritten it
to use the generic SPI slave code after comments from Geert [1]).

I do have a feeling that upstreaming this code takes a bit too long ...

[1] - https://lkml.org/lkml/2018/9/26/836

>=20
> Changes for v4:
>=20
> - Rebase to v4.20-rc5 (no code changes needed)
>=20
> Changes for v3:
>=20
> - Rebase to v4.20-rc2 (no code changes needed)
>=20
> Changes for v2:
>=20
> - Remove patch which adds extra NXP specific DTS property to support
> slave mode and reuse the generic one (spi-slave)
> - Remove patch which brings back the mcr_register local copy. It is
> not needed as generic SPI slave infrastructure is used.
> - Rewrite the code to use spi_controller_is_slave() helper functions
> ---
>  drivers/spi/spi-fsl-dspi.c | 40
> ++++++++++++++++++++++++++++++---------- 1 file changed, 30
> insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 5e10dc5c93a5..348682be9dd5 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -233,6 +233,9 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi
> *dspi) {
>  	u16 cmd =3D dspi->tx_cmd, data =3D dspi_pop_tx(dspi);
> =20
> +	if (spi_controller_is_slave(dspi->master))
> +		return data;
> +
>  	if (dspi->len > 0)
>  		cmd |=3D SPI_PUSHR_CMD_CONT;
>  	return cmd << 16 | data;
> @@ -329,6 +332,11 @@ static int dspi_next_xfer_dma_submit(struct
> fsl_dspi *dspi) dma_async_issue_pending(dma->chan_rx);
>  	dma_async_issue_pending(dma->chan_tx);
> =20
> +	if (spi_controller_is_slave(dspi->master)) {
> +
> wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
> +		return 0;
> +	}
> +
>  	time_left =3D
> wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
> DMA_COMPLETION_TIMEOUT); if (time_left =3D=3D 0) {
> @@ -798,14 +806,18 @@ static int dspi_setup(struct spi_device *spi)
>  	ns_delay_scale(&pasc, &asc, sck_cs_delay, clkrate);
> =20
>  	chip->ctar_val =3D SPI_CTAR_CPOL(spi->mode & SPI_CPOL ? 1 : 0)
> -		| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0)
> -		| SPI_CTAR_LSBFE(spi->mode & SPI_LSB_FIRST ? 1 : 0)
> -		| SPI_CTAR_PCSSCK(pcssck)
> -		| SPI_CTAR_CSSCK(cssck)
> -		| SPI_CTAR_PASC(pasc)
> -		| SPI_CTAR_ASC(asc)
> -		| SPI_CTAR_PBR(pbr)
> -		| SPI_CTAR_BR(br);
> +		| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0);
> +
> +	if (!spi_controller_is_slave(dspi->master)) {
> +		chip->ctar_val |=3D SPI_CTAR_LSBFE(spi->mode &
> +						 SPI_LSB_FIRST ? 1 :
> 0)
> +			| SPI_CTAR_PCSSCK(pcssck)
> +			| SPI_CTAR_CSSCK(cssck)
> +			| SPI_CTAR_PASC(pasc)
> +			| SPI_CTAR_ASC(asc)
> +			| SPI_CTAR_PBR(pbr)
> +			| SPI_CTAR_BR(br);
> +	}
> =20
>  	spi_set_ctldata(spi, chip);
> =20
> @@ -970,8 +982,13 @@ static const struct regmap_config
> dspi_xspi_regmap_config[] =3D {=20
>  static void dspi_init(struct fsl_dspi *dspi)
>  {
> -	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER |
> SPI_MCR_PCSIS |
> -		     (dspi->devtype_data->xspi_mode ? SPI_MCR_XSPI :
> 0));
> +	unsigned int mcr =3D SPI_MCR_PCSIS |
> +		(dspi->devtype_data->xspi_mode ? SPI_MCR_XSPI : 0);
> +
> +	if (!spi_controller_is_slave(dspi->master))
> +		mcr |=3D SPI_MCR_MASTER;
> +
> +	regmap_write(dspi->regmap, SPI_MCR, mcr);
>  	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
>  	if (dspi->devtype_data->xspi_mode)
>  		regmap_write(dspi->regmap, SPI_CTARE(0),
> @@ -1027,6 +1044,9 @@ static int dspi_probe(struct platform_device
> *pdev) }
>  		master->bus_num =3D bus_num;
> =20
> +		if (of_property_read_bool(np, "spi-slave"))
> +			master->slave =3D true;
> +
>  		dspi->devtype_data =3D
> of_device_get_match_data(&pdev->dev); if (!dspi->devtype_data) {
>  			dev_err(&pdev->dev, "can't get
> devtype_data\n");




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/W4Esgja4AsQbHE3sTBx7r6y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlxYFCkACgkQAR8vZIA0
zr1T7gf8DLa3CcHiFqBGUSa7LlfF73nm1NjO1JAbIB9inEccDPGYG9FoT0oVTzl6
7xOlOClt+hjsZC80MTBcyqKImEqHyUEdCzyvoPymqIgl3ZIJe9hGvDyve/N1NHEB
JgbDE16xZlhiEJFHCMjXFg7AO2ZftOtbeZIQRcFnS/DOK+q1ezM74X0sVP32/RNl
ZnBdqB4cEFLjxcpRupWtJqjCpfo4RULn5SNeWLhL+F3qvduapNedEiMgQVkjhA8W
NGu0rXCbkobe73Rqg+KRZQdaP0IB+4Q56jSSJ06zXoMUEHzfKR5uT+ehBTKDqMYF
nA5ICtn4v0jdcHgqsp9yS0phICwWWQ==
=PII2
-----END PGP SIGNATURE-----

--Sig_/W4Esgja4AsQbHE3sTBx7r6y--
