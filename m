From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 01/11] spi-dw: expose platform data stucture.
Date: Wed, 22 Jun 2011 21:47:06 -0600
Message-ID: <BANLkTin9Ouf76VEFRam+eo=H7Gw3Tv6OLA@mail.gmail.com>
References: <1308794413-11069-1-git-send-email-dirk.brandewie@gmail.com> <1308794413-11069-2-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: dirk.brandewie@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308794413-11069-2-git-send-email-dirk.brandewie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 22, 2011 at 8:00 PM,  <dirk.brandewie@gmail.com> wrote:
> From: Dirk Brandewie <dirk.brandewie@gmail.com>
>
> Expose the platform data structure for use by client drivers. ATM
> there are not any in-tree drivers using the driver (that I can
> find). This patch exposes the platform data needed for client drivers=
=2E

?  Why would client drivers want to muck with this configuration?  I
can understand the dw_spi driver being able to have per-spi_device
configuration, but spi_drivers absolutely should not have visibility
into bus-specific details.  Am I misunderstanding something.

g.

>
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---
> =A0drivers/spi/spi-dw.c =A0 =A0 =A0 | =A0 =A03 ---
> =A0drivers/spi/spi-dw.h =A0 =A0 =A0 | =A0 18 +-----------------
> =A0include/linux/spi/spi-dw.h | =A0 42 ++++++++++++++++++++++++++++++=
++++++++++++
> =A03 files changed, 43 insertions(+), 20 deletions(-)
> =A0create mode 100644 include/linux/spi/spi-dw.h
>
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index ece5f69..61f7ed8 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -38,9 +38,6 @@
> =A0#define QUEUE_RUNNING =A00
> =A0#define QUEUE_STOPPED =A01
>
> -#define MRST_SPI_DEASSERT =A0 =A0 =A00
> -#define MRST_SPI_ASSERT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> -
> =A0/* Slave spi_dev related */
> =A0struct chip_data {
> =A0 =A0 =A0 =A0u16 cr0;
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 7a5e78d..92bee30 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -3,6 +3,7 @@
>
> =A0#include <linux/io.h>
> =A0#include <linux/scatterlist.h>
> +#include <linux/spi/spi-dw.h>
>
> =A0/* Bit fields in CTRLR0 */
> =A0#define SPI_DFS_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> @@ -49,11 +50,6 @@
> =A0/* TX RX interrupt level threshold, max can be 256 */
> =A0#define SPI_INT_THRESHOLD =A0 =A0 =A0 =A0 =A0 =A0 =A032
>
> -enum dw_ssi_type {
> - =A0 =A0 =A0 SSI_MOTO_SPI =3D 0,
> - =A0 =A0 =A0 SSI_TI_SSP,
> - =A0 =A0 =A0 SSI_NS_MICROWIRE,
> -};
>
> =A0struct dw_spi_reg {
> =A0 =A0 =A0 =A0u32 =A0 =A0 ctrl0;
> @@ -208,18 +204,6 @@ static inline void spi_umask_intr(struct dw_spi =
*dws, u32 mask)
> =A0 =A0 =A0 =A0dw_writel(dws, imr, new_mask);
> =A0}
>
> -/*
> - * Each SPI slave device to work with dw_api controller should
> - * has such a structure claiming its working mode (PIO/DMA etc),
> - * which can be save in the "controller_data" member of the
> - * struct spi_device
> - */
> -struct dw_spi_chip {
> - =A0 =A0 =A0 u8 poll_mode; =A0 /* 0 for contoller polling mode */
> - =A0 =A0 =A0 u8 type; =A0 =A0 =A0 =A0/* SPI/SSP/Micrwire */
> - =A0 =A0 =A0 u8 enable_dma;
> - =A0 =A0 =A0 void (*cs_control)(u32 command);
> -};
>
> =A0extern int dw_spi_add_host(struct dw_spi *dws);
> =A0extern void dw_spi_remove_host(struct dw_spi *dws);
> diff --git a/include/linux/spi/spi-dw.h b/include/linux/spi/spi-dw.h
> new file mode 100644
> index 0000000..787b154
> --- /dev/null
> +++ b/include/linux/spi/spi-dw.h
> @@ -0,0 +1,42 @@
> +/*
> + *
> + * Copyright (c) 2009, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WI=
THOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public L=
icense for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along with
> + * this program; if not, write to the Free Software Foundation, Inc.=
,
> + * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#ifndef _SPI_DW_H_
> +#define _SPI_DW_H_
> +enum spi_dw_ssi_type {
> + =A0 =A0 =A0 SSI_MOTO_SPI =3D 0,
> + =A0 =A0 =A0 SSI_TI_SSP,
> + =A0 =A0 =A0 SSI_NS_MICROWIRE,
> +};
> +
> +#define MRST_SPI_DEASSERT =A0 =A0 =A00
> +#define MRST_SPI_ASSERT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> +
> +/*
> + * Each SPI slave device to work with dw_api controller should
> + * has such a structure claiming its working mode (PIO/DMA etc),
> + * which can be save in the "controller_data" member of the
> + * struct spi_device
> + */
> +struct spi_dw_chip {
> + =A0 =A0 =A0 u8 poll_mode; =A0 /* 0 for contoller polling mode */
> + =A0 =A0 =A0 u8 type; =A0 =A0 =A0 =A0/* SPI/SSP/Micrwire */
> + =A0 =A0 =A0 u8 enable_dma;
> + =A0 =A0 =A0 void (*cs_control)(u32 command);
> +};
> +#endif
> --
> 1.7.3.4
>
>
> ---------------------------------------------------------------------=
---------
> Simplify data backup and recovery for your virtual environment with v=
Ranger.
> Installation's a snap, and flexible recovery options mean your data i=
s safe,
> secure and there when you need it. Data protection magic?
> Nope - It's vRanger. Get your free trial download today.
> http://p.sf.net/sfu/quest-sfdev2dev
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
