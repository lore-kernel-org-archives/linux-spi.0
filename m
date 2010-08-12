From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2] spi: add spi_tegra driver
Date: Thu, 12 Aug 2010 13:54:46 -0600
Message-ID: <AANLkTim4nL+Re=qc55CGS+ksq+ACtGe=vqOeGQ3HbQWM@mail.gmail.com>
References: <1280450224-25118-1-git-send-email-ccross@google.com>
	<1281574023-25160-1-git-send-email-konkers@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1281574023-25160-1-git-send-email-konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Erik,

Thanks for the quick respin.  I've got some more comments below, most
of them minor, but there are some questions about the locking model.
I don't see any problem with me picking this driver up into my
next-spi tree once the .26 merge window closes.

g.

On Wed, Aug 11, 2010 at 6:47 PM, Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org> wrote:

Missing patch description.  Give reviewers and future readers some
more details about what hardware this patch adds support for.

> v2 changes:
> =A0from Thierry Reding:
> =A0 =A0* add "select TEGRA_SYSTEM_DMA" to Kconfig
> =A0from Grant Likely:
> =A0 =A0* add oneline description to header
> =A0 =A0* inline references to DRIVER_NAME
> =A0 =A0* inline references to BUSY_TIMEOUT
> =A0 =A0* open coded bytes_per_word()
> =A0 =A0* spi_readl/writel -> spi_tegra_readl/writel
> =A0 =A0* move transfer validation to spi_tegra_transfer
> =A0 =A0* don't request_mem_region iomem as platform bus does that for us
> =A0 =A0* __exit -> __devexit
>
> Signed-off-by: Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> ---
> =A0drivers/spi/Kconfig =A0 =A0 | =A0 =A07 +
> =A0drivers/spi/Makefile =A0 =A0| =A0 =A01 +
> =A0drivers/spi/spi_tegra.c | =A0638 +++++++++++++++++++++++++++++++++++++=
++++++++++
> =A03 files changed, 646 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/spi/spi_tegra.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 91c2f4f..9fdb309 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -298,6 +298,13 @@ config SPI_STMP3XXX
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0SPI driver for Freescale STMP37xx/378x SoC SSP interfa=
ce
>
> +config SPI_TEGRA
> + =A0 =A0 =A0 tristate "Nvidia Tegra SPI controller"
> + =A0 =A0 =A0 depends on ARCH_TEGRA
> + =A0 =A0 =A0 select TEGRA_SYSTEM_DMA
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 SPI driver for NVidia Tegra SoCs
> +
> =A0config SPI_TXX9
> =A0 =A0 =A0 =A0tristate "Toshiba TXx9 SPI controller"
> =A0 =A0 =A0 =A0depends on GENERIC_GPIO && CPU_TX49XX
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index e9cbd18..b6573d8 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_SPI_PPC4xx) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=
=3D spi_ppc4xx.o
> =A0obj-$(CONFIG_SPI_S3C24XX_GPIO) =A0 =A0 =A0 =A0 +=3D spi_s3c24xx_gpio.o
> =A0obj-$(CONFIG_SPI_S3C24XX) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi_s3c24xx_=
hw.o
> =A0obj-$(CONFIG_SPI_S3C64XX) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi_s3c64xx.o
> +obj-$(CONFIG_SPI_TEGRA) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=
=3D spi_tegra.o
> =A0obj-$(CONFIG_SPI_TXX9) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi_txx9.o
> =A0obj-$(CONFIG_SPI_XILINX) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D xilinx_spi.o
> =A0obj-$(CONFIG_SPI_XILINX_OF) =A0 =A0 =A0 =A0 =A0 =A0+=3D xilinx_spi_of.o
> diff --git a/drivers/spi/spi_tegra.c b/drivers/spi/spi_tegra.c
> new file mode 100644
> index 0000000..5afb7a7
> --- /dev/null
> +++ b/drivers/spi/spi_tegra.c
> @@ -0,0 +1,638 @@
> +/*
> + * Driver for Nvidia TEGRA spi controller.
> + *
> + * Copyright (C) 2010 Google, Inc.
> + *
> + * Author:
> + * =A0 =A0 Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#undef DEBUG

Still need to trim this #undef

> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +
> +#include <linux/spi/spi.h>
> +
> +#include <mach/dma.h>
> +
> +#define SLINK_COMMAND =A0 =A0 =A0 =A0 =A00x000
> +#define =A0 BIT_LENGTH(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(((x) & 0x1f) << 0)
> +#define =A0 WORD_SIZE(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((x) & 0x1f) <=
< 5)
> +#define =A0 BOTH_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 10)
> +#define =A0 CS_SW =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 11)
> +#define =A0 CS_VALUE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 12)
> +#define =A0 CS_POLARITY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 13)
> +#define =A0 IDLE_SDA_DRIVE_LOW =A0 =A0 =A0 =A0 =A0 (0 << 16)
> +#define =A0 IDLE_SDA_DRIVE_HIGH =A0 =A0 =A0 =A0 =A0(1 << 16)
> +#define =A0 IDLE_SDA_PULL_LOW =A0 =A0 =A0 =A0 =A0 =A0(2 << 16)
> +#define =A0 IDLE_SDA_PULL_HIGH =A0 =A0 =A0 =A0 =A0 (3 << 16)
> +#define =A0 IDLE_SDA_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(3 << 16)
> +#define =A0 CS_POLARITY1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 20)
> +#define =A0 CK_SDA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 21)
> +#define =A0 CS_POLARITY2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 22)
> +#define =A0 CS_POLARITY3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 23)
> +#define =A0 IDLE_SCLK_DRIVE_LOW =A0 =A0 =A0 =A0 =A0(0 << 24)
> +#define =A0 IDLE_SCLK_DRIVE_HIGH =A0 =A0 =A0 =A0 (1 << 24)
> +#define =A0 IDLE_SCLK_PULL_LOW =A0 =A0 =A0 =A0 =A0 (2 << 24)
> +#define =A0 IDLE_SCLK_PULL_HIGH =A0 =A0 =A0 =A0 =A0(3 << 24)
> +#define =A0 IDLE_SCLK_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 (3 << 24)
> +#define =A0 M_S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 <<=
 28)
> +#define =A0 WAIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 2=
9)
> +#define =A0 GO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <<=
 30)
> +#define =A0 ENB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 <<=
 31)

It's a good idea to prefix all these register #defines with something
driver specific to avoid the possibility of collisions with the global
namespace.

> +
> +#define SLINK_COMMAND2 =A0 =A0 =A0 =A0 0x004
> +#define =A0 LSBFE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 0)
> +#define =A0 SSOE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 1)
> +#define =A0 SPIE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
> +#define =A0 BIDIROE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 6)
> +#define =A0 MODFEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 7)
> +#define =A0 INT_SIZE(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(((x) & 0x1f)=
 << 8)
> +#define =A0 CS_ACTIVE_BETWEEN =A0 =A0 =A0 =A0 =A0 =A0(1 << 17)
> +#define =A0 SS_EN_CS(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(((x) & 0x3) =
<< 18)
> +#define =A0 SS_SETUP(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(((x) & 0x3) =
<< 20)
> +#define =A0 FIFO_REFILLS_0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0 << 22)
> +#define =A0 FIFO_REFILLS_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 22)
> +#define =A0 FIFO_REFILLS_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (2 << 22)
> +#define =A0 FIFO_REFILLS_3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (3 << 22)
> +#define =A0 FIFO_REFILLS_MASK =A0 =A0 =A0 =A0 =A0 =A0(3 << 22)
> +#define =A0 WAIT_PACK_INT(x) =A0 =A0 =A0 =A0 =A0 =A0 (((x) & 0x7) << 26)
> +#define =A0 SPC0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 2=
9)
> +#define =A0 TXEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 3=
0)
> +#define =A0 RXEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 3=
1)
> +
> +#define SLINK_STATUS =A0 =A0 =A0 =A0 =A0 0x008
> +#define =A0 COUNT(val) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((val) >> 0)=
 & 0x1f)
> +#define =A0 WORD(val) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(((val) >> =
5) & 0x1f)
> +#define =A0 BLK_CNT(val) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((val) >> 0) &=
 0xffff)
> +#define =A0 MODF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 1=
6)
> +#define =A0 RX_UNF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 18)
> +#define =A0 TX_OVF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 19)
> +#define =A0 TX_FULL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 20)
> +#define =A0 TX_EMPTY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 21)
> +#define =A0 RX_FULL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 22)
> +#define =A0 RX_EMPTY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 23)
> +#define =A0 TX_UNF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 24)
> +#define =A0 RX_OVF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 25)
> +#define =A0 TX_FLUSH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 26)
> +#define =A0 RX_FLUSH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 27)
> +#define =A0 SCLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 2=
8)
> +#define =A0 ERR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 <<=
 29)
> +#define =A0 RDY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 <<=
 30)
> +#define =A0 BSY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 <<=
 31)
> +
> +#define SLINK_MAS_DATA =A0 =A0 =A0 =A0 0x010
> +#define SLINK_SLAVE_DATA =A0 =A0 =A0 0x014
> +
> +#define SLINK_DMA_CTL =A0 =A0 =A0 =A0 =A00x018
> +#define =A0 DMA_BLOCK_SIZE(x) =A0 =A0 =A0 =A0 =A0 =A0(((x) & 0xffff) << =
0)
> +#define =A0 TX_TRIG_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0 << 16)
> +#define =A0 TX_TRIG_4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 16)
> +#define =A0 TX_TRIG_8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(2 << 16)
> +#define =A0 TX_TRIG_16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (3 << 16)
> +#define =A0 TX_TRIG_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (3 << 16)
> +#define =A0 RX_TRIG_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0 << 18)
> +#define =A0 RX_TRIG_4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 18)
> +#define =A0 RX_TRIG_8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(2 << 18)
> +#define =A0 RX_TRIG_16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (3 << 18)
> +#define =A0 RX_TRIG_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (3 << 18)
> +#define =A0 PACKED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 20)
> +#define =A0 PACK_SIZE_4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0 << 21)
> +#define =A0 PACK_SIZE_8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 21)
> +#define =A0 PACK_SIZE_16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (2 << 21)
> +#define =A0 PACK_SIZE_32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (3 << 21)
> +#define =A0 PACK_SIZE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 (3 << 21)
> +#define =A0 IE_TXC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 26)
> +#define =A0 IE_RXC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 27)
> +#define =A0 DMA_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 31)
> +
> +#define SLINK_STATUS2 =A0 =A0 =A0 =A0 =A00x01c
> +#define =A0 TX_FIFO_EMPTY_COUNT(val) =A0 =A0 (((val) & 0x3f) >> 0)
> +#define =A0 RX_FIFO_FULL_COUNT(val) =A0 =A0 =A0(((val) & 0x3f) >> 16)
> +
> +#define SLINK_TX_FIFO =A0 =A0 =A0 =A0 =A00x100
> +#define SLINK_RX_FIFO =A0 =A0 =A0 =A0 =A00x180
> +
> +static const unsigned long spi_tegra_req_sels[] =3D {
> + =A0 =A0 =A0 TEGRA_DMA_REQ_SEL_SL2B1,
> + =A0 =A0 =A0 TEGRA_DMA_REQ_SEL_SL2B2,
> + =A0 =A0 =A0 TEGRA_DMA_REQ_SEL_SL2B3,
> + =A0 =A0 =A0 TEGRA_DMA_REQ_SEL_SL2B4,
> +};
> +
> +static inline unsigned bytes_per_word(u8 bits)
> +{
> + =A0 =A0 =A0 WARN_ON((bits < 1) || bits > 32);
> + =A0 =A0 =A0 if (bits <=3D 8)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 else if (bits <=3D 16)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 2;
> + =A0 =A0 =A0 else if (bits <=3D 24)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 3;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 4;
> +}

No longer used, can be removed.

> +
> +#define BB_LEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 32
> +
> +struct spi_tegra_data {
> + =A0 =A0 =A0 struct spi_master =A0 =A0 =A0 *master;
> + =A0 =A0 =A0 struct platform_device =A0*pdev;
> + =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
> +
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk;
> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*base;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 phys;
> +
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_speed;
> +
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0queue;
> + =A0 =A0 =A0 struct spi_transfer =A0 =A0 *cur;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cur_pos;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cur_len;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cur_bytes_per_word;
> +
> + =A0 =A0 =A0 /* The tegra spi controller has a bug which causes the firs=
t word
> + =A0 =A0 =A0 =A0* in PIO transactions to be garbage. =A0Since packed DMA=
 transactions
> + =A0 =A0 =A0 =A0* require transfers to be 4 byte aligned we need a bounc=
e buffer
> + =A0 =A0 =A0 =A0* for the generic case.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 struct tegra_dma_req =A0 =A0rx_dma_req;
> + =A0 =A0 =A0 struct tegra_dma_channel *rx_dma;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rx_bb;
> + =A0 =A0 =A0 dma_addr_t =A0 =A0 =A0 =A0 =A0 =A0 =A0rx_bb_phys;
> +};
> +
> +
> +static unsigned long spi_tegra_readl(struct spi_tegra_data *tspi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
unsigned long reg)
> +{
> + =A0 =A0 =A0 return readl(tspi->base + reg);
> +}

static inline

> +
> +static void spi_tegra_writel(struct spi_tegra_data *tspi, unsigned long =
val,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long reg)
> +{
> + =A0 =A0 =A0 writel(val, tspi->base + reg);
> +}

ditto

> +
> +static void spi_tegra_go(struct spi_tegra_data *tspi)
> +{
> + =A0 =A0 =A0 unsigned long val;
> +
> + =A0 =A0 =A0 wmb();
> +
> + =A0 =A0 =A0 val =3D spi_tegra_readl(tspi, SLINK_DMA_CTL);
> + =A0 =A0 =A0 val &=3D ~DMA_BLOCK_SIZE(~0) & ~DMA_EN;
> + =A0 =A0 =A0 val |=3D DMA_BLOCK_SIZE(tspi->rx_dma_req.size / 4 - 1);
> + =A0 =A0 =A0 spi_tegra_writel(tspi, val, SLINK_DMA_CTL);
> +
> + =A0 =A0 =A0 tegra_dma_enqueue_req(tspi->rx_dma, &tspi->rx_dma_req);
> +
> + =A0 =A0 =A0 val |=3D DMA_EN;
> + =A0 =A0 =A0 spi_tegra_writel(tspi, val, SLINK_DMA_CTL);
> +}
> +
> +static unsigned spi_tegra_fill_tx_fifo(struct spi_tegra_data *tspi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
spi_transfer *t)
> +{
> + =A0 =A0 =A0 unsigned len =3D min(t->len - tspi->cur_pos, BB_LEN *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tspi->cur_bytes_per_=
word);
> + =A0 =A0 =A0 u8 *tx_buf =3D (u8 *)t->tx_buf + tspi->cur_pos;
> + =A0 =A0 =A0 int i, j;
> + =A0 =A0 =A0 unsigned long val;
> +
> + =A0 =A0 =A0 val =3D spi_tegra_readl(tspi, SLINK_COMMAND);
> + =A0 =A0 =A0 val &=3D ~WORD_SIZE(~0);
> + =A0 =A0 =A0 val |=3D WORD_SIZE(len / tspi->cur_bytes_per_word - 1);
> + =A0 =A0 =A0 spi_tegra_writel(tspi, val, SLINK_COMMAND);
> +
> + =A0 =A0 =A0 for (i =3D 0; i < len; i +=3D tspi->cur_bytes_per_word) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < tspi->cur_bytes_per_word;=
 j++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D tx_buf[i + j] << j=
 * 8;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_tegra_writel(tspi, val, SLINK_TX_FIFO);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tspi->rx_dma_req.size =3D len / tspi->cur_bytes_per_word * =
4;
> +
> + =A0 =A0 =A0 return len;
> +}
> +
> +static unsigned spi_tegra_drain_rx_fifo(struct spi_tegra_data *tspi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
spi_transfer *t)
> +{
> + =A0 =A0 =A0 unsigned len =3D tspi->cur_len;
> + =A0 =A0 =A0 u8 *rx_buf =3D (u8 *)t->rx_buf + tspi->cur_pos;
> + =A0 =A0 =A0 int i, j;
> + =A0 =A0 =A0 unsigned long val;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < len; i +=3D tspi->cur_bytes_per_word) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D tspi->rx_bb[i / tspi->cur_bytes_per=
_word];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < tspi->cur_bytes_per_word;=
 j++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_buf[i + j] =3D (val >> (=
j * 8)) & 0xff;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return len;
> +}
> +
> +static void spi_tegra_start_transfer(struct spi_device *spi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct spi_transfer *t)
> +{
> + =A0 =A0 =A0 struct spi_tegra_data *tspi =3D spi_master_get_devdata(spi-=
>master);
> + =A0 =A0 =A0 u32 speed;
> + =A0 =A0 =A0 u8 bits_per_word;
> + =A0 =A0 =A0 unsigned long val;
> +
> + =A0 =A0 =A0 speed =3D t->speed_hz ? t->speed_hz : spi->max_speed_hz;
> + =A0 =A0 =A0 bits_per_word =3D t->bits_per_word ? t->bits_per_word =A0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->bits_per_word;
> +
> + =A0 =A0 =A0 tspi->cur_bytes_per_word =3D (bits_per_word - 1) / 8 + 1;
> +
> + =A0 =A0 =A0 if (speed !=3D tspi->cur_speed)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_set_rate(tspi->clk, speed);
> +
> + =A0 =A0 =A0 if (tspi->cur_speed =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(tspi->clk);
> +
> + =A0 =A0 =A0 tspi->cur_speed =3D speed;
> +
> + =A0 =A0 =A0 val =3D spi_tegra_readl(tspi, SLINK_COMMAND2);
> + =A0 =A0 =A0 if (t->rx_buf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D RXEN;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~RXEN;
> +
> + =A0 =A0 =A0 if (t->tx_buf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D TXEN;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~TXEN;
> +
> + =A0 =A0 =A0 val &=3D ~SS_EN_CS(~0);
> + =A0 =A0 =A0 val |=3D SS_EN_CS(spi->chip_select);
> + =A0 =A0 =A0 val |=3D SPIE;

Nit: This would be more concise:

+ =A0 =A0 =A0 val &=3D ~(SS_EN_CS(~0) | RXEN | TXEN);
+ =A0 =A0 =A0 if (t->rx_buf)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D RXEN;
+ =A0 =A0 =A0 if (t->tx_buf)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D TXEN;
+ =A0 =A0 =A0 val |=3D SS_EN_CS(spi->chip_select);
+ =A0 =A0 =A0 val |=3D SPIE;


> +
> + =A0 =A0 =A0 spi_tegra_writel(tspi, val, SLINK_COMMAND2);
> +
> + =A0 =A0 =A0 val =3D spi_tegra_readl(tspi, SLINK_COMMAND);
> + =A0 =A0 =A0 val &=3D ~BIT_LENGTH(~0);
> + =A0 =A0 =A0 val |=3D BIT_LENGTH(bits_per_word - 1);
> +
> + =A0 =A0 =A0 /* FIXME: should probably control CS manually so that we ca=
n be sure
> + =A0 =A0 =A0 =A0* it does not go low between transfer and to support del=
ay_usecs
> + =A0 =A0 =A0 =A0* correctly.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 val &=3D ~IDLE_SCLK_MASK & ~CK_SDA & ~CS_SW;
> +
> + =A0 =A0 =A0 if (spi->mode & SPI_CPHA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D CK_SDA;
> +
> + =A0 =A0 =A0 if (spi->mode & SPI_CPOL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D IDLE_SCLK_DRIVE_HIGH;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D IDLE_SCLK_DRIVE_LOW;

nit: IDLE_SCLK_DRIVE_LOW =3D=3D 0.  The driver will be more concise if the
above 2 lines are dropped.
> +
> + =A0 =A0 =A0 val |=3D M_S;
> +
> + =A0 =A0 =A0 spi_tegra_writel(tspi, val, SLINK_COMMAND);

The read/modify/write register blocks are quite common.  Would it be
clearer and more concise to have a spi_tegra_clrsetbits() static
inline?

> +
> + =A0 =A0 =A0 spi_tegra_writel(tspi, RX_FLUSH | TX_FLUSH, SLINK_STATUS);
> +
> + =A0 =A0 =A0 tspi->cur =3D t;
> + =A0 =A0 =A0 tspi->cur_pos =3D 0;
> + =A0 =A0 =A0 tspi->cur_len =3D spi_tegra_fill_tx_fifo(tspi, t);
> +
> + =A0 =A0 =A0 spi_tegra_go(tspi);
> +}
> +
> +static void spi_tegra_start_message(struct spi_device *spi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct spi_message *m)
> +{
> + =A0 =A0 =A0 struct spi_transfer *t;
> +
> + =A0 =A0 =A0 m->actual_length =3D 0;
> +
> + =A0 =A0 =A0 t =3D list_first_entry(&m->transfers, struct spi_transfer, =
transfer_list);
> + =A0 =A0 =A0 spi_tegra_start_transfer(spi, t);
> +}
> +
> +static void tegra_spi_rx_dma_complete(struct tegra_dma_req *req)
> +{
> + =A0 =A0 =A0 struct spi_tegra_data *tspi =3D req->dev;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 struct spi_message *m;
> + =A0 =A0 =A0 struct spi_device *spi;
> + =A0 =A0 =A0 int complete =3D 0;
> + =A0 =A0 =A0 int timeout =3D 0;
> + =A0 =A0 =A0 unsigned long val;
> +
> + =A0 =A0 =A0 /* the SPI controller may come back with both the BSY and R=
DY bits
> + =A0 =A0 =A0 =A0* set. =A0In this case we need to wait for the BSY bit t=
o clear so
> + =A0 =A0 =A0 =A0* that we are sure the DMA is finished. =A01000 reads wa=
s empirically
> + =A0 =A0 =A0 =A0* determined to be long enough.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 while (timeout++ < 1000) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(spi_tegra_readl(tspi, SLINK_STATUS) &=
 BSY))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }

What happens if the BSY bit is still set when the loop exits?

> +
> + =A0 =A0 =A0 val =3D spi_tegra_readl(tspi, SLINK_STATUS);
> + =A0 =A0 =A0 val |=3D RDY;
> + =A0 =A0 =A0 spi_tegra_writel(tspi, val, SLINK_STATUS);

The spin lock isn't held at this point.  Will that make this
read-modify-write operation risky?

> +
> + =A0 =A0 =A0 spin_lock_irqsave(&tspi->lock, flags);

Is there any condition/event which could cause the spi controller to
go busy before obtaining the spinlock?

> +
> + =A0 =A0 =A0 m =3D list_first_entry(&tspi->queue, struct spi_message, qu=
eue);
> + =A0 =A0 =A0 spi =3D m->state;
> +
> + =A0 =A0 =A0 tspi->cur_pos +=3D spi_tegra_drain_rx_fifo(tspi, tspi->cur);
> + =A0 =A0 =A0 m->actual_length +=3D tspi->cur_pos;
> +
> + =A0 =A0 =A0 if (tspi->cur_pos < tspi->cur->len) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tspi->cur_len =3D spi_tegra_fill_tx_fifo(ts=
pi, tspi->cur);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_tegra_go(tspi);
> + =A0 =A0 =A0 } else if (!list_is_last(&tspi->cur->transfer_list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&m->tran=
sfers)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tspi->cur =3D =A0list_first_entry(&tspi->cu=
r->transfer_list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 struct spi_transfer,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 transfer_list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_tegra_start_transfer(spi, tspi->cur);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (complete) {

Looks like the above else clause is the only thing that can set
complete.  You could delete the above three lines to get the same
behaviour.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&m->queue);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 m->status =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 m->complete(m->context);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!list_empty(&tspi->queue)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 m =3D list_first_entry(&tsp=
i->queue, struct spi_message,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0queue);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi =3D m->state;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_tegra_start_message(spi=
, m);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(tspi->clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tspi->cur_speed =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&tspi->lock, flags);
> +}
> +
> +static int spi_tegra_setup(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct spi_tegra_data *tspi =3D spi_master_get_devdata(spi-=
>master);
> + =A0 =A0 =A0 unsigned long cs_bit;
> + =A0 =A0 =A0 unsigned long val;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 dev_dbg(&spi->dev, "setup %d bpw, %scpol, %scpha, %dHz\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->bits_per_word,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->mode & SPI_CPOL ? "" : "~",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->mode & SPI_CPHA ? "" : "~",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->max_speed_hz);
> +
> +
> + =A0 =A0 =A0 switch (spi->chip_select) {
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_bit =3D CS_POLARITY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_bit =3D CS_POLARITY1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_bit =3D CS_POLARITY2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case 4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_bit =3D CS_POLARITY3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;

CS_POLARITY is named a little oddly as it seems to indicate the bit,
not the polarity of the bit.  Would this better be named
CS_BIT0..CS_BIT3?

> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&tspi->lock, flags);
> +
> + =A0 =A0 =A0 val =3D spi_tegra_readl(tspi, SLINK_COMMAND);
> + =A0 =A0 =A0 if (spi->mode & SPI_CS_HIGH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D cs_bit;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~cs_bit;
> + =A0 =A0 =A0 spi_tegra_writel(tspi, val, SLINK_COMMAND);
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&tspi->lock, flags);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int spi_tegra_transfer(struct spi_device *spi, struct spi_message=
 *m)
> +{
> + =A0 =A0 =A0 struct spi_tegra_data *tspi =3D spi_master_get_devdata(spi-=
>master);
> + =A0 =A0 =A0 struct spi_transfer *t;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int was_empty;
> +
> + =A0 =A0 =A0 if (list_empty(&m->transfers) || !m->complete)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 list_for_each_entry(t, &m->transfers, transfer_list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->bits_per_word < 0 || t->bits_per_wor=
d > 32)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->len =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!t->rx_buf && !t->tx_buf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 m->state =3D spi;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&tspi->lock, flags);
> + =A0 =A0 =A0 was_empty =3D list_empty(&tspi->queue);
> + =A0 =A0 =A0 list_add_tail(&m->queue, &tspi->queue);
> +
> + =A0 =A0 =A0 if (was_empty)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_tegra_start_message(spi, m);
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&tspi->lock, flags);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void spi_tegra_cleanup(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 dev_dbg(&spi->dev, "cleanup\n");
> +}
> +
> +static int __init spi_tegra_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct spi_master =A0 =A0 =A0 *master;
> + =A0 =A0 =A0 struct spi_tegra_data =A0 *tspi;
> + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 *r;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 master =3D spi_alloc_master(&pdev->dev, sizeof *tspi);
> + =A0 =A0 =A0 if (master =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "master allocation fail=
ed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* the spi->mode bits understood by this driver: */
> + =A0 =A0 =A0 master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> +
> + =A0 =A0 =A0 if (pdev->id !=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 master->bus_num =3D pdev->id;
> +
> + =A0 =A0 =A0 master->setup =3D spi_tegra_setup;
> + =A0 =A0 =A0 master->transfer =3D spi_tegra_transfer;
> + =A0 =A0 =A0 master->cleanup =3D spi_tegra_cleanup;
> + =A0 =A0 =A0 master->num_chipselect =3D 4;
> +
> + =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, master);
> + =A0 =A0 =A0 tspi =3D spi_master_get_devdata(master);
> + =A0 =A0 =A0 tspi->master =3D master;
> + =A0 =A0 =A0 tspi->pdev =3D pdev;
> + =A0 =A0 =A0 spin_lock_init(&tspi->lock);
> +
> + =A0 =A0 =A0 r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (r =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tspi->phys =3D r->start;
> + =A0 =A0 =A0 tspi->base =3D ioremap(r->start, r->end - r->start + 1);
> + =A0 =A0 =A0 if (!tspi->base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can't ioremap iomem\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tspi->clk =3D clk_get(&pdev->dev, NULL);
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(tspi->clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can not get clock\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(tspi->clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 INIT_LIST_HEAD(&tspi->queue);
> +
> + =A0 =A0 =A0 tspi->rx_dma =3D tegra_dma_allocate_channel(TEGRA_DMA_MODE_=
ONESHOT);
> + =A0 =A0 =A0 if (IS_ERR(tspi->rx_dma)) {

As an aside, and commenting on the tegra DMA api... Is the IS_ERR()
pattern in the tegra_dma_allocate_channel() return really a good idea
here?  Personally I find that pattern isn't very useful, especially
when the results is either "yes, allocated" or "no, not-alocated", and
it is very easy to write code that tests the wrong thing on the return
value because the compiler cannot catch it.  In other words, if it
isn't vital to return a specific error code, the using the PTR_ERR()
pattern adds unnecessary risk to the code because developers are used
to seeing and writing this pattern:

tspi->rx_dma =3D tegra_dma_allocate_channel(TEGRA_DMA_MODE_ONESHOT);
if (!tspi->rx_dma)
	return -ENOMEM;

The compiler won't catch it if the return value is an PTR_ERR.

(I know that some subsystems make heavy use of it, particularly
filesystems and the block layer which do need to return specific error
codes to userspace.  My argument is that the specific error code is
probably irrelevant when allocating DMA channels)

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can not allocate rx dm=
a channel\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(tspi->rx_dma);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tspi->rx_bb =3D dma_alloc_coherent(&pdev->dev, sizeof(u32) =
* BB_LEN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&tspi->rx_bb_phys, GFP_KERNEL);
> + =A0 =A0 =A0 if (!tspi->rx_bb) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can not allocate rx bo=
unce buffer\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err4;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tspi->rx_dma_req.complete =3D tegra_spi_rx_dma_complete;
> + =A0 =A0 =A0 tspi->rx_dma_req.to_memory =3D 1;
> + =A0 =A0 =A0 tspi->rx_dma_req.dest_addr =3D tspi->rx_bb_phys;
> + =A0 =A0 =A0 tspi->rx_dma_req.dest_bus_width =3D 32;
> + =A0 =A0 =A0 tspi->rx_dma_req.source_addr =3D tspi->phys + SLINK_RX_FIFO;
> + =A0 =A0 =A0 tspi->rx_dma_req.source_bus_width =3D 32;
> + =A0 =A0 =A0 tspi->rx_dma_req.source_wrap =3D 4;
> + =A0 =A0 =A0 tspi->rx_dma_req.req_sel =3D spi_tegra_req_sels[pdev->id];
> + =A0 =A0 =A0 tspi->rx_dma_req.dev =3D tspi;
> +
> + =A0 =A0 =A0 ret =3D spi_register_master(master);
> +
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err5;
> +
> + =A0 =A0 =A0 return ret;
> +
> +err5:
> + =A0 =A0 =A0 dma_free_coherent(&pdev->dev, sizeof(u32) * BB_LEN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tspi->rx_bb, tspi->rx_b=
b_phys);
> +err4:
> + =A0 =A0 =A0 tegra_dma_free_channel(tspi->rx_dma);
> +err3:
> + =A0 =A0 =A0 clk_put(tspi->clk);
> +err2:
> + =A0 =A0 =A0 iounmap(tspi->base);
> +err1:
> + =A0 =A0 =A0 release_mem_region(r->start, (r->end - r->start) + 1);

Since this version doesn't request_mem_region(), this release is
dangling.  (However, as rmk pointed out the request_mem_region() was
completely fine and the driver should continue to use it.  Sorry for
the noise).

> +err0:
> + =A0 =A0 =A0 spi_master_put(master);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int __devexit spi_tegra_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct spi_master =A0 =A0 =A0 *master;
> + =A0 =A0 =A0 struct spi_tegra_data =A0 *tspi;
> +
> + =A0 =A0 =A0 master =3D dev_get_drvdata(&pdev->dev);
> + =A0 =A0 =A0 tspi =3D spi_master_get_devdata(master);
> +
> + =A0 =A0 =A0 tegra_dma_free_channel(tspi->rx_dma);
> +
> + =A0 =A0 =A0 dma_free_coherent(&pdev->dev, sizeof(u32) * BB_LEN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tspi->rx_bb, tspi->rx_b=
b_phys);
> +
> + =A0 =A0 =A0 clk_put(tspi->clk);
> + =A0 =A0 =A0 iounmap(tspi->base);
> +
> + =A0 =A0 =A0 spi_master_put(master);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +MODULE_ALIAS("platform:spi_tegra");
> +
> +static struct platform_driver spi_tegra_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D =A0 =A0 =A0 =A0 "spi_tegra",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D =A0 =A0 =A0 =A0THIS_MODULE,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .remove =3D =A0 =A0 =A0 __devexit_p(spi_tegra_remove),
> +};
> +
> +static int __init spi_tegra_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_probe(&spi_tegra_driver, spi_tegra_p=
robe);
> +}
> +subsys_initcall(spi_tegra_init);

Unless there is a specific reason that this driver needs to be
initialized earlier, it should use the module_init() call.  In which
case the reason it is initialized early should be documented with a
comment.  (for reference: 4 of the mainlined spi bus drivers use
subsys_initcall() whereas 30 of them use module_init()..  1 uses
device_initcall() which is the same as module_init.  None of the ones
using subsys_initcall() give a reason why.)

g.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =
