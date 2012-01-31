From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 9/9 v3] spi: add Broadcom BCM63xx SPI controller driver
Date: Tue, 31 Jan 2012 23:22:43 +0530
Message-ID: <CAM=Q2csgc07XrOfTaSFHFQXnZoe2_HHips4x9Ht0j_1EP_1BwA@mail.gmail.com>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
	<1328019048-5892-10-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Tanguy Bouzeloc <tanguy.bouzeloc-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1328019048-5892-10-git-send-email-florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
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

On Tue, Jan 31, 2012 at 7:40 PM, Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wro=
te:
> This patch adds support for the SPI controller found on the Broadcom BCM6=
3xx
> SoCs.
>
> Signed-off-by: Tanguy Bouzeloc <tanguy.bouzeloc-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> ---
> Changes since v2:
> - reworked bcm63xx_spi_setup_transfer to choose closest spi transfer
> =A0frequency
> - removed invalid 25Mhz frequency
> - fixed some minor checkpatch issues
>
> Changes since v1:
> - switched to the devm_* API which frees resources automatically
> - switched to dev_pm_ops
> - use module_platform_driver
> - remove MODULE_VERSION()
> - fixed return value when clock is not present using PTR_ERR()
> - fixed probe() error path to disable clock in case of failure
>
> =A0drivers/spi/Kconfig =A0 =A0 =A0 | =A0 =A06 +
> =A0drivers/spi/Makefile =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/spi/spi-bcm63xx.c | =A0486 +++++++++++++++++++++++++++++++++++=
++++++++++
> =A03 files changed, 493 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/spi/spi-bcm63xx.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3f9a47e..16818ac 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -94,6 +94,12 @@ config SPI_AU1550
> =A0 =A0 =A0 =A0 =A0If you say yes to this option, support will be include=
d for the
> =A0 =A0 =A0 =A0 =A0PSC SPI controller found on Au1550, Au1200 and Au1300 =
series.
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
> index 0000000..eba8505
> --- /dev/null
> +++ b/drivers/spi/spi-bcm63xx.c
> @@ -0,0 +1,486 @@
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
> +#include <linux/io.h>
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

are you sure it should be bcm_readw

> +}
> +
> +static inline u16 bcm_spi_readw(struct bcm63xx_spi *bs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned in=
t offset)
> +{
> + =A0 =A0 =A0 return bcm_readw(bs->regs + bcm63xx_spireg(offset));
> +}
> +

---------------------------------------------------------------------------=
---
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
