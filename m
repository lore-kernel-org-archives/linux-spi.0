From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH] This adds support for SPI
	slave	controller drivers
Date: Fri, 12 Jun 2009 06:05:24 +0300
Message-ID: <20090612030522.GU10382@tarshish>
References: <1243914698.22129.4.camel@ubuntu-vmware>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi mailing list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1243914698.22129.4.camel@ubuntu-vmware>
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

Your patches are very interesting.

Unfortunately, your email client (Evolution?) has broken long lines in your 
patches. Please resend them. You may consult Documentation/email-clients.txt.

baruch

On Mon, Jun 01, 2009 at 08:51:37PM -0700, Ken Mills wrote:
> This patch adds a new API to support slave SPI controller drivers.
> 
> Signed-off-by: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi.c       |  368
> ++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/spi/spi.h |  100 ++++++++++++-
>  2 files changed, 427 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 8eba98c..504f0ae 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -26,19 +26,34 @@
>  #include <linux/spi/spi.h>
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
>  static void spidev_release(struct device *dev)
>  {
>  	struct spi_device	*spi = to_spi_device(dev);
>  
> -	/* spi masters may cleanup for released devices */
> -	if (spi->master->cleanup)
> -		spi->master->cleanup(spi);
> +	if (spi->master) {
> +		/* spi masters may cleanup for released devices */
> +		if (spi->master->cleanup)
> +			spi->master->cleanup(spi);
> +
> +		spi_master_put(spi->master);
> +	} else {
> +		/* spi slave controller */
> +		if (spi->slave->cleanup)
> +			spi->slave->cleanup(spi);
> +
> +		spi_slave_put(spi->slave);
> +	}
>  
> -	spi_master_put(spi->master);
>  	kfree(dev);
>  }
>  
> @@ -46,7 +61,6 @@ static ssize_t
>  modalias_show(struct device *dev, struct device_attribute *a, char
> *buf)
>  {
>  	const struct spi_device	*spi = to_spi_device(dev);
> -
>  	return sprintf(buf, "%s\n", spi->modalias);
>  }
>  
> @@ -62,14 +76,12 @@ static struct device_attribute spi_dev_attrs[] = {
>  static int spi_match_device(struct device *dev, struct device_driver
> *drv)
>  {
>  	const struct spi_device	*spi = to_spi_device(dev);
> -
>  	return strcmp(spi->modalias, drv->name) == 0;
>  }
>  
>  static int spi_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
>  	const struct spi_device		*spi = to_spi_device(dev);
> -
>  	add_uevent_var(env, "MODALIAS=%s", spi->modalias);
>  	return 0;
>  }
> @@ -153,10 +165,13 @@ int spi_register_driver(struct spi_driver *sdrv)
>  	sdrv->driver.bus = &spi_bus_type;
>  	if (sdrv->probe)
>  		sdrv->driver.probe = spi_drv_probe;
> +
>  	if (sdrv->remove)
>  		sdrv->driver.remove = spi_drv_remove;
> +
>  	if (sdrv->shutdown)
>  		sdrv->driver.shutdown = spi_drv_shutdown;
> +
>  	return driver_register(&sdrv->driver);
>  }
>  EXPORT_SYMBOL_GPL(spi_register_driver);
> @@ -197,28 +212,70 @@ static DEFINE_MUTEX(board_lock);
>   */
>  struct spi_device *spi_alloc_device(struct spi_master *master)
>  {
> -	struct spi_device	*spi;
> +	struct spi_device	*spi_m_dev;
>  	struct device		*dev = master->dev.parent;
>  
>  	if (!spi_master_get(master))
>  		return NULL;
>  
> -	spi = kzalloc(sizeof *spi, GFP_KERNEL);
> -	if (!spi) {
> +	spi_m_dev = kzalloc(sizeof *spi_m_dev, GFP_KERNEL);
> +	if (!spi_m_dev) {
>  		dev_err(dev, "cannot alloc spi_device\n");
>  		spi_master_put(master);
>  		return NULL;
>  	}
>  
> -	spi->master = master;
> -	spi->dev.parent = dev;
> -	spi->dev.bus = &spi_bus_type;
> -	spi->dev.release = spidev_release;
> -	device_initialize(&spi->dev);
> -	return spi;
> +	spi_m_dev->master = master;
> +	spi_m_dev->slave = NULL;
> +	spi_m_dev->dev.parent = dev;
> +	spi_m_dev->dev.bus = &spi_bus_type;
> +	spi_m_dev->dev.release = spidev_release;
> +	device_initialize(&spi_m_dev->dev);
> +	return spi_m_dev;
>  }
>  EXPORT_SYMBOL_GPL(spi_alloc_device);
>  
> +/*
> +* spi_alloc_slave_device - Allocate a new SPI device
> +* @slave: Controller to which device is connected
> +* Context: can sleep
> +*
> +* Allows a driver to allocate and initialize a spi_device without
> +* registering it immediately.  This allows a driver to directly
> +* fill the spi_device with device parameters before calling
> +* spi_add_slave_device() on it.
> +*
> +* Caller is responsible to call spi_add_slave_device() on the returned
> +* spi_device structure to add it to the SPI slave.  If the caller
> +* needs to discard the spi_device without adding it, then it should
> +* call spi_dev_slave_put() on it.
> +* Returns a pointer to the new device, or NULL.
> +*/
> +struct spi_device *spi_alloc_slave_device(struct spi_slave *slave)
> +{
> +	struct spi_device	*spi_s;
> +	struct device		*dev = slave->dev.parent;
> +
> +	if (!spi_slave_get(slave))
> +		return NULL;
> +
> +	spi_s = kzalloc(sizeof *spi_s, GFP_KERNEL);
> +	if (!spi_s) {
> +		dev_err(dev, "cannot alloc spi_slave_device\n");
> +		spi_slave_put(slave);
> +		return NULL;
> +	}
> +
> +	spi_s->slave = slave;
> +	spi_s->master = NULL;
> +	spi_s->dev.parent = dev;
> +	spi_s->dev.bus = &spi_bus_type;
> +	spi_s->dev.release = spidev_release;
> +	device_initialize(&spi_s->dev);
> +	return spi_s;
> +}
> +EXPORT_SYMBOL_GPL(spi_alloc_slave_device);
> +
>  /**
>   * spi_add_device - Add spi_device allocated with spi_alloc_device
>   * @spi: spi_device to register
> @@ -231,21 +288,29 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
>  int spi_add_device(struct spi_device *spi)
>  {
>  	static DEFINE_MUTEX(spi_add_lock);
> -	struct device *dev = spi->master->dev.parent;
>  	int status;
> -
> -	/* Chipselects are numbered 0..max; validate. */
> -	if (spi->chip_select >= spi->master->num_chipselect) {
> -		dev_err(dev, "cs%d >= max %d\n",
> -			spi->chip_select,
> -			spi->master->num_chipselect);
> -		return -EINVAL;
> -	}
> -
> +	struct device *dev;
> +
> +	if (spi->master) {
> +		/* Master Controller */
> +		dev = spi->master->dev.parent;
> +		/* Chipselects are numbered 0..max; validate. */
> +		if (spi->chip_select >= spi->master->num_chipselect) {
> +			dev_err(dev, "cs%d >= max %d\n",
> +				spi->chip_select,
> +				spi->master->num_chipselect);
> +			return -EINVAL;
> +		}
>  	/* Set the bus ID string */
>  	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->master->dev),
>  			spi->chip_select);
> -
> +	} else {
> +		/* Slave Controller */
> +		dev = spi->slave->dev.parent;
> +		/* Set the bus ID string */
> +		dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->slave->dev),
> +				spi->chip_select);
> +	}
>  
>  	/* We need to make sure there's no other device with this
>  	 * chipselect **BEFORE** we call setup(), else we'll trash
> @@ -265,7 +330,11 @@ int spi_add_device(struct spi_device *spi)
>  	 * normally rely on the device being setup.  Devices
>  	 * using SPI_CS_HIGH can't coexist well otherwise...
>  	 */
> -	status = spi->master->setup(spi);
> +	if (spi->master)
> +		status = spi->master->setup(spi);
> +	else
> +		status = spi->slave->setup(spi);	/* Slave Controller */
> +
>  	if (status < 0) {
>  		dev_err(dev, "can't %s %s, status %d\n",
>  				"setup", dev_name(&spi->dev), status);
> @@ -286,6 +355,7 @@ done:
>  }
>  EXPORT_SYMBOL_GPL(spi_add_device);
>  
> +
>  /**
>   * spi_new_device - instantiate one new SPI device
>   * @master: Controller to which device is connected
> @@ -317,6 +387,8 @@ struct spi_device *spi_new_device(struct spi_master
> *master,
>  	if (!proxy)
>  		return NULL;
>  
> +
> +
>  	WARN_ON(strlen(chip->modalias) >= sizeof(proxy->modalias));
>  
>  	proxy->chip_select = chip->chip_select;
> @@ -339,6 +411,54 @@ struct spi_device *spi_new_device(struct spi_master
> *master,
>  EXPORT_SYMBOL_GPL(spi_new_device);
>  
>  /**
> +* spi_slave_new_device - instantiate one new SPI device
> +* @slave: Controller to which device is connected
> +* @chip: Describes the SPI device
> +* Context: can sleep
> +*
> +* On typical mainboards, this is purely internal; and it's not needed
> +* after board init creates the hard-wired devices.  Some development
> +* platforms may not be able to use spi_register_board_info though, and
> +* this is exported so that for example a USB or parport based adapter
> +* driver could add devices (which it would learn about out-of-band).
> +*
> +* Returns the new device, or NULL.
> +*/
> +struct spi_device *spi_slave_new_device(struct spi_slave *slave,
> +				  struct spi_board_info *chip)
> +{
> +	struct spi_device	*proxy_slave;
> +	int			status;
> +
> +	proxy_slave = spi_alloc_slave_device(slave);
> +
> +	if (!proxy_slave)
> +		return NULL;
> +
> +	WARN_ON(strlen(chip->modalias) >= sizeof(proxy_slave->modalias));
> +
> +	proxy_slave->chip_select = chip->chip_select;
> +	proxy_slave->max_speed_hz = chip->max_speed_hz;
> +	proxy_slave->mode = chip->mode;
> +	proxy_slave->irq = chip->irq;
> +	strlcpy(proxy_slave->modalias, chip->modalias,
> +					sizeof(proxy_slave->modalias));
> +	proxy_slave->dev.platform_data = (void *) chip->platform_data;
> +	proxy_slave->controller_data = chip->controller_data;
> +	proxy_slave->controller_state = NULL;
> +
> +	status = spi_add_device(proxy_slave);
> +	if (status < 0) {
> +		spi_dev_put(proxy_slave);
> +		return NULL;
> +	}
> +
> +	return proxy_slave;
> +}
> +EXPORT_SYMBOL_GPL(spi_slave_new_device);
> +
> +
> +/**
>   * spi_register_board_info - register SPI devices for a given board
>   * @info: array of chip descriptors
>   * @n: how many descriptors are provided
> @@ -365,6 +485,7 @@ spi_register_board_info(struct spi_board_info const
> *info, unsigned n)
>  	bi = kmalloc(sizeof(*bi) + n * sizeof *info, GFP_KERNEL);
>  	if (!bi)
>  		return -ENOMEM;
> +
>  	bi->n_board_info = n;
>  	memcpy(bi->board_info, info, n * sizeof *info);
>  
> @@ -374,6 +495,7 @@ spi_register_board_info(struct spi_board_info const
> *info, unsigned n)
>  	return 0;
>  }
>  
> +
>  /* FIXME someone should add support for a __setup("spi", ...) that
>   * creates board info from kernel command lines
>   */
> @@ -399,6 +521,28 @@ static void scan_boardinfo(struct spi_master
> *master)
>  	mutex_unlock(&board_lock);
>  }
>  
> +static void spi_slave_scan_boardinfo(struct spi_slave *slave)
> +{
> +	struct boardinfo	*bi;
> +
> +	mutex_lock(&board_lock);
> +	list_for_each_entry(bi, &board_list, list) {
> +		struct spi_board_info	*chip = bi->board_info;
> +		unsigned		n;
> +
> +		for (n = bi->n_board_info; n > 0; n--, chip++) {
> +			if (chip->bus_num != slave->bus_num)
> +				continue;
> +			/* NOTE: this relies on spi_new_device to
> +			 * issue diagnostics when given bogus inputs
> +			 */
> +			(void) spi_slave_new_device(slave, chip);
> +
> +		}
> +	}
> +	mutex_unlock(&board_lock);
> +}
> +
>  /*-------------------------------------------------------------------------*/
>  
>  static void spi_master_release(struct device *dev)
> @@ -415,6 +559,19 @@ static struct class spi_master_class = {
>  	.dev_release	= spi_master_release,
>  };
>  
> +static void spi_slave_release(struct device *dev)
> +{
> +	struct spi_slave *slave;
> +
> +	slave = container_of(dev, struct spi_slave, dev);
> +	kfree(slave);
> +}
> +
> +static struct class spi_slave_class = {
> +	.name		= "spi_slave",
> +	.owner		= THIS_MODULE,
> +	.dev_release	= spi_slave_release,
> +};
>  
>  /**
>   * spi_alloc_master - allocate SPI master controller
> @@ -456,6 +613,47 @@ struct spi_master *spi_alloc_master(struct device
> *dev, unsigned size)
>  EXPORT_SYMBOL_GPL(spi_alloc_master);
>  
>  /**
> +* spi_alloc_slave - allocate SPI slave controller
> +* @dev: the controller, possibly using the platform_bus
> +* @size: how much zeroed driver-private data to allocate; the pointer
> to this
> +*	memory is in the driver_data field of the returned device,
> +*	accessible with spi_slave_get_devdata().
> +* Context: can sleep
> +*
> +* This call is used only by SPI master controller drivers, which are
> the
> +* only ones directly touching chip registers.  It's how they allocate
> +* an spi_master structure, prior to calling spi_register_slave().
> +*
> +* This must be called from context that can sleep.  It returns the SPI
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
> +	struct spi_slave	*slave;
> +
> +	if (!dev)
> +		return NULL;
> +
> +	slave = kzalloc(size + sizeof *slave, GFP_KERNEL);
> +	if (!slave)
> +		return NULL;
> +
> +	device_initialize(&slave->dev);
> +	slave->dev.class = &spi_slave_class;
> +	slave->dev.parent = get_device(dev);
> +	spi_slave_set_devdata(slave, &slave[1]);
> +
> +	return slave;
> +}
> +EXPORT_SYMBOL_GPL(spi_alloc_slave);
> +
> +
> +
> +/**
>   * spi_register_master - register SPI master controller
>   * @master: initialized master, originally from spi_alloc_master()
>   * Context: can sleep
> @@ -507,7 +705,8 @@ int spi_register_master(struct spi_master *master)
>  	status = device_add(&master->dev);
>  	if (status < 0)
>  		goto done;
> -	dev_dbg(dev, "registered master %s%s\n", dev_name(&master->dev),
> +
> +	dev_dbg(dev, "spi_register_master() : %s%s\n", dev_name(&master->dev),
>  			dynamic ? " (dynamic)" : "");
>  
>  	/* populate children from any spi device tables */
> @@ -518,6 +717,69 @@ done:
>  }
>  EXPORT_SYMBOL_GPL(spi_register_master);
>  
> +/**
> +* spi_register_slave - register SPI slave controller
> +* @master: initialized master, originally from spi_alloc_slave()
> +* Context: can sleep
> +*
> +* SPI slave controllers connect to their drivers using some non-SPI
> bus,
> +* such as the platform bus.  The final stage of probe() in that code
> +* includes calling spi_register_slave() to hook up to this SPI bus
> glue.
> +*
> +* SPI controllers use board specific (often SOC specific) bus numbers,
> +* and board-specific addressing for SPI devices combines those numbers
> +* with chip select numbers.  Since SPI does not directly support
> dynamic
> +* device identification, boards need configuration tables telling which
> +* chip is at which address.
> +*
> +* This must be called from context that can sleep.  It returns zero on
> +* success, else a negative error code (dropping the slave's refcount).
> +* After a successful return, the caller is responsible for calling
> +* spi_unregister_slave().
> +*/
> +int spi_register_slave(struct spi_slave *slave)
> +{
> +	static atomic_t		dyn_bus_id = ATOMIC_INIT((1<<15) - 1);
> +	struct device		*dev = slave->dev.parent;
> +	int			status = -ENODEV;
> +	int			dynamic = 0;
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	/* even if it's just one always-selected device, there must
> +	 * be at least one chipselect
> +	 */
> +	if (slave->num_chipselect == 0)
> +		return -EINVAL;
> +
> +	/* convention:  dynamically assigned bus IDs count down from the max
> */
> +	if (slave->bus_num < 0) {
> +		/* FIXME switch to an IDR based scheme, something like
> +		 * I2C now uses, so we can't run out of "dynamic" IDs
> +		 */
> +		slave->bus_num = atomic_dec_return(&dyn_bus_id);
> +		dynamic = 1;
> +	}
> +
> +	/* register the device, then userspace will see it.
> +	 * registration fails if the bus ID is in use.
> +	 */
> +	dev_set_name(&slave->dev, "spi%u", slave->bus_num);
> +	status = device_add(&slave->dev);
> +	if (status < 0)
> +		goto done;
> +
> +	dev_dbg(dev, "registered slave %s%s\n", dev_name(&slave->dev),
> +			dynamic ? " (dynamic)" : "");
> +
> +	/* populate children from any spi device tables */
> +	spi_slave_scan_boardinfo(slave);
> +	status = 0;
> +done:
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(spi_register_slave);
>  
>  static int __unregister(struct device *dev, void *master_dev)
>  {
> @@ -547,6 +809,27 @@ void spi_unregister_master(struct spi_master
> *master)
>  }
>  EXPORT_SYMBOL_GPL(spi_unregister_master);
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
> +	int dummy;
> +
> +	dummy = device_for_each_child(slave->dev.parent, &slave->dev,
> +					__unregister);
> +	device_unregister(&slave->dev);
> +}
> +EXPORT_SYMBOL_GPL(spi_unregister_slave);
> +
> +
>  static int __spi_master_match(struct device *dev, void *data)
>  {
>  	struct spi_master *m;
> @@ -626,6 +909,18 @@ int spi_sync(struct spi_device *spi, struct
> spi_message *message)
>  }
>  EXPORT_SYMBOL_GPL(spi_sync);
>  
> +/* spi_transfer_async - Wraper function to allow spi_async to expose to
> +* user protocol drivers for modem handshaking
> +*/
> +
> +int spi_transfer_async(struct spi_device *spi, struct spi_message
> *message)
> +{
> +	int status;
> +	status = spi_async(spi, message);
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(spi_transfer_async);
> +
>  /* portable code must never pass more than 32 bytes */
>  #define	SPI_BUFSIZ	max(32,SMP_CACHE_BYTES)
>  
> @@ -724,6 +1019,12 @@ static int __init spi_init(void)
>  	status = class_register(&spi_master_class);
>  	if (status < 0)
>  		goto err2;
> +
> +	status = class_register(&spi_slave_class);
> +
> +	if (status < 0)
> +		goto err2;
> +
>  	return 0;
>  
>  err2:
> @@ -743,4 +1044,3 @@ err0:
>   * include needing to have boardinfo data structures be much more
> public.
>   */
>  postcore_initcall(spi_init);
> -
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index a0faa18..5845bb1 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -22,15 +22,18 @@
>  #include <linux/device.h>
>  
>  /*
> - * INTERFACES between SPI master-side drivers and SPI infrastructure.
> - * (There's no SPI slave support for Linux yet...)
> + * INTERFACES between SPI Master/Slave side drivers and
> + * SPI infrastructure.
> + * SPI Slave Support added : It uses few new APIs and
> + * a new spi_slave struct
>   */
>  extern struct bus_type spi_bus_type;
>  
>  /**
>   * struct spi_device - Master side proxy for an SPI slave device
>   * @dev: Driver model representation of the device.
> - * @master: SPI controller used with the device.
> + * @master: SPI Master controller used with the device.
> + * @slave: SPI Slave Controller used with the device
>   * @max_speed_hz: Maximum clock rate to be used with this chip
>   *	(on this board); may be changed by the device's driver.
>   *	The spi_transfer.speed_hz can override this for each transfer.
> @@ -67,6 +70,7 @@ extern struct bus_type spi_bus_type;
>  struct spi_device {
>  	struct device		dev;
>  	struct spi_master	*master;
> +	struct spi_slave	*slave;
>  	u32			max_speed_hz;
>  	u8			chip_select;
>  	u8			mode;
> @@ -140,7 +144,6 @@ static inline void *spi_get_drvdata(struct
> spi_device *spi)
>  struct spi_message;
>  
>  
> -
>  /**
>   * struct spi_driver - Host side "protocol" driver
>   * @probe: Binds this driver to the spi device.  Drivers can verify
> @@ -279,16 +282,56 @@ struct spi_master {
>  	void			(*cleanup)(struct spi_device *spi);
>  };
>  
> +/**
> + * struct spi_slave - interface to SPI Slave Controller
> + * @dev: device interface to this driver
> + * @bus_num: board-specific (and often SOC-specific) identifier for a
> + *	given SPI controller.
> + * @num_chipselect: chipselects are used to distinguish individual
> + *	SPI slaves, and are numbered from zero to num_chipselects.
> + *	each slave has a chipselect signal, but it's common that not
> + *	every chipselect is connected to a slave.
> + * @setup: updates the device mode and clocking records used by a
> + *	device's SPI controller; protocol code may call this.  This
> + *	must fail if an unrecognized or unsupported mode is requested.
> + *	It's always safe to call this unless transfers are pending on
> + *	the device whose settings are being modified.
> + * @transfer: adds a message to the controller's transfer queue.
> + * @cleanup: frees controller-specific state
> + */
> +struct spi_slave {
> +	struct device	dev;
> +	s16			bus_num;
> +	u16			num_chipselect;
> +
> +	int			(*setup)(struct spi_device *spi);
> +
> +	int			(*transfer)(struct spi_device *spi,
> +						struct spi_message *mesg);
> +
> +	void			(*cleanup)(struct spi_device *spi);
> +};
> +
>  static inline void *spi_master_get_devdata(struct spi_master *master)
>  {
>  	return dev_get_drvdata(&master->dev);
>  }
>  
> +static inline void *spi_slave_get_devdata(struct spi_slave *slave)
> +{
> +	return dev_get_drvdata(&slave->dev);
> +}
> +
>  static inline void spi_master_set_devdata(struct spi_master *master,
> void *data)
>  {
>  	dev_set_drvdata(&master->dev, data);
>  }
>  
> +static inline void spi_slave_set_devdata(struct spi_slave *slave, void
> *data)
> +{
> +	dev_set_drvdata(&slave->dev, data);
> +}
> +
>  static inline struct spi_master *spi_master_get(struct spi_master
> *master)
>  {
>  	if (!master || !get_device(&master->dev))
> @@ -296,20 +339,42 @@ static inline struct spi_master
> *spi_master_get(struct spi_master *master)
>  	return master;
>  }
>  
> +static inline struct spi_slave *spi_slave_get(struct spi_slave *slave)
> +{
> +	if (!slave || !get_device(&slave->dev))
> +		return NULL;
> +	return slave;
> +}
> +
>  static inline void spi_master_put(struct spi_master *master)
>  {
>  	if (master)
>  		put_device(&master->dev);
>  }
>  
> +static inline void spi_slave_put(struct spi_slave *slave)
> +{
> +	if (slave)
> +		put_device(&slave->dev);
> +}
> +
>  
>  /* the spi driver core manages memory for the spi_master classdev */
>  extern struct spi_master *
>  spi_alloc_master(struct device *host, unsigned size);
>  
> +extern struct spi_slave *
> +spi_alloc_slave(struct device *host, unsigned size);
> +
> +
>  extern int spi_register_master(struct spi_master *master);
> +
> +extern int spi_register_slave(struct spi_slave *slave);
> +
>  extern void spi_unregister_master(struct spi_master *master);
>  
> +extern void spi_unregister_slave(struct spi_slave *slave);
> +
>  extern struct spi_master *spi_busnum_to_master(u16 busnum);
>  
>  /*---------------------------------------------------------------------------*/
> @@ -544,10 +609,12 @@ static inline void spi_message_free(struct
> spi_message *m)
>  static inline int
>  spi_setup(struct spi_device *spi)
>  {
> -	return spi->master->setup(spi);
> +	if (spi->master)
> +		return spi->master->setup(spi);
> +	else
> +		return spi->slave->setup(spi);
>  }
>  
> -
>  /**
>   * spi_async - asynchronous SPI transfer
>   * @spi: device with which data will be exchanged
> @@ -581,7 +648,10 @@ static inline int
>  spi_async(struct spi_device *spi, struct spi_message *message)
>  {
>  	message->spi = spi;
> -	return spi->master->transfer(spi, message);
> +	if (spi->master)
> +		return spi->master->transfer(spi, message);	/* Master */
> +	else
> +		return spi->slave->transfer(spi, message);	/* Slave */
>  }
>  
>  /*---------------------------------------------------------------------------*/
> @@ -593,6 +663,11 @@ spi_async(struct spi_device *spi, struct
> spi_message *message)
>  
>  extern int spi_sync(struct spi_device *spi, struct spi_message
> *message);
>  
> +/* spi_transfer_async() exposes spi_async() functionality */
> +extern int spi_transfer_async(struct spi_device *spi,
> +			      struct spi_message *message);
> +
> +
>  /**
>   * spi_write - SPI synchronous write
>   * @spi: device to which data will be written
> @@ -801,12 +876,23 @@ spi_register_board_info(struct spi_board_info
> const *info, unsigned n)
>  extern struct spi_device *
>  spi_alloc_device(struct spi_master *master);
>  
> +extern struct spi_device *
> +spi_alloc_slave_device(struct spi_slave *slave);
> +
>  extern int
>  spi_add_device(struct spi_device *spi);
>  
> +extern int
> +spi_add_slave_device(struct spi_device *spi);
> +
> +
>  extern struct spi_device *
>  spi_new_device(struct spi_master *, struct spi_board_info *);
>  
> +extern struct spi_device *
> +spi_slave_new_device(struct spi_slave *, struct spi_board_info *);
> +
> +
>  static inline void
>  spi_unregister_device(struct spi_device *spi)
>  {
> -- 
> 1.5.4.3
> 
> 
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables unlimited
> royalty-free distribution of the report engine for externally facing 
> server and web deployment.
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
