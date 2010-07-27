From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] of/spi: call of_register_spi_devices() from spi core code
Date: Tue, 27 Jul 2010 11:40:34 -0600
Message-ID: <AANLkTimG+QLksWVbQ63F=Bc1h-9946J1RO0qSavBAegO@mail.gmail.com>
References: <AANLkTik9GYDGi3jnMdPdyOa6sFv4bo_+4b-RWMq7nW6x@mail.gmail.com>
	<1280237967-2460-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1280237967-2460-1-git-send-email-agust-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 27, 2010 at 7:39 AM, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org> wrote:
> Move of_register_spi_devices() call from some drivers to
> spi_register_master(). Also change the function to use
> the struct device_node pointer from master spi device
> instead of passing it as function argument.
>
> Since xilinx_spi_of.c and spi_ppc4xx.c drivers do not use
> spi_register_master(), they still call of_register_spi_devices()
> directly. Maybe these drivers should be reworked later.
>
> Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
> Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> ---
> =A0drivers/of/of_spi.c =A0 =A0 =A0 =A0 =A0 | =A0 =A07 +++----
> =A0drivers/spi/mpc52xx_psc_spi.c | =A0 =A09 +--------
> =A0drivers/spi/mpc52xx_spi.c =A0 =A0 | =A0 =A02 --
> =A0drivers/spi/spi.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +++++
> =A0drivers/spi/spi_mpc8xxx.c =A0 =A0 | =A0 =A03 ---
> =A0drivers/spi/spi_ppc4xx.c =A0 =A0 =A0| =A0 =A03 ++-
> =A0drivers/spi/xilinx_spi.c =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/spi/xilinx_spi_of.c =A0 | =A0 =A02 +-
> =A0include/linux/of_spi.h =A0 =A0 =A0 =A0| =A0 11 ++++++++---
> =A09 files changed, 21 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c
> index d504f1d..76a0529 100644
> --- a/drivers/of/of_spi.c
> +++ b/drivers/of/of_spi.c
> @@ -15,12 +15,11 @@
> =A0/**
> =A0* of_register_spi_devices - Register child devices onto the SPI bus
> =A0* @master: =A0 =A0Pointer to spi_master device
> - * @np: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parent node of SPI device nodes
> =A0*
> - * Registers an spi_device for each child node of 'np' which has a 'reg'
> + * Registers an spi_device for each child node of master node which has =
a 'reg'
> =A0* property.
> =A0*/
> -void of_register_spi_devices(struct spi_master *master, struct device_no=
de *np)
> +void of_register_spi_devices(struct spi_master *master)
> =A0{
> =A0 =A0 =A0 =A0struct spi_device *spi;
> =A0 =A0 =A0 =A0struct device_node *nc;
> @@ -28,7 +27,7 @@ void of_register_spi_devices(struct spi_master *master,=
 struct device_node *np)
> =A0 =A0 =A0 =A0int rc;
> =A0 =A0 =A0 =A0int len;

if (!master->dev.of_node)
	return;
>
> - =A0 =A0 =A0 for_each_child_of_node(np, nc) {
> + =A0 =A0 =A0 for_each_child_of_node(master->dev.of_node, nc) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Alloc an spi_device */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi =3D spi_alloc_device(master);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!spi) {
> diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
> index 7104cb7..a6eb5d4 100644
> --- a/drivers/spi/mpc52xx_psc_spi.c
> +++ b/drivers/spi/mpc52xx_psc_spi.c
> @@ -17,7 +17,6 @@
> =A0#include <linux/errno.h>
> =A0#include <linux/interrupt.h>
> =A0#include <linux/of_platform.h>
> -#include <linux/of_spi.h>
> =A0#include <linux/workqueue.h>
> =A0#include <linux/completion.h>
> =A0#include <linux/io.h>
> @@ -470,7 +469,6 @@ static int __init mpc52xx_psc_spi_of_probe(struct of_=
device *op,
> =A0 =A0 =A0 =A0const u32 *regaddr_p;
> =A0 =A0 =A0 =A0u64 regaddr64, size64;
> =A0 =A0 =A0 =A0s16 id =3D -1;
> - =A0 =A0 =A0 int rc;
>
> =A0 =A0 =A0 =A0regaddr_p =3D of_get_address(op->dev.of_node, 0, &size64, =
NULL);
> =A0 =A0 =A0 =A0if (!regaddr_p) {
> @@ -491,13 +489,8 @@ static int __init mpc52xx_psc_spi_of_probe(struct of=
_device *op,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0id =3D *psc_nump + 1;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 rc =3D mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (=
u32)size64,
> + =A0 =A0 =A0 return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (=
u32)size64,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_of_par=
se_and_map(op->dev.of_node, 0), id);
> - =A0 =A0 =A0 if (rc =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_register_spi_devices(dev_get_drvdata(&op=
->dev),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 op->dev.of_node);
> -
> - =A0 =A0 =A0 return rc;
> =A0}
>
> =A0static int __exit mpc52xx_psc_spi_of_remove(struct of_device *op)
> diff --git a/drivers/spi/mpc52xx_spi.c b/drivers/spi/mpc52xx_spi.c
> index b1a76bf..18e1c86 100644
> --- a/drivers/spi/mpc52xx_spi.c
> +++ b/drivers/spi/mpc52xx_spi.c
> @@ -18,7 +18,6 @@
> =A0#include <linux/interrupt.h>
> =A0#include <linux/delay.h>
> =A0#include <linux/spi/spi.h>
> -#include <linux/of_spi.h>
> =A0#include <linux/io.h>
> =A0#include <linux/of_gpio.h>
> =A0#include <linux/slab.h>
> @@ -512,7 +511,6 @@ static int __devinit mpc52xx_spi_probe(struct of_devi=
ce *op,
> =A0 =A0 =A0 =A0if (rc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_register;
>
> - =A0 =A0 =A0 of_register_spi_devices(master, op->dev.of_node);
> =A0 =A0 =A0 =A0dev_info(&ms->master->dev, "registered MPC5200 SPI bus\n");
>
> =A0 =A0 =A0 =A0return rc;
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index fdde706..626fa48 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -26,6 +26,7 @@
> =A0#include <linux/slab.h>
> =A0#include <linux/mod_devicetable.h>
> =A0#include <linux/spi/spi.h>
> +#include <linux/of_spi.h>
>
>
> =A0/* SPI bustype and spi_master class are registered after board init co=
de
> @@ -544,6 +545,10 @@ int spi_register_master(struct spi_master *master)
> =A0 =A0 =A0 =A0/* populate children from any spi device tables */
> =A0 =A0 =A0 =A0scan_boardinfo(master);
> =A0 =A0 =A0 =A0status =3D 0;
> +
> + =A0 =A0 =A0 /* Register devices from the device tree */
> + =A0 =A0 =A0 master->dev.of_node =3D dev->of_node;

Drop this line.  There must be a way for drivers to override the
behaviour.  On i2c I solved this by still requiring the driver to copy
the of_node pointer into the master's dev structure.  That gives
drivers the option to use another node for the list of spi child
devices or to skip broken spi busses.

So this line should still appear in each of the OF-aware SPI bus drivers.

> + =A0 =A0 =A0 of_register_spi_devices(master);
> =A0done:
> =A0 =A0 =A0 =A0return status;
> =A0}
> diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
> index 97ab0a8..89fea11 100644
> --- a/drivers/spi/spi_mpc8xxx.c
> +++ b/drivers/spi/spi_mpc8xxx.c
> @@ -38,7 +38,6 @@
> =A0#include <linux/of_platform.h>
> =A0#include <linux/gpio.h>
> =A0#include <linux/of_gpio.h>
> -#include <linux/of_spi.h>
> =A0#include <linux/slab.h>
>
> =A0#include <sysdev/fsl_soc.h>
> @@ -1299,8 +1298,6 @@ static int __devinit of_mpc8xxx_spi_probe(struct of=
_device *ofdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 of_register_spi_devices(master, np);
> -
> =A0 =A0 =A0 =A0return 0;
>
> =A0err:
> diff --git a/drivers/spi/spi_ppc4xx.c b/drivers/spi/spi_ppc4xx.c
> index d53466a..0bcea55 100644
> --- a/drivers/spi/spi_ppc4xx.c
> +++ b/drivers/spi/spi_ppc4xx.c
> @@ -545,7 +545,8 @@ static int __init spi_ppc4xx_of_probe(struct of_devic=
e *op,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0dev_info(dev, "driver initialized\n");
> - =A0 =A0 =A0 of_register_spi_devices(master, np);
> + =A0 =A0 =A0 master->dev.of_node =3D np;
> + =A0 =A0 =A0 of_register_spi_devices(master);

You can drop these lines.  This drivers calls spi_bitbang_start, which
in turn calls spi_register_master().

>
> =A0 =A0 =A0 =A0return 0;
>
> diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
> index 1b47363..d101a84 100644
> --- a/drivers/spi/xilinx_spi.c
> +++ b/drivers/spi/xilinx_spi.c
> @@ -390,6 +390,7 @@ struct spi_master *xilinx_spi_init(struct device *dev=
, struct resource *mem,
>
> =A0 =A0 =A0 =A0master->bus_num =3D bus_num;
> =A0 =A0 =A0 =A0master->num_chipselect =3D pdata->num_chipselect;
> + =A0 =A0 =A0 master->dev.of_node =3D dev->of_node;
>
> =A0 =A0 =A0 =A0xspi->mem =3D *mem;
> =A0 =A0 =A0 =A0xspi->irq =3D irq;
> diff --git a/drivers/spi/xilinx_spi_of.c b/drivers/spi/xilinx_spi_of.c
> index 4654805..0295bbf 100644
> --- a/drivers/spi/xilinx_spi_of.c
> +++ b/drivers/spi/xilinx_spi_of.c
> @@ -81,7 +81,7 @@ static int __devinit xilinx_spi_of_probe(struct of_devi=
ce *ofdev,
> =A0 =A0 =A0 =A0dev_set_drvdata(&ofdev->dev, master);
>
> =A0 =A0 =A0 =A0/* Add any subnodes on the SPI bus */
> - =A0 =A0 =A0 of_register_spi_devices(master, ofdev->dev.of_node);
> + =A0 =A0 =A0 of_register_spi_devices(master);

Ditto here, spi_bitbang_start() is used by this driver.

Overall though, this is the right direction.  Thanks!

g.

>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> diff --git a/include/linux/of_spi.h b/include/linux/of_spi.h
> index 5f71ee8..9e3e70f 100644
> --- a/include/linux/of_spi.h
> +++ b/include/linux/of_spi.h
> @@ -9,10 +9,15 @@
> =A0#ifndef __LINUX_OF_SPI_H
> =A0#define __LINUX_OF_SPI_H
>
> -#include <linux/of.h>
> =A0#include <linux/spi/spi.h>
>
> -extern void of_register_spi_devices(struct spi_master *master,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct device_node *np);
> +#if defined(CONFIG_OF_SPI) || defined(CONFIG_OF_SPI_MODULE)
> +extern void of_register_spi_devices(struct spi_master *master);
> +#else
> +static inline void of_register_spi_devices(struct spi_master *master)
> +{
> + =A0 =A0 =A0 return;
> +}
> +#endif /* CONFIG_OF_SPI */
>
> =A0#endif /* __LINUX_OF_SPI */
> --
> 1.7.0.4
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
