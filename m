From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] Memory-mapped Dwsignware SPI driver
Date: Mon, 18 Jan 2010 10:21:21 -0700
Message-ID: <fa686aa41001180921u3919c3e4u3711097218cbfa7e@mail.gmail.com>
References: <20100118164921.23527.74770.stgit@station520.octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100118164921.23527.74770.stgit-PR71IgaHmJalNznWqnLNUK6RkeBMCJyt@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 18, 2010 at 9:50 AM, Jean-Hugues Deschenes
<jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org> wrote:
> Adds a memory-mapped I/O dw_spi platform device.
>
> Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
> ---
> =A0drivers/spi/Kconfig =A0 =A0 =A0 | =A0 16 ++++
> =A0drivers/spi/Makefile =A0 =A0 =A0| =A0 =A01
> =A0drivers/spi/dw_spi_mmio.c | =A0164 +++++++++++++++++++++++++++++++++++=
++++++++++
> =A03 files changed, 178 insertions(+), 3 deletions(-)
> =A0create mode 100644 drivers/spi/dw_spi_mmio.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index f55eb01..79c8d5f 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -308,14 +308,24 @@ config SPI_NUC900
> =A0#
>
> =A0config SPI_DESIGNWARE
> - =A0 =A0 =A0 bool "DesignWare SPI controller core support"
> + =A0 =A0 =A0 tristate "DesignWare SPI controller core support"
> =A0 =A0 =A0 =A0depends on SPI_MASTER
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0general driver for SPI controller core from DesignWare
>
> +choice
> + =A0 =A0 =A0 prompt "Designware bus type"
> + =A0 =A0 =A0 depends on SPI_DESIGNWARE
> + =A0 =A0 =A0 default SPI_DW_PCI
> +
> =A0config SPI_DW_PCI
> - =A0 =A0 =A0 tristate "PCI interface driver for DW SPI core"
> - =A0 =A0 =A0 depends on SPI_DESIGNWARE && PCI
> + =A0 =A0 =A0 bool "PCI interface driver for DW SPI core"
> + =A0 =A0 =A0 depends on PCI
> +
> +config SPI_DW_MMIO
> + =A0 =A0 =A0 bool "Memory-mapped io interface driver for DW SPI core"
> +
> +endchoice

The MMIO patch looks non-orthogonal to the PCI stuff so I don't
understand why a choice/endchoice is being used here.  Is there any
reason that both bus attachments cannot be compiled as modules at the
same time?

> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index f3d2810..c3e5ce7 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_SPI_AU1550) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=
=3D au1550_spi.o
> =A0obj-$(CONFIG_SPI_BUTTERFLY) =A0 =A0 =A0 =A0 =A0 =A0+=3D spi_butterfly.o
> =A0obj-$(CONFIG_SPI_DESIGNWARE) =A0 =A0 =A0 =A0 =A0 +=3D dw_spi.o
> =A0obj-$(CONFIG_SPI_DW_PCI) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D dw_spi_pci.o
> +obj-$(CONFIG_SPI_DW_MMIO) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D dw_spi_mmio.o
> =A0obj-$(CONFIG_SPI_GPIO) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi_gpio.o
> =A0obj-$(CONFIG_SPI_IMX) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi_imx.o
> =A0obj-$(CONFIG_SPI_LM70_LLP) =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi_lm70llp.o
> diff --git a/drivers/spi/dw_spi_mmio.c b/drivers/spi/dw_spi_mmio.c
> new file mode 100644
> index 0000000..9abeb45
> --- /dev/null
> +++ b/drivers/spi/dw_spi_mmio.c
> @@ -0,0 +1,164 @@
> +/*
> + * dw_spi_mmio.c - Memory-mapped interface driver for DW SPI Core
> + *
> + * Copyright (c) 2010, Octasic semiconductor.
> + *
> + * Somewhat derived from PCI implementation,
> + * Copyright (c) 2009, Intel Corporation.
> + *
> + * ...and from designware i2c driver
> + * Copyright (C) 2006 Texas Instruments.
> + * Copyright (C) 2007 MontaVista Software Inc.
> + * Copyright (C) 2009 Provigent Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public Licen=
se for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, write to the Free Software Foundation,
> + * Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.

Do you really need these three paragraphs of preamble?  IMNSOH, the
first paragraph stating GPLv2 should be sufficient.

Otherwise, the patch looks good to me.  I don't have any technical
comments on the code.

Thanks,
g.



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
