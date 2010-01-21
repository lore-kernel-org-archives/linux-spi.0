From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2] Memory-mapped dw_spi driver
Date: Thu, 21 Jan 2010 07:46:35 -0700
Message-ID: <fa686aa41001210646h9c8422exec5572eeb2b0ae65@mail.gmail.com>
References: <20100121142636.31707.70616.stgit@station520.octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100121142636.31707.70616.stgit-PR71IgaHmJalNznWqnLNUK6RkeBMCJyt@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jan 21, 2010 at 7:27 AM, Jean-Hugues Deschenes
<jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org> wrote:
> Adds a memory-mapped I/O dw_spi platform device.
>
> ---
> Changelog v1->v2
> - simplified dw_spi_mmio.c preamble (Grant Likely)
> - build of dw_spi_mmio and dw_spi_pci are now independant
> =A0of each other (Grant Likely)
> - add call to dw_spi_remove_host (Feng Tang)
> ---
>
> Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
> ---

BTW, anything below a '---' line gets dropped by git, so your s-o-b
line got dropped and I had to add it back manually.  Please make sure
anything that belongs in the commit text goes above the first ---
line.

Cheers,
g.

> =A0drivers/spi/Kconfig =A0 =A0 =A0 | =A0 =A04 +
> =A0drivers/spi/Makefile =A0 =A0 =A0| =A0 =A01
> =A0drivers/spi/dw_spi_mmio.c | =A0148 +++++++++++++++++++++++++++++++++++=
++++++++++
> =A03 files changed, 153 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/spi/dw_spi_mmio.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index f55eb01..02be3a6 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -317,6 +317,10 @@ config SPI_DW_PCI
> =A0 =A0 =A0 =A0tristate "PCI interface driver for DW SPI core"
> =A0 =A0 =A0 =A0depends on SPI_DESIGNWARE && PCI
>
> +config SPI_DW_MMIO
> + =A0 =A0 =A0 tristate "Memory-mapped io interface driver for DW SPI core"
> + =A0 =A0 =A0 depends on SPI_DESIGNWARE
> +
> =A0#
> =A0# There are lots of SPI device types, with sensors and memory
> =A0# being probably the most widely used ones.
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
> index 0000000..26c4b49
> --- /dev/null
> +++ b/drivers/spi/dw_spi_mmio.c
> @@ -0,0 +1,148 @@
> +/*
> + * dw_spi_mmio.c - Memory-mapped interface driver for DW SPI Core
> + *
> + * Copyright (c) 2010, Octasic semiconductor.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/dw_spi.h>
> +#include <linux/spi/spi.h>
> +
> +#define DRIVER_NAME "dw_spi_mmio"
> +
> +struct dw_spi_mmio {
> + =A0 =A0 =A0 struct dw_spi =A0 dws;
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk;
> +};
> +
> +static int __devinit dw_spi_mmio_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct dw_spi_mmio *dwsmmio;
> + =A0 =A0 =A0 struct dw_spi *dws;
> + =A0 =A0 =A0 struct resource *mem, *ioarea;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 dwsmmio =3D kzalloc(sizeof(struct dw_spi_mmio), GFP_KERNEL);
> + =A0 =A0 =A0 if (!dwsmmio) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_end;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dws =3D &dwsmmio->dws;
> +
> + =A0 =A0 =A0 /* Get basic io resource and map it */
> + =A0 =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (!mem) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource?\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_kfree;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ioarea =3D request_mem_region(mem->start, resource_size(mem=
),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->name);
> + =A0 =A0 =A0 if (!ioarea) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "SPI region already cla=
imed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_kfree;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dws->regs =3D ioremap_nocache(mem->start, resource_size(mem=
));
> + =A0 =A0 =A0 if (!dws->regs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "SPI region already map=
ped\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_release_reg;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dws->irq =3D platform_get_irq(pdev, 0);
> + =A0 =A0 =A0 if (dws->irq < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no irq resource?\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dws->irq; /* -ENXIO */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unmap;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dwsmmio->clk =3D clk_get(&pdev->dev, NULL);
> + =A0 =A0 =A0 if (!dwsmmio->clk) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 clk_enable(dwsmmio->clk);
> +
> + =A0 =A0 =A0 dws->parent_dev =3D &pdev->dev;
> + =A0 =A0 =A0 dws->bus_num =3D 0;
> + =A0 =A0 =A0 dws->num_cs =3D 4;
> + =A0 =A0 =A0 dws->max_freq =3D clk_get_rate(dwsmmio->clk);
> +
> + =A0 =A0 =A0 ret =3D dw_spi_add_host(dws);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk;
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, dwsmmio);
> + =A0 =A0 =A0 return 0;
> +
> +err_clk:
> + =A0 =A0 =A0 clk_disable(dwsmmio->clk);
> + =A0 =A0 =A0 clk_put(dwsmmio->clk);
> + =A0 =A0 =A0 dwsmmio->clk =3D NULL;
> +err_irq:
> + =A0 =A0 =A0 free_irq(dws->irq, dws);
> +err_unmap:
> + =A0 =A0 =A0 iounmap(dws->regs);
> +err_release_reg:
> + =A0 =A0 =A0 release_mem_region(mem->start, resource_size(mem));
> +err_kfree:
> + =A0 =A0 =A0 kfree(dwsmmio);
> +err_end:
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int __devexit dw_spi_mmio_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct dw_spi_mmio *dwsmmio =3D platform_get_drvdata(pdev);
> + =A0 =A0 =A0 struct resource *mem;
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> +
> + =A0 =A0 =A0 clk_disable(dwsmmio->clk);
> + =A0 =A0 =A0 clk_put(dwsmmio->clk);
> + =A0 =A0 =A0 dwsmmio->clk =3D NULL;
> +
> + =A0 =A0 =A0 free_irq(dwsmmio->dws.irq, &dwsmmio->dws);
> + =A0 =A0 =A0 dw_spi_remove_host(&dwsmmio->dws);
> + =A0 =A0 =A0 iounmap(dwsmmio->dws.regs);
> + =A0 =A0 =A0 kfree(dwsmmio);
> +
> + =A0 =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 release_mem_region(mem->start, resource_size(mem));
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct platform_driver dw_spi_mmio_driver =3D {
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(dw_spi_mmio_remove),
> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRIVER_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init dw_spi_mmio_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_probe(&dw_spi_mmio_driver, dw_spi_mm=
io_probe);
> +}
> +
> +static void __exit dw_spi_mmio_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&dw_spi_mmio_driver);
> +}
> +
> +module_init(dw_spi_mmio_init);
> +module_exit(dw_spi_mmio_exit);
> +
> +MODULE_AUTHOR("Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>=
");
> +MODULE_DESCRIPTION("Memory-mapped I/O interface driver for DW SPI Core");
> +MODULE_LICENSE("GPL v2");
>
>



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
