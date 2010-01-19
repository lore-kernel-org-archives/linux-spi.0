From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] Add support for slave controllers
	plus sysfs entries for power management
Date: Tue, 19 Jan 2010 08:59:40 -0700
Message-ID: <fa686aa41001190759j1d916f87o309efe37b3e96bf4@mail.gmail.com>
References: <1261170416.10785.5.camel@ubuntu-vmware>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi mailing list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1261170416.10785.5.camel@ubuntu-vmware>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Ken,

On Fri, Dec 18, 2009 at 2:06 PM, Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> >From d429aaa794f8d578501c13fed3eae28e50049b1f Mon Sep 17 00:00:00 2001
> From: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Date: Wed, 16 Dec 2009 17:44:54 -0800
> Subject: [PATCH] Add support for slave controllers plus sysfs entries for=
 power
> =A0management

Since this patch changes the behaviour of the core SPI code, I'm
giving it rather more attention than I would for just a device driver.
 The current model is that each spi_device is registered with an
spi_master.  Many device drivers operate on the assumption that the
->master pointer is valid.  With this patch, it appears that
spi_devices can be registered either against an spi_master or an
spi_slave; thus invalidating the assumption drivers are already
operating under.  That alone makes me nervous.

Can you provide a bit of a write up on the model and use cases you see
for spi_slave registrations?  Do you expect any spi_device to be
registered on an spi_slave?  Does the behaviour of an spi_device need
to change when it is registered against an spi_slave?  I want to be
sure that the design is sane before I merge new behaviour into the
core.

g.


> Signed-off-by: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
> =A0drivers/spi/Kconfig =A0 =A0 | =A0 12 ++
> =A0drivers/spi/spi.c =A0 =A0 =A0 | =A0402 +++++++++++++++++++++++++++++++=
++++++++++++++--
> =A0include/linux/spi/spi.h | =A0 83 ++++++++++-
> =A03 files changed, 482 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 4b6f7cb..d1124b3 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -278,6 +278,18 @@ config SPI_TLE62X0
>
> =A0endif # SPI_MASTER
>
> + =A0 =A0 =A0 config SPI_SLAVE
> + =A0 =A0 =A0 bool "SPI Slave support"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This will enable SPI slave controller support. In this =
mode, clock
> + =A0 =A0 =A0 =A0 and frame are provided by the SPI master controller.
> +
> +if SPI_SLAVE
> +
> +comment "SPI SLAVE Controller Drivers"
> +
> =A0# (slave support would go here)
>
> +endif # SPI_SLAVE
> +
> =A0endif # SPI
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index b76f246..9a2a5c9 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -36,10 +36,21 @@ static void spidev_release(struct device *dev)
> =A0 =A0 =A0 =A0struct spi_device =A0 =A0 =A0 *spi =3D to_spi_device(dev);
>
> =A0 =A0 =A0 =A0/* spi masters may cleanup for released devices */
> - =A0 =A0 =A0 if (spi->master->cleanup)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->master->cleanup(spi);
> + =A0 =A0 =A0 if (spi->master) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi->master->cleanup)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->master->cleanup(spi);
>
> - =A0 =A0 =A0 spi_master_put(spi->master);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_master_put(spi->master);
> + =A0 =A0 =A0 }
> +
> +#ifdef CONFIG_SPI_SLAVE
> + =A0 =A0 =A0 if (spi->slave) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi->slave->cleanup)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->slave->cleanup(spi);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_slave_put(spi->slave);
> + =A0 =A0 =A0 }
> +#endif
> =A0 =A0 =A0 =A0kfree(dev);
> =A0}
>
> @@ -129,6 +140,73 @@ static int spi_resume(struct device *dev)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return value;
> =A0}
> +static const char power_group[] =3D "power";
> +static const char on_string[] =3D "on";
> +static const char suspend_string[] =3D "suspend";
> +
> +static ssize_t
> +show_level(struct device *s_dev, struct device_attribute *attr, char *bu=
f)
> +{
> + =A0 =A0 =A0 struct spi_device *dev =3D to_spi_device(s_dev);
> + =A0 =A0 =A0 const char *p;
> +
> + =A0 =A0 =A0 if (dev->state =3D=3D SPI_STATE_ON)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D on_string; =A0 =A0 =A0 =A0 =A0/* ON o=
r Active */
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D suspend_string; =A0 =A0 /* Suspended =
*/
> +
> + =A0 =A0 =A0 return sprintf(buf, "%s\n", p);
> +}
> +
> +static ssize_t
> +set_level(struct device *s_dev, struct device_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t count)
> +{
> + =A0 =A0 =A0 struct spi_device *dev =3D to_spi_device(s_dev);
> + =A0 =A0 =A0 int len =3D count;
> + =A0 =A0 =A0 char *cp;
> + =A0 =A0 =A0 int rc =3D 0;
> +
> + =A0 =A0 =A0 cp =3D memchr(buf, '\n', count);
> + =A0 =A0 =A0 if (cp)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D cp - buf;
> +
> + =A0 =A0 =A0 if (len =3D=3D sizeof on_string - 1 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncmp(buf, on_string, len=
) =3D=3D 0) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_resume(s_dev); =A0 =A0 =A0 =A0 =A0 =A0 =
=A0/* =A0Turn ON SPI Device */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->state =3D SPI_STATE_ON; =A0 =A0 =A0/* =
Save new State */
> +
> + =A0 =A0 =A0 } else if (len =3D=3D sizeof suspend_string - 1 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncmp(buf, suspend_string=
, len) =3D=3D 0) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_suspend(s_dev, PMSG_SUSPEND); =A0 =A0 =
=A0 /*Suspend SPI Device*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->state =3D SPI_STATE_SUSPENDED; =A0 =A0=
 =A0 /* Save new State */
> +
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -EINVAL;
> +
> + =A0 =A0 =A0 return (rc < 0 ? rc : count);
> +}
> +
> +static DEVICE_ATTR(level, S_IRUGO | S_IWUSR, show_level, set_level);
> +
> +static int add_power_attributes(struct device *dev)
> +{
> + =A0 =A0 =A0 int rc =3D 0;
> +
> + =A0 =A0 =A0 rc =3D sysfs_add_file_to_group(&dev->kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &dev_attr_level.attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 power_group);
> + =A0 =A0 =A0 return rc;
> +}
> +
> +static void remove_power_attributes(struct device *dev)
> +{
> + =A0 =A0 =A0 sysfs_remove_file_from_group(&dev->kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &dev_attr_level.attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 power_group);
> +}
>
> =A0#else
> =A0#define spi_suspend =A0 =A0NULL
> @@ -150,13 +228,21 @@ static int spi_drv_probe(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0const struct spi_driver =A0 =A0 =A0 =A0 *sdrv =3D to_spi_d=
river(dev->driver);
>
> +#ifdef CONFIG_PM
> + =A0 =A0 =A0 struct spi_device *sdev =3D to_spi_device(dev);
> + =A0 =A0 =A0 if (add_power_attributes(dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 remove_power_attributes(dev);
> + =A0 =A0 =A0 sdev->state =3D SPI_STATE_ON; =A0 =A0 /* By default set ON*/
> +#endif
> =A0 =A0 =A0 =A0return sdrv->probe(to_spi_device(dev));
> =A0}
>
> =A0static int spi_drv_remove(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0const struct spi_driver =A0 =A0 =A0 =A0 *sdrv =3D to_spi_d=
river(dev->driver);
> -
> +#ifdef CONFIG_PM
> + =A0 =A0 =A0 remove_power_attributes(dev);
> +#endif
> =A0 =A0 =A0 =A0return sdrv->remove(to_spi_device(dev));
> =A0}
>
> @@ -181,6 +267,11 @@ int spi_register_driver(struct spi_driver *sdrv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdrv->driver.remove =3D spi_drv_remove;
> =A0 =A0 =A0 =A0if (sdrv->shutdown)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdrv->driver.shutdown =3D spi_drv_shutdown;
> + =A0 =A0 =A0 if (sdrv->suspend)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdrv->driver.suspend =3D spi_suspend;
> + =A0 =A0 =A0 if (sdrv->resume)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdrv->driver.resume =3D spi_resume;
> +
> =A0 =A0 =A0 =A0return driver_register(&sdrv->driver);
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_register_driver);
> @@ -235,6 +326,7 @@ struct spi_device *spi_alloc_device(struct spi_master=
 *master)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0spi->master =3D master;
> + =A0 =A0 =A0 spi->slave =3D NULL;
> =A0 =A0 =A0 =A0spi->dev.parent =3D dev;
> =A0 =A0 =A0 =A0spi->dev.bus =3D &spi_bus_type;
> =A0 =A0 =A0 =A0spi->dev.release =3D spidev_release;
> @@ -255,21 +347,31 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
> =A0int spi_add_device(struct spi_device *spi)
> =A0{
> =A0 =A0 =A0 =A0static DEFINE_MUTEX(spi_add_lock);
> - =A0 =A0 =A0 struct device *dev =3D spi->master->dev.parent;
> + =A0 =A0 =A0 struct device *dev =3D NULL;
> =A0 =A0 =A0 =A0int status;
>
> - =A0 =A0 =A0 /* Chipselects are numbered 0..max; validate. */
> - =A0 =A0 =A0 if (spi->chip_select >=3D spi->master->num_chipselect) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "cs%d >=3D max %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_select,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->master->num_chipselect=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
> -
> + =A0 =A0 =A0 if (spi->master) {
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
> + =A0 =A0 =A0 }
>
> +#ifdef CONFIG_SPI_SLAVE
> + =A0 =A0 =A0 if (spi->slave) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev =3D spi->slave->dev.parent;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the bus ID string */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_set_name(&spi->dev, "%s.%u", dev_name(&=
spi->slave->dev),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_s=
elect);
> + =A0 =A0 =A0 }
> +#endif
>
> =A0 =A0 =A0 =A0/* We need to make sure there's no other device with this
> =A0 =A0 =A0 =A0 * chipselect **BEFORE** we call setup(), else we'll trash
> @@ -604,6 +706,262 @@ struct spi_master *spi_busnum_to_master(u16 bus_num)
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_busnum_to_master);
>
> +#ifdef CONFIG_SPI_SLAVE
> +/**
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
> +
> +
> +
> +
> +
> +/**
> +* spi_alloc_slave - allocate SPI slave controller
> +* @dev: the controller, possibly using the platform_bus
> +* @size: how much zeroed driver-private data to allocate; the pointer to=
 this
> +* =A0 =A0 =A0memory is in the driver_data field of the returned device,
> +* =A0 =A0 =A0accessible with spi_slave_get_devdata().
> +* Context: can sleep
> +*
> +* This call is used only by SPI master controller drivers, which are the
> +* only ones directly touching chip registers. =A0It's how they allocate
> +* an spi_master structure, prior to calling spi_register_slave().
> +*
> +* This must be called from context that can sleep. =A0It returns the SPI
> +* master structure on success, else NULL.
> +*
> +* The caller is responsible for assigning the bus number and initializing
> +* the master's methods before calling spi_register_slave(); and (after e=
rrors
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
> +/*
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
> +
> +/**
> +* spi_register_slave - register SPI slave controller
> +* @master: initialized master, originally from spi_alloc_slave()
> +* Context: can sleep
> +*
> +* SPI slave controllers connect to their drivers using some non-SPI bus,
> +* such as the platform bus. =A0The final stage of probe() in that code
> +* includes calling spi_register_slave() to hook up to this SPI bus glue.
> +*
> +* SPI controllers use board specific (often SOC specific) bus numbers,
> +* and board-specific addressing for SPI devices combines those numbers
> +* with chip select numbers. =A0Since SPI does not directly support dynam=
ic
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
rom the max */
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
> +
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
> +#endif
>
> =A0/*--------------------------------------------------------------------=
-----*/
>
> @@ -634,6 +992,11 @@ int spi_setup(struct spi_device *spi)
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0bad_bits;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 status;
>
> +#ifdef CONFIG_SPI_SLAVE
> + =A0 =A0 =A0 if (spi->slave)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return spi->slave->setup(spi);
> +#endif
> +
> =A0 =A0 =A0 =A0/* help drivers fail *cleanly* when they need options
> =A0 =A0 =A0 =A0 * that aren't supported with their current master
> =A0 =A0 =A0 =A0 */
> @@ -695,7 +1058,15 @@ EXPORT_SYMBOL_GPL(spi_setup);
> =A0int spi_async(struct spi_device *spi, struct spi_message *message)
> =A0{
> =A0 =A0 =A0 =A0struct spi_master *master =3D spi->master;
> +#ifdef CONFIG_SPI_SLAVE
> + =A0 =A0 =A0 struct spi_slave *slave =3D spi->slave;
>
> + =A0 =A0 =A0 if (slave) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 message->spi =3D spi;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 message->status =3D -EINPROGRESS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return slave->transfer(spi, message);
> + =A0 =A0 =A0 }
> +#endif
> =A0 =A0 =A0 =A0/* Half-duplex links include original MicroWire, and ones =
with
> =A0 =A0 =A0 =A0 * only one data pin like SPI_3WIRE (switches direction) o=
r where
> =A0 =A0 =A0 =A0 * either MOSI or MISO is missing. =A0They can also be cau=
sed by
> @@ -871,6 +1242,11 @@ static int __init spi_init(void)
> =A0 =A0 =A0 =A0status =3D class_register(&spi_master_class);
> =A0 =A0 =A0 =A0if (status < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err2;
> +#ifdef CONFIG_SPI_SLAVE
> + =A0 =A0 =A0 status =3D class_register(&spi_slave_class);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> +#endif
> =A0 =A0 =A0 =A0return 0;
>
> =A0err2:
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 97b60b3..98781a7 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -23,15 +23,26 @@
> =A0#include <linux/mod_devicetable.h>
>
> =A0/*
> - * INTERFACES between SPI master-side drivers and SPI infrastructure.
> - * (There's no SPI slave support for Linux yet...)
> + * INTERFACES between SPI Master/Slave side drivers and
> + * SPI infrastructure.
> + * SPI Slave Support added : It uses few new APIs and
> + * a new spi_slave struct
> =A0*/
> =A0extern struct bus_type spi_bus_type;
>
> +/* SPI Device State for power managment */
> +enum spi_device_state {
> +
> + =A0 =A0 =A0 SPI_STATE_SUSPENDED =3D 0,
> + =A0 =A0 =A0 SPI_STATE_ON
> +
> +};
> +
> =A0/**
> =A0* struct spi_device - Master side proxy for an SPI slave device
> =A0* @dev: Driver model representation of the device.
> =A0* @master: SPI controller used with the device.
> + * @slave: SPI Slave Controller used with the device
> =A0* @max_speed_hz: Maximum clock rate to be used with this chip
> =A0* =A0 =A0 (on this board); may be changed by the device's driver.
> =A0* =A0 =A0 The spi_transfer.speed_hz can override this for each transfe=
r.
> @@ -68,6 +79,8 @@ extern struct bus_type spi_bus_type;
> =A0struct spi_device {
> =A0 =A0 =A0 =A0struct device =A0 =A0 =A0 =A0 =A0 dev;
> =A0 =A0 =A0 =A0struct spi_master =A0 =A0 =A0 *master;
> + =A0 =A0 =A0 struct spi_slave =A0 =A0 =A0 =A0*slave;
> + =A0 =A0 =A0 enum spi_device_state =A0 state;
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_speed_hz;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip_select;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode;
> @@ -295,16 +308,56 @@ struct spi_master {
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
> =A0static inline void spi_master_set_devdata(struct spi_master *master, v=
oid *data)
> =A0{
> =A0 =A0 =A0 =A0dev_set_drvdata(&master->dev, data);
> =A0}
>
> +static inline void spi_slave_set_devdata(struct spi_slave *slave, void *=
data)
> +{
> + =A0 =A0 =A0 dev_set_drvdata(&slave->dev, data);
> +}
> +
> =A0static inline struct spi_master *spi_master_get(struct spi_master *mas=
ter)
> =A0{
> =A0 =A0 =A0 =A0if (!master || !get_device(&master->dev))
> @@ -312,12 +365,24 @@ static inline struct spi_master *spi_master_get(str=
uct spi_master *master)
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
>
> =A0/* the spi driver core manages memory for the spi_master classdev */
> =A0extern struct spi_master *
> @@ -328,6 +393,11 @@ extern void spi_unregister_master(struct spi_master =
*master);
>
> =A0extern struct spi_master *spi_busnum_to_master(u16 busnum);
>
> +extern struct spi_slave *
> +spi_alloc_slave(struct device *host, unsigned size);
> +
> +extern int spi_register_slave(struct spi_slave *slave);
> +extern void spi_unregister_slave(struct spi_slave *slave);
> =A0/*--------------------------------------------------------------------=
-------*/
>
> =A0/*
> @@ -759,12 +829,21 @@ spi_register_board_info(struct spi_board_info const=
 *info, unsigned n)
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
> =A0extern struct spi_device *
> =A0spi_new_device(struct spi_master *, struct spi_board_info *);
>
> +extern struct spi_device *
> +spi_slave_new_device(struct spi_slave *, struct spi_board_info *);
> +
> =A0static inline void
> =A0spi_unregister_device(struct spi_device *spi)
> =A0{
> --
> 1.5.4.3
>
>
>
>
> -------------------------------------------------------------------------=
-----
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and e=
asy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
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
