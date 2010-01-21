From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] Memory-mapped dw_spi driver
Date: Thu, 21 Jan 2010 15:53:36 +0100
Message-ID: <20100121145336.GC3738@pengutronix.de>
References: <20100121142636.31707.70616.stgit@station520.octasic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0082352723911529055=="
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


--===============0082352723911529055==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2010 at 09:27:26AM -0500, Jean-Hugues Deschenes wrote:
> Adds a memory-mapped I/O dw_spi platform device.
>=20

Only minor stuff.

> ---
> Changelog v1->v2
> - simplified dw_spi_mmio.c preamble (Grant Likely)
> - build of dw_spi_mmio and dw_spi_pci are now independant
>   of each other (Grant Likely)
> - add call to dw_spi_remove_host (Feng Tang)
> ---
>=20
> Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/spi/Kconfig       |    4 +
>  drivers/spi/Makefile      |    1=20
>  drivers/spi/dw_spi_mmio.c |  148 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 153 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/dw_spi_mmio.c
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index f55eb01..02be3a6 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -317,6 +317,10 @@ config SPI_DW_PCI
>  	tristate "PCI interface driver for DW SPI core"
>  	depends on SPI_DESIGNWARE && PCI
> =20
> +config SPI_DW_MMIO
> +	tristate "Memory-mapped io interface driver for DW SPI core"

DesignWare would be better readable than DW, but then it should be fixed for
PCI, too. Well, never mind...

> +	depends on SPI_DESIGNWARE
> +
>  #
>  # There are lots of SPI device types, with sensors and memory
>  # being probably the most widely used ones.
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index f3d2810..c3e5ce7 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_SPI_AU1550)		+=3D au1550_spi.o
>  obj-$(CONFIG_SPI_BUTTERFLY)		+=3D spi_butterfly.o
>  obj-$(CONFIG_SPI_DESIGNWARE)		+=3D dw_spi.o
>  obj-$(CONFIG_SPI_DW_PCI)		+=3D dw_spi_pci.o
> +obj-$(CONFIG_SPI_DW_MMIO)		+=3D dw_spi_mmio.o
>  obj-$(CONFIG_SPI_GPIO)			+=3D spi_gpio.o
>  obj-$(CONFIG_SPI_IMX)			+=3D spi_imx.o
>  obj-$(CONFIG_SPI_LM70_LLP)		+=3D spi_lm70llp.o
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
> +	struct dw_spi	dws;
> +	struct clk		*clk;
> +};

Broken indentation (just space after the struct name)

> +
> +static int __devinit dw_spi_mmio_probe(struct platform_device *pdev)
> +{
> +	struct dw_spi_mmio *dwsmmio;
> +	struct dw_spi *dws;
> +	struct resource *mem, *ioarea;
> +	int ret;
> +
> +	dwsmmio =3D kzalloc(sizeof(struct dw_spi_mmio), GFP_KERNEL);
> +	if (!dwsmmio) {
> +		ret =3D -ENOMEM;
> +		goto err_end;
> +	}
> +
> +	dws =3D &dwsmmio->dws;
> +
> +	/* Get basic io resource and map it */
> +	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem) {
> +		dev_err(&pdev->dev, "no mem resource?\n");
> +		ret =3D -EINVAL;
> +		goto err_kfree;
> +	}
> +
> +	ioarea =3D request_mem_region(mem->start, resource_size(mem),
> +			pdev->name);
> +	if (!ioarea) {
> +		dev_err(&pdev->dev, "SPI region already claimed\n");
> +		ret =3D -EBUSY;
> +		goto err_kfree;
> +	}
> +
> +	dws->regs =3D ioremap_nocache(mem->start, resource_size(mem));
> +	if (!dws->regs) {
> +		dev_err(&pdev->dev, "SPI region already mapped\n");
> +		ret =3D -ENOMEM;
> +		goto err_release_reg;
> +	}
> +
> +	dws->irq =3D platform_get_irq(pdev, 0);
> +	if (dws->irq < 0) {
> +		dev_err(&pdev->dev, "no irq resource?\n");
> +		ret =3D dws->irq; /* -ENXIO */
> +		goto err_unmap;
> +	}
> +
> +	dwsmmio->clk =3D clk_get(&pdev->dev, NULL);
> +	if (!dwsmmio->clk) {
> +		ret =3D -ENODEV;
> +		goto err_irq;
> +	}
> +	clk_enable(dwsmmio->clk);
> +
> +	dws->parent_dev =3D &pdev->dev;
> +	dws->bus_num =3D 0;
> +	dws->num_cs =3D 4;
> +	dws->max_freq =3D clk_get_rate(dwsmmio->clk);
> +
> +	ret =3D dw_spi_add_host(dws);
> +	if (ret)
> +		goto err_clk;
> +
> +	platform_set_drvdata(pdev, dwsmmio);
> +	return 0;
> +
> +err_clk:
> +	clk_disable(dwsmmio->clk);
> +	clk_put(dwsmmio->clk);
> +	dwsmmio->clk =3D NULL;
> +err_irq:
> +	free_irq(dws->irq, dws);
> +err_unmap:
> +	iounmap(dws->regs);
> +err_release_reg:
> +	release_mem_region(mem->start, resource_size(mem));
> +err_kfree:
> +	kfree(dwsmmio);
> +err_end:
> +	return ret;
> +}
> +
> +static int __devexit dw_spi_mmio_remove(struct platform_device *pdev)
> +{
> +	struct dw_spi_mmio *dwsmmio =3D platform_get_drvdata(pdev);
> +	struct resource *mem;
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	clk_disable(dwsmmio->clk);
> +	clk_put(dwsmmio->clk);
> +	dwsmmio->clk =3D NULL;
> +
> +	free_irq(dwsmmio->dws.irq, &dwsmmio->dws);
> +	dw_spi_remove_host(&dwsmmio->dws);
> +	iounmap(dwsmmio->dws.regs);
> +	kfree(dwsmmio);
> +
> +	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	release_mem_region(mem->start, resource_size(mem));
> +	return 0;
> +}
> +
> +static struct platform_driver dw_spi_mmio_driver =3D {
> +	.remove		=3D __devexit_p(dw_spi_mmio_remove),
> +	.driver		=3D {
> +		.name	=3D DRIVER_NAME,
> +		.owner	=3D THIS_MODULE,
> +	},
> +};
> +
> +static int __init dw_spi_mmio_init(void)
> +{
> +	return platform_driver_probe(&dw_spi_mmio_driver, dw_spi_mmio_probe);
> +}
> +
> +static void __exit dw_spi_mmio_exit(void)
> +{
> +	platform_driver_unregister(&dw_spi_mmio_driver);
> +}
> +
> +module_init(dw_spi_mmio_init);
> +module_exit(dw_spi_mmio_exit);

Those should be directly below the functions.

> +
> +MODULE_AUTHOR("Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>=
");
> +MODULE_DESCRIPTION("Memory-mapped I/O interface driver for DW SPI Core");

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktYanAACgkQD27XaX1/VRuY7ACgmEeS/h+PHHAV9YEMZwsu30LL
O78AoMYnViUpRwWjX/N6hWP85viD/oK8
=42sy
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--


--===============0082352723911529055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
--===============0082352723911529055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0082352723911529055==--
