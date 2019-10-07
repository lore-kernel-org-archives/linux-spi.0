From: Han Xu <han.xu@nxp.com>
Subject: RE: [PATCH] spi: spi-fsl-qspi: Introduce variable to fix different
 invalid master Id
Date: Mon, 7 Oct 2019 14:56:39 +0000
Message-ID: <AM6PR04MB4967B073EEA50BFEE2F69C6D979B0@AM6PR04MB4967.eurprd04.prod.outlook.com>
References: <1569920356-8953-1-git-send-email-kuldeep.singh@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: Kuldeep Singh <kuldeep.singh@nxp.com>
To: Kuldeep Singh <kuldeep.singh@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1569920356-8953-1-git-send-email-kuldeep.singh@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: Kuldeep Singh <kuldeep.singh@nxp.com>
> Sent: Tuesday, October 1, 2019 3:59 AM
> To: Han Xu <han.xu@nxp.com>; broonie@kernel.org; linux-spi@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org
> Cc: Kuldeep Singh <kuldeep.singh@nxp.com>; Suresh Gupta
> <suresh.gupta@nxp.com>
> Subject: [PATCH] spi: spi-fsl-qspi: Introduce variable to fix different i=
nvalid master Id
>=20
> Different platforms have different Master with different SourceID on AHB =
bus. The
> 0X0E Master ID is used by cluster 3 in case of LS2088A.
> So, patch introduce an invalid master id variable to fix invalid mastered=
 on different
> platforms.
>=20
> Signed-off-by: Suresh Gupta <suresh.gupta@nxp.com>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> ---
>  drivers/spi/spi-fsl-qspi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c inde=
x
> c02e24c..51385b0 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -63,6 +63,11 @@
>  #define QUADSPI_IPCR			0x08
>  #define QUADSPI_IPCR_SEQID(x)		((x) << 24)
>=20
> +#define QUADSPI_BUF0CR                  0x10
> +#define QUADSPI_BUF1CR                  0x14
> +#define QUADSPI_BUF2CR                  0x18
> +#define QUADSPI_BUFXCR_INVALID_MSTRID   0xe
> +
>  #define QUADSPI_BUF3CR			0x1c
>  #define QUADSPI_BUF3CR_ALLMST_MASK	BIT(31)
>  #define QUADSPI_BUF3CR_ADATSZ(x)	((x) << 8)
> @@ -184,6 +189,7 @@
>  struct fsl_qspi_devtype_data {
>  	unsigned int rxfifo;
>  	unsigned int txfifo;
> +	int invalid_mstrid;
>  	unsigned int ahb_buf_size;
>  	unsigned int quirks;
>  	bool little_endian;
> @@ -192,6 +198,7 @@ struct fsl_qspi_devtype_data {  static const struct
> fsl_qspi_devtype_data vybrid_data =3D {
>  	.rxfifo =3D SZ_128,
>  	.txfifo =3D SZ_64,
> +	.invalid_mstrid =3D QUADSPI_BUFXCR_INVALID_MSTRID,
>  	.ahb_buf_size =3D SZ_1K,
>  	.quirks =3D QUADSPI_QUIRK_SWAP_ENDIAN,
>  	.little_endian =3D true,
> @@ -200,6 +207,7 @@ static const struct fsl_qspi_devtype_data vybrid_data=
 =3D
> {  static const struct fsl_qspi_devtype_data imx6sx_data =3D {
>  	.rxfifo =3D SZ_128,
>  	.txfifo =3D SZ_512,
> +	.invalid_mstrid =3D QUADSPI_BUFXCR_INVALID_MSTRID,
>  	.ahb_buf_size =3D SZ_1K,
>  	.quirks =3D QUADSPI_QUIRK_4X_INT_CLK | QUADSPI_QUIRK_TKT245618,
>  	.little_endian =3D true,
> @@ -208,6 +216,7 @@ static const struct fsl_qspi_devtype_data imx6sx_data=
 =3D
> {  static const struct fsl_qspi_devtype_data imx7d_data =3D {
>  	.rxfifo =3D SZ_128,
>  	.txfifo =3D SZ_512,
> +	.invalid_mstrid =3D QUADSPI_BUFXCR_INVALID_MSTRID,
>  	.ahb_buf_size =3D SZ_1K,
>  	.quirks =3D QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK,
>  	.little_endian =3D true,
> @@ -216,6 +225,7 @@ static const struct fsl_qspi_devtype_data imx7d_data =
=3D
> {  static const struct fsl_qspi_devtype_data imx6ul_data =3D {
>  	.rxfifo =3D SZ_128,
>  	.txfifo =3D SZ_512,
> +	.invalid_mstrid =3D QUADSPI_BUFXCR_INVALID_MSTRID,
>  	.ahb_buf_size =3D SZ_1K,
>  	.quirks =3D QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK,
>  	.little_endian =3D true,
> @@ -224,6 +234,7 @@ static const struct fsl_qspi_devtype_data imx6ul_data=
 =3D
> {  static const struct fsl_qspi_devtype_data ls1021a_data =3D {
>  	.rxfifo =3D SZ_128,
>  	.txfifo =3D SZ_64,
> +	.invalid_mstrid =3D QUADSPI_BUFXCR_INVALID_MSTRID,
>  	.ahb_buf_size =3D SZ_1K,
>  	.quirks =3D 0,
>  	.little_endian =3D false,
> @@ -233,6 +244,7 @@ static const struct fsl_qspi_devtype_data ls2080a_dat=
a =3D {
>  	.rxfifo =3D SZ_128,
>  	.txfifo =3D SZ_64,
>  	.ahb_buf_size =3D SZ_1K,
> +	.invalid_mstrid =3D 0x0,
>  	.quirks =3D QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_BASE_INTERNAL,
>  	.little_endian =3D true,
>  };
> @@ -615,6 +627,7 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, cons=
t
> struct spi_mem_op *op)
>  	void __iomem *base =3D q->iobase;
>  	u32 addr_offset =3D 0;
>  	int err =3D 0;
> +	int invalid_mstrid =3D q->devtype_data->invalid_mstrid;
>=20
>  	mutex_lock(&q->lock);
>=20
> @@ -638,6 +651,10 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, con=
st
> struct spi_mem_op *op)
>  	qspi_writel(q, QUADSPI_SPTRCLR_BFPTRC | QUADSPI_SPTRCLR_IPPTRC,
>  		    base + QUADSPI_SPTRCLR);
>=20
> +	qspi_writel(q, invalid_mstrid, base + QUADSPI_BUF0CR);
> +	qspi_writel(q, invalid_mstrid, base + QUADSPI_BUF1CR);
> +	qspi_writel(q, invalid_mstrid, base + QUADSPI_BUF2CR);
> +
>  	fsl_qspi_prepare_lut(q, op);
>=20
>  	/*

Acked-by: Han Xu <han.xu@nxp.com>

> --
> 2.7.4
