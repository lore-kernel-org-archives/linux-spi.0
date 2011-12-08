From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] SPI: add CSR SiRFprimaII SPI controller driver
Date: Thu, 8 Dec 2011 14:15:56 +0100
Message-ID: <20111208131509.GA13430@pengutronix.de>
References: <1322797883-28915-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1650496189210289944=="
Cc: workgroup.linux@csr.com, Song <zhiwu.song@csr.com>,
 grant.likely@secretlab.ca, Barry Song <Baohua.Song@csr.com>,
 spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
To: Barry Song <Barry.Song@csr.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1322797883-28915-1-git-send-email-Barry.Song@csr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============1650496189210289944==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2011 at 11:51:23AM +0800, Barry Song wrote:
> From: Zhiwu Song <zhiwu.song@csr.com>
>=20
> CSR SiRFprimaII has two SPIs (SPI0 and SPI1). Features:
> =E2=96=A0 Master and slave modes
> =E2=96=A0 8-/12-/16-/32-bit data unit
> =E2=96=A0 256 bytes receive data FIFO and 256 bytes transmit data FIFO
> =E2=96=A0 Multi-unit frame
> =E2=96=A0 Configurable SPI_EN (chip select pin) active state
> =E2=96=A0 Configurable SPI_CLK polarity
> =E2=96=A0 Configurable SPI_CLK phase
> =E2=96=A0 Configurable MSB/LSB first

I'd suggest to stick to 7-bit ASCII whenever possible.

>=20
> Signed-off-by: Zhiwu Song <zhiwu.song@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Again, only a rough, more formal review. Mostly looking good, though.

> ---
>  drivers/spi/Kconfig          |    7 +
>  drivers/spi/Makefile         |    1 +
>  drivers/spi/spi-sirf.c       |  629 ++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/spi/spi-sirf.h |   27 ++
>  4 files changed, 664 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/spi-sirf.c
>  create mode 100644 include/linux/spi/spi-sirf.h
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index a1fd73d..784a09e 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -325,6 +325,13 @@ config SPI_SH_SCI
>  	help
>  	  SPI driver for SuperH SCI blocks.
> =20
> +config SPI_SIRF
> +        tristate "CSR SiRFprimaII SPI controller"
> +	depends on ARCH_PRIMA2
> +	select SPI_BITBANG
> +        help
> +          SPI driver for CSR SiRFprimaII SoCs
> +

No spaces for indentation.


>  config SPI_STMP3XXX
>  	tristate "Freescale STMP37xx/378x SPI/SSP controller"
>  	depends on ARCH_STMP3XXX && SPI_MASTER
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 61c3261..e919846 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_SPI_S3C64XX)		+=3D spi-s3c64xx.o
>  obj-$(CONFIG_SPI_SH)			+=3D spi-sh.o
>  obj-$(CONFIG_SPI_SH_MSIOF)		+=3D spi-sh-msiof.o
>  obj-$(CONFIG_SPI_SH_SCI)		+=3D spi-sh-sci.o
> +obj-$(CONFIG_SPI_SIRF)		+=3D spi-sirf.o
>  obj-$(CONFIG_SPI_STMP3XXX)		+=3D spi-stmp.o
>  obj-$(CONFIG_SPI_TEGRA)			+=3D spi-tegra.o
>  obj-$(CONFIG_SPI_TI_SSP)		+=3D spi-ti-ssp.o
> diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
> new file mode 100644
> index 0000000..9c4089b
> --- /dev/null
> +++ b/drivers/spi/spi-sirf.c
> @@ -0,0 +1,629 @@
> +/*
> + * SPI bus driver for CSR SiRFprimaII
> + *
> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group c=
ompany.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/bitops.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi_bitbang.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/spi/spi-sirf.h>
> +
> +#define DRIVER_NAME "sirfsoc_spi"
> +
> +#define SPI_CTRL		0x0000	/* SPI controller configuration register */
> +#define SPI_CMD			0x0004	/* SPI command register */
> +#define SPI_TX_RX_EN		0x0008	/* SPI interface transfer enable register */
> +#define SPI_INT_EN		0x000C	/* SPI interrupt enable register */
> +#define SPI_INT_STATUS		0x0010	/* SPI interrupt register */
> +#define SPI_TX_DMA_IO_CTRL	0x0100	/* SPI TXFIFO DMA/IO register */
> +#define SPI_TX_DMA_IO_LEN	0x0104	/* SPI transmit data length register */
> +#define SPI_TXFIFO_CTRL		0x0108	/* SPI TXFIFO control register */
> +#define SPI_TXFIFO_LEVEL_CHK	0x010C	/* SPI TXFIFO check level register */
> +#define SPI_TXFIFO_OP		0x0110	/* SPI TXFIFO operation register */
> +#define SPI_TXFIFO_STATUS	0x0114	/* SPI TXFIFO status register */
> +#define SPI_TXFIFO_DATA		0x0118	/* SPI TXFIFO bottom */
> +#define SPI_RX_DMA_IO_CTRL	0x0120	/* SPI RXFIFO DMA/IO register */
> +#define SPI_RX_DMA_IO_LEN	0x0124	/* SPI receive length register */
> +#define SPI_RXFIFO_CTRL		0x0128	/* SPI RXFIFO control register */
> +#define SPI_RXFIFO_LEVEL_CHK	0x012C	/* SPI RXFIFO check level register */
> +#define SPI_RXFIFO_OP		0x0130	/* SPI RXFIFO operation register */
> +#define SPI_RXFIFO_STATUS	0x0134	/* SPI RXFIFO status register */
> +#define SPI_RXFIFO_DATA		0x0138	/* SPI RXFIFO bottom */
> +#define SLV_RX_SAMPLE_MODE	0x0140	/* Rx sample mode when slave mode */
> +#define DUMMY_DELAY_CTRL	0x0144	/* Control reg when insert dummy delay */
> +
> +/* SPI CTRL register defines */
> +#define SLV_MODE		BIT(16)
> +#define CMD_MODE		BIT(17)
> +#define CS_IO_OUT		BIT(18)
> +#define CS_IO_MODE		BIT(19)
> +#define CLK_IDLE_STAT		BIT(20)
> +#define CS_IDLE_STAT		BIT(21)
> +#define TRAN_MSB		BIT(22)
> +#define DRV_POS_EDGE		BIT(23)
> +#define CS_HOLD_TIME		BIT(24)
> +#define CLK_SAMPLE_MODE		BIT(25)
> +#define TRAN_DAT_FORMAT_8	(0<<26)
> +#define TRAN_DAT_FORMAT_12	(1<<26)
> +#define TRAN_DAT_FORMAT_16	(2<<26)
> +#define TRAN_DAT_FORMAT_32	(3<<26)
> +#define CMD_BYTE_NUM(x)		((x&3)<<28)

Spaces around operators.

=2E..

> +static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_trans=
fer *t)
> +{
> +	struct sirfsoc_spi *sspi;
> +	u32 word =3D 0;
> +	int timeout =3D t->len * 10;
> +	sspi =3D spi_master_get_devdata(spi->master);
> +
> +	sspi->tx =3D t->tx_buf;
> +	sspi->rx =3D t->rx_buf;
> +	sspi->left_tx_cnt =3D sspi->left_rx_cnt =3D t->len;
> +	INIT_COMPLETION(sspi->done);
> +
> +	writel(INT_MASK_ALL, sspi->base + SPI_INT_STATUS);	/* Clear interrupts =
*/
> +
> +	if (t->len =3D=3D 1) {
> +		writel(readl(sspi->base + SPI_CTRL) | ENA_AUTO_CLR,
> +		       sspi->base + SPI_CTRL);
> +		writel(0, sspi->base + SPI_TX_DMA_IO_LEN);
> +		writel(0, sspi->base + SPI_RX_DMA_IO_LEN);
> +	} else if ((t->len > 1) && (t->len < DATA_FRAME_LEN_MAX)) {
> +		writel(readl(sspi->base + SPI_CTRL) | MUL_DAT_MODE |
> +		       ENA_AUTO_CLR, sspi->base + SPI_CTRL);
> +		writel(t->len - 1, sspi->base + SPI_TX_DMA_IO_LEN);
> +		writel(t->len - 1, sspi->base + SPI_RX_DMA_IO_LEN);
> +	} else {
> +		writel(readl(sspi->base + SPI_CTRL),
> +			sspi->base + SPI_CTRL);
> +		writel(0, sspi->base + SPI_TX_DMA_IO_LEN);
> +		writel(0, sspi->base + SPI_RX_DMA_IO_LEN);
> +	}
> +
> +	writel(FIFO_RESET, sspi->base + SPI_RXFIFO_OP);	/* Reset TX, RX FIFO */
> +	writel(FIFO_RESET, sspi->base + SPI_TXFIFO_OP);
> +	writel(FIFO_START, sspi->base + SPI_RXFIFO_OP);	/* Start FIFOs */
> +	writel(FIFO_START, sspi->base + SPI_TXFIFO_OP);
> +
> +	/* fill up the Tx FIFO */
> +	while (!(readl(sspi->base + SPI_TXFIFO_STATUS) & FIFO_FULL) &&
> +		(sspi->left_tx_cnt > 0)) {
> +		if (sspi->tx)
> +			word =3D sspi->pop_tx_word(sspi);
> +		writel(word, sspi->base + SPI_TXFIFO_DATA);
> +		sspi->left_tx_cnt--;
> +	}
> +	writel(RX_OFLOW_INT_EN | TX_UFLOW_INT_EN | RXFIFO_THD_INT_EN |
> +		TXFIFO_THD_INT_EN | FRM_END_INT_EN | RXFIFO_FULL_INT_EN |
> +		TXFIFO_EMPTY_INT_EN, sspi->base + SPI_INT_EN);
> +	writel(SPI_RX_EN | SPI_TX_EN, sspi->base + SPI_TX_RX_EN); /* RX, TX ena=
ble */
> +
> +	if (wait_for_completion_timeout(&sspi->done, timeout) =3D=3D 0)
> +		dev_err(&spi->dev, "transfer timeout\n");
> +
> +	writel(0, sspi->base + SPI_RXFIFO_OP);	/* TX, RX FIFO stop */
> +	writel(0, sspi->base + SPI_TXFIFO_OP);
> +	writel(0, sspi->base + SPI_TX_RX_EN);	/* RX, TX disable */
> +	writel(0, sspi->base + SPI_INT_EN);	/* Disable all interrupts */

I'd think the comments after all those writel are stating the obvious :)

> +
> +	return t->len - sspi->left_rx_cnt;
> +}
> +

=2E..

> +static int __devinit spi_sirfsoc_probe(struct platform_device *dev)
> +{
> +	struct sirfsoc_spi *sspi;
> +	struct spi_master *master;
> +	struct resource *mem_res;
> +	int ret;
> +
> +	master =3D spi_alloc_master(&dev->dev, sizeof(*sspi));
> +	if (master =3D=3D NULL) {
> +		dev_err(&dev->dev, "Unable to allocate SPI master\n");
> +		return -ENOMEM;
> +	}
> +	platform_set_drvdata(dev, master);
> +	sspi =3D spi_master_get_devdata(master);
> +
> +	mem_res =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (mem_res =3D=3D NULL) {
> +		dev_err(&dev->dev, "Unable to get IO resource\n");
> +		ret =3D -ENOMEM;
> +		goto free_master;
> +	}

devm_request_mem_region() is missing. Or use the new
devm_request_and_ioremap() function (although currently only available
in linux-next).

> +
> +	sspi->base =3D devm_ioremap(&dev->dev, mem_res->start, mem_res->end -
> +		mem_res->start + 1);
> +	if (sspi->base =3D=3D NULL) {
> +		dev_err(&dev->dev, "IO remap failed!\n");
> +		ret =3D -ENOMEM;
> +		goto free_master;
> +	}
> +
> +	if (of_property_read_u32(dev->dev.of_node, "cell-index", &dev->id)) {
> +		dev_err(&dev->dev, "Fail to get index\n");
> +		ret =3D -ENODEV;
> +		goto free_master;
> +	}
> +
> +	sspi->irq =3D platform_get_irq(dev, 0);
> +	if (!sspi->irq) {

Sadly, platform_get_irq returns an errno.

> +		ret =3D -ENODEV;
> +		goto free_master;
> +	}
> +	ret =3D devm_request_irq(&dev->dev, sspi->irq, spi_sirfsoc_irq, 0, DRIV=
ER_NAME, sspi);
> +	if (ret)
> +		goto free_master;

=2E..

> +static int  __devexit spi_sirfsoc_remove(struct platform_device *dev)
> +{
> +	struct spi_master *master;
> +	struct sirfsoc_spi *sspi;
> +
> +	master =3D platform_get_drvdata(dev);
> +	sspi =3D spi_master_get_devdata(master);
> +
> +	spi_bitbang_stop(&sspi->bitbang);
> +	clk_put(sspi->clk);
> +	clk_disable(sspi->clk);

First put then disable?

> +	pinmux_disable(sspi->pmx);
> +	pinmux_put(sspi->pmx);
> +	spi_master_put(master);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int spi_sirfsoc_suspend(struct device *dev)

dev_pm_ops?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7guIwACgkQD27XaX1/VRtEqACeLOPVcqKnmo9AoqIcwf0OPAKT
wKAAoKKmyoQ4HltssL8bqpzj9GB//mc8
=g9LW
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--


--===============1650496189210289944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1650496189210289944==--
