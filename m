From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2] spi: atmel: cleanup wait_for_completion return handling
Date: Wed, 4 Feb 2015 10:18:00 +0100
Message-ID: <54D1E3C8.7000304@atmel.com>
References: <1422891811-28541-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: Nicholas Mc Guire <hofrat@osadl.org>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422891811-28541-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Le 02/02/2015 16:43, Nicholas Mc Guire a =E9crit :
> return type of wait_for_completion_timeout is unsigned long not int, =
this
> patch adds an appropriate variable and fixes up the assignment. It re=
moves=20
> the else branch as the only thing it was doing is assigning ret =3D 0=
; - but=20
> ret is never used thereafter so that is not needed. As the string in=20
> dev_err already states "timeout" there is little point in printing th=
e 0.=20
> A typo in "trasfer" -> transfer is also fixed.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks. Bye.

> ---
>=20
> v2: fixes commit message and whitespace damage reported by
>     Mark Brown <broonie@kernel.org>
>=20
> This patch was only compile tested with at91_dt_defconfig
> (implies CONFIG_SPI_ATMEL=3Dy)
>=20
> Patch is against 3.19.0-rc6 (localversion-next =3D -next-20150202)
>=20
>  drivers/spi/spi-atmel.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 23d8f5f5..9af7841 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1046,6 +1046,7 @@ static int atmel_spi_one_transfer(struct spi_ma=
ster *master,
>  	struct atmel_spi_device	*asd;
>  	int			timeout;
>  	int			ret;
> +	unsigned long		dma_timeout;
> =20
>  	as =3D spi_master_get_devdata(master);
> =20
> @@ -1103,15 +1104,12 @@ static int atmel_spi_one_transfer(struct spi_=
master *master,
> =20
>  		/* interrupts are disabled, so free the lock for schedule */
>  		atmel_spi_unlock(as);
> -		ret =3D wait_for_completion_timeout(&as->xfer_completion,
> -							SPI_DMA_TIMEOUT);
> +		dma_timeout =3D wait_for_completion_timeout(&as->xfer_completion,
> +							  SPI_DMA_TIMEOUT);
>  		atmel_spi_lock(as);
> -		if (WARN_ON(ret =3D=3D 0)) {
> -			dev_err(&spi->dev,
> -				"spi trasfer timeout, err %d\n", ret);
> +		if (WARN_ON(dma_timeout =3D=3D 0)) {
> +			dev_err(&spi->dev, "spi transfer timeout\n");
>  			as->done_status =3D -EIO;
> -		} else {
> -			ret =3D 0;
>  		}
> =20
>  		if (as->done_status)
>=20


--=20
Nicolas Ferre
