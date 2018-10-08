From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v2] ARM: dspi: Provide support for DSPI slave more
 operation (Vybryd vf610)
Date: Mon, 8 Oct 2018 14:23:39 +0200
Message-ID: <20181008142339.61db70b8@jawa>
References: <20180927150709.17010-1-lukma@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/l6PsuMdULPkcpP1+lmSnSLc"; protocol="application/pgp-signature"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180927150709.17010-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/l6PsuMdULPkcpP1+lmSnSLc
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

Gentle ping on this patch...

>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
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
> index 7cb3ab0a35a0..05aeaf954f85 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -229,6 +229,9 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi
> *dspi) {
>  	u16 cmd =3D dspi->tx_cmd, data =3D dspi_pop_tx(dspi);
> =20
> +	if (spi_controller_is_slave(dspi->master))
> +		return data;
> +
>  	if (dspi->len > 0)
>  		cmd |=3D SPI_PUSHR_CMD_CONT;
>  	return cmd << 16 | data;
> @@ -325,6 +328,11 @@ static int dspi_next_xfer_dma_submit(struct
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
> @@ -792,14 +800,18 @@ static int dspi_setup(struct spi_device *spi)
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
> @@ -964,8 +976,13 @@ static const struct regmap_config
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
> @@ -1021,6 +1038,9 @@ static int dspi_probe(struct platform_device
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
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/l6PsuMdULPkcpP1+lmSnSLc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlu7TEsACgkQAR8vZIA0
zr3frQgA33eBI8PFfDOKRpp7ikqZX7c8mZGNo4sT6F8t5rsbg7X/McPW4q/8kvIy
U9mjXUZ43r4QhPXCDrvAzpFqp+wJEqFmtYSK5dog/1wdMbG/K+eKVDfPf/05SUbt
eYx9tKC3LytGqUH1JdhdlkviJEIOgrWnw83XWVUHvOsbbZuI0YrV0w1QRMPhYksD
OTgUnQIRsMdzT/8WAjKqE+ShY6NNkGR9Z2jUdvSFNJRLBwya53F9kYWXAGFFw+PR
VhPY2Q4OgMXazmduq7F6zy+LXEEBaQwZ0TdcEdgdJzJy/6UgX7wlgNEffZiPFufr
ei5tqtrihXNZZLpeIS7FIaBMa9acrQ==
=3pUs
-----END PGP SIGNATURE-----

--Sig_/l6PsuMdULPkcpP1+lmSnSLc--
