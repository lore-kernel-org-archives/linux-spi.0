From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: Add SuperH HSPI prototype driver
Date: Wed, 4 Jan 2012 13:05:48 -0700
Message-ID: <20120104200548.GH15503@ponder.secretlab.ca>
References: <87vcp2tnst.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87vcp2tnst.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 27, 2011 at 12:35:18AM -0800, Kuninori Morimoto wrote:
> This patch adds SuperH HSPI driver.
> It is still prototype driver, but has enough function at this point.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

Some brief comments below...

> ---
> +static int hspi_pop(struct hspi_priv *hspi, struct spi_message *msg,
> +		    struct spi_transfer *t)
> +{
> +	int i;
> +	u8 *data = (u8 *)t->rx_buf;
> +
> +	/*
> +	 * FIXME
> +	 * very simple, but polling receive
> +	 */
> +	for (i = 0; i < t->len; i++) {
> +		/* wait remains */
> +		while ((0x1 & hspi_read(hspi, SPSR)))
> +			mdelay(10);
> +
> +		/* dummy write */
> +		hspi_write(hspi, SPTBR, 0x0);
> +
> +		/* wait recive */
> +		while (!(0x4 & hspi_read(hspi, SPSR)))
> +			mdelay(10);

Those mdelays are really expensive.  Can the driver sleep instead?

> +
> +		data[i] = (u8)hspi_read(hspi, SPRBR);
> +	}
> +
> +	return 0;
> +}
> +
> +static void hspi_work(struct work_struct *work)
> +{
> +	struct hspi_priv *hspi = container_of(work, struct hspi_priv, ws);
> +	struct sh_hspi_info *info = hspi2info(hspi);
> +	struct spi_message *msg;
> +	struct spi_transfer *t;
> +	unsigned long flags;
> +	u32 data;
> +	int ret;
> +
> +	dev_dbg(hspi->dev, "%s\n", __func__);
> +
> +	/************************ pm enable ************************/
> +	pm_runtime_get_sync(hspi->dev);
> +
> +	/* setup first of all in under pm_runtime */
> +	data = SH_HSPI_CLK_DIVC(info->flags);
> +
> +	if (info->flags & SH_HSPI_FBS)
> +		data |= 1 << 7;
> +	if (info->flags & SH_HSPI_CLKP_HIGH)
> +		data |= 1 << 6;
> +	if (info->flags & SH_HSPI_IDIV_DIV128)
> +		data |= 1 << 5;
> +
> +	hspi_write(hspi, SPCR, data);
> +	hspi_write(hspi, SPSR, 0x0);
> +	hspi_write(hspi, SPSCR, 0x1);	/* master mode */
> +
> +	while (1) {
> +		msg = NULL;
> +
> +		/************************ spin lock ************************/
> +		spin_lock_irqsave(&hspi->lock, flags);
> +		if (!list_empty(&hspi->queue)) {
> +			msg = list_entry(hspi->queue.next,
> +					 struct spi_message, queue);
> +			list_del_init(&msg->queue);
> +		}
> +		spin_unlock_irqrestore(&hspi->lock, flags);
> +		/************************ spin unlock ************************/
> +		if (!msg)
> +			break;
> +
> +		ret = 0;
> +		list_for_each_entry(t, &msg->transfers, transfer_list) {
> +			if (t->tx_buf) {
> +				ret = hspi_push(hspi, msg, t);
> +				if (ret < 0)
> +					goto error;
> +			}
> +			if (t->rx_buf) {
> +				ret = hspi_pop(hspi, msg, t);
> +				if (ret < 0)
> +					goto error;
> +			}
> +			msg->actual_length += t->len;
> +		}
> +error:
> +		msg->status = ret;
> +		msg->complete(msg->context);
> +	}
> +
> +	pm_runtime_put_sync(hspi->dev);
> +	/************************ pm disable ************************/
> +
> +	return;
> +}
> +
> +/*
> + *		spi master function
> + */
> +static int hspi_setup(struct spi_device *spi)
> +{
> +	struct hspi_priv *hspi = spi_master_get_devdata(spi->master);
> +	struct device *dev = hspi->dev;
> +
> +	if (8 != spi->bits_per_word) {
> +		dev_err(dev, "bits_per_word shluld be 8\n");

typo

> +		return -EIO;
> +	}
> +
> +	dev_dbg(dev, "%s setup\n", spi->modalias);
> +
> +	return 0;
> +}
> +
> +static void hspi_cleanup(struct spi_device *spi)
> +{
> +	struct hspi_priv *hspi = spi_master_get_devdata(spi->master);
> +	struct device *dev = hspi->dev;
> +
> +	dev_dbg(dev, "%s cleanup\n", spi->modalias);
> +}
> +
> +static int hspi_transfer(struct spi_device *spi, struct spi_message *msg)
> +{
> +	struct hspi_priv *hspi = spi_master_get_devdata(spi->master);
> +	unsigned long flags;
> +
> +	/************************ spin lock ************************/
> +	spin_lock_irqsave(&hspi->lock, flags);
> +
> +	msg->actual_length	= 0;
> +	msg->status		= -EINPROGRESS;
> +	list_add_tail(&msg->queue, &hspi->queue);
> +
> +	spin_unlock_irqrestore(&hspi->lock, flags);
> +	/************************ spin unlock ************************/
> +
> +	queue_work(hspi->workqueue, &hspi->ws);
> +
> +	return 0;
> +}
> +
> +static int __devinit hspi_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct spi_master *master;
> +	struct hspi_priv *hspi;
> +	const char *devname;
> +	int ret;
> +
> +	/* get base addr */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "invalid resource\n");
> +		return -EINVAL;
> +	}
> +
> +	master = spi_alloc_master(&pdev->dev, sizeof(struct hspi_priv));

sizeof(*hspi)

> +	if (!master) {
> +		dev_err(&pdev->dev, "spi_alloc_master error.\n");
> +		return -ENOMEM;
> +	}
> +
> +	hspi = spi_master_get_devdata(master);
> +	dev_set_drvdata(&pdev->dev, hspi);
> +
> +	devname = dev_name(&pdev->dev);
> +
> +	/* init hspi */
> +	hspi->master	= master;
> +	hspi->dev	= &pdev->dev;
> +	hspi->addr	= ioremap(res->start, resource_size(res));
> +	if (!hspi->addr) {
> +		dev_err(&pdev->dev, "ioremap error.\n");
> +		ret = -ENOMEM;
> +		goto error1;
> +	}
> +	hspi->workqueue = create_singlethread_workqueue(devname);

nit: After addressing my comment below, devname is referenced exactly
once after being set.  create_singlethread_workqueue(dev_name(&pdev->dev))
is sufficient here.

> +	if (!hspi->workqueue) {
> +		dev_err(&pdev->dev, "create workqueue error\n");
> +		ret = -EBUSY;
> +		goto error2;
> +	}
> +
> +	spin_lock_init(&hspi->lock);
> +	INIT_LIST_HEAD(&hspi->queue);
> +	INIT_WORK(&hspi->ws, hspi_work);
> +
> +	master->num_chipselect	= 1;
> +	master->bus_num		= pdev->id;
> +	master->setup		= hspi_setup;
> +	master->transfer	= hspi_transfer;
> +	master->cleanup		= hspi_cleanup;
> +	master->mode_bits	= SPI_CPOL | SPI_CPHA;
> +	ret = spi_register_master(master);
> +	if (ret < 0) {
> +		printk(KERN_ERR "spi_register_master error.\n");

dev_err()

> +		goto error3;
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
> +
> +	dev_info(&pdev->dev, "%s probed\n", devname);

dev_info() prints the devname already.  This line prints it twice.

> +
> +	return 0;
> +
> + error3:
> +	destroy_workqueue(hspi->workqueue);
> + error2:
> +	iounmap(hspi->addr);
> + error1:
> +	spi_master_put(master);
> +
> +	return ret;
> +}
> +
> +static int __devexit hspi_remove(struct platform_device *pdev)
> +{
> +	struct hspi_priv *hspi = dev_get_drvdata(&pdev->dev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +
> +	destroy_workqueue(hspi->workqueue);
> +	iounmap(hspi->addr);
> +	spi_unregister_master(hspi->master);

Must unregister the master *before* unmapping it and destroying the workqueue.

> +
> +	return 0;
> +}

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
