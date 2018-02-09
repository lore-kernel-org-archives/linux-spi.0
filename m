From: Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 1/6] spi: Extend the core to ease integration of SPI
 memory controllers
Date: Fri, 9 Feb 2018 13:52:05 +0100
Message-ID: <20180209135205.6872203c@xps13>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
        <20180205232120.5851-2-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Yogesh Gaur <yogeshnarayan.gaur-3arQi8VN3Tc@public.gmane.org>,
        Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Peter Pan <peterpansjtu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>,
        Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
To: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180205232120.5851-2-boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Boris,

Just a few comments on the form below.

On Tue,  6 Feb 2018 00:21:15 +0100, Boris Brezillon
<boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:

> From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> 
> Some controllers are exposing high-level interfaces to access various
> kind of SPI memories. Unfortunately they do not fit in the current
> spi_controller model and usually have drivers placed in
> drivers/mtd/spi-nor which are only supporting SPI NORs and not SPI
> memories in general.
> 
> This is an attempt at defining a SPI memory interface which works for
> all kinds of SPI memories (NORs, NANDs, SRAMs).
> 
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/spi/spi.c       | 423 +++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/spi/spi.h | 226 ++++++++++++++++++++++++++
>  2 files changed, 646 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index b33a727a0158..57bc540a0521 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2057,6 +2057,24 @@ static int of_spi_register_master(struct spi_controller *ctlr)
>  }
>  #endif
>  
> +static int spi_controller_check_ops(struct spi_controller *ctlr)
> +{
> +	/*
> +	 * The controller can implement only the high-level SPI-memory like
> +	 * operations if it does not support regular SPI transfers.
> +	 */
> +	if (ctlr->mem_ops) {
> +		if (!ctlr->mem_ops->supports_op ||
> +		    !ctlr->mem_ops->exec_op)
> +			return -EINVAL;
> +	} else if (!ctlr->transfer && !ctlr->transfer_one &&
> +		   !ctlr->transfer_one_message) {
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * spi_register_controller - register SPI master or slave controller
>   * @ctlr: initialized master, originally from spi_alloc_master() or
> @@ -2090,6 +2108,14 @@ int spi_register_controller(struct spi_controller *ctlr)
>  	if (!dev)
>  		return -ENODEV;
>  
> +	/*
> +	 * Make sure all necessary hooks are implemented before registering
> +	 * the SPI controller.
> +	 */
> +	status = spi_controller_check_ops(ctlr);
> +	if (status)
> +		return status;
> +
>  	if (!spi_controller_is_slave(ctlr)) {
>  		status = of_spi_register_master(ctlr);
>  		if (status)
> @@ -2155,10 +2181,14 @@ int spi_register_controller(struct spi_controller *ctlr)
>  			spi_controller_is_slave(ctlr) ? "slave" : "master",
>  			dev_name(&ctlr->dev));
>  
> -	/* If we're using a queued driver, start the queue */
> -	if (ctlr->transfer)
> +	/*
> +	 * If we're using a queued driver, start the queue. Note that we don't
> +	 * need the queueing logic if the driver is only supporting high-level
> +	 * memory operations.
> +	 */
> +	if (ctlr->transfer) {
>  		dev_info(dev, "controller is unqueued, this is deprecated\n");
> -	else {
> +	} else if (ctlr->transfer_one || ctlr->transfer_one_message) {
>  		status = spi_controller_initialize_queue(ctlr);
>  		if (status) {
>  			device_del(&ctlr->dev);
> @@ -2893,6 +2923,13 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
>  {
>  	struct spi_controller *ctlr = spi->controller;
>  
> +	/*
> +	 * Some controllers do not support doing regular SPI transfers. Return
> +	 * ENOTSUPP when this is the case.
> +	 */
> +	if (!ctlr->transfer)
> +		return -ENOTSUPP;
> +
>  	message->spi = spi;
>  
>  	SPI_STATISTICS_INCREMENT_FIELD(&ctlr->statistics, spi_async);
> @@ -3321,6 +3358,386 @@ int spi_write_then_read(struct spi_device *spi,
>  }
>  EXPORT_SYMBOL_GPL(spi_write_then_read);
>  
> +/**
> + * spi_controller_dma_map_mem_op_data() - DMA-map the buffer attached to a
> + *					  memory operation
> + * @ctlr: the SPI controller requesting this dma_map()
> + * @op: the memory operation containing the buffer to map
> + * @sgt: a pointer to a non-initialized sg_table that will be filled by this
> + *	 function
> + *
> + * Some controllers might want to do DMA on the data buffer embedded in @op.
> + * This helper prepares everything for you and provides a ready-to-use
> + * sg_table. This function is not intended to be called from spi drivers.
> + * Only SPI controller drivers should use it.
> + * Note that the caller must ensure the memory region pointed by
> + * op->data.buf.{in,out} is DMA-able before calling this function.
> + *
> + * Return: 0 in case of success, a negative error code otherwise.
> + */
> +int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
> +				       const struct spi_mem_op *op,
> +				       struct sg_table *sgt)
> +{
> +	struct device *dmadev;
> +
> +	if (!op->data.nbytes)
> +		return -EINVAL;
> +
> +	if (op->data.dir == SPI_MEM_DATA_OUT)
> +		dmadev = ctlr->dma_tx ?
> +			 ctlr->dma_tx->device->dev : ctlr->dev.parent;
> +	else
> +		dmadev = ctlr->dma_rx ?
> +			 ctlr->dma_rx->device->dev : ctlr->dev.parent;
> +
> +	if (!dmadev)
> +		return -EINVAL;
> +
> +	return spi_map_buf(ctlr, dmadev, sgt, op->data.buf.in, op->data.nbytes,
> +			   op->data.dir == SPI_MEM_DATA_IN ?
> +			   DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +}
> +EXPORT_SYMBOL_GPL(spi_controller_dma_map_mem_op_data);
> +
> +/**
> + * spi_controller_dma_unmap_mem_op_data() - DMA-unmap the buffer attached to a
> + *					    memory operation
> + * @ctlr: the SPI controller requesting this dma_unmap()
> + * @op: the memory operation containing the buffer to unmap
> + * @sgt: a pointer to an sg_table previously initialized by
> + *	 spi_controller_dma_map_mem_op_data()
> + *
> + * Some controllers might want to do DMA on the data buffer embedded in @op.
> + * This helper prepares things so that the CPU can access the
> + * op->data.buf.{in,out} buffer again.
> + *
> + * This function is not intended to be called from spi drivers. Only SPI

s/spi/SPI/

> + * controller drivers should use it.
> + *
> + * This function should be called after the DMA operation has finished an is

s/an/and/

> + * only valid if the previous spi_controller_dma_map_mem_op_data() has returned
> + * 0.
> + *
> + * Return: 0 in case of success, a negative error code otherwise.
> + */
> +void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
> +					  const struct spi_mem_op *op,
> +					  struct sg_table *sgt)
> +{
> +	struct device *dmadev;
> +
> +	if (!op->data.nbytes)
> +		return;
> +
> +	if (op->data.dir == SPI_MEM_DATA_OUT)
> +		dmadev = ctlr->dma_tx ?
> +			 ctlr->dma_tx->device->dev : ctlr->dev.parent;
> +	else
> +		dmadev = ctlr->dma_rx ?
> +			 ctlr->dma_rx->device->dev : ctlr->dev.parent;
> +
> +	spi_unmap_buf(ctlr, dmadev, sgt,
> +		      op->data.dir == SPI_MEM_DATA_IN ?
> +		      DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +}
> +EXPORT_SYMBOL_GPL(spi_controller_dma_unmap_mem_op_data);
> +
> +static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
> +{
> +	u32 mode = mem->spi->mode;
> +
> +	switch (buswidth) {
> +	case 1:
> +		return 0;
> +
> +	case 2:
> +		if ((tx && (mode & (SPI_TX_DUAL | SPI_TX_QUAD))) ||
> +		    (!tx && (mode & (SPI_RX_DUAL | SPI_RX_QUAD))))
> +			return 0;
> +
> +		break;
> +
> +	case 4:
> +		if ((tx && (mode & SPI_TX_QUAD)) ||
> +		    (!tx && (mode & SPI_RX_QUAD)))
> +			return 0;
> +
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -ENOTSUPP;
> +}
> +
> +/**
> + * spi_mem_supports_op() - Check if a memory device and the controller it is
> + *			   connected to support a specific memory operation
> + * @mem: the SPI memory
> + * @op: the memory operation to check
> + *
> + * Some controllers are only supporting Single or Dual IOs, others might only
> + * support specific opcodes, or it can even be that the controller and device
> + * both support Quad IOs but the hardware prevents you from using it because
> + * only 2 IO lines are connected.
> + *
> + * This function checks whether a specific operation is supported.
> + *
> + * Return: true if @op is supported, false otherwise.
> + */
> +bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	struct spi_controller *ctlr = mem->spi->controller;
> +
> +	if (spi_check_buswidth_req(mem, op->cmd.buswidth, true))
> +		return false;
> +
> +	if (op->addr.nbytes &&
> +	    spi_check_buswidth_req(mem, op->addr.buswidth, true))
> +		return false;
> +
> +	if (op->dummy.nbytes &&
> +	    spi_check_buswidth_req(mem, op->dummy.buswidth, true))
> +		return false;
> +
> +	if (op->data.nbytes &&
> +	    spi_check_buswidth_req(mem, op->data.buswidth,
> +				   op->data.dir == SPI_MEM_DATA_IN ?
> +				   false : true))

Why not just op->data.dir != SPI_MEM_DATA_IN or even better ==
SPI_MEM_DATA_OUT if it exists?

> +		return false;
> +
> +	if (ctlr->mem_ops)
> +		return ctlr->mem_ops->supports_op(mem, op);
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(spi_mem_supports_op);
> +
> +/**
> + * spi_mem_exec_op() - Execute a memory operation
> + * @mem: the SPI memory
> + * @op: the memory operation to execute
> + *
> + * Executes a memory operation.
> + *
> + * This function first checks that @op is supported and then tries to execute
> + * it.
> + *
> + * Return: 0 in case of success, a negative error code otherwise.
> + */
> +int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	unsigned int tmpbufsize, xferpos = 0, totalxferlen = 0;
> +	struct spi_controller *ctlr = mem->spi->controller;
> +	struct spi_transfer xfers[4] = { };
> +	struct spi_message msg;
> +	u8 *tmpbuf;
> +	int ret;
> +
> +	if (!spi_mem_supports_op(mem, op))
> +		return -ENOTSUPP;
> +
> +	if (ctlr->mem_ops) {
> +		if (ctlr->auto_runtime_pm) {
> +			ret = pm_runtime_get_sync(ctlr->dev.parent);
> +			if (ret < 0) {
> +				dev_err(&ctlr->dev,
> +					"Failed to power device: %d\n",
> +					ret);
> +				return ret;
> +			}
> +		}
> +
> +		mutex_lock(&ctlr->bus_lock_mutex);
> +		mutex_lock(&ctlr->io_mutex);
> +		ret = ctlr->mem_ops->exec_op(mem, op);
> +		mutex_unlock(&ctlr->io_mutex);
> +		mutex_unlock(&ctlr->bus_lock_mutex);

Is not this a bit dangerous? I guess that no one should release the bus
lock without having already released the IO lock but maybe this should
be clearly mentioned in a comment in the original structure definition?

> +
> +		if (ctlr->auto_runtime_pm)
> +			pm_runtime_put(ctlr->dev.parent);
> +
> +		/*
> +		 * Some controllers only optimize specific paths (typically the
> +		 * read path) and expect the core to use the regular SPI
> +		 * interface in these cases.
> +		 */
> +		if (!ret || ret != -ENOTSUPP)
> +			return ret;
> +	}
> +
> +	tmpbufsize = sizeof(op->cmd.opcode) + op->addr.nbytes +
> +		     op->dummy.nbytes;
> +
> +	/*
> +	 * Allocate a buffer to transmit the CMD, ADDR cycles with kmalloc() so
> +	 * we're guaranteed that this buffer is DMA-able, as required by the
> +	 * SPI layer.
> +	 */
> +	tmpbuf = kzalloc(tmpbufsize, GFP_KERNEL | GFP_DMA);
> +	if (!tmpbuf)
> +		return -ENOMEM;
> +
> +	spi_message_init(&msg);
> +
> +	tmpbuf[0] = op->cmd.opcode;
> +	xfers[xferpos].tx_buf = tmpbuf;
> +	xfers[xferpos].len = sizeof(op->cmd.opcode);
> +	xfers[xferpos].tx_nbits = op->cmd.buswidth;
> +	spi_message_add_tail(&xfers[xferpos], &msg);
> +	xferpos++;
> +	totalxferlen++;
> +
> +	if (op->addr.nbytes) {
> +		memcpy(tmpbuf + 1, op->addr.buf, op->addr.nbytes);
> +		xfers[xferpos].tx_buf = tmpbuf + 1;
> +		xfers[xferpos].len = op->addr.nbytes;
> +		xfers[xferpos].tx_nbits = op->addr.buswidth;
> +		spi_message_add_tail(&xfers[xferpos], &msg);
> +		xferpos++;
> +		totalxferlen += op->addr.nbytes;
> +	}
> +
> +	if (op->dummy.nbytes) {
> +		memset(tmpbuf + op->addr.nbytes + 1, 0xff, op->dummy.nbytes);
> +		xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
> +		xfers[xferpos].len = op->dummy.nbytes;
> +		xfers[xferpos].tx_nbits = op->dummy.buswidth;
> +		spi_message_add_tail(&xfers[xferpos], &msg);
> +		xferpos++;
> +		totalxferlen += op->dummy.nbytes;
> +	}
> +
> +	if (op->data.nbytes) {
> +		if (op->data.dir == SPI_MEM_DATA_IN) {
> +			xfers[xferpos].rx_buf = op->data.buf.in;
> +			xfers[xferpos].rx_nbits = op->data.buswidth;
> +		} else {
> +			xfers[xferpos].tx_buf = op->data.buf.out;
> +			xfers[xferpos].tx_nbits = op->data.buswidth;
> +		}
> +
> +		xfers[xferpos].len = op->data.nbytes;
> +		spi_message_add_tail(&xfers[xferpos], &msg);
> +		xferpos++;
> +		totalxferlen += op->data.nbytes;
> +	}
> +
> +	ret = spi_sync(mem->spi, &msg);
> +
> +	kfree(tmpbuf);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (msg.actual_length != totalxferlen)
> +		return -EIO;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_mem_exec_op);
> +
> +/**
> + * spi_mem_adjust_op_size() - Adjust the data size of a SPI mem operation to
> + *			      match controller limitations
> + * @mem: the SPI memory
> + * @op: the operation to adjust
> + *
> + * Some controllers have FIFO limitations and must split a data transfer
> + * operation into multiple ones, others require a specific alignment for
> + * optimized accesses. This function allows SPI mem drivers to split a single
> + * operation into multiple sub-operations when required.
> + *
> + * Return: a negative error code if the controller can't properly adjust @op,
> + *	   0 otherwise. Note that @op->data.nbytes will be updated if @op
> + *	   can't be handled in a single step.
> + */
> +int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> +{
> +	struct spi_controller *ctlr = mem->spi->controller;
> +
> +	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
> +		return ctlr->mem_ops->adjust_op_size(mem, op);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
> +
> +static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
> +{
> +	return container_of(drv, struct spi_mem_driver, spidrv.driver);
> +}
> +
> +static int spi_mem_probe(struct spi_device *spi)
> +{
> +	struct spi_mem_driver *memdrv = to_spi_mem_drv(spi->dev.driver);
> +	struct spi_mem *mem;
> +
> +	mem = devm_kzalloc(&spi->dev, sizeof(*mem), GFP_KERNEL);
> +	if (!mem)
> +		return -ENOMEM;
> +
> +	mem->spi = spi;
> +	spi_set_drvdata(spi, mem);
> +
> +	return memdrv->probe(mem);
> +}
> +
> +static int spi_mem_remove(struct spi_device *spi)
> +{
> +	struct spi_mem_driver *memdrv = to_spi_mem_drv(spi->dev.driver);
> +	struct spi_mem *mem = spi_get_drvdata(spi);
> +
> +	if (memdrv->remove)
> +		return memdrv->remove(mem);
> +
> +	return 0;
> +}
> +
> +static void spi_mem_shutdown(struct spi_device *spi)
> +{
> +	struct spi_mem_driver *memdrv = to_spi_mem_drv(spi->dev.driver);
> +	struct spi_mem *mem = spi_get_drvdata(spi);
> +
> +	if (memdrv->shutdown)
> +		memdrv->shutdown(mem);
> +}
> +
> +/**
> + * spi_mem_driver_register_with_owner() - Register a SPI memory driver
> + * @memdrv: the SPI memory driver to register
> + * @owner: the owner of this driver
> + *
> + * Registers a SPI memory driver.
> + *
> + * Return: 0 in case of success, a negative error core otherwise.
> + */
> +
> +int spi_mem_driver_register_with_owner(struct spi_mem_driver *memdrv,
> +				       struct module *owner)
> +{
> +	memdrv->spidrv.probe = spi_mem_probe;
> +	memdrv->spidrv.remove = spi_mem_remove;
> +	memdrv->spidrv.shutdown = spi_mem_shutdown;
> +
> +	return __spi_register_driver(owner, &memdrv->spidrv);
> +}
> +EXPORT_SYMBOL_GPL(spi_mem_driver_register_with_owner);
> +
> +/**
> + * spi_mem_driver_unregister_with_owner() - Unregister a SPI memory driver
> + * @memdrv: the SPI memory driver to unregister
> + *
> + * Unregisters a SPI memory driver.
> + */
> +void spi_mem_driver_unregister(struct spi_mem_driver *memdrv)
> +{
> +	spi_unregister_driver(&memdrv->spidrv);
> +}
> +EXPORT_SYMBOL_GPL(spi_mem_driver_unregister);
> +
>  /*-------------------------------------------------------------------------*/
>  
>  #if IS_ENABLED(CONFIG_OF_DYNAMIC)
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 7b2170bfd6e7..af3c4ac62b55 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -27,6 +27,7 @@ struct property_entry;
>  struct spi_controller;
>  struct spi_transfer;
>  struct spi_flash_read_message;
> +struct spi_controller_mem_ops;
>  
>  /*
>   * INTERFACES between SPI master-side drivers and SPI slave protocol handlers,
> @@ -376,6 +377,9 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
>   *                    transfer_one callback.
>   * @handle_err: the subsystem calls the driver to handle an error that occurs
>   *		in the generic implementation of transfer_one_message().
> + * @mem_ops: optimized/dedicated operations for interactions with SPI memory.
> + *	     This field is optional and should only be implemented if the
> + *	     controller has native support for memory like operations.
>   * @unprepare_message: undo any work done by prepare_message().
>   * @slave_abort: abort the ongoing transfer request on an SPI slave controller
>   * @spi_flash_read: to support spi-controller hardwares that provide
> @@ -564,6 +568,9 @@ struct spi_controller {
>  	void (*handle_err)(struct spi_controller *ctlr,
>  			   struct spi_message *message);
>  
> +	/* Optimized handlers for SPI memory-like operations. */
> +	const struct spi_controller_mem_ops *mem_ops;
> +
>  	/* gpio chip select */
>  	int			*cs_gpios;
>  
> @@ -1227,6 +1234,225 @@ int spi_flash_read(struct spi_device *spi,
>  
>  /*---------------------------------------------------------------------------*/
>  
> +/* SPI memory related definitions. */
> +
> +#define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
> +	{							\
> +		.buswidth = __buswidth,				\
> +		.opcode = __opcode,				\
> +	}
> +
> +#define SPI_MEM_OP_ADDRS(__nbytes, __buf, __buswidth)		\
> +	{							\
> +		.nbytes = __nbytes,				\
> +		.buf = __buf,					\
> +		.buswidth = __buswidth,				\
> +	}
> +
> +#define SPI_MEM_OP_NO_ADDRS	{ }
> +
> +#define SPI_MEM_OP_DUMMY(__nbytes, __buswidth)			\
> +	{							\
> +		.nbytes = __nbytes,				\
> +		.buswidth = __buswidth,				\
> +	}
> +
> +#define SPI_MEM_OP_NO_DUMMY	{ }
> +
> +#define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
> +	{							\
> +		.dir = SPI_MEM_DATA_IN,				\
> +		.nbytes = __nbytes,				\
> +		.buf.in = __buf,				\
> +		.buswidth = __buswidth,				\
> +	}
> +
> +#define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
> +	{							\
> +		.dir = SPI_MEM_DATA_OUT,			\
> +		.nbytes = __nbytes,				\
> +		.buf.out = __buf,				\
> +		.buswidth = __buswidth,				\
> +	}
> +
> +#define SPI_MEM_OP_NO_DATA	{ }
> +
> +/**
> + * enum spi_mem_data_dir - describes the direction of a SPI memory data
> + *			   transfer from the controller perspective
> + * @SPI_MEM_DATA_IN: data coming from the SPI memory
> + * @SPI_MEM_DATA_OUT: data sent the SPI memory
> + */
> +enum spi_mem_data_dir {
> +	SPI_MEM_DATA_IN,
> +	SPI_MEM_DATA_OUT,
> +};
> +
> +/**
> + * struct spi_mem_op - describes a SPI memory operation
> + * @cmd.buswidth: number of IO lines used to transmit the command
> + * @cmd.opcode: operation opcode
> + * @addr.nbytes: number of address bytes to send. Can be zero if the operation
> + *		 does not need to send an address
> + * @addr.buswidth: number of IO lines used to transmit the address cycles
> + * @addr.buf: buffer storing the address bytes
> + * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
> + *		  be zero if the operation does not require dummy bytes
> + * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
> + * @data.buswidth: number of IO lanes used to send/receive the data
> + * @data.dir: direction of the transfer
> + * @data.buf.in: input buffer
> + * @data.buf.out: output buffer
> + */
> +struct spi_mem_op {
> +	struct {
> +		u8 buswidth;
> +		u8 opcode;
> +	} cmd;
> +
> +	struct {
> +		u8 nbytes;
> +		u8 buswidth;
> +		const u8 *buf;
> +	} addr;
> +
> +	struct {
> +		u8 nbytes;
> +		u8 buswidth;
> +	} dummy;
> +
> +	struct {
> +		u8 buswidth;
> +		enum spi_mem_data_dir dir;
> +		unsigned int nbytes;
> +		/* buf.{in,out} must be DMA-able. */
> +		union {
> +			void *in;
> +			const void *out;
> +		} buf;
> +	} data;
> +};
> +
> +#define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
> +	{							\
> +		.cmd = __cmd,					\
> +		.addr = __addr,					\
> +		.dummy = __dummy,				\
> +		.data = __data,					\
> +	}
> +
> +/**
> + * struct spi_mem - describes a SPI memory device
> + * @spi: the underlying SPI device
> + * @drvpriv: spi_mem_drviver private data
> + *
> + * Extra information that describe the SPI memory device and may be needed by
> + * the controller to properly handle this device should be placed here.
> + *
> + * One example would be the device size since some controller expose their SPI
> + * mem devices through a io-mapped region.
> + */
> +struct spi_mem {
> +	struct spi_device *spi;
> +	void *drvpriv;
> +};
> +
> +/**
> + * struct spi_mem_set_drvdata() - attach driver private data to a SPI mem
> + *				  device
> + * @mem: memory device
> + * @data: data to attach to the memory device
> + */
> +static inline void spi_mem_set_drvdata(struct spi_mem *mem, void *data)
> +{
> +	mem->drvpriv = data;
> +}
> +
> +/**
> + * struct spi_mem_get_drvdata() - get driver private data attached to a SPI mem
> + *				  device
> + * @mem: memory device
> + *
> + * Return: the data attached to the mem device.
> + */
> +static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
> +{
> +	return mem->drvpriv;
> +}
> +
> +/**
> + * struct spi_controller_mem_ops - SPI memory operations
> + * @adjust_op_size: shrink the data xfer of an operation to match controller's
> + *		    limitations (can be alignment of max RX/TX size
> + *		    limitations)
> + * @supports_op: check if an operation is supported by the controller
> + * @exec_op: execute a SPI memory operation
> + *
> + * This interface should be implemented by SPI controllers providing an
> + * high-level interface to execute SPI memory operation, which is usually the
> + * case for QSPI controllers.
> + */
> +struct spi_controller_mem_ops {
> +	int (*adjust_op_size)(struct spi_mem *mem, struct spi_mem_op *op);
> +	bool (*supports_op)(struct spi_mem *mem,
> +			    const struct spi_mem_op *op);
> +	int (*exec_op)(struct spi_mem *mem,
> +		       const struct spi_mem_op *op);

:)

> +};
> +
> +int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
> +				       const struct spi_mem_op *op,
> +				       struct sg_table *sg);
> +
> +void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
> +					  const struct spi_mem_op *op,
> +					  struct sg_table *sg);
> +
> +int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
> +
> +bool spi_mem_supports_op(struct spi_mem *mem,
> +			 const struct spi_mem_op *op);
> +
> +int spi_mem_exec_op(struct spi_mem *mem,
> +		    const struct spi_mem_op *op);
> +
> +/**
> + * struct spi_mem_driver - SPI memory driver
> + * @spidrv: inherit from a SPI driver
> + * @probe: probe a SPI memory. Usually where detection/initialization takes
> + *	   place
> + * @remove: remove a SPI memory
> + * @shutdown: take appropriate action when the system is shutdown
> + *
> + * This is just a thin wrapper around a spi_driver. The core takes care of
> + * allocating the spi_mem object and forwarding the probe/remove/shutdown
> + * request to the spi_mem_driver. The reason we use this wrapper is because
> + * we might have to stuff more information into the spi_mem struct to let
> + * SPI controllers know more about the SPI memory they interact with, and
> + * having this intermediate layer allows us to do that without adding more
> + * useless fields to the spi_device object.
> + */
> +struct spi_mem_driver {
> +	struct spi_driver spidrv;
> +	int (*probe)(struct spi_mem *mem);
> +	int (*remove)(struct spi_mem *mem);
> +	void (*shutdown)(struct spi_mem *mem);
> +};
> +
> +int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
> +				       struct module *owner);
> +
> +#define spi_mem_driver_register(__drv)                                  \
> +	spi_mem_driver_register_with_owner(__drv, THIS_MODULE)
> +
> +void spi_mem_driver_unregister(struct spi_mem_driver *drv);
> +
> +#define module_spi_mem_driver(__drv)                                    \
> +	module_driver(__drv, spi_mem_driver_register,                   \
> +		      spi_mem_driver_unregister)
> +
> +/*---------------------------------------------------------------------------*/
> +
>  /*
>   * INTERFACE between board init code and SPI infrastructure.
>   *


Best regards,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
