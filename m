From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH spi-next] spi: add Broadcom BCM63xx SPI controller driver
Date: Tue, 22 Nov 2011 13:56:07 +0530
Message-ID: <CAM=Q2cudxgW-B_TEDgBrdk4CFB9LgZqE9db6vDH+MJEgJeCQcg@mail.gmail.com>
References: <1321906615-11392-1-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Tanguy Bouzeloc <tanguy.bouzeloc-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1321906615-11392-1-git-send-email-florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Florian,

On Tue, Nov 22, 2011 at 1:46 AM, Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wro=
te:
> This patch adds support for the SPI controller found on the Broadcom BCM6=
3xx
> SoCs.
>
> Signed-off-by: Tanguy Bouzeloc <tanguy.bouzeloc-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> ---
> The platform related changes have been submitted on the linux-mips ml:
> http://www.linux-mips.org/archives/linux-mips/2011-11/msg00547.html
>
> Ralf, if Grant is okay with that patch, it probably makes sense to merge =
this
> controller via your tree since it depends on the arch/mips/bcm63xx knobs.
>
> =A0drivers/spi/Kconfig =A0 =A0 =A0 | =A0 =A06 +
> =A0drivers/spi/Makefile =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/spi/spi-bcm63xx.c | =A0494 +++++++++++++++++++++++++++++++++++=
++++++++++
> =A03 files changed, 501 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/spi/spi-bcm63xx.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 52e2900..8aecc4e 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -94,6 +94,12 @@ config SPI_AU1550
> =A0 =A0 =A0 =A0 =A0If you say yes to this option, support will be include=
d for the
> =A0 =A0 =A0 =A0 =A0Au1550 SPI controller (may also work with Au1200,Au121=
0,Au1250).
>
> +config SPI_BCM63XX
> + =A0 =A0 =A0 tristate "Broadcom BCM63xx SPI controller"
> + =A0 =A0 =A0 depends on BCM63XX
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 =A0Enable support for the SPI controller on the Broadco=
m BCM63xx SoCs.
> +
> =A0config SPI_BITBANG
> =A0 =A0 =A0 =A0tristate "Utilities for Bitbanging SPI masters"
> =A0 =A0 =A0 =A0help
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 61c3261..be38f73 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_SPI_ALTERA) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=
=3D spi-altera.o
> =A0obj-$(CONFIG_SPI_ATMEL) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0+=3D spi-atmel.o
> =A0obj-$(CONFIG_SPI_ATH79) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0+=3D spi-ath79.o
> =A0obj-$(CONFIG_SPI_AU1550) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi-au1550.o
> +obj-$(CONFIG_SPI_BCM63XX) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi-bcm63xx.o
> =A0obj-$(CONFIG_SPI_BFIN) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi-bfin5x=
x.o
> =A0obj-$(CONFIG_SPI_BFIN_SPORT) =A0 =A0 =A0 =A0 =A0 +=3D spi-bfin-sport.o
> =A0obj-$(CONFIG_SPI_BITBANG) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi-bitbang.o
> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> new file mode 100644
> index 0000000..9f01fc8
> --- /dev/null
> +++ b/drivers/spi/spi-bcm63xx.c
> @@ -0,0 +1,494 @@
> +/*
> + * Broadcom BCM63xx SPI controller support
> + *
> + * Copyright (C) 2009-2011 Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> + * Copyright (C) 2010 Tanguy Bouzeloc <tanguy.bouzeloc-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the
> + * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/spi/spi.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +
> +#include <bcm63xx_dev_spi.h>
> +
> +#define PFX =A0 =A0 =A0 =A0 =A0 =A0KBUILD_MODNAME
> +#define DRV_VER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"0.1.2"
> +
> +struct bcm63xx_spi {
> + =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stopping;
> + =A0 =A0 =A0 struct completion =A0 =A0 =A0 done;
> +
> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*regs;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
> +
> + =A0 =A0 =A0 /* Platform data */
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed_hz;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fifo_size;
> +
> + =A0 =A0 =A0 /* Data buffers */
> + =A0 =A0 =A0 const unsigned char =A0 =A0 *tx_ptr;
> + =A0 =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 *rx_ptr;
> +
> + =A0 =A0 =A0 /* data iomem */
> + =A0 =A0 =A0 u8 __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0*tx_io;
> + =A0 =A0 =A0 const u8 __iomem =A0 =A0 =A0 =A0*rx_io;
> +
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 remaining_bytes;
> +
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk;
> + =A0 =A0 =A0 struct platform_device =A0*pdev;
> +};
> +
> +static inline u8 bcm_spi_readb(struct bcm63xx_spi *bs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned in=
t offset)
> +{
> + =A0 =A0 =A0 return bcm_readw(bs->regs + bcm63xx_spireg(offset));
> +}
> +
> +static inline u16 bcm_spi_readw(struct bcm63xx_spi *bs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned in=
t offset)
> +{
> + =A0 =A0 =A0 return bcm_readw(bs->regs + bcm63xx_spireg(offset));
> +}
> +
> +static inline void bcm_spi_writeb(struct bcm63xx_spi *bs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 valu=
e, unsigned int offset)
> +{
> + =A0 =A0 =A0 bcm_writeb(value, bs->regs + bcm63xx_spireg(offset));
> +}
> +
> +static inline void bcm_spi_writew(struct bcm63xx_spi *bs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 val=
ue, unsigned int offset)
> +{
> + =A0 =A0 =A0 bcm_writew(value, bs->regs + bcm63xx_spireg(offset));
> +}
> +
> +static int bcm63xx_spi_setup_transfer(struct spi_device *spi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct spi_transfer *t)
> +{
> + =A0 =A0 =A0 struct bcm63xx_spi *bs =3D spi_master_get_devdata(spi->mast=
er);
> + =A0 =A0 =A0 u8 bits_per_word;
> + =A0 =A0 =A0 u8 clk_cfg;
> + =A0 =A0 =A0 u32 hz;
> + =A0 =A0 =A0 unsigned int div;
> +
> + =A0 =A0 =A0 bits_per_word =3D (t) ? t->bits_per_word : spi->bits_per_wo=
rd;
> + =A0 =A0 =A0 hz =3D (t) ? t->speed_hz : spi->max_speed_hz;
> + =A0 =A0 =A0 if (bits_per_word !=3D 8) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "%s, unsupported bits_pe=
r_word=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, bits_per_word);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (spi->chip_select > spi->master->num_chipselect) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "%s, unsupported slave %=
d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, spi->chip_select);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Check clock setting */
> + =A0 =A0 =A0 div =3D (bs->speed_hz / hz);
> + =A0 =A0 =A0 switch (div) {
> + =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_cfg =3D SPI_CLK_25MHZ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_cfg =3D SPI_CLK_12_50MHZ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 8:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_cfg =3D SPI_CLK_6_250MHZ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 16:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_cfg =3D SPI_CLK_3_125MHZ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 32:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_cfg =3D SPI_CLK_1_563MHZ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 64:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_cfg =3D SPI_CLK_0_781MHZ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 128:
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set to slowest mode for compatibility */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_cfg =3D SPI_CLK_0_391MHZ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 bcm_spi_writeb(bs, clk_cfg, SPI_CLK_CFG);
> + =A0 =A0 =A0 dev_dbg(&spi->dev, "Setting clock register to %d (hz %d, cm=
d %02x)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 div, hz, clk_cfg);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/* the spi->mode bits understood by this driver: */
> +#define MODEBITS (SPI_CPOL | SPI_CPHA)
> +
> +static int bcm63xx_spi_setup(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct bcm63xx_spi *bs;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 bs =3D spi_master_get_devdata(spi->master);
> +
> + =A0 =A0 =A0 if (bs->stopping)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ESHUTDOWN;
> +
> + =A0 =A0 =A0 if (!spi->bits_per_word)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->bits_per_word =3D 8;
> +
> + =A0 =A0 =A0 if (spi->mode & ~MODEBITS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "%s, unsupported mode bi=
ts %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, spi->mode & ~MODE=
BITS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D bcm63xx_spi_setup_transfer(spi, NULL);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "setup: unsupported mode=
 bits %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->mode & ~MODEBITS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec/bit\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, spi->mode & MODEBITS, spi->bits_p=
er_word, 0);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/* Fill the TX FIFO with as many bytes as possible */
> +static void bcm63xx_spi_fill_tx_fifo(struct bcm63xx_spi *bs)
> +{
> + =A0 =A0 =A0 u8 size;
> +
> + =A0 =A0 =A0 /* Fill the Tx FIFO with as many bytes as possible */
> + =A0 =A0 =A0 size =3D bs->remaining_bytes < bs->fifo_size ? bs->remainin=
g_bytes :
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bs->fifo_size;
> + =A0 =A0 =A0 memcpy_toio(bs->tx_io, bs->tx_ptr, size);
> + =A0 =A0 =A0 bs->remaining_bytes -=3D size;
> +}
> +
> +static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer=
 *t)
> +{
> + =A0 =A0 =A0 struct bcm63xx_spi *bs =3D spi_master_get_devdata(spi->mast=
er);
> + =A0 =A0 =A0 u16 msg_ctl;
> + =A0 =A0 =A0 u16 cmd;
> +
> + =A0 =A0 =A0 dev_dbg(&spi->dev, "txrx: tx %p, rx %p, len %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->tx_buf, t->rx_buf, t->len);
> +
> + =A0 =A0 =A0 /* Transmitter is inhibited */
> + =A0 =A0 =A0 bs->tx_ptr =3D t->tx_buf;
> + =A0 =A0 =A0 bs->rx_ptr =3D t->rx_buf;
> + =A0 =A0 =A0 init_completion(&bs->done);
> +
> + =A0 =A0 =A0 if (t->tx_buf) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bs->remaining_bytes =3D t->len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcm63xx_spi_fill_tx_fifo(bs);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Enable the command done interrupt which
> + =A0 =A0 =A0 =A0* we use to determine completion of a command */
> + =A0 =A0 =A0 bcm_spi_writeb(bs, SPI_INTR_CMD_DONE, SPI_INT_MASK);
> +
> + =A0 =A0 =A0 /* Fill in the Message control register */
> + =A0 =A0 =A0 msg_ctl =3D (t->len << SPI_BYTE_CNT_SHIFT);
> +
> + =A0 =A0 =A0 if (t->rx_buf && t->tx_buf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg_ctl |=3D (SPI_FD_RW << SPI_MSG_TYPE_SHI=
FT);
> + =A0 =A0 =A0 else if (t->rx_buf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg_ctl |=3D (SPI_HD_R << SPI_MSG_TYPE_SHIF=
T);
> + =A0 =A0 =A0 else if (t->tx_buf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg_ctl |=3D (SPI_HD_W << SPI_MSG_TYPE_SHIF=
T);
> +
> + =A0 =A0 =A0 bcm_spi_writew(bs, msg_ctl, SPI_MSG_CTL);
> +
> + =A0 =A0 =A0 /* Issue the transfer */
> + =A0 =A0 =A0 cmd =3D SPI_CMD_START_IMMEDIATE;
> + =A0 =A0 =A0 cmd |=3D (0 << SPI_CMD_PREPEND_BYTE_CNT_SHIFT);
> + =A0 =A0 =A0 cmd |=3D (spi->chip_select << SPI_CMD_DEVICE_ID_SHIFT);
> + =A0 =A0 =A0 bcm_spi_writew(bs, cmd, SPI_CMD);
> + =A0 =A0 =A0 wait_for_completion(&bs->done);
> +
> + =A0 =A0 =A0 /* Disable the CMD_DONE interrupt */
> + =A0 =A0 =A0 bcm_spi_writeb(bs, 0, SPI_INT_MASK);
> +
> + =A0 =A0 =A0 return t->len - bs->remaining_bytes;
> +}
> +
> +static int bcm63xx_transfer(struct spi_device *spi, struct spi_message *=
m)
> +{
> + =A0 =A0 =A0 struct bcm63xx_spi *bs =3D spi_master_get_devdata(spi->mast=
er);
> + =A0 =A0 =A0 struct spi_transfer *t;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (unlikely(list_empty(&m->transfers)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (bs->stopping)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ESHUTDOWN;
> +
> + =A0 =A0 =A0 list_for_each_entry(t, &m->transfers, transfer_list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret +=3D bcm63xx_txrx_bufs(spi, t);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 m->complete(m->context);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/* This driver supports single master mode only. Hence
> + * CMD_DONE is the only interrupt we care about
> + */
> +static irqreturn_t bcm63xx_spi_interrupt(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct spi_master *master =3D (struct spi_master *)dev_id;
> + =A0 =A0 =A0 struct bcm63xx_spi *bs =3D spi_master_get_devdata(master);
> + =A0 =A0 =A0 u8 intr;
> + =A0 =A0 =A0 u16 cmd;
> +
> + =A0 =A0 =A0 /* Read interupts and clear them immediately */
> + =A0 =A0 =A0 intr =3D bcm_spi_readb(bs, SPI_INT_STATUS);
> + =A0 =A0 =A0 bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
> + =A0 =A0 =A0 bcm_spi_writeb(bs, 0, SPI_INT_MASK);
> +
> + =A0 =A0 =A0 /* A tansfer completed */
> + =A0 =A0 =A0 if (intr & SPI_INTR_CMD_DONE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 rx_tail;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_tail =3D bcm_spi_readb(bs, SPI_RX_TAIL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read out all the data */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rx_tail)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy_fromio(bs->rx_ptr, b=
s->rx_io, rx_tail);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* See if there is more data to send */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bs->remaining_bytes > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcm63xx_spi_fill_tx_fifo(bs=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Start the transfer */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcm_spi_writew(bs, SPI_HD_W=
 << SPI_MSG_TYPE_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SPI_MSG_CTL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd =3D bcm_spi_readw(bs, S=
PI_CMD);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd |=3D SPI_CMD_START_IMME=
DIATE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd |=3D (0 << SPI_CMD_PREP=
END_BYTE_CNT_SHIFT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcm_spi_writeb(bs, SPI_INTR=
_CMD_DONE, SPI_INT_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcm_spi_writew(bs, cmd, SPI=
_CMD);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete(&bs->done);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +
> +static int __init bcm63xx_spi_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct resource *r;
> + =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
> + =A0 =A0 =A0 struct bcm63xx_spi_pdata *pdata =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 struct spi_master *master;
> + =A0 =A0 =A0 struct clk *clk;
> + =A0 =A0 =A0 struct bcm63xx_spi *bs;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (!r) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no iomem\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 irq =3D platform_get_irq(pdev, 0);
> + =A0 =A0 =A0 if (irq < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no irq\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clk =3D clk_get(dev, "spi");
> + =A0 =A0 =A0 if (IS_ERR(clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no clock for device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 master =3D spi_alloc_master(dev, sizeof(*bs));
> + =A0 =A0 =A0 if (!master) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "out of memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 bs =3D spi_master_get_devdata(master);
> + =A0 =A0 =A0 init_completion(&bs->done);
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, master);
> + =A0 =A0 =A0 bs->pdev =3D pdev;
> +
> + =A0 =A0 =A0 if (!request_mem_region(r->start, resource_size(r), PFX)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "iomem request failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_put_master;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 bs->regs =3D ioremap_nocache(r->start, resource_size(r));
> + =A0 =A0 =A0 if (!bs->regs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "unable to ioremap regs\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_put_master;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 bs->irq =3D irq;
> + =A0 =A0 =A0 bs->clk =3D clk;
> + =A0 =A0 =A0 bs->fifo_size =3D pdata->fifo_size;
> +
> + =A0 =A0 =A0 ret =3D request_irq(irq, bcm63xx_spi_interrupt, 0, pdev->na=
me, master);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "unable to request irq\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_unmap;
> + =A0 =A0 =A0 }
Could this be a threaded irq ?
> +
> + =A0 =A0 =A0 master->bus_num =3D pdata->bus_num;
> + =A0 =A0 =A0 master->num_chipselect =3D pdata->num_chipselect;
> + =A0 =A0 =A0 master->setup =3D bcm63xx_spi_setup;
> + =A0 =A0 =A0 master->transfer =3D bcm63xx_transfer;
> + =A0 =A0 =A0 bs->speed_hz =3D pdata->speed_hz;
> + =A0 =A0 =A0 bs->stopping =3D 0;
> + =A0 =A0 =A0 bs->tx_io =3D (u8 *)(bs->regs + bcm63xx_spireg(SPI_MSG_DATA=
));
> + =A0 =A0 =A0 bs->rx_io =3D (const u8 *)(bs->regs + bcm63xx_spireg(SPI_RX=
_DATA));
> + =A0 =A0 =A0 spin_lock_init(&bs->lock);
> +
> + =A0 =A0 =A0 /* Initialize hardware */
> + =A0 =A0 =A0 clk_enable(bs->clk);
> + =A0 =A0 =A0 bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
> +
> + =A0 =A0 =A0 /* register and we are done */
> + =A0 =A0 =A0 ret =3D spi_register_master(master);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "spi register failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_reset_hw;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_info(dev, "at 0x%08x (irq %d, FIFOs size %d) v%s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r->start, irq, bs->fifo_size, DRV_VER);
> +
> + =A0 =A0 =A0 return 0;
> +
> +out_reset_hw:
> + =A0 =A0 =A0 clk_disable(clk);
> + =A0 =A0 =A0 free_irq(irq, master);
> +out_unmap:
> + =A0 =A0 =A0 iounmap(bs->regs);
> +out_put_master:
> + =A0 =A0 =A0 spi_master_put(master);
> +out_free:
> + =A0 =A0 =A0 clk_put(clk);
> +out:
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int __exit bcm63xx_spi_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct spi_master *master =3D platform_get_drvdata(pdev);
> + =A0 =A0 =A0 struct bcm63xx_spi *bs =3D spi_master_get_devdata(master);
> + =A0 =A0 =A0 struct resource *r =3D platform_get_resource(pdev, IORESOUR=
CE_MEM, 0);
> +
> + =A0 =A0 =A0 /* reset spi block */
> + =A0 =A0 =A0 bcm_spi_writeb(bs, 0, SPI_INT_MASK);
> + =A0 =A0 =A0 spin_lock(&bs->lock);
> + =A0 =A0 =A0 bs->stopping =3D 1;
> +
> + =A0 =A0 =A0 /* HW shutdown */
> + =A0 =A0 =A0 clk_disable(bs->clk);
> + =A0 =A0 =A0 clk_put(bs->clk);
> +
> + =A0 =A0 =A0 spin_unlock(&bs->lock);
> +
> + =A0 =A0 =A0 free_irq(bs->irq, master);
> + =A0 =A0 =A0 iounmap(bs->regs);
> + =A0 =A0 =A0 release_mem_region(r->start, r->end - r->start);
> + =A0 =A0 =A0 platform_set_drvdata(pdev, 0);
> + =A0 =A0 =A0 spi_unregister_master(master);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int bcm63xx_spi_suspend(struct platform_device *pdev, pm_message_=
t mesg)
> +{
> + =A0 =A0 =A0 struct spi_master *master =3D platform_get_drvdata(pdev);
> + =A0 =A0 =A0 struct bcm63xx_spi *bs =3D spi_master_get_devdata(master);
> +
> + =A0 =A0 =A0 clk_disable(bs->clk);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int bcm63xx_spi_resume(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct spi_master *master =3D platform_get_drvdata(pdev);
> + =A0 =A0 =A0 struct bcm63xx_spi *bs =3D spi_master_get_devdata(master);
> +
> + =A0 =A0 =A0 clk_enable(bs->clk);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +#else
> +#define bcm63xx_spi_suspend =A0 =A0NULL
> +#define bcm63xx_spi_resume =A0 =A0 NULL
> +#endif
> +
> +static struct platform_driver bcm63xx_spi_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "bcm63xx-spi",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D bcm63xx_spi_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(bcm63xx_spi_remove),
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D bcm63xx_spi_suspend,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D bcm63xx_spi_resume,

Could we move to dev pm ops?
> +};
> +
> +
> +static int __init bcm63xx_spi_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&bcm63xx_spi_driver);
> +}
> +
> +static void __exit bcm63xx_spi_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&bcm63xx_spi_driver);
> +}
> +
> +module_init(bcm63xx_spi_init);
> +module_exit(bcm63xx_spi_exit);
> +
> +MODULE_ALIAS("platform:bcm63xx_spi");
> +MODULE_AUTHOR("Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>");
> +MODULE_AUTHOR("Tanguy Bouzeloc <tanguy.bouzeloc-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>");
> +MODULE_DESCRIPTION("Broadcom BCM63xx SPI Controller driver");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VER);
> --
> 1.7.5.4
>
>
> -------------------------------------------------------------------------=
-----
> All the data continuously generated in your IT infrastructure
> contains a definitive record of customers, application performance,
> security threats, fraudulent activity, and more. Splunk takes this
> data and makes sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-novd2d
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>

---------------------------------------------------------------------------=
---
All the data continuously generated in your IT infrastructure =

contains a definitive record of customers, application performance, =

security threats, fraudulent activity, and more. Splunk takes this =

data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
