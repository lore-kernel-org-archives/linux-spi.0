From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] spi: tegra20-slink: change chip select action order
Date: Tue, 26 Mar 2019 15:44:37 +0100
Message-ID: <20190326144437.GA21654@ulmo>
References: <20190326143050.26232-1-gaireg@gaireg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Randolph =?utf-8?Q?Maa=C3=9Fen?= <gaireg@gaireg.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326143050.26232-1-gaireg@gaireg.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 03:30:50PM +0100, Randolph Maa=C3=9Fen wrote:
> To transfer via SPI the tegra20-slink driver first sets the command
> register, which contains the chip select value, and after that the
> command2 register, which contains the chip select line. This leads to a
> small spike in the chip selct 0 line between the set of the value and
> the selection of the chip select line.
>=20
> This commit changes the order of the register writes so that first the
> chip select line is chosen and then the value is set, removing the
> spike.
>=20
> Signed-off-by: Randolph Maa=C3=9Fen <gaireg@gaireg.de>
> ---
>  drivers/spi/spi-tegra20-slink.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Looks good to me. Adding Sowjanya who has been looking into SPI
recently.

Thierry

> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-sl=
ink.c
> index 1427f343b39a..6d4679126213 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -717,9 +717,6 @@ static int tegra_slink_start_transfer_one(struct spi_=
device *spi,
>  	command2 =3D tspi->command2_reg;
>  	command2 &=3D ~(SLINK_RXEN | SLINK_TXEN);
> =20
> -	tegra_slink_writel(tspi, command, SLINK_COMMAND);
> -	tspi->command_reg =3D command;
> -
>  	tspi->cur_direction =3D 0;
>  	if (t->rx_buf) {
>  		command2 |=3D SLINK_RXEN;
> @@ -729,9 +726,18 @@ static int tegra_slink_start_transfer_one(struct spi=
_device *spi,
>  		command2 |=3D SLINK_TXEN;
>  		tspi->cur_direction |=3D DATA_DIR_TX;
>  	}
> +
> +	/*
> +	 * Writing to the command2 register bevore the command register prevents
> +	 * a spike in chip_select line 0. This selects the chip_select line
> +	 * before changing the chip_select value.
> +	 */
>  	tegra_slink_writel(tspi, command2, SLINK_COMMAND2);
>  	tspi->command2_reg =3D command2;
> =20
> +	tegra_slink_writel(tspi, command, SLINK_COMMAND);
> +	tspi->command_reg =3D command;
> +
>  	if (total_fifo_words > SLINK_FIFO_DEPTH)
>  		ret =3D tegra_slink_start_dma_based_transfer(tspi, t);
>  	else
> --=20
> 2.11.0
>=20

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyaOtEACgkQ3SOs138+
s6EE1A//Xgtd5RAaeIlQE1iF6N1TrDkckZBMA+MGB//cbClQCbyK/qoGPSCz+9hz
yariyY0fQlISkIFU2WEHbsI+j5DnKQFZoL7+It+jFyjKDx133yqwCH2RvFVu3GRK
S6NWE2LpRZyj2lCf3wa8YIOuY/vCylF4V8SHjXinhDwfYKkollLOj5tbh9y4vwTz
wOcTBEEc2/TqTZQkMeCQcLrSWT1RgKLwMtSxw/8UlOtOAd+Q9WZ+/aRgfpk2aKH7
WlmCCfdsT+Jg7i10S/vpXJpelGq6sgSB6oTsTFvyGyyLADMkeVfWjsLb67KKHPkQ
FspCeXI+Gz8sPd3eSPpoF+6yBiXAWuQ3xIrk2TJW1ZhcqpIUGc91zHl5zmY9loLL
Zej3ruowHgSMZLdNtw0EzZRqnDkOzz+itkvxPiKUa3T1hJtPierXmHoNlDU/mEtL
uYaPB3CRNOTqXaZT8lcYfRSn15WvcvI4F5wXmQhTY6Dn9bHtt9+qK1mL0/IYGciz
xwrc0E2IuBgwiQzn1EpmsMY++VmWYJuX+1qr2guc9Ol32Ki8cTaHlQ5pVs4x0p1e
+8iAAPF6E3gxdLrJApbc1bgxJ6/EbuC/69bzH23nxQNxJ2A1+rRr41Ba9lYpGT9y
0YceWTQZfq08wPve6U/pEUX913qYJUzAHL+181fUMs89rfdNmh4=
=nMZ4
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
