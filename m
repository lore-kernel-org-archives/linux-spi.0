From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 5/6] spi: octeon: Split driver into Octeon specific and
 common parts
Date: Sun, 24 Jul 2016 14:38:11 -0400
Message-ID: <CAP=VYLrQDwCfYFCkxd0N4PfgP-2U+pcw_Gm0Yo_8m0=0o3pBrA@mail.gmail.com>
References: <cover.1469174814.git.jglauber@cavium.com> <edfc55f3653fedd5e13a8bd1282e089b269a4e61.1469174814.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org,
	"Steven J. Hill" <steven.hill@cavium.com>,
	David Daney <david.daney@cavium.com>
To: Jan Glauber <jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <edfc55f3653fedd5e13a8bd1282e089b269a4e61.1469174814.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Jul 23, 2016 at 6:42 AM, Jan Glauber <jglauber@cavium.com> wrote:
> Separate driver probing from SPI transfer functions.
>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> Tested-by: Steven J. Hill <steven.hill@cavium.com>
> ---
>  drivers/spi/Makefile                       |   1 +
>  drivers/spi/spi-cavium-octeon.c            | 104 +++++++++++++++++++++++++
>  drivers/spi/{spi-octeon.c => spi-cavium.c} | 120 +----------------------------
>  drivers/spi/spi-cavium.h                   |  31 ++++++++
>  4 files changed, 138 insertions(+), 118 deletions(-)
>  create mode 100644 drivers/spi/spi-cavium-octeon.c
>  rename drivers/spi/{spi-octeon.c => spi-cavium.c} (55%)
>
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 3c74d00..185367e 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_SPI_MT65XX)                += spi-mt65xx.o
>  obj-$(CONFIG_SPI_MXS)                  += spi-mxs.o
>  obj-$(CONFIG_SPI_NUC900)               += spi-nuc900.o
>  obj-$(CONFIG_SPI_OC_TINY)              += spi-oc-tiny.o
> +spi-octeon-objs                                := spi-cavium.o spi-cavium-octeon.o
>  obj-$(CONFIG_SPI_OCTEON)               += spi-octeon.o
>  obj-$(CONFIG_SPI_OMAP_UWIRE)           += spi-omap-uwire.o
>  obj-$(CONFIG_SPI_OMAP_100K)            += spi-omap-100k.o
> diff --git a/drivers/spi/spi-cavium-octeon.c b/drivers/spi/spi-cavium-octeon.c
> new file mode 100644
> index 0000000..ee4703e
> --- /dev/null
> +++ b/drivers/spi/spi-cavium-octeon.c
> @@ -0,0 +1,104 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2011, 2012 Cavium, Inc.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/of.h>

[...]

> +MODULE_DEVICE_TABLE(of, octeon_spi_match);
> +
> +static struct platform_driver octeon_spi_driver = {
> +       .driver = {
> +               .name           = "spi-octeon",
> +               .of_match_table = octeon_spi_match,
> +       },
> +       .probe          = octeon
_spi_probe,
> +       .remove         = octeon_spi_remove,
> +};
> +
> +module_platform_driver(octeon_spi_driver);
> +
> +MODULE_DESCRIPTION("Cavium, Inc. OCTEON SPI bus driver");
> +MODULE_AUTHOR("David Daney");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-cavium.c
> similarity index 55%
> rename from drivers/spi/spi-octeon.c
> rename to drivers/spi/spi-cavium.c
> index 2180176..5aaf215 100644
> --- a/drivers/spi/spi-octeon.c
> +++ b/drivers/spi/spi-cavium.c
> @@ -6,42 +6,13 @@
>   * Copyright (C) 2011, 2012 Cavium, Inc.
>   */
>
> -#include <linux/platform_device.h>
> -#include <linux/interrupt.h>
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>

It almost looks like all the modular stuff got moved to the new file and
maybe the above module.h isn't needed in the original file anymore?

Paul.
--

>  #include <linux/delay.h>
>  #include <linux/io.h>
> -#include <linux/of.h>
> -
> -#include <asm/octeon/octeon.h>
>
>  #include "spi-cavium.h"

[...]
