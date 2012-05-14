From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH 2/2] spi: Add SPI master controller for OCTEON SOCs.
Date: Mon, 14 May 2012 11:16:37 +0530
Message-ID: <CAM=Q2csSQWbCOCQpubDok1=hmPvHU0MTEUg+-FGhp91=O5L6Hw@mail.gmail.com>
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>
	<1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: devicetree-discuss@lists.ozlabs.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org,
	David Daney <david.daney@cavium.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi David,
A few comments.

On Sat, May 12, 2012 at 3:04 AM, David Daney <ddaney.cavm@gmail.com> wr=
ote:
> From: David Daney <david.daney@cavium.com>
>
> Add the driver, link it into the kbuild system and provide device tre=
e
> binding documentation.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
> =A0.../devicetree/bindings/spi/spi-octeon.txt =A0 =A0 =A0 =A0 | =A0 3=
3 ++
> =A0drivers/spi/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0| =A0 =A07 +
> =A0drivers/spi/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/spi/spi-octeon.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0369 ++++++++++++++++++++
> =A04 files changed, 410 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/spi/spi-octeo=
n.txt
> =A0create mode 100644 drivers/spi/spi-octeon.c
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-octeon.txt b/D=
ocumentation/devicetree/bindings/spi/spi-octeon.txt
> new file mode 100644
> index 0000000..431add1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-octeon.txt
> @@ -0,0 +1,33 @@
> +Cavium, Inc. OCTEON SOC SPI master controller.
> +
> +Required properties:
> +- compatible : "cavium,octeon-3010-spi"
> +- reg : The register base for the controller.
> +- interrupts : One interrupt, used by the controller.
> +- #address-cells : <1>, as required by generic SPI binding.
> +- #size-cells : <0>, also as required by generic SPI binding.
> +
> +Child nodes as per the generic SPI binding.
> +
> +Example:
> +
> + =A0 =A0 =A0 spi@1070000001000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "cavium,octeon-3010-spi"=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x10700 0x00001000 0x0 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <0 58>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeprom@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "st,m952=
56", "atmel,at25";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-max-frequency =3D <=
5000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-cpha;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-cpol;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pagesize =3D <64>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D <32768>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 address-width =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 00c0240..e1dd0d0 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -228,6 +228,13 @@ config SPI_OC_TINY
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This is the driver for OpenCores tiny SPI master c=
ontroller.
>
> +config SPI_OCTEON
> + =A0 =A0 =A0 tristate "Cavium OCTEON SPI controller"
> + =A0 =A0 =A0 depends on CPU_CAVIUM_OCTEON
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 SPI host driver for the hardware found on some Cavi=
um OCTEON
> + =A0 =A0 =A0 =A0 SOCs.
> +
> =A0config SPI_OMAP_UWIRE
> =A0 =A0 =A0 =A0tristate "OMAP1 MicroWire"
> =A0 =A0 =A0 =A0depends on ARCH_OMAP1
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 9d75d21..c7f8b71 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_SPI_MPC52xx_PSC) =A0 =A0 =A0 =A0 +=3D =
spi-mpc52xx-psc.o
> =A0obj-$(CONFIG_SPI_MPC52xx) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi-mpc5=
2xx.o
> =A0obj-$(CONFIG_SPI_NUC900) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi-nuc9=
00.o
> =A0obj-$(CONFIG_SPI_OC_TINY) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi-oc-t=
iny.o
> +obj-$(CONFIG_SPI_OCTEON) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi-octeon=
=2Eo
> =A0obj-$(CONFIG_SPI_OMAP_UWIRE) =A0 =A0 =A0 =A0 =A0 +=3D spi-omap-uwi=
re.o
> =A0obj-$(CONFIG_SPI_OMAP_100K) =A0 =A0 =A0 =A0 =A0 =A0+=3D spi-omap-1=
00k.o
> =A0obj-$(CONFIG_SPI_OMAP24XX) =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi-omap2-=
mcspi.o
> diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
> new file mode 100644
> index 0000000..7207aaf
> --- /dev/null
> +++ b/drivers/spi/spi-octeon.c
> @@ -0,0 +1,369 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU Gener=
al Public
> + * License. =A0See the file "COPYING" in the main directory of this =
archive
> + * for more details.
> + *
> + * Copyright (C) 2011, 2012 Cavium, Inc.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/spi/spi.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/of_spi.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +
> +#include <asm/octeon/octeon.h>
> +#include <asm/octeon/cvmx-mpi-defs.h>
> +
> +#define DRV_VERSION "2.0" /* Version 1 was the out-of-tree driver */
This could be given a miss. As it is less meaningful once accepted.

> +#define DRV_DESCRIPTION "Cavium, Inc. OCTEON SPI bus driver"
> +
> +
> +#define OCTEON_SPI_CFG 0
> +#define OCTEON_SPI_STS 0x08
> +#define OCTEON_SPI_TX 0x10
> +#define OCTEON_SPI_DAT0 0x80
> +
> +#define OCTEON_SPI_MAX_BYTES 9
> +
> +#define OCTEON_SPI_MAX_CLOCK_HZ 16000000
> +
> +struct octeon_spi {
> + =A0 =A0 =A0 struct spi_master *my_master;
> + =A0 =A0 =A0 u64 register_base;
> + =A0 =A0 =A0 u64 last_cfg;
> + =A0 =A0 =A0 u64 cs_enax;
> +};
> +
> +struct octeon_spi_setup {
> + =A0 =A0 =A0 u32 max_speed_hz;
> + =A0 =A0 =A0 u8 chip_select;
> + =A0 =A0 =A0 u8 mode;
> + =A0 =A0 =A0 u8 bits_per_word;
> +};
> +
> +static void octeon_spi_wait_ready(struct octeon_spi *p)
> +{
> + =A0 =A0 =A0 union cvmx_mpi_sts mpi_sts;
> + =A0 =A0 =A0 unsigned int loops =3D 0;
> +
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (loops++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __delay(500);
Could we allow  have a non-busy loop here?
