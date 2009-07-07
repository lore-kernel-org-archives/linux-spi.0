From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fwd: [PATCH] This adds support for SPI slave
	controller drivers
Date: Tue, 7 Jul 2009 21:58:59 +0200
Message-ID: <63386a3d0907071258t695fdbaerd8485c58f27dcd00@mail.gmail.com>
References: <1243914698.22129.4.camel@ubuntu-vmware>
	<63386a3d0906121312x31e3ff5dy75d64c56c08fffb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	spi mailing list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <63386a3d0906121312x31e3ff5dy75d64c56c08fffb0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

---------- Forwarded message ----------
From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: 2009/6/12
Subject: Re: [spi-devel-general] [PATCH] This adds support for SPI
slave controller drivers
To: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Kopia: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, spi mailing
list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>


2009/6/2 Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>:

> This patch adds a new API to support slave SPI controller drivers.

That's very interesting!

> Signed-off-by: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
> =A0drivers/spi/spi.c =A0 =A0 =A0 | =A0368

Can you include a Kconfig alteration so that there is also
config SPI_SLAVE and make it possible to have either MASTER,
SLAVE or BOTH devices? So that we get three classes of SPI
drivers in the Kconfig?

I also wonder how hard it would be to modify spi.c so that it
only conditionally compiles in MASTER and/or SLAVE, such
that it is possible to compile in only MASTER code if you only
use the SPI subsystem as master and only SLAVE code if
you only use the SPI subsystem as slave. So splitting the
code in two sets - one with the master functions withing a
#ifdef CONFIG_SPI_MASTER and one set inside
#ifdef CONFIG_SPI_SLAVE and then follow the pattern from
(See rule 2 from Documentation/SubmittingPatches)

The primary reason is that embedded folks worry a lot about
system footprint (bloat) and would probably like to have it that
way.

Some people will probably argue that in that case it is better
to split the implementation in two files so spi.{c|h} is split into
spi-master.{c|h} and spi-slave.{c|h} you get the picture. Do these
two things share enough stuff to warrant being in the same
file (and I think #fidef:ed) or should it be splitted up?

> ++++++++++++++++++++++++++++++++++++++++++-----
> =A0include/linux/spi/spi.h | =A0100 ++++++++++++-
> =A02 files changed, 427 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 8eba98c..504f0ae 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -26,19 +26,34 @@
> =A0#include <linux/spi/spi.h>
>
>
> -/* SPI bustype and spi_master class are registered after board init
> code
> - * provides the SPI device tables, ensuring that both are present by
> the
> - * time controller driver registration causes spi_devices to
> "enumerate".
> - */
> +/* SPI bustype, spi_master and spi_slave class are registered after
> board
> +* init code provides the SPI device tables, ensuring that both are
> present
> +* by the time controller driver registration causes spi_devices
> +* to "enumerate".
> +*/
> +
> +/* SPI Slave Support is added for new spi slave devices: It uses common
> APIs,
> +* apart from few new APIs and a spi_slave structure.
> +*/
> +
> =A0static void spidev_release(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct spi_device =A0 =A0 =A0 *spi =3D to_spi_device(dev);
>
> - =A0 =A0 =A0 /* spi masters may cleanup for released devices */
> - =A0 =A0 =A0 if (spi->master->cleanup)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->master->cleanup(spi);
> + =A0 =A0 =A0 if (spi->master) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* spi masters may cleanup for released dev=
ices */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi->master->cleanup)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->master->cleanup(spi);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_master_put(spi->master);
> + =A0 =A0 =A0 } else {

Is it really mutually exclusive like that?

I think terminating the if() clause and then
if (spi->slave) { is better but that's just me.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* spi slave controller */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi->slave->cleanup)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->slave->cleanup(spi);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_slave_put(spi->slave);
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 spi_master_put(spi->master);
> =A0 =A0 =A0 =A0kfree(dev);
> =A0}
>
> @@ -46,7 +61,6 @@ static ssize_t
> =A0modalias_show(struct device *dev, struct device_attribute *a, char
> *buf)
> =A0{
> =A0 =A0 =A0 =A0const struct spi_device *spi =3D to_spi_device(dev);
> -
> =A0 =A0 =A0 =A0return sprintf(buf, "%s\n", spi->modalias);
> =A0}
>
> @@ -62,14 +76,12 @@ static struct device_attribute spi_dev_attrs[] =3D {
> =A0static int spi_match_device(struct device *dev, struct device_driver
> *drv)
> =A0{
> =A0 =A0 =A0 =A0const struct spi_device *spi =3D to_spi_device(dev);
> -
> =A0 =A0 =A0 =A0return strcmp(spi->modalias, drv->name) =3D=3D 0;
> =A0}
>
> =A0static int spi_uevent(struct device *dev, struct kobj_uevent_env *env)
> =A0{
> =A0 =A0 =A0 =A0const struct spi_device =A0 =A0 =A0 =A0 *spi =3D to_spi_de=
vice(dev);
> -
> =A0 =A0 =A0 =A0add_uevent_var(env, "MODALIAS=3D%s", spi->modalias);
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -153,10 +165,13 @@ int spi_register_driver(struct spi_driver *sdrv)
> =A0 =A0 =A0 =A0sdrv->driver.bus =3D &spi_bus_type;
> =A0 =A0 =A0 =A0if (sdrv->probe)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdrv->driver.probe =3D spi_drv_probe;
> +
> =A0 =A0 =A0 =A0if (sdrv->remove)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdrv->driver.remove =3D spi_drv_remove;
> +
> =A0 =A0 =A0 =A0if (sdrv->shutdown)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdrv->driver.shutdown =3D spi_drv_shutdown;
> +
> =A0 =A0 =A0 =A0return driver_register(&sdrv->driver);
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_register_driver);
> @@ -197,28 +212,70 @@ static DEFINE_MUTEX(board_lock);
> =A0*/
> =A0struct spi_device *spi_alloc_device(struct spi_master *master)

As a consequence this should be renamed spi_alloc_master_device()

> =A0{
> - =A0 =A0 =A0 struct spi_device =A0 =A0 =A0 *spi;
> + =A0 =A0 =A0 struct spi_device =A0 =A0 =A0 *spi_m_dev;

You even rename the local variables like this to reflect that
it's a master function now...

> =A0 =A0 =A0 =A0struct device =A0 =A0 =A0 =A0 =A0 *dev =3D master->dev.par=
ent;
>
> =A0 =A0 =A0 =A0if (!spi_master_get(master))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>
> - =A0 =A0 =A0 spi =3D kzalloc(sizeof *spi, GFP_KERNEL);
> - =A0 =A0 =A0 if (!spi) {
> + =A0 =A0 =A0 spi_m_dev =3D kzalloc(sizeof *spi_m_dev, GFP_KERNEL);
> + =A0 =A0 =A0 if (!spi_m_dev) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "cannot alloc spi_device\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi_master_put(master);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 spi->master =3D master;
> - =A0 =A0 =A0 spi->dev.parent =3D dev;
> - =A0 =A0 =A0 spi->dev.bus =3D &spi_bus_type;
> - =A0 =A0 =A0 spi->dev.release =3D spidev_release;
> - =A0 =A0 =A0 device_initialize(&spi->dev);
> - =A0 =A0 =A0 return spi;
> + =A0 =A0 =A0 spi_m_dev->master =3D master;
> + =A0 =A0 =A0 spi_m_dev->slave =3D NULL;
> + =A0 =A0 =A0 spi_m_dev->dev.parent =3D dev;
> + =A0 =A0 =A0 spi_m_dev->dev.bus =3D &spi_bus_type;
> + =A0 =A0 =A0 spi_m_dev->dev.release =3D spidev_release;
> + =A0 =A0 =A0 device_initialize(&spi_m_dev->dev);
> + =A0 =A0 =A0 return spi_m_dev;
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_alloc_device);
>
> +/*

Open with two stars to get kerneldoc /**

> +* spi_alloc_slave_device - Allocate a new SPI device
> +* @slave: Controller to which device is connected
> +* Context: can sleep
> +*
> +* Allows a driver to allocate and initialize a spi_device without
> +* registering it immediately. =A0This allows a driver to directly
> +* fill the spi_device with device parameters before calling
> +* spi_add_slave_device() on it.
> +*
> +* Caller is responsible to call spi_add_slave_device() on the returned
> +* spi_device structure to add it to the SPI slave. =A0If the caller
> +* needs to discard the spi_device without adding it, then it should
> +* call spi_dev_slave_put() on it.
> +* Returns a pointer to the new device, or NULL.
> +*/
> +struct spi_device *spi_alloc_slave_device(struct spi_slave *slave)
> +{
> + =A0 =A0 =A0 struct spi_device =A0 =A0 =A0 *spi_s;
> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev =3D slave->dev.paren=
t;
> +
> + =A0 =A0 =A0 if (!spi_slave_get(slave))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 spi_s =3D kzalloc(sizeof *spi_s, GFP_KERNEL);
> + =A0 =A0 =A0 if (!spi_s) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "cannot alloc spi_slave_device=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_slave_put(slave);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spi_s->slave =3D slave;
> + =A0 =A0 =A0 spi_s->master =3D NULL;
> + =A0 =A0 =A0 spi_s->dev.parent =3D dev;
> + =A0 =A0 =A0 spi_s->dev.bus =3D &spi_bus_type;
> + =A0 =A0 =A0 spi_s->dev.release =3D spidev_release;
> + =A0 =A0 =A0 device_initialize(&spi_s->dev);
> + =A0 =A0 =A0 return spi_s;
> +}
> +EXPORT_SYMBOL_GPL(spi_alloc_slave_device);
> +
> =A0/**
> =A0* spi_add_device - Add spi_device allocated with spi_alloc_device
> =A0* @spi: spi_device to register
> @@ -231,21 +288,29 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
> =A0int spi_add_device(struct spi_device *spi)
> =A0{
> =A0 =A0 =A0 =A0static DEFINE_MUTEX(spi_add_lock);
> - =A0 =A0 =A0 struct device *dev =3D spi->master->dev.parent;
> =A0 =A0 =A0 =A0int status;
> -
> - =A0 =A0 =A0 /* Chipselects are numbered 0..max; validate. */
> - =A0 =A0 =A0 if (spi->chip_select >=3D spi->master->num_chipselect) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "cs%d >=3D max %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_select,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->master->num_chipselect=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
> -
> + =A0 =A0 =A0 struct device *dev;
> +
> + =A0 =A0 =A0 if (spi->master) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Master Controller */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev =3D spi->master->dev.parent;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Chipselects are numbered 0..max; validat=
e. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi->chip_select >=3D spi->master->num_=
chipselect) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "cs%d >=3D max=
 %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_s=
elect,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->master=
->num_chipselect);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0/* Set the bus ID string */
> =A0 =A0 =A0 =A0dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->master->de=
v),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi->chip_select);
> -
> + =A0 =A0 =A0 } else {

I prefer if (spi->slave) {

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Slave Controller */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev =3D spi->slave->dev.parent;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the bus ID string */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_set_name(&spi->dev, "%s.%u", dev_name(&=
spi->slave->dev),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_s=
elect);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* We need to make sure there's no other device with this
> =A0 =A0 =A0 =A0 * chipselect **BEFORE** we call setup(), else we'll trash
> @@ -265,7 +330,11 @@ int spi_add_device(struct spi_device *spi)
> =A0 =A0 =A0 =A0 * normally rely on the device being setup. =A0Devices
> =A0 =A0 =A0 =A0 * using SPI_CS_HIGH can't coexist well otherwise...
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 status =3D spi->master->setup(spi);
> + =A0 =A0 =A0 if (spi->master)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D spi->master->setup(spi);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D spi->slave->setup(spi); =A0 =A0 =
=A0 =A0/* Slave Controller */
> +
> =A0 =A0 =A0 =A0if (status < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "can't %s %s, status %d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"setup", d=
ev_name(&spi->dev), status);
> @@ -286,6 +355,7 @@ done:
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_add_device);
>
> +
> =A0/**
> =A0* spi_new_device - instantiate one new SPI device
> =A0* @master: Controller to which device is connected
> @@ -317,6 +387,8 @@ struct spi_device *spi_new_device(struct spi_master
> *master,
> =A0 =A0 =A0 =A0if (!proxy)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>
> +
> +
> =A0 =A0 =A0 =A0WARN_ON(strlen(chip->modalias) >=3D sizeof(proxy->modalias=
));
>
> =A0 =A0 =A0 =A0proxy->chip_select =3D chip->chip_select;
> @@ -339,6 +411,54 @@ struct spi_device *spi_new_device(struct spi_master
> *master,
> =A0EXPORT_SYMBOL_GPL(spi_new_device);
>
> =A0/**
> +* spi_slave_new_device - instantiate one new SPI device
> +* @slave: Controller to which device is connected
> +* @chip: Describes the SPI device
> +* Context: can sleep
> +*
> +* On typical mainboards, this is purely internal; and it's not needed
> +* after board init creates the hard-wired devices. =A0Some development
> +* platforms may not be able to use spi_register_board_info though, and
> +* this is exported so that for example a USB or parport based adapter
> +* driver could add devices (which it would learn about out-of-band).
> +*
> +* Returns the new device, or NULL.
> +*/
> +struct spi_device *spi_slave_new_device(struct spi_slave *slave,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
spi_board_info *chip)
> +{
> + =A0 =A0 =A0 struct spi_device =A0 =A0 =A0 *proxy_slave;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status;
> +
> + =A0 =A0 =A0 proxy_slave =3D spi_alloc_slave_device(slave);
> +
> + =A0 =A0 =A0 if (!proxy_slave)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 WARN_ON(strlen(chip->modalias) >=3D sizeof(proxy_slave->mod=
alias));
> +
> + =A0 =A0 =A0 proxy_slave->chip_select =3D chip->chip_select;
> + =A0 =A0 =A0 proxy_slave->max_speed_hz =3D chip->max_speed_hz;
> + =A0 =A0 =A0 proxy_slave->mode =3D chip->mode;
> + =A0 =A0 =A0 proxy_slave->irq =3D chip->irq;
> + =A0 =A0 =A0 strlcpy(proxy_slave->modalias, chip->modalias,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 sizeof(proxy_slave->modalias));
> + =A0 =A0 =A0 proxy_slave->dev.platform_data =3D (void *) chip->platform_=
data;
> + =A0 =A0 =A0 proxy_slave->controller_data =3D chip->controller_data;
> + =A0 =A0 =A0 proxy_slave->controller_state =3D NULL;
> +
> + =A0 =A0 =A0 status =3D spi_add_device(proxy_slave);
> + =A0 =A0 =A0 if (status < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_dev_put(proxy_slave);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return proxy_slave;
> +}
> +EXPORT_SYMBOL_GPL(spi_slave_new_device);
> +
> +
> +/**
> =A0* spi_register_board_info - register SPI devices for a given board
> =A0* @info: array of chip descriptors
> =A0* @n: how many descriptors are provided
> @@ -365,6 +485,7 @@ spi_register_board_info(struct spi_board_info const
> *info, unsigned n)

Rename to spi_register_master_board_info() or similar?

> =A0 =A0 =A0 =A0bi =3D kmalloc(sizeof(*bi) + n * sizeof *info, GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!bi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> +
> =A0 =A0 =A0 =A0bi->n_board_info =3D n;
> =A0 =A0 =A0 =A0memcpy(bi->board_info, info, n * sizeof *info);
>
> @@ -374,6 +495,7 @@ spi_register_board_info(struct spi_board_info const
> *info, unsigned n)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +
> =A0/* FIXME someone should add support for a __setup("spi", ...) that
> =A0* creates board info from kernel command lines
> =A0*/
> @@ -399,6 +521,28 @@ static void scan_boardinfo(struct spi_master
> *master)

Rename to scan_master_boardinfo() or similar?

> =A0 =A0 =A0 =A0mutex_unlock(&board_lock);
> =A0}
>
> +static void spi_slave_scan_boardinfo(struct spi_slave *slave)
> +{
> + =A0 =A0 =A0 struct boardinfo =A0 =A0 =A0 =A0*bi;
> +
> + =A0 =A0 =A0 mutex_lock(&board_lock);
> + =A0 =A0 =A0 list_for_each_entry(bi, &board_list, list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_board_info =A0 *chip =3D bi->boa=
rd_info;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (n =3D bi->n_board_info; n > 0; n--, ch=
ip++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chip->bus_num !=3D slav=
e->bus_num)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* NOTE: this relies on spi=
_new_device to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* issue diagnostics when=
 given bogus inputs
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void) spi_slave_new_device=
(slave, chip);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 mutex_unlock(&board_lock);
> +}
> +
> =A0/*--------------------------------------------------------------------=
-----*/
>
> =A0static void spi_master_release(struct device *dev)
> @@ -415,6 +559,19 @@ static struct class spi_master_class =3D {
> =A0 =A0 =A0 =A0.dev_release =A0 =A0=3D spi_master_release,
> =A0};
>
> +static void spi_slave_release(struct device *dev)
> +{
> + =A0 =A0 =A0 struct spi_slave *slave;
> +
> + =A0 =A0 =A0 slave =3D container_of(dev, struct spi_slave, dev);
> + =A0 =A0 =A0 kfree(slave);
> +}
> +
> +static struct class spi_slave_class =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "spi_slave",
> + =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 .dev_release =A0 =A0=3D spi_slave_release,
> +};
>
> =A0/**
> =A0* spi_alloc_master - allocate SPI master controller
> @@ -456,6 +613,47 @@ struct spi_master *spi_alloc_master(struct device
> *dev, unsigned size)
> =A0EXPORT_SYMBOL_GPL(spi_alloc_master);
>
> =A0/**
> +* spi_alloc_slave - allocate SPI slave controller
> +* @dev: the controller, possibly using the platform_bus
> +* @size: how much zeroed driver-private data to allocate; the pointer
> to this
> +* =A0 =A0 =A0memory is in the driver_data field of the returned device,
> +* =A0 =A0 =A0accessible with spi_slave_get_devdata().
> +* Context: can sleep
> +*
> +* This call is used only by SPI master controller drivers, which are
> the
> +* only ones directly touching chip registers. =A0It's how they allocate
> +* an spi_master structure, prior to calling spi_register_slave().
> +*
> +* This must be called from context that can sleep. =A0It returns the SPI
> +* master structure on success, else NULL.
> +*
> +* The caller is responsible for assigning the bus number and
> initializing
> +* the master's methods before calling spi_register_slave(); and (after
> errors
> +* adding the device) calling spi_slave_put() to prevent a memory leak.
> +*/
> +struct spi_slave *spi_alloc_slave(struct device *dev, unsigned size)
> +{
> + =A0 =A0 =A0 struct spi_slave =A0 =A0 =A0 =A0*slave;
> +
> + =A0 =A0 =A0 if (!dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 slave =3D kzalloc(size + sizeof *slave, GFP_KERNEL);
> + =A0 =A0 =A0 if (!slave)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 device_initialize(&slave->dev);
> + =A0 =A0 =A0 slave->dev.class =3D &spi_slave_class;
> + =A0 =A0 =A0 slave->dev.parent =3D get_device(dev);
> + =A0 =A0 =A0 spi_slave_set_devdata(slave, &slave[1]);
> +
> + =A0 =A0 =A0 return slave;
> +}
> +EXPORT_SYMBOL_GPL(spi_alloc_slave);
> +
> +
> +
> +/**
> =A0* spi_register_master - register SPI master controller
> =A0* @master: initialized master, originally from spi_alloc_master()
> =A0* Context: can sleep
> @@ -507,7 +705,8 @@ int spi_register_master(struct spi_master *master)
> =A0 =A0 =A0 =A0status =3D device_add(&master->dev);
> =A0 =A0 =A0 =A0if (status < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto done;
> - =A0 =A0 =A0 dev_dbg(dev, "registered master %s%s\n", dev_name(&master->=
dev),
> +
> + =A0 =A0 =A0 dev_dbg(dev, "spi_register_master() : %s%s\n", dev_name(&ma=
ster->dev),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dynamic ? " (dynamic)" : "=
");
>
> =A0 =A0 =A0 =A0/* populate children from any spi device tables */
> @@ -518,6 +717,69 @@ done:
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_register_master);
>
> +/**
> +* spi_register_slave - register SPI slave controller
> +* @master: initialized master, originally from spi_alloc_slave()
> +* Context: can sleep
> +*
> +* SPI slave controllers connect to their drivers using some non-SPI
> bus,
> +* such as the platform bus. =A0The final stage of probe() in that code
> +* includes calling spi_register_slave() to hook up to this SPI bus
> glue.
> +*
> +* SPI controllers use board specific (often SOC specific) bus numbers,
> +* and board-specific addressing for SPI devices combines those numbers
> +* with chip select numbers. =A0Since SPI does not directly support
> dynamic
> +* device identification, boards need configuration tables telling which
> +* chip is at which address.
> +*
> +* This must be called from context that can sleep. =A0It returns zero on
> +* success, else a negative error code (dropping the slave's refcount).
> +* After a successful return, the caller is responsible for calling
> +* spi_unregister_slave().
> +*/
> +int spi_register_slave(struct spi_slave *slave)
> +{
> + =A0 =A0 =A0 static atomic_t =A0 =A0 =A0 =A0 dyn_bus_id =3D ATOMIC_INIT(=
(1<<15) - 1);
> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev =3D slave->dev.paren=
t;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENO=
DEV;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dynamic =3D 0;
> +
> + =A0 =A0 =A0 if (!dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 /* even if it's just one always-selected device, there must
> + =A0 =A0 =A0 =A0* be at least one chipselect
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (slave->num_chipselect =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 /* convention: =A0dynamically assigned bus IDs count down f=
rom the max
> */
> + =A0 =A0 =A0 if (slave->bus_num < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME switch to an IDR based scheme, som=
ething like
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* I2C now uses, so we can't run out of "=
dynamic" IDs
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 slave->bus_num =3D atomic_dec_return(&dyn_b=
us_id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dynamic =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* register the device, then userspace will see it.
> + =A0 =A0 =A0 =A0* registration fails if the bus ID is in use.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 dev_set_name(&slave->dev, "spi%u", slave->bus_num);
> + =A0 =A0 =A0 status =3D device_add(&slave->dev);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "registered slave %s%s\n", dev_name(&slave->de=
v),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dynamic ? " (dynamic)" : ""=
);
> +
> + =A0 =A0 =A0 /* populate children from any spi device tables */
> + =A0 =A0 =A0 spi_slave_scan_boardinfo(slave);
> + =A0 =A0 =A0 status =3D 0;
> +done:
> + =A0 =A0 =A0 return status;
> +}
> +EXPORT_SYMBOL_GPL(spi_register_slave);
>
> =A0static int __unregister(struct device *dev, void *master_dev)

Rename this __unregister_master() then?

> =A0{
> @@ -547,6 +809,27 @@ void spi_unregister_master(struct spi_master
> *master)
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_unregister_master);
>
> +/**
> +* spi_unregister_slave - unregister SPI slave controller
> +* @master: the slave being unregistered
> +* Context: can sleep
> +*
> +* This call is used only by SPI slave controller drivers, which are the
> +* only ones directly touching chip registers.
> +*
> +* This must be called from context that can sleep.
> +*/
> +void spi_unregister_slave(struct spi_slave *slave)
> +{
> + =A0 =A0 =A0 int dummy;
> +
> + =A0 =A0 =A0 dummy =3D device_for_each_child(slave->dev.parent, &slave->=
dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 __unregister);
> + =A0 =A0 =A0 device_unregister(&slave->dev);
> +}
> +EXPORT_SYMBOL_GPL(spi_unregister_slave);
> +
> +
> =A0static int __spi_master_match(struct device *dev, void *data)
> =A0{
> =A0 =A0 =A0 =A0struct spi_master *m;
> @@ -626,6 +909,18 @@ int spi_sync(struct spi_device *spi, struct
> spi_message *message)
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_sync);
>
> +/* spi_transfer_async - Wraper function to allow spi_async to expose to
> +* user protocol drivers for modem handshaking

What is that comment about "modem handshaking" supposed
to mean? I'm way confused by that... SPI can be used for
anything, not just modems.

> +*/
> +
> +int spi_transfer_async(struct spi_device *spi, struct spi_message
> *message)
> +{
> + =A0 =A0 =A0 int status;
> + =A0 =A0 =A0 status =3D spi_async(spi, message);
> + =A0 =A0 =A0 return status;
> +}
> +EXPORT_SYMBOL_GPL(spi_transfer_async);
> +

Is this some slave-specific function or what is it?
Is it part of the SPI slave support patchset or can it be
handled separately?


> =A0/* portable code must never pass more than 32 bytes */
> =A0#define =A0 =A0 =A0 =A0SPI_BUFSIZ =A0 =A0 =A0max(32,SMP_CACHE_BYTES)
>
> @@ -724,6 +1019,12 @@ static int __init spi_init(void)
> =A0 =A0 =A0 =A0status =3D class_register(&spi_master_class);
> =A0 =A0 =A0 =A0if (status < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err2;
> +
> + =A0 =A0 =A0 status =3D class_register(&spi_slave_class);
> +
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> +

I would register each of these conditionally.

> =A0 =A0 =A0 =A0return 0;
>
> =A0err2:
> @@ -743,4 +1044,3 @@ err0:
> =A0* include needing to have boardinfo data structures be much more
> public.
> =A0*/
> =A0postcore_initcall(spi_init);
> -
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index a0faa18..5845bb1 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -22,15 +22,18 @@
> =A0#include <linux/device.h>
>
> =A0/*
> - * INTERFACES between SPI master-side drivers and SPI infrastructure.
> - * (There's no SPI slave support for Linux yet...)
> + * INTERFACES between SPI Master/Slave side drivers and
> + * SPI infrastructure.

Cool now we have slave support!

> + * SPI Slave Support added : It uses few new APIs and
> + * a new spi_slave struct

Please remove this. No ChangeLogs in the kernel files.
See

> =A0*/
> =A0extern struct bus_type spi_bus_type;
>
> =A0/**
> =A0* struct spi_device - Master side proxy for an SPI slave device
> =A0* @dev: Driver model representation of the device.
> - * @master: SPI controller used with the device.
> + * @master: SPI Master controller used with the device.
> + * @slave: SPI Slave Controller used with the device
> =A0* @max_speed_hz: Maximum clock rate to be used with this chip
> =A0* =A0 =A0 (on this board); may be changed by the device's driver.
> =A0* =A0 =A0 The spi_transfer.speed_hz can override this for each transfe=
r.
> @@ -67,6 +70,7 @@ extern struct bus_type spi_bus_type;
> =A0struct spi_device {
> =A0 =A0 =A0 =A0struct device =A0 =A0 =A0 =A0 =A0 dev;
> =A0 =A0 =A0 =A0struct spi_master =A0 =A0 =A0 *master;
> + =A0 =A0 =A0 struct spi_slave =A0 =A0 =A0 =A0*slave;

I would certainly consider
#ifdef CONFIG_SPI_MASTER
=A0 =A0 =A0 =A0struct spi_master =A0 =A0 =A0 *master;
#endif
#ifdef CONFIG_SPI_SLAVE
=A0 =A0 =A0 struct spi_slave =A0 =A0 =A0 =A0*slave;
#endif

> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_speed_hz;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip_select;

There are a lot of things in this struct that I think is only
applicable to masters. A slave driver is not in the position
of dictating its max speed, chip select etc and it should then
be moved to the spi_master struct, should have been earlier
perhaps but it is really a prerequisite for slave support
I think.

> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode;
> @@ -140,7 +144,6 @@ static inline void *spi_get_drvdata(struct
> spi_device *spi)
> =A0struct spi_message;
>
>
> -
> =A0/**
> =A0* struct spi_driver - Host side "protocol" driver
> =A0* @probe: Binds this driver to the spi device. =A0Drivers can verify
> @@ -279,16 +282,56 @@ struct spi_master {
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*cleanup)(str=
uct spi_device *spi);
> =A0};
>
> +/**
> + * struct spi_slave - interface to SPI Slave Controller
> + * @dev: device interface to this driver
> + * @bus_num: board-specific (and often SOC-specific) identifier for a
> + * =A0 =A0 given SPI controller.
> + * @num_chipselect: chipselects are used to distinguish individual
> + * =A0 =A0 SPI slaves, and are numbered from zero to num_chipselects.
> + * =A0 =A0 each slave has a chipselect signal, but it's common that not
> + * =A0 =A0 every chipselect is connected to a slave.
> + * @setup: updates the device mode and clocking records used by a
> + * =A0 =A0 device's SPI controller; protocol code may call this. =A0This
> + * =A0 =A0 must fail if an unrecognized or unsupported mode is requested.
> + * =A0 =A0 It's always safe to call this unless transfers are pending on
> + * =A0 =A0 the device whose settings are being modified.
> + * @transfer: adds a message to the controller's transfer queue.
> + * @cleanup: frees controller-specific state
> + */
> +struct spi_slave {
> + =A0 =A0 =A0 struct device =A0 dev;
> + =A0 =A0 =A0 s16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_num;
> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_chipselect;
> +
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*setup)(struct=
 spi_device *spi);
> +
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*transfer)(str=
uct spi_device *spi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 struct spi_message *mesg);

Is this name really apropriate for a slave, shouldn't it be
named (*receive) rather than (*transfer)?

> +
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*cleanup)(stru=
ct spi_device *spi);
> +};
> +
> =A0static inline void *spi_master_get_devdata(struct spi_master *master)
> =A0{
> =A0 =A0 =A0 =A0return dev_get_drvdata(&master->dev);
> =A0}
>
> +static inline void *spi_slave_get_devdata(struct spi_slave *slave)
> +{
> + =A0 =A0 =A0 return dev_get_drvdata(&slave->dev);
> +}
> +
> =A0static inline void spi_master_set_devdata(struct spi_master *master,
> void *data)
> =A0{
> =A0 =A0 =A0 =A0dev_set_drvdata(&master->dev, data);
> =A0}
>
> +static inline void spi_slave_set_devdata(struct spi_slave *slave, void
> *data)
> +{
> + =A0 =A0 =A0 dev_set_drvdata(&slave->dev, data);
> +}
> +
> =A0static inline struct spi_master *spi_master_get(struct spi_master
> *master)
> =A0{
> =A0 =A0 =A0 =A0if (!master || !get_device(&master->dev))
> @@ -296,20 +339,42 @@ static inline struct spi_master
> *spi_master_get(struct spi_master *master)
> =A0 =A0 =A0 =A0return master;
> =A0}
>
> +static inline struct spi_slave *spi_slave_get(struct spi_slave *slave)
> +{
> + =A0 =A0 =A0 if (!slave || !get_device(&slave->dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 return slave;
> +}
> +
> =A0static inline void spi_master_put(struct spi_master *master)
> =A0{
> =A0 =A0 =A0 =A0if (master)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0put_device(&master->dev);
> =A0}
>
> +static inline void spi_slave_put(struct spi_slave *slave)
> +{
> + =A0 =A0 =A0 if (slave)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_device(&slave->dev);
> +}
> +
>
> =A0/* the spi driver core manages memory for the spi_master classdev */
> =A0extern struct spi_master *
> =A0spi_alloc_master(struct device *host, unsigned size);
>
> +extern struct spi_slave *
> +spi_alloc_slave(struct device *host, unsigned size);
> +
> +
> =A0extern int spi_register_master(struct spi_master *master);
> +
> +extern int spi_register_slave(struct spi_slave *slave);
> +
> =A0extern void spi_unregister_master(struct spi_master *master);
>
> +extern void spi_unregister_slave(struct spi_slave *slave);
> +
> =A0extern struct spi_master *spi_busnum_to_master(u16 busnum);
>
> =A0/*--------------------------------------------------------------------=
-------*/
> @@ -544,10 +609,12 @@ static inline void spi_message_free(struct
> spi_message *m)
> =A0static inline int
> =A0spi_setup(struct spi_device *spi)
> =A0{
> - =A0 =A0 =A0 return spi->master->setup(spi);
> + =A0 =A0 =A0 if (spi->master)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return spi->master->setup(spi);
> + =A0 =A0 =A0 else

if (spi->slave)

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return spi->slave->setup(spi);
> =A0}
>
> -
> =A0/**
> =A0* spi_async - asynchronous SPI transfer
> =A0* @spi: device with which data will be exchanged
> @@ -581,7 +648,10 @@ static inline int
> =A0spi_async(struct spi_device *spi, struct spi_message *message)
> =A0{
> =A0 =A0 =A0 =A0message->spi =3D spi;
> - =A0 =A0 =A0 return spi->master->transfer(spi, message);
> + =A0 =A0 =A0 if (spi->master)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return spi->master->transfer(spi, message);=
 =A0 =A0 /* Master */
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return spi->slave->transfer(spi, message); =
=A0 =A0 =A0/* Slave */

rename spi->slave->receive()

> =A0}
>
> =A0/*--------------------------------------------------------------------=
-------*/
> @@ -593,6 +663,11 @@ spi_async(struct spi_device *spi, struct
> spi_message *message)
>
> =A0extern int spi_sync(struct spi_device *spi, struct spi_message
> *message);
>
> +/* spi_transfer_async() exposes spi_async() functionality */
> +extern int spi_transfer_async(struct spi_device *spi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_mess=
age *message);
> +
> +
> =A0/**
> =A0* spi_write - SPI synchronous write
> =A0* @spi: device to which data will be written
> @@ -801,12 +876,23 @@ spi_register_board_info(struct spi_board_info
> const *info, unsigned n)
> =A0extern struct spi_device *
> =A0spi_alloc_device(struct spi_master *master);
>
> +extern struct spi_device *
> +spi_alloc_slave_device(struct spi_slave *slave);
> +
> =A0extern int
> =A0spi_add_device(struct spi_device *spi);
>
> +extern int
> +spi_add_slave_device(struct spi_device *spi);
> +
> +
> =A0extern struct spi_device *
> =A0spi_new_device(struct spi_master *, struct spi_board_info *);
>
> +extern struct spi_device *
> +spi_slave_new_device(struct spi_slave *, struct spi_board_info *);
> +
> +
> =A0static inline void
> =A0spi_unregister_device(struct spi_device *spi)
> =A0{
> --
> 1.5.4.3
>

Hope this helps,
Linus Walleij

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have =

the opportunity to enter the BlackBerry Developer Challenge. See full prize =

details at: http://p.sf.net/sfu/blackberry
