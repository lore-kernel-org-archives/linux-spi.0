From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi: Add SuperH HSPI prototype driver
Date: Thu, 1 Mar 2012 14:56:17 +0530
Message-ID: <CAM=Q2cv3QBLEWp+rQ9f5onBS1j=wZOes5m-r9fs6Uvfu6bnTkg@mail.gmail.com>
References: <87vcp2tnst.wl%kuninori.morimoto.gx@renesas.com>
	<20120104200548.GH15503@ponder.secretlab.ca>
	<871urd9xq0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <871urd9xq0.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Kuninori,

On Fri, Jan 6, 2012 at 11:30 AM, Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> This patch adds SuperH HSPI driver.
> It is still prototype driver, but has enough function at this point.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
> v1 -> v2
>
> - mdelay() -> msleep()
> - typo fix
> - sizeof(struct hspi_priv) -> sizeof(*hspi)
> - remove "devname"
> - use dev_err() instead of printk(KERN_ERR, )
> - modiry spi_unregister_master() timing
>
> =A0drivers/spi/Kconfig =A0 =A0 =A0 =A0 | =A0 =A06 +
> =A0drivers/spi/Makefile =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/spi/spi-sh-hspi.c =A0 | =A0363 +++++++++++++++++++++++++++++++=
++++++++++++
> =A0include/linux/spi/sh_hspi.h | =A0 34 ++++
> =A04 files changed, 404 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/spi/spi-sh-hspi.c
> =A0create mode 100644 include/linux/spi/sh_hspi.h
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index a1fd73d..33bb33e 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -325,6 +325,12 @@ config SPI_SH_SCI
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0SPI driver for SuperH SCI blocks.
>
> +config SPI_SH_HSPI
> + =A0 =A0 =A0 tristate "SuperH HSPI controller"
> + =A0 =A0 =A0 depends on ARCH_SHMOBILE
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 SPI driver for SuperH HSPI blocks.
> +
> =A0config SPI_STMP3XXX
> =A0 =A0 =A0 =A0tristate "Freescale STMP37xx/378x SPI/SSP controller"
> =A0 =A0 =A0 =A0depends on ARCH_STMP3XXX && SPI_MASTER
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 61c3261..d65e059 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_SPI_S3C64XX) =A0 =A0 =A0 =A0 =A0 =A0 +=3D =
spi-s3c64xx.o
> =A0obj-$(CONFIG_SPI_SH) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi-sh.o
> =A0obj-$(CONFIG_SPI_SH_MSIOF) =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi-sh-msiof.o
> =A0obj-$(CONFIG_SPI_SH_SCI) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi-sh-sci.o
> +obj-$(CONFIG_SPI_SH_HSPI) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi-sh-hspi.o
> =A0obj-$(CONFIG_SPI_STMP3XXX) =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi-stmp.o
> =A0obj-$(CONFIG_SPI_TEGRA) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0+=3D spi-tegra.o
> =A0obj-$(CONFIG_SPI_TI_SSP) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi-ti-ssp.o
> diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
> new file mode 100644
> index 0000000..f527d24
> --- /dev/null
> +++ b/drivers/spi/spi-sh-hspi.c
> @@ -0,0 +1,363 @@
> +/*
> + * SuperH HSPI bus driver
> + *
> + * Copyright (C) 2011 =A0Kuninori Morimoto
> + *
> + * Based on spi-sh.c:
> + * Based on pxa2xx_spi.c:
> + * Copyright (C) 2011 Renesas Solutions Corp.
> + * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA =A002110-13=
01 =A0USA
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/timer.h>
> +#include <linux/delay.h>
> +#include <linux/list.h>
> +#include <linux/workqueue.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/io.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/sh_hspi.h>
> +
> +#define SPCR =A0 0x00
> +#define SPSR =A0 0x04
> +#define SPSCR =A00x08
> +#define SPTBR =A00x0C
> +#define SPRBR =A00x10
> +#define SPCR2 =A00x14
> +
> +/* SPSR */
> +#define RXFL =A0 (1 << 2)
> +
> +#define hspi2info(h) =A0 (h->dev->platform_data)
> +
> +struct hspi_priv {
> + =A0 =A0 =A0 void __iomem *addr;
> + =A0 =A0 =A0 struct spi_master *master;
> + =A0 =A0 =A0 struct list_head queue;
> + =A0 =A0 =A0 struct workqueue_struct *workqueue;
> + =A0 =A0 =A0 struct work_struct ws;
> + =A0 =A0 =A0 struct device *dev;
> + =A0 =A0 =A0 spinlock_t lock;
> +};
> +
> +/*
> + * =A0 =A0 =A0 =A0 =A0 =A0 basic function
> + */
> +static void hspi_write(struct hspi_priv *hspi, int reg, u32 val)
> +{
> + =A0 =A0 =A0 iowrite32(val, hspi->addr + reg);
> +}
> +
> +static u8 hspi_read(struct hspi_priv *hspi, int reg)
> +{
> + =A0 =A0 =A0 return (u8)ioread32(hspi->addr + reg);

You  do a ioread32 and then typecast to u8 Didnt undwerstand?

> +}
> +
> +/*
> + * =A0 =A0 =A0 =A0 =A0 =A0 transfer function
> + */
> +static int hspi_status_check_timeout(struct hspi_priv *hspi, u32 mask, u=
32 val)
> +{
> + =A0 =A0 =A0 int t =3D 256;
> +
> + =A0 =A0 =A0 while (t--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((mask & hspi_read(hspi, SPSR)) =3D=3D v=
al)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(10);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_err(hspi->dev, "timeout\n");
> + =A0 =A0 =A0 return -ETIMEDOUT;
> +}
> +
> +static int hspi_push(struct hspi_priv *hspi, struct spi_message *msg,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct spi_transfer *t)
> +{
> + =A0 =A0 =A0 int i, ret;
> + =A0 =A0 =A0 u8 *data =3D (u8 *)t->tx_buf;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* FIXME
> + =A0 =A0 =A0 =A0* very simple, but polling transfer
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (i =3D 0; i < t->len; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* wait remains */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D hspi_status_check_timeout(hspi, 0x1=
, 0x0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hspi_write(hspi, SPTBR, (u32)data[i]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* wait recive */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D hspi_status_check_timeout(hspi, 0x4=
, 0x4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* dummy read */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hspi_read(hspi, SPRBR);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int hspi_pop(struct hspi_priv *hspi, struct spi_message *msg,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_transfer *t)
> +{
> + =A0 =A0 =A0 int i, ret;
> + =A0 =A0 =A0 u8 *data =3D (u8 *)t->rx_buf;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* FIXME
> + =A0 =A0 =A0 =A0* very simple, but polling receive
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (i =3D 0; i < t->len; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* wait remains */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D hspi_status_check_timeout(hspi, 0x1=
, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* dummy write */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hspi_write(hspi, SPTBR, 0x0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* wait recive */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D hspi_status_check_timeout(hspi, 0x4=
, 0x4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data[i] =3D (u8)hspi_read(hspi, SPRBR);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void hspi_work(struct work_struct *work)
> +{
> + =A0 =A0 =A0 struct hspi_priv *hspi =3D container_of(work, struct hspi_p=
riv, ws);
> + =A0 =A0 =A0 struct sh_hspi_info *info =3D hspi2info(hspi);
> + =A0 =A0 =A0 struct spi_message *msg;
> + =A0 =A0 =A0 struct spi_transfer *t;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 u32 data;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 dev_dbg(hspi->dev, "%s\n", __func__);
> +
> + =A0 =A0 =A0 /************************ pm enable ***********************=
*/
> + =A0 =A0 =A0 pm_runtime_get_sync(hspi->dev);
> +
> + =A0 =A0 =A0 /* setup first of all in under pm_runtime */
> + =A0 =A0 =A0 data =3D SH_HSPI_CLK_DIVC(info->flags);
> +
> + =A0 =A0 =A0 if (info->flags & SH_HSPI_FBS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data |=3D 1 << 7;
> + =A0 =A0 =A0 if (info->flags & SH_HSPI_CLKP_HIGH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data |=3D 1 << 6;
> + =A0 =A0 =A0 if (info->flags & SH_HSPI_IDIV_DIV128)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data |=3D 1 << 5;
> +
> + =A0 =A0 =A0 hspi_write(hspi, SPCR, data);
> + =A0 =A0 =A0 hspi_write(hspi, SPSR, 0x0);
> + =A0 =A0 =A0 hspi_write(hspi, SPSCR, 0x1); =A0 /* master mode */
> +
> + =A0 =A0 =A0 while (1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg =3D NULL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /************************ spin lock *******=
*****************/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&hspi->lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!list_empty(&hspi->queue)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg =3D list_entry(hspi->qu=
eue.next,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct spi_message, queue);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_init(&msg->queue);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&hspi->lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /************************ spin unlock *****=
*******************/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!msg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(t, &msg->transfers, tra=
nsfer_list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->tx_buf) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D hsp=
i_push(hspi, msg, t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 goto error;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->rx_buf) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D hsp=
i_pop(hspi, msg, t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 goto error;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->actual_length +=3D t->=
len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +error:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->status =3D ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->complete(msg->context);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pm_runtime_put_sync(hspi->dev);
> + =A0 =A0 =A0 /************************ pm disable **********************=
**/
> +
> + =A0 =A0 =A0 return;
> +}
> +
> +/*
> + * =A0 =A0 =A0 =A0 =A0 =A0 spi master function
> + */
> +static int hspi_setup(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct hspi_priv *hspi =3D spi_master_get_devdata(spi->mast=
er);
> + =A0 =A0 =A0 struct device *dev =3D hspi->dev;
> +
> + =A0 =A0 =A0 if (8 !=3D spi->bits_per_word) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "bits_per_word should be 8\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s setup\n", spi->modalias);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void hspi_cleanup(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct hspi_priv *hspi =3D spi_master_get_devdata(spi->mast=
er);
> + =A0 =A0 =A0 struct device *dev =3D hspi->dev;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s cleanup\n", spi->modalias);
> +}
> +
> +static int hspi_transfer(struct spi_device *spi, struct spi_message *msg)
> +{
> + =A0 =A0 =A0 struct hspi_priv *hspi =3D spi_master_get_devdata(spi->mast=
er);
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 /************************ spin lock ***********************=
*/
> + =A0 =A0 =A0 spin_lock_irqsave(&hspi->lock, flags);
> +
> + =A0 =A0 =A0 msg->actual_length =A0 =A0 =A0=3D 0;
> + =A0 =A0 =A0 msg->status =A0 =A0 =A0 =A0 =A0 =A0 =3D -EINPROGRESS;
> + =A0 =A0 =A0 list_add_tail(&msg->queue, &hspi->queue);
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&hspi->lock, flags);
> + =A0 =A0 =A0 /************************ spin unlock *********************=
***/
> +
> + =A0 =A0 =A0 queue_work(hspi->workqueue, &hspi->ws);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int __devinit hspi_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 struct spi_master *master;
> + =A0 =A0 =A0 struct hspi_priv *hspi;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 /* get base addr */
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (!res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "invalid resource\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 master =3D spi_alloc_master(&pdev->dev, sizeof(*hspi));
> + =A0 =A0 =A0 if (!master) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "spi_alloc_master error=
.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 hspi =3D spi_master_get_devdata(master);
> + =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, hspi);
> +
> + =A0 =A0 =A0 /* init hspi */
> + =A0 =A0 =A0 hspi->master =A0 =A0=3D master;
> + =A0 =A0 =A0 hspi->dev =A0 =A0 =A0 =3D &pdev->dev;
> + =A0 =A0 =A0 hspi->addr =A0 =A0 =A0=3D ioremap(res->start, resource_size=
(res));
Could we use devm_* functions here


> + =A0 =A0 =A0 if (!hspi->addr) {

<snip>

---------------------------------------------------------------------------=
---
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing =

also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
