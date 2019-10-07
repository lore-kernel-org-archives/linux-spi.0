From: Han Xu <han.xu@nxp.com>
Subject: RE: [EXT] [PATCH] spi: spi-fsl-qspi: Clear TDH bits in FLSHCR
 register
Date: Mon, 7 Oct 2019 14:58:57 +0000
Message-ID: <AM6PR04MB4967AA90DEDA889FE721F158979B0@AM6PR04MB4967.eurprd04.prod.outlook.com>
References: <20191007071933.26786-1-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Schrempf Frieder <frieder.schrempf@kontron.de>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191007071933.26786-1-frieder.schrempf@kontron.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: Schrempf Frieder <frieder.schrempf@kontron.de>
> Sent: Monday, October 7, 2019 2:23 AM
> To: Han Xu <han.xu@nxp.com>; Mark Brown <broonie@kernel.org>
> Cc: Schrempf Frieder <frieder.schrempf@kontron.de>; stable@vger.kernel.or=
g;
> linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXT] [PATCH] spi: spi-fsl-qspi: Clear TDH bits in FLSHCR regist=
er
>=20
> Caution: EXT Email
>=20
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> Later versions of the QSPI controller (e.g. in i.MX6UL/ULL and i.MX7) see=
m to have
> an additional TDH setting in the FLSHCR register, that needs to be set in=
 accordance
> with the access mode that is used (DDR or SDR).
>=20
> Previous bootstages such as BootROM or bootloader might have used the DDR
> mode to access the flash. As we currently only use SDR mode, we need to m=
ake
> sure the TDH bits are cleared upon initialization.
>=20
> Fixes: 84d043185dbe ("spi: Add a driver for the Freescale/NXP QuadSPI con=
troller")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  drivers/spi/spi-fsl-qspi.c | 38 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c inde=
x
> c02e24c01136..63c9f7edaf6c 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -63,6 +63,11 @@
>  #define QUADSPI_IPCR                   0x08
>  #define QUADSPI_IPCR_SEQID(x)          ((x) << 24)
>=20
> +#define QUADSPI_FLSHCR                 0x0c
> +#define QUADSPI_FLSHCR_TCSS_MASK       GENMASK(3, 0)
> +#define QUADSPI_FLSHCR_TCSH_MASK       GENMASK(11, 8)
> +#define QUADSPI_FLSHCR_TDH_MASK                GENMASK(17, 16)
> +
>  #define QUADSPI_BUF3CR                 0x1c
>  #define QUADSPI_BUF3CR_ALLMST_MASK     BIT(31)
>  #define QUADSPI_BUF3CR_ADATSZ(x)       ((x) << 8)
> @@ -95,6 +100,9 @@
>  #define QUADSPI_FR                     0x160
>  #define QUADSPI_FR_TFF_MASK            BIT(0)
>=20
> +#define QUADSPI_RSER                   0x164
> +#define QUADSPI_RSER_TFIE              BIT(0)
> +
>  #define QUADSPI_SPTRCLR                        0x16c
>  #define QUADSPI_SPTRCLR_IPPTRC         BIT(8)
>  #define QUADSPI_SPTRCLR_BFPTRC         BIT(0)
> @@ -112,9 +120,6 @@
>  #define QUADSPI_LCKER_LOCK             BIT(0)
>  #define QUADSPI_LCKER_UNLOCK           BIT(1)
>=20
> -#define QUADSPI_RSER                   0x164
> -#define QUADSPI_RSER_TFIE              BIT(0)
> -
>  #define QUADSPI_LUT_BASE               0x310
>  #define QUADSPI_LUT_OFFSET             (SEQID_LUT * 4 * 4)
>  #define QUADSPI_LUT_REG(idx) \
> @@ -181,6 +186,12 @@
>   */
>  #define QUADSPI_QUIRK_BASE_INTERNAL    BIT(4)
>=20
> +/*
> + * Controller uses TDH bits in register QUADSPI_FLSHCR.
> + * They need to be set in accordance with the DDR/SDR mode.
> + */
> +#define QUADSPI_QUIRK_USE_TDH_SETTING  BIT(5)
> +
>  struct fsl_qspi_devtype_data {
>         unsigned int rxfifo;
>         unsigned int txfifo;
> @@ -209,7 +220,8 @@ static const struct fsl_qspi_devtype_data imx7d_data =
=3D {
>         .rxfifo =3D SZ_128,
>         .txfifo =3D SZ_512,
>         .ahb_buf_size =3D SZ_1K,
> -       .quirks =3D QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK,
> +       .quirks =3D QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK |
> +                 QUADSPI_QUIRK_USE_TDH_SETTING,
>         .little_endian =3D true,
>  };
>=20
> @@ -217,7 +229,8 @@ static const struct fsl_qspi_devtype_data imx6ul_data=
 =3D {
>         .rxfifo =3D SZ_128,
>         .txfifo =3D SZ_512,
>         .ahb_buf_size =3D SZ_1K,
> -       .quirks =3D QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK,
> +       .quirks =3D QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK |
> +                 QUADSPI_QUIRK_USE_TDH_SETTING,
>         .little_endian =3D true,
>  };
>=20
> @@ -275,6 +288,11 @@ static inline int needs_amba_base_offset(struct fsl_=
qspi *q)
>         return !(q->devtype_data->quirks & QUADSPI_QUIRK_BASE_INTERNAL); =
 }
>=20
> +static inline int needs_tdh_setting(struct fsl_qspi *q) {
> +       return q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING;
> +}
> +
>  /*
>   * An IC bug makes it necessary to rearrange the 32-bit data.
>   * Later chips, such as IMX6SLX, have fixed this bug.
> @@ -710,6 +728,16 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q=
)
>         qspi_writel(q, QUADSPI_MCR_MDIS_MASK |
> QUADSPI_MCR_RESERVED_MASK,
>                     base + QUADSPI_MCR);
>=20
> +       /*
> +        * Previous boot stages (BootROM, bootloader) might have used DDR
> +        * mode and did not clear the TDH bits. As we currently use SDR m=
ode
> +        * only, clear the TDH bits if necessary.
> +        */
> +       if (needs_tdh_setting(q))
> +               qspi_writel(q, qspi_readl(q, base + QUADSPI_FLSHCR) &
> +                           ~QUADSPI_FLSHCR_TDH_MASK,
> +                           base + QUADSPI_FLSHCR);
> +
>         reg =3D qspi_readl(q, base + QUADSPI_SMPR);
>         qspi_writel(q, reg & ~(QUADSPI_SMPR_FSDLY_MASK
>                         | QUADSPI_SMPR_FSPHS_MASK
> --

Acked-by: Han Xu <han.xu@nxp.com>

> 2.17.1
