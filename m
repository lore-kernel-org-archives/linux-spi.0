From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/3] davinci: spi: add replacement
	SPI driver
Date: Tue, 29 Jun 2010 16:43:04 -0600
Message-ID: <AANLkTikafbOdPgRBPc8nDChKwm2J_jWZ7JejbYo0rzJg@mail.gmail.com>
References: <1276530901-4413-1-git-send-email-bniebuhr@efjohnson.com>
	<1276530901-4413-2-git-send-email-bniebuhr@efjohnson.com>
	<1276530901-4413-3-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1276530901-4413-3-git-send-email-bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jun 14, 2010 at 9:55 AM, Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
> ---
> =A0arch/arm/mach-davinci/include/mach/spi.h | =A0 41 +-
> =A0drivers/spi/davinci_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0936 ++++=
++++++++++++++++++++++++++
> =A0drivers/spi/davinci_spi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0186 ++++=
++
> =A03 files changed, 1149 insertions(+), 14 deletions(-)
> =A0create mode 100644 drivers/spi/davinci_spi.c
> =A0create mode 100644 drivers/spi/davinci_spi.h
>
> diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-dav=
inci/include/mach/spi.h
> index 910efbf..10c39d8 100644
> --- a/arch/arm/mach-davinci/include/mach/spi.h
> +++ b/arch/arm/mach-davinci/include/mach/spi.h
> @@ -19,26 +19,39 @@
> =A0#ifndef __ARCH_ARM_DAVINCI_SPI_H
> =A0#define __ARCH_ARM_DAVINCI_SPI_H
>
> +#define SPI_INTERN_CS =A00xFF
> +
> +/* resource flags for IORESOURCE_DMA resources */
> +#define IORESOURCE_DMA_RX_CHAN =A0 =A0 =A0 =A0 0x01
> +#define IORESOURCE_DMA_TX_CHAN =A0 =A0 =A0 =A0 0x02
> +#define IORESOURCE_DMA_EVENT_Q =A0 =A0 =A0 =A0 0x04
> +
> =A0enum {
> - =A0 =A0 =A0 SPI_VERSION_1, /* For DM355/DM365/DM6467 */
> + =A0 =A0 =A0 SPI_VERSION_1, /* For DM355/DM365/DM6467*/

Unrelated whitespace damage.

> =A0 =A0 =A0 =A0SPI_VERSION_2, /* For DA8xx */
> =A0};
>
> =A0struct davinci_spi_platform_data {
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0version;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0num_chipselect;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0wdelay;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0odd_parity;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0parity_enable;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0wait_enable;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0timer_disable;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0clk_internal;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0cs_hold;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0intr_level;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0poll_mode;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0use_dma;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0c2tdelay;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0t2cdelay;
> + =A0 =A0 =A0 u16 =A0 =A0 num_chipselect;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0*chip_sel;
> +};

This change isn't bisectable with the next patch.  The structure is
changes, but the users aren't change until the next patch.  Same with
the patch that removes the old driver, it will cause a compile failure
because the C file is deleted if someone bisects between the first
patch and the second.

For the structure change, you need to remove the users before or in
the same patch as removing the structure elements.

For the .c file, I understand wanting to remove the old file
completely to eliminate the noise, but you can probably leave the
header block and the module boilerplate in place so that it doesn't
break the build without doubly modifying the Makefile.

> +
> +struct davinci_spi_config {
> + =A0 =A0 =A0 u32 =A0 =A0 odd_parity:1;
> + =A0 =A0 =A0 u32 =A0 =A0 parity_enable:1;
> + =A0 =A0 =A0 u32 =A0 =A0 intr_level:1;

Use bool instead of u32

> + =A0 =A0 =A0 u32 =A0 =A0 io_type:2;
> +#define SPI_IO_TYPE_INTR =A0 =A00
> +#define SPI_IO_TYPE_POLL =A0 =A01
> +#define SPI_IO_TYPE_DMA =A0 =A0 2
> + =A0 =A0 =A0 u32 =A0 =A0 bytes_per_word:2;
> + =A0 =A0 =A0 u32 =A0 =A0 wdelay:6;

Just use an int instead of a bitfields.  This is just a config structure.

> + =A0 =A0 =A0 u32 =A0 =A0 timer_disable:1;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0c2t_delay;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0t2c_delay;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0t2e_delay;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0c2e_delay;
> =A0};
>
> =A0#endif /* __ARCH_ARM_DAVINCI_SPI_H */
> diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
> new file mode 100644
> index 0000000..0bed840
> --- /dev/null
> +++ b/drivers/spi/davinci_spi.c
> @@ -0,0 +1,936 @@
> +/*
> + * Copyright (C) 2009 Texas Instruments.
> + * Copyright (C) 2010 EF Johnson Technologies
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =A002111-130=
7 =A0USA
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/gpio.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi_bitbang.h>
> +
> +#include <mach/spi.h>
> +#include <mach/edma.h>
> +
> +#include "davinci_spi.h"
> +
> +#define =A0 =A0 =A0 =A0DAVINCI_SPI_NO_RESOURCE =A0 =A0 =A0 =A0 ((resourc=
e_size_t)-1)
> +
> +static void davinci_spi_rx_buf_u8(u32 data, struct davinci_spi *davinci_=
spi)
> +{
> + =A0 =A0 =A0 if (davinci_spi->rx) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 *rx =3D davinci_spi->rx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rx++ =3D (u8)data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->rx =3D rx;
> + =A0 =A0 =A0 }
> +}
> +
> +static void davinci_spi_rx_buf_u16(u32 data, struct davinci_spi *davinci=
_spi)
> +{
> + =A0 =A0 =A0 if (davinci_spi->rx) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 *rx =3D davinci_spi->rx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rx++ =3D (u16)data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->rx =3D rx;
> + =A0 =A0 =A0 }
> +}
> +
> +static u32 davinci_spi_tx_buf_u8(struct davinci_spi *davinci_spi)
> +{
> + =A0 =A0 =A0 u32 data =3D 0;
> + =A0 =A0 =A0 if (davinci_spi->tx) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u8 *tx =3D davinci_spi->tx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D *tx++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->tx =3D tx;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return data;
> +}
> +
> +static u32 davinci_spi_tx_buf_u16(struct davinci_spi *davinci_spi)
> +{
> + =A0 =A0 =A0 u32 data =3D 0;
> + =A0 =A0 =A0 if (davinci_spi->tx) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u16 *tx =3D davinci_spi->tx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D *tx++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->tx =3D tx;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return data;
> +}
> +
> +static inline void set_io_bits(void __iomem *addr, u32 bits)
> +{
> + =A0 =A0 =A0 u32 v =3D ioread32(addr);
> +
> + =A0 =A0 =A0 v |=3D bits;
> + =A0 =A0 =A0 iowrite32(v, addr);
> +}
> +
> +static inline void clear_io_bits(void __iomem *addr, u32 bits)
> +{
> + =A0 =A0 =A0 u32 v =3D ioread32(addr);
> +
> + =A0 =A0 =A0 v &=3D ~bits;
> + =A0 =A0 =A0 iowrite32(v, addr);
> +}
> +
> +/*
> + * Interface to control the chip select signal
> + */
> +static void davinci_spi_chipselect(struct spi_device *spi, int value)
> +{
> + =A0 =A0 =A0 struct davinci_spi *davinci_spi;
> + =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
> + =A0 =A0 =A0 u8 i, chip_sel =3D spi->chip_select;
> + =A0 =A0 =A0 u32 spidat1;
> + =A0 =A0 =A0 u16 spidat1_cfg;
> +
> + =A0 =A0 =A0 davinci_spi =3D spi_master_get_devdata(spi->master);
> + =A0 =A0 =A0 pdata =3D davinci_spi->pdata;
> +
> + =A0 =A0 =A0 spidat1 =3D SPIDAT1_CSNR_MASK;
> + =A0 =A0 =A0 if (value =3D=3D BITBANG_CS_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 |=3D SPIDAT1_CSHOLD_MASK;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 |=3D SPIDAT1_WDEL_MASK;
> +
> + =A0 =A0 =A0 if (pdata->chip_sel =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value =3D=3D BITBANG_CS_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 &=3D ~((0x1 << chip=
_sel) << SPIDAT1_CSNR_SHIFT);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->num_chipselect; i+=
+) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->chip_sel[i] =3D=
=3D SPI_INTERN_CS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i =3D=
=3D chip_sel) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (va=
lue =3D=3D BITBANG_CS_ACTIVE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spidat1 &=3D ~((0x1 << chip_sel)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 << SPIDAT1_CSNR_SHIFT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value =
=3D=3D BITBANG_CS_INACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 gpio_set_value(pdata->chip_sel[i], 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (i =
=3D=3D chip_sel)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 gpio_set_value(pdata->chip_sel[i], 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spidat1_cfg =3D spidat1 >> SPIDAT1_CSNR_SHIFT;
> + =A0 =A0 =A0 iowrite16(spidat1_cfg, davinci_spi->base + SPIDAT1 + 2);
> +}
> +
> +/*
> + * davinci_spi_get_prescale - Calculates the correct prescale value
> + * @max_speed_hz: the maximum rate the SPI clock can run at
> + *
> + * This function calculates the prescale value that generates a clock ra=
te
> + * less than or equal to the specified maximum
> + */
> +static inline u32 davinci_spi_get_prescale(struct davinci_spi *davinci_s=
pi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 u32 max_speed_hz)
> +{
> + =A0 =A0 =A0 return ((clk_get_rate(davinci_spi->clk) - 1) / max_speed_hz=
) & 0xff;
> +}
> +
> +/*
> + * davinci_spi_setup_transfer - This functions will determine transfer m=
ethod
> + * @spi: spi device on which data transfer to be done
> + * @t: spi transfer in which transfer info is filled
> + *
> + * This function determines data transfer method (8/16/32 bit transfer).
> + * It will also set the SPI Clock Control register according to
> + * SPI slave device freq.
> + */
> +static int davinci_spi_setup_transfer(struct spi_device *spi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_transfer *t)
> +{
> + =A0 =A0 =A0 struct davinci_spi *davinci_spi;
> + =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
> + =A0 =A0 =A0 struct davinci_spi_config *spi_cfg;
> + =A0 =A0 =A0 u8 bits_per_word =3D 0;
> + =A0 =A0 =A0 u32 hz =3D 0, spifmt =3D 0, prescale, delay =3D 0;
> +
> + =A0 =A0 =A0 davinci_spi =3D spi_master_get_devdata(spi->master);
> + =A0 =A0 =A0 pdata =3D davinci_spi->pdata;
> + =A0 =A0 =A0 spi_cfg =3D spi->controller_data;
> +
> + =A0 =A0 =A0 if (t) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bits_per_word =3D t->bits_per_word;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hz =3D t->speed_hz;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* if bits_per_word is not set then set it default */
> + =A0 =A0 =A0 if (!bits_per_word)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bits_per_word =3D spi->bits_per_word;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Assign function pointer to appropriate transfer method
> + =A0 =A0 =A0 =A0* 8bit, 16bit or 32bit transfer
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (bits_per_word <=3D 8 && bits_per_word >=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->get_rx =3D davinci_spi_rx_buf_=
u8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->get_tx =3D davinci_spi_tx_buf_=
u8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_cfg->bytes_per_word =3D 1;
> + =A0 =A0 =A0 } else if (bits_per_word <=3D 16 && bits_per_word >=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->get_rx =3D davinci_spi_rx_buf_=
u16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->get_tx =3D davinci_spi_tx_buf_=
u16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_cfg->bytes_per_word =3D 2;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (!hz)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hz =3D spi->max_speed_hz;
> +
> + =A0 =A0 =A0 prescale =3D davinci_spi_get_prescale(davinci_spi, hz);
> + =A0 =A0 =A0 spifmt |=3D (prescale << SPIFMT_PRESCALE_SHIFT);
> +
> + =A0 =A0 =A0 spifmt |=3D (bits_per_word & 0x1f);
> +
> + =A0 =A0 =A0 if (spi->mode & SPI_LSB_FIRST)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_SHIFTDIR_MASK;
> +
> + =A0 =A0 =A0 if (spi->mode & SPI_CPOL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_POLARITY_MASK;
> +
> + =A0 =A0 =A0 if (!(spi->mode & SPI_CPHA))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_PHASE_MASK;
> +
> + =A0 =A0 =A0 if (davinci_spi->version =3D=3D SPI_VERSION_2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D ((spi_cfg->wdelay << SPIFMT_WDE=
LAY_SHIFT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & SPIFMT_WD=
ELAY_MASK);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_cfg->odd_parity)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_ODD_PARI=
TY_MASK;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_cfg->parity_enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_PARITYEN=
A_MASK;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi->mode & SPI_READY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_WAITENA_=
MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delay |=3D (spi_cfg->t2e_de=
lay
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 << SPIDELAY_T2EDELAY_SHIFT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 & SPIDELAY_T2EDELAY_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delay |=3D (spi_cfg->c2e_de=
lay
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 << SPIDELAY_C2EDELAY_SHIFT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 & SPIDELAY_C2EDELAY_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_cfg->timer_disable) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_DISTIMER=
_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delay |=3D (spi_cfg->c2t_de=
lay
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 << SPIDELAY_C2TDELAY_SHIFT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 & SPIDELAY_C2TDELAY_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delay |=3D (spi_cfg->t2c_de=
lay
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 << SPIDELAY_T2CDELAY_SHIFT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 & SPIDELAY_T2CDELAY_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(delay, davinci_spi->base + SPIDEL=
AY);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 iowrite32(spifmt, davinci_spi->base + SPIFMT0);
> +
> + =A0 =A0 =A0 if (spi_cfg->intr_level)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(SPI_INTLVL_1, davinci_spi->base +=
 SPILVL);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(SPI_INTLVL_0, davinci_spi->base +=
 SPILVL);
> +
> + =A0 =A0 =A0 if (spi->mode & SPI_LOOP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPIGCR1_LOO=
PBACK_MASK);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPIGCR1_LOO=
PBACK_MASK);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void davinci_spi_dma_rx_callback(unsigned lch, u16 ch_status, voi=
d *data)
> +{
> + =A0 =A0 =A0 struct davinci_spi *davinci_spi =3D (struct davinci_spi *)d=
ata;
> + =A0 =A0 =A0 struct davinci_spi_dma *davinci_spi_dma;
> + =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
> +
> + =A0 =A0 =A0 davinci_spi_dma =3D &(davinci_spi->dma_channels);
> + =A0 =A0 =A0 pdata =3D davinci_spi->pdata;
> +
> + =A0 =A0 =A0 edma_stop(davinci_spi_dma->dma_rx_channel);
> +
> + =A0 =A0 =A0 if (ch_status =3D=3D DMA_COMPLETE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->rcount =3D 0;
> +
> + =A0 =A0 =A0 complete(&davinci_spi->done);
> +}
> +
> +static void davinci_spi_dma_tx_callback(unsigned lch, u16 ch_status, voi=
d *data)
> +{
> + =A0 =A0 =A0 struct davinci_spi *davinci_spi =3D (struct davinci_spi *)d=
ata;
> + =A0 =A0 =A0 struct davinci_spi_dma *davinci_spi_dma;
> + =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
> +
> + =A0 =A0 =A0 davinci_spi_dma =3D &(davinci_spi->dma_channels);
> + =A0 =A0 =A0 pdata =3D davinci_spi->pdata;
> +
> + =A0 =A0 =A0 edma_stop(davinci_spi_dma->dma_tx_channel);
> +
> + =A0 =A0 =A0 if (ch_status =3D=3D DMA_COMPLETE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->wcount =3D 0;
> +}
> +
> +static int davinci_spi_request_dma(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct davinci_spi *davinci_spi;
> + =A0 =A0 =A0 struct davinci_spi_dma *davinci_spi_dma;
> + =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
> + =A0 =A0 =A0 struct device *sdev;
> + =A0 =A0 =A0 int r;
> +
> + =A0 =A0 =A0 davinci_spi =3D spi_master_get_devdata(spi->master);
> + =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_channels;
> + =A0 =A0 =A0 pdata =3D davinci_spi->pdata;
> + =A0 =A0 =A0 sdev =3D davinci_spi->bitbang.master->dev.parent;
> +
> + =A0 =A0 =A0 r =3D edma_alloc_channel(davinci_spi_dma->dma_rx_sync_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi=
_dma_rx_callback, davinci_spi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi=
_dma->eventq);
> + =A0 =A0 =A0 if (r < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to request DMA channe=
l for MibSPI RX\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D =A0-EAGAIN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto rx_dma_failed;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 davinci_spi_dma->dma_rx_channel =3D r;
> +
> + =A0 =A0 =A0 r =3D edma_alloc_channel(davinci_spi_dma->dma_tx_sync_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi=
_dma_tx_callback, davinci_spi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi=
_dma->eventq);
> + =A0 =A0 =A0 if (r < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to request DMA channe=
l for MibSPI TX\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -EAGAIN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto tx_dma_failed;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 davinci_spi_dma->dma_tx_channel =3D r;
> +
> + =A0 =A0 =A0 r =3D edma_alloc_slot(EDMA_CTLR(davinci_spi_dma->dma_tx_syn=
c_dev),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EDMA_SLOT_A=
NY);
> + =A0 =A0 =A0 if (r < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to request SPI DMA pa=
ram slot\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -EAGAIN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto param_failed;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 davinci_spi_dma->dummy_param_slot =3D r;
> + =A0 =A0 =A0 edma_link(davinci_spi_dma->dummy_param_slot,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi_dma->dummy_param_slot);
> +
> + =A0 =A0 =A0 return 0;
> +
> +param_failed:
> + =A0 =A0 =A0 edma_free_channel(davinci_spi_dma->dma_tx_channel);
> + =A0 =A0 =A0 davinci_spi_dma->dma_tx_channel =3D -1;
> +tx_dma_failed:
> + =A0 =A0 =A0 edma_free_channel(davinci_spi_dma->dma_rx_channel);
> + =A0 =A0 =A0 davinci_spi_dma->dma_rx_channel =3D -1;
> +rx_dma_failed:
> + =A0 =A0 =A0 return r;
> +}
> +
> +/*
> + * davinci_spi_setup - This functions will set default transfer method
> + * @spi: spi device on which data transfer to be done
> + *
> + * This functions sets the default transfer method.
> + */
> +
> +static int davinci_spi_setup(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 int retval =3D 0;
> + =A0 =A0 =A0 struct davinci_spi *davinci_spi;
> + =A0 =A0 =A0 struct davinci_spi_dma *davinci_dma;
> + =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
> + =A0 =A0 =A0 struct davinci_spi_config *spi_cfg;
> + =A0 =A0 =A0 u32 prescale;
> +
> + =A0 =A0 =A0 davinci_spi =3D spi_master_get_devdata(spi->master);
> + =A0 =A0 =A0 pdata =3D davinci_spi->pdata;
> + =A0 =A0 =A0 spi_cfg =3D (struct davinci_spi_config *)spi->controller_da=
ta;
> + =A0 =A0 =A0 davinci_dma =3D &(davinci_spi->dma_channels);
> +
> + =A0 =A0 =A0 /* if bits per word length is zero then set it default 8 */
> + =A0 =A0 =A0 if (!spi->bits_per_word)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->bits_per_word =3D 8;
> +
> + =A0 =A0 =A0 if (!(spi->mode & SPI_NO_CS)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((pdata->chip_sel =3D=3D NULL) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata->chip_sel[spi->chip_select] =
=3D=3D SPI_INTERN_CS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->ba=
se + SPIPC0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 1 << spi->chip_select);
> +
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (spi->mode & SPI_READY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIPC0, SPI=
PC0_SPIENA_MASK);
> +
> + =A0 =A0 =A0 if (spi_cfg->io_type =3D=3D SPI_IO_TYPE_DMA) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_dma =3D &(davinci_spi->dma_channels=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((davinci_dma->dma_tx_sync_dev =3D=3D DA=
VINCI_SPI_NO_RESOURCE) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (davinci_dma->dma_rx_sync_dev =3D=
=3D DAVINCI_SPI_NO_RESOURCE) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (davinci_dma->eventq =3D=3D DAVINCI=
_SPI_NO_RESOURCE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_cfg->io_type =3D SPI_IO=
_TYPE_INTR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if ((davinci_dma->dma_rx_channel =3D=
=3D -1) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(davinci_dma->dma_tx_cha=
nnel =3D=3D -1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D davinci_spi_requ=
est_dma(spi);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Validate desired clock rate
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 prescale =3D davinci_spi_get_prescale(davinci_spi, spi->max=
_speed_hz);
> + =A0 =A0 =A0 if ((prescale < 2) || (prescale > 255))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 return retval;
> +}
> +
> +static void davinci_spi_cleanup(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct davinci_spi *davinci_spi =3D spi_master_get_devdata(=
spi->master);
> + =A0 =A0 =A0 struct davinci_spi_dma *davinci_spi_dma;
> + =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
> +
> + =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_channels;
> + =A0 =A0 =A0 pdata =3D davinci_spi->pdata;
> +
> + =A0 =A0 =A0 if (davinci_spi_dma->dma_rx_channel !=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_channel(davinci_spi_dma->dma_rx_c=
hannel);
> +
> + =A0 =A0 =A0 if (davinci_spi_dma->dma_tx_channel !=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_channel(davinci_spi_dma->dma_tx_c=
hannel);
> +
> + =A0 =A0 =A0 if (davinci_spi_dma->dummy_param_slot !=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_slot(davinci_spi_dma->dummy_param=
_slot);
> +}
> +
> +static int davinci_spi_check_error(struct davinci_spi *davinci_spi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =
int_status)
> +{
> + =A0 =A0 =A0 struct device *sdev =3D davinci_spi->bitbang.master->dev.pa=
rent;
> +
> + =A0 =A0 =A0 if (int_status & SPIFLG_TIMEOUT_MASK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "SPI Time-out Error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (int_status & SPIFLG_DESYNC_MASK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "SPI Desynchronization Error\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (int_status & SPIFLG_BITERR_MASK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "SPI Bit error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (davinci_spi->version =3D=3D SPI_VERSION_2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (int_status & SPIFLG_DLEN_ERR_MASK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "SPI Data Len=
gth Error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (int_status & SPIFLG_PARERR_MASK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "SPI Parity E=
rror\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (int_status & SPIFLG_OVRRUN_MASK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "SPI Data Ove=
rrun error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (int_status & SPIFLG_TX_INTR_MASK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "SPI TX intr =
bit set\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (int_status & SPIFLG_BUF_INIT_ACTIVE_MAS=
K) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "SPI Buffer I=
nit Active\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * davinci_spi_process_events - check for and handle any SPI controller =
events
> + * @davinci_spi - the controller data
> + *
> + * This function will check the SPIFLG register and handle any events th=
at are
> + * detected there
> + */
> +static int davinci_spi_process_events(struct davinci_spi *davinci_spi)
> +{
> + =A0 =A0 =A0 u32 status, tx_data, rx_data, spidat1;
> + =A0 =A0 =A0 u8 tx_word =3D 0;
> +
> + =A0 =A0 =A0 status =3D ioread32(davinci_spi->base + SPIFLG);
> +
> + =A0 =A0 =A0 if ((davinci_spi->version =3D=3D SPI_VERSION_2) &&
> + =A0 =A0 =A0 =A0 =A0 (likely(status & SPIFLG_TX_INTR_MASK)) &&
> + =A0 =A0 =A0 =A0 =A0 (likely(davinci_spi->wcount > 0)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_word =3D 1;
> +
> + =A0 =A0 =A0 if (likely(status & SPIFLG_RX_INTR_MASK)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_data =3D ioread32(davinci_spi->base + SP=
IBUF) & 0xFFFF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->get_rx(rx_data, davinci_spi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->rcount--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((davinci_spi->version !=3D SPI_VERSION_=
2) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (likely(davinci_spi->wcount > 0)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_word =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (unlikely(status & SPIFLG_ERROR_MASK)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->errors =3D (status & SPIFLG_ER=
ROR_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (likely(tx_word)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 =3D ioread32(davinci_spi->base + SP=
IDAT1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->wcount--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_data =3D davinci_spi->get_tx(davinci_spi=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 &=3D 0xFFFF0000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 |=3D (tx_data & 0xFFFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(spidat1, davinci_spi->base + SPID=
AT1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * davinci_spi_txrx_bufs - function which will handle transfer data
> + * @spi: spi device on which data transfer to be done
> + * @t: spi transfer in which transfer info is filled
> + *
> + * This function will put data to be transferred into data register
> + * of SPI controller and then wait until the completion will be marked
> + * by the IRQ Handler.
> + */
> +static int davinci_spi_txrx_bufs(struct spi_device *spi, struct spi_tran=
sfer *t)
> +{
> + =A0 =A0 =A0 struct davinci_spi *davinci_spi;
> + =A0 =A0 =A0 int data_type, ret =3D 0;
> + =A0 =A0 =A0 u32 tx_data, spidat1;
> + =A0 =A0 =A0 u16 tx_buf_count =3D 0, rx_buf_count =3D 0;
> + =A0 =A0 =A0 struct davinci_spi_config *spi_cfg;
> + =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
> + =A0 =A0 =A0 struct davinci_spi_dma *davinci_dma;
> + =A0 =A0 =A0 struct device *sdev;
> + =A0 =A0 =A0 dma_addr_t tx_reg, rx_reg;
> + =A0 =A0 =A0 void *tx_buf, *rx_buf;
> + =A0 =A0 =A0 struct edmacc_param rx_param, tx_param;
> +
> + =A0 =A0 =A0 davinci_spi =3D spi_master_get_devdata(spi->master);
> + =A0 =A0 =A0 pdata =3D davinci_spi->pdata;
> + =A0 =A0 =A0 spi_cfg =3D (struct davinci_spi_config *)spi->controller_da=
ta;
> + =A0 =A0 =A0 davinci_dma =3D &(davinci_spi->dma_channels);
> +
> + =A0 =A0 =A0 davinci_spi->tx =3D t->tx_buf;
> + =A0 =A0 =A0 davinci_spi->rx =3D t->rx_buf;
> + =A0 =A0 =A0 davinci_spi->wcount =3D t->len / spi_cfg->bytes_per_word;
> + =A0 =A0 =A0 davinci_spi->rcount =3D davinci_spi->wcount;
> + =A0 =A0 =A0 davinci_spi->errors =3D 0;
> +
> + =A0 =A0 =A0 spidat1 =3D ioread32(davinci_spi->base + SPIDAT1);
> +
> + =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOW=
N_MASK);
> + =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MAS=
K);
> +
> + =A0 =A0 =A0 INIT_COMPLETION(davinci_spi->done);
> +
> + =A0 =A0 =A0 if ((spi_cfg->io_type =3D=3D SPI_IO_TYPE_INTR) ||
> + =A0 =A0 =A0 =A0 =A0 (spi_cfg->io_type =3D=3D SPI_IO_TYPE_POLL)) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_cfg->io_type =3D=3D SPI_IO_TYPE_INT=
R)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->ba=
se + SPIINT, SPIINT_MASKINT);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* start the transfer */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->wcount--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_data =3D davinci_spi->get_tx(davinci_spi=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 &=3D 0xFFFF0000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 |=3D (tx_data & 0xFFFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(spidat1, davinci_spi->base + SPID=
AT1);
> +
> + =A0 =A0 =A0 } else if (spi_cfg->io_type =3D=3D SPI_IO_TYPE_DMA) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_type =3D spi_cfg->bytes_per_word;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_reg =3D (dma_addr_t)davinci_spi->pbase +=
 SPIDAT1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_reg =3D (dma_addr_t)davinci_spi->pbase +=
 SPIBUF;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->tx_buf) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_buf =3D ((void *)t->tx_b=
uf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_buf_count =3D davinci_sp=
i->wcount;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_buf =3D (void *)davinci_=
spi->tmp_buf;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_buf_count =3D SPI_BUFSIZ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->rx_buf) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_buf =3D (void *)t->rx_bu=
f;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_buf_count =3D davinci_sp=
i->rcount;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_buf =3D (void *)davinci_=
spi->tmp_buf;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_buf_count =3D SPI_BUFSIZ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->tx_dma =3D dma_map_single(&spi->dev, tx_=
buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 tx_buf_count, DMA_TO_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->rx_dma =3D dma_map_single(&spi->dev, rx_=
buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 rx_buf_count, DMA_FROM_DEVICE);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.opt =3D TCINTEN | EDMA_TCC(davinci=
_dma->dma_tx_channel);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.src =3D t->tx_buf ? t->tx_dma : tx=
_reg;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.a_b_cnt =3D davinci_spi->wcount <<=
 16 | data_type;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.dst =3D tx_reg;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.src_dst_bidx =3D t->tx_buf ? data_=
type : 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.link_bcntrld =3D 0xffff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.src_dst_cidx =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.ccnt =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_write_slot(davinci_dma->dma_tx_channel=
, &tx_param);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_link(davinci_dma->dma_tx_channel,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_dma->dummy_para=
m_slot);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.opt =3D TCINTEN | EDMA_TCC(davinci=
_dma->dma_rx_channel);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.src =3D rx_reg;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.a_b_cnt =3D davinci_spi->rcount <<=
 16 | data_type;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.dst =3D t->rx_dma;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.src_dst_bidx =3D (t->rx_buf ? data=
_type : 0) << 16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.link_bcntrld =3D 0xffff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.src_dst_cidx =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.ccnt =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_write_slot(davinci_dma->dma_rx_channel=
, &rx_param);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite16(spidat1 >> SPIDAT1_CSNR_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi=
->base + SPIDAT1 + 2);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_start(davinci_dma->dma_rx_channel);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_start(davinci_dma->dma_tx_channel);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIINT, SPI=
INT_DMA_REQ_EN);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Wait for the transfer to complete */
> + =A0 =A0 =A0 if (spi_cfg->io_type !=3D SPI_IO_TYPE_POLL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_completion_interruptible(&(davinci=
_spi->done));
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((davinci_spi->rcount > 0) && (ret =
=3D=3D 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D davinci_spi_process=
_events(davinci_spi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
> + =A0 =A0 =A0 if (spi_cfg->io_type =3D=3D SPI_IO_TYPE_DMA) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(NULL, t->tx_dma, tx_buf_co=
unt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 DMA_TO_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(NULL, t->rx_dma, rx_buf_co=
unt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 DMA_FROM_DEVICE);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_M=
ASK);
> + =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_=
MASK);
> +
> + =A0 =A0 =A0 if (davinci_spi->errors) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D davinci_spi_check_error(davinci_spi=
, davinci_spi->errors);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if ((davinci_spi->rcount !=3D 0) || (davinci_spi->wcount !=
=3D 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdev =3D davinci_spi->bitbang.master->dev.p=
arent;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(sdev, "SPI data transfer error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return t->len;
> +}
> +
> +/*
> + * davinci_spi_irq - probe function for SPI Master Controller
> + * @irq: IRQ number for this SPI Master
> + * @context_data: structure for SPI Master controller davinci_spi
> + *
> + * ISR will determine that interrupt arrives either for READ or WRITE co=
mmand.
> + * According to command it will do the appropriate action. It will check
> + * transfer length and if it is not zero then dispatch transfer command =
again.
> + * If transfer length is zero then it will indicate the COMPLETION so th=
at
> + * davinci_spi_bufs function can go ahead.
> + */
> +static irqreturn_t davinci_spi_irq(s32 irq, void *context_data)
> +{
> + =A0 =A0 =A0 struct davinci_spi *davinci_spi =3D context_data;
> + =A0 =A0 =A0 int status;
> +
> + =A0 =A0 =A0 status =3D davinci_spi_process_events(davinci_spi);
> + =A0 =A0 =A0 if (unlikely(status !=3D 0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIINT, S=
PIINT_MASKINT);
> +
> + =A0 =A0 =A0 if ((davinci_spi->rcount =3D=3D 0) || (status !=3D 0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete(&(davinci_spi->done));
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +resource_size_t davinci_spi_get_dma_by_flag(struct platform_device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long flag)
> +{
> + =A0 =A0 =A0 struct resource *r;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < 10; i++) {

Bit of a hack in the loop limits.  This is a bit better:

for (i =3D 0; i < dev->num_resources; i++)

Still not efficient, but at least the limits are sane.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D platform_get_resource(dev, IORESOURCE=
_DMA, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((r->flags & flag) =3D=3D flag)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r->start;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return DAVINCI_SPI_NO_RESOURCE;
> +}
> +
> +/*
> + * davinci_spi_probe - probe function for SPI Master Controller
> + * @pdev: platform_device structure which contains plateform specific da=
ta
> + *
> + * According to Linux Device Model this function will be invoked by Linux
> + * with plateform_device struct which contains the device specific info.

platform_device (spelling)

> + * This function will map the SPI controller's memory, register IRQ,
> + * Reset SPI controller and setting its registers to default value.
> + * It will invoke spi_bitbang_start to create work queue so that client =
driver
> + * can register transfer method to work queue.
> + */
> +static int davinci_spi_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct spi_master *master;
> + =A0 =A0 =A0 struct davinci_spi *davinci_spi;
> + =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
> + =A0 =A0 =A0 struct resource *r, *mem;
> + =A0 =A0 =A0 resource_size_t dma_rx_chan =3D DAVINCI_SPI_NO_RESOURCE;
> + =A0 =A0 =A0 resource_size_t dma_tx_chan =3D DAVINCI_SPI_NO_RESOURCE;
> + =A0 =A0 =A0 resource_size_t dma_eventq =3D DAVINCI_SPI_NO_RESOURCE;
> + =A0 =A0 =A0 int i =3D 0, ret =3D 0;
> + =A0 =A0 =A0 u32 spipc0;
> +
> + =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 if (pdata =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 master =3D spi_alloc_master(&pdev->dev, sizeof(struct davin=
ci_spi));
> + =A0 =A0 =A0 if (master =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, master);
> +
> + =A0 =A0 =A0 davinci_spi =3D spi_master_get_devdata(master);
> + =A0 =A0 =A0 if (davinci_spi =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_master;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (r =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_master;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 davinci_spi->pbase =3D r->start;
> + =A0 =A0 =A0 davinci_spi->region_size =3D resource_size(r);
> + =A0 =A0 =A0 davinci_spi->pdata =3D pdata;
> +
> + =A0 =A0 =A0 mem =3D request_mem_region(r->start, davinci_spi->region_si=
ze,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pdev->name);
> + =A0 =A0 =A0 if (mem =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_master;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 davinci_spi->base =3D (struct davinci_spi_reg __iomem *)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioremap(r->start, davinci_s=
pi->region_size);
> + =A0 =A0 =A0 if (davinci_spi->base =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto release_region;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 davinci_spi->irq =3D platform_get_irq(pdev, 0);
> + =A0 =A0 =A0 if (davinci_spi->irq <=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unmap_io;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D request_irq(davinci_spi->irq, davinci_spi_irq, IRQF=
_DISABLED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name(&pdev->dev), d=
avinci_spi);
> + =A0 =A0 =A0 if (ret !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EAGAIN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unmap_io;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Allocate tmp_buf for tx_buf */
> + =A0 =A0 =A0 davinci_spi->tmp_buf =3D kzalloc(SPI_BUFSIZ, GFP_KERNEL);
> + =A0 =A0 =A0 if (davinci_spi->tmp_buf =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 davinci_spi->bitbang.master =3D spi_master_get(master);
> + =A0 =A0 =A0 if (davinci_spi->bitbang.master =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_tmp_buf;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 davinci_spi->clk =3D clk_get(&pdev->dev, NULL);
> + =A0 =A0 =A0 if (IS_ERR(davinci_spi->clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto put_master;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 clk_enable(davinci_spi->clk);
> +
> +
> + =A0 =A0 =A0 master->bus_num =3D pdev->id;
> + =A0 =A0 =A0 master->num_chipselect =3D pdata->num_chipselect;
> + =A0 =A0 =A0 master->setup =3D davinci_spi_setup;
> + =A0 =A0 =A0 master->cleanup =3D davinci_spi_cleanup;
> +
> + =A0 =A0 =A0 davinci_spi->bitbang.chipselect =3D davinci_spi_chipselect;
> + =A0 =A0 =A0 davinci_spi->bitbang.setup_transfer =3D davinci_spi_setup_t=
ransfer;
> + =A0 =A0 =A0 davinci_spi->bitbang.txrx_bufs =3D davinci_spi_txrx_bufs;
> +
> + =A0 =A0 =A0 davinci_spi->version =3D pdata->version;
> +
> + =A0 =A0 =A0 davinci_spi->bitbang.flags =3D SPI_NO_CS | SPI_LSB_FIRST | =
SPI_LOOP;
> + =A0 =A0 =A0 if (davinci_spi->version =3D=3D SPI_VERSION_2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->bitbang.flags |=3D SPI_READY;
> +
> + =A0 =A0 =A0 dma_rx_chan =3D davinci_spi_get_dma_by_flag(pdev, IORESOURC=
E_DMA_RX_CHAN);
> + =A0 =A0 =A0 dma_tx_chan =3D davinci_spi_get_dma_by_flag(pdev, IORESOURC=
E_DMA_TX_CHAN);
> + =A0 =A0 =A0 dma_eventq =A0=3D davinci_spi_get_dma_by_flag(pdev, IORESOU=
RCE_DMA_EVENT_Q);
> + =A0 =A0 =A0 davinci_spi->dma_channels.dma_rx_channel =3D -1;
> + =A0 =A0 =A0 davinci_spi->dma_channels.dma_rx_sync_dev =3D dma_rx_chan;
> + =A0 =A0 =A0 davinci_spi->dma_channels.dma_tx_channel =3D -1;
> + =A0 =A0 =A0 davinci_spi->dma_channels.dma_tx_sync_dev =3D dma_tx_chan;
> + =A0 =A0 =A0 davinci_spi->dma_channels.dummy_param_slot =3D -1;
> + =A0 =A0 =A0 davinci_spi->dma_channels.eventq =3D dma_eventq;
> +
> + =A0 =A0 =A0 davinci_spi->get_rx =3D davinci_spi_rx_buf_u8;
> + =A0 =A0 =A0 davinci_spi->get_tx =3D davinci_spi_tx_buf_u8;
> +
> + =A0 =A0 =A0 init_completion(&davinci_spi->done);
> +
> + =A0 =A0 =A0 /* Reset In/OUT SPI module */
> + =A0 =A0 =A0 iowrite32(0, davinci_spi->base + SPIGCR0);
> + =A0 =A0 =A0 udelay(100);
> + =A0 =A0 =A0 iowrite32(1, davinci_spi->base + SPIGCR0);
> +
> + =A0 =A0 =A0 /* Set up SPIPC0. =A0CS and ENA init is done in davinci_spi=
_setup */
> + =A0 =A0 =A0 spipc0 =3D SPIPC0_DIFUN_MASK | SPIPC0_DOFUN_MASK | SPIPC0_C=
LKFUN_MASK;
> + =A0 =A0 =A0 iowrite32(spipc0, davinci_spi->base + SPIPC0);
> +
> + =A0 =A0 =A0 /* initialize chip selects */
> + =A0 =A0 =A0 if (pdata->chip_sel !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->num_chipselect; i+=
+) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->chip_sel[i] !=3D=
 SPI_INTERN_CS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direct=
ion_output(pdata->chip_sel[i], 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 iowrite32(SPIDEF_CSDEF_MASK, davinci_spi->base + SPIDEF);
> +
> + =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_CLKMOD_MAS=
K);
> + =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_MASTER_MAS=
K);
> + =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_=
MASK);
> +
> + =A0 =A0 =A0 ret =3D spi_bitbang_start(&davinci_spi->bitbang);
> + =A0 =A0 =A0 if (ret !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_clk;
> +
> + =A0 =A0 =A0 dev_info(&pdev->dev, "Controller at 0x%p \n", davinci_spi->=
base);
> +
> + =A0 =A0 =A0 return ret;
> +
> +free_clk:
> + =A0 =A0 =A0 clk_disable(davinci_spi->clk);
> + =A0 =A0 =A0 clk_put(davinci_spi->clk);
> +put_master:
> + =A0 =A0 =A0 spi_master_put(master);
> +free_tmp_buf:
> + =A0 =A0 =A0 kfree(davinci_spi->tmp_buf);
> +err1:
> + =A0 =A0 =A0 free_irq(davinci_spi->irq, davinci_spi);
> +unmap_io:
> + =A0 =A0 =A0 iounmap(davinci_spi->base);
> +release_region:
> + =A0 =A0 =A0 release_mem_region(davinci_spi->pbase, davinci_spi->region_=
size);
> +free_master:
> + =A0 =A0 =A0 kfree(master);
> +err:
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/*
> + * davinci_spi_remove - remove function for SPI Master Controller
> + * @pdev: platform_device structure which contains plateform specific da=
ta
> + *
> + * This function will do the reverse action of davinci_spi_probe function
> + * It will free the IRQ and SPI controller's memory region.
> + * It will also call spi_bitbang_stop to destroy the work queue which was
> + * created by spi_bitbang_start.
> + */
> +static int __exit davinci_spi_remove(struct platform_device *pdev)

__devexit

> +{
> + =A0 =A0 =A0 struct davinci_spi *davinci_spi;
> + =A0 =A0 =A0 struct spi_master *master;
> +
> + =A0 =A0 =A0 master =3D dev_get_drvdata(&pdev->dev);
> + =A0 =A0 =A0 davinci_spi =3D spi_master_get_devdata(master);
> +
> + =A0 =A0 =A0 spi_bitbang_stop(&davinci_spi->bitbang);
> +
> + =A0 =A0 =A0 clk_disable(davinci_spi->clk);
> + =A0 =A0 =A0 clk_put(davinci_spi->clk);
> + =A0 =A0 =A0 spi_master_put(master);
> + =A0 =A0 =A0 kfree(davinci_spi->tmp_buf);
> + =A0 =A0 =A0 free_irq(davinci_spi->irq, davinci_spi);
> + =A0 =A0 =A0 iounmap(davinci_spi->base);
> + =A0 =A0 =A0 release_mem_region(davinci_spi->pbase, davinci_spi->region_=
size);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct platform_driver davinci_spi_driver =3D {
> + =A0 =A0 =A0 .driver.name =3D "spi_davinci",

.driver =3D {
	.name =3D "spi_davinci",
	.owner =3D THIS_MODULE,
},

> + =A0 =A0 =A0 .remove =3D __exit_p(davinci_spi_remove),

__devexit_p()

> +};
> +
> +static int __init davinci_spi_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_probe(&davinci_spi_driver, davinci_s=
pi_probe);
> +}
> +
> +static void __exit davinci_spi_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&davinci_spi_driver);
> +}
> +
> +module_init(davinci_spi_init);
> +module_exit(davinci_spi_exit);

Put the module_init() hook immediately after the davinci_spi_init()
definition to keep the references together.

> +MODULE_DESCRIPTION("TI DaVinci SPI Master Controller Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/spi/davinci_spi.h b/drivers/spi/davinci_spi.h
> new file mode 100644
> index 0000000..462b2a2
> --- /dev/null
> +++ b/drivers/spi/davinci_spi.h
> @@ -0,0 +1,186 @@

This header file is only used by davinci_spi.c.  Please move the
contents of davinci_spi.h into the .c file.  No need to use a header
when only one file includes it.

The driver looks good, but the patch series isn't quite ready for
merging.  The bisect breakage is the most serious concern, followed by
the missing commit messages.  If you respin the series to fix these
problems, then I'll pick it up into my next-spi branch.

Cheers,
g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
