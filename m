From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: Applied "spi: tegra114: fix PIO transfer" to the spi tree
Date: Mon, 29 Apr 2019 21:42:39 +0000
Message-ID: <BYAPR12MB33989027C79790E4B3CC827CC2390@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1555363834-32155-2-git-send-email-skomatineni@nvidia.com>
 <20190416163257.956F211281C6@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        "Laxman Dewangan" <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Timo Alho <talho@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416163257.956F211281C6@debutante.sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

I don't see below patches that I see as applied in latest linux-next.
Can you please confirm if they are applied?

Applied "spi: tegra114: fix PIO transfer" to the spi tree
Applied "spi: expand mode support" to the spi tree

Thanks
Sowjanya

> The patch

>   spi: tegra114: fix PIO transfer

> has been applied to the spi tree at

>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.=
1

> All being well this means that it will be integrated into the linux-next =
tree (usually sometime in the next 24 hours) and sent to Linus during the n=
ext merge window (or sooner if it is a bug fix), however if problems are di=
scovered then the patch may be dropped or reverted. =20

> You may get further e-mails resulting from automated or manual testing an=
d review of the tree, please engage with people reporting problems and send=
 followup patches addressing any issues that are reported if needed.

> If any updates are required or you are submitting further changes they sh=
ould be sent as incremental updates against current git, existing patches w=
ill not be replaced.

> Please add any relevant lists and maintainers to the CCs when replying to=
 this mail.

>
> Thanks,
> Mark

>
> From 3f6e3f7843a6a1667ed890ca51a1388fc7bf3429 Mon Sep 17 00:00:00 2001
> From: Sowjanya Komatineni <skomatineni@nvidia.com>
> Date: Mon, 15 Apr 2019 14:30:26 -0700
> Subject: [PATCH] spi: tegra114: fix PIO transfer
>
> This patch fixes PIO mode transfer to use PIO bit in SPI_COMMAND1 registe=
r.
> Current driver uses DMA_EN instead of PIO bit.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/spi/spi-tegra114.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c inde=
x b57f10182fae..21e4fdad013f 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -641,8 +641,9 @@ static int tegra_spi_start_cpu_based_transfer(
>
>  	tspi->is_curr_dma_xfer =3D false;
> =20
> -	val |=3D SPI_DMA_EN;
> -	tegra_spi_writel(tspi, val, SPI_DMA_CTL);
> +	val =3D tspi->command1_reg;
> +	val |=3D SPI_PIO;
> +	tegra_spi_writel(tspi, val, SPI_COMMAND1);
>  	return 0;
>  }
>=20
> --
> 2.20.1
