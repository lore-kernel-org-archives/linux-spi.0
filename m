From: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 1/6] spi: Extend the core to ease integration of SPI
 memory controllers
Date: Sun, 11 Feb 2018 17:00:19 +0100
Message-ID: <20180211170019.7ebfd39c@bbrezillon>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
        <20180205232120.5851-2-boris.brezillon@bootlin.com>
        <20180209135205.6872203c@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180209135205.6872203c@xps13>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Miquel,

On Fri, 9 Feb 2018 13:52:05 +0100
Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:

> > +/**
> > + * spi_controller_dma_unmap_mem_op_data() - DMA-unmap the buffer attached to a
> > + *					    memory operation
> > + * @ctlr: the SPI controller requesting this dma_unmap()
> > + * @op: the memory operation containing the buffer to unmap
> > + * @sgt: a pointer to an sg_table previously initialized by
> > + *	 spi_controller_dma_map_mem_op_data()
> > + *
> > + * Some controllers might want to do DMA on the data buffer embedded in @op.
> > + * This helper prepares things so that the CPU can access the
> > + * op->data.buf.{in,out} buffer again.
> > + *
> > + * This function is not intended to be called from spi drivers. Only SPI  
> 
> s/spi/SPI/
> 
> > + * controller drivers should use it.
> > + *
> > + * This function should be called after the DMA operation has finished an is  
> 
> s/an/and/

Will fix both.

> 
> > + * only valid if the previous spi_controller_dma_map_mem_op_data() has returned
> > + * 0.
> > + *
> > + * Return: 0 in case of success, a negative error code otherwise.
> > + */
> > +void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
> > +					  const struct spi_mem_op *op,
> > +					  struct sg_table *sgt)
> > +{
> > +	struct device *dmadev;
> > +
> > +	if (!op->data.nbytes)
> > +		return;
> > +
> > +	if (op->data.dir == SPI_MEM_DATA_OUT)
> > +		dmadev = ctlr->dma_tx ?
> > +			 ctlr->dma_tx->device->dev : ctlr->dev.parent;
> > +	else
> > +		dmadev = ctlr->dma_rx ?
> > +			 ctlr->dma_rx->device->dev : ctlr->dev.parent;
> > +
> > +	spi_unmap_buf(ctlr, dmadev, sgt,
> > +		      op->data.dir == SPI_MEM_DATA_IN ?
> > +		      DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > +}
> > +EXPORT_SYMBOL_GPL(spi_controller_dma_unmap_mem_op_data);
> > +
> > +static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
> > +{
> > +	u32 mode = mem->spi->mode;
> > +
> > +	switch (buswidth) {
> > +	case 1:
> > +		return 0;
> > +
> > +	case 2:
> > +		if ((tx && (mode & (SPI_TX_DUAL | SPI_TX_QUAD))) ||
> > +		    (!tx && (mode & (SPI_RX_DUAL | SPI_RX_QUAD))))
> > +			return 0;
> > +
> > +		break;
> > +
> > +	case 4:
> > +		if ((tx && (mode & SPI_TX_QUAD)) ||
> > +		    (!tx && (mode & SPI_RX_QUAD)))
> > +			return 0;
> > +
> > +		break;
> > +
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return -ENOTSUPP;
> > +}
> > +
> > +/**
> > + * spi_mem_supports_op() - Check if a memory device and the controller it is
> > + *			   connected to support a specific memory operation
> > + * @mem: the SPI memory
> > + * @op: the memory operation to check
> > + *
> > + * Some controllers are only supporting Single or Dual IOs, others might only
> > + * support specific opcodes, or it can even be that the controller and device
> > + * both support Quad IOs but the hardware prevents you from using it because
> > + * only 2 IO lines are connected.
> > + *
> > + * This function checks whether a specific operation is supported.
> > + *
> > + * Return: true if @op is supported, false otherwise.
> > + */
> > +bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
> > +{
> > +	struct spi_controller *ctlr = mem->spi->controller;
> > +
> > +	if (spi_check_buswidth_req(mem, op->cmd.buswidth, true))
> > +		return false;
> > +
> > +	if (op->addr.nbytes &&
> > +	    spi_check_buswidth_req(mem, op->addr.buswidth, true))
> > +		return false;
> > +
> > +	if (op->dummy.nbytes &&
> > +	    spi_check_buswidth_req(mem, op->dummy.buswidth, true))
> > +		return false;
> > +
> > +	if (op->data.nbytes &&
> > +	    spi_check_buswidth_req(mem, op->data.buswidth,
> > +				   op->data.dir == SPI_MEM_DATA_IN ?
> > +				   false : true))  
> 
> Why not just op->data.dir != SPI_MEM_DATA_IN or even better ==
> SPI_MEM_DATA_OUT if it exists?

Indeed, I'll use op->data.dir == SPI_MEM_DATA_OUT.

> 
> > +		return false;
> > +
> > +	if (ctlr->mem_ops)
> > +		return ctlr->mem_ops->supports_op(mem, op);
> > +
> > +	return true;
> > +}
> > +EXPORT_SYMBOL_GPL(spi_mem_supports_op);
> > +
> > +/**
> > + * spi_mem_exec_op() - Execute a memory operation
> > + * @mem: the SPI memory
> > + * @op: the memory operation to execute
> > + *
> > + * Executes a memory operation.
> > + *
> > + * This function first checks that @op is supported and then tries to execute
> > + * it.
> > + *
> > + * Return: 0 in case of success, a negative error code otherwise.
> > + */
> > +int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> > +{
> > +	unsigned int tmpbufsize, xferpos = 0, totalxferlen = 0;
> > +	struct spi_controller *ctlr = mem->spi->controller;
> > +	struct spi_transfer xfers[4] = { };
> > +	struct spi_message msg;
> > +	u8 *tmpbuf;
> > +	int ret;
> > +
> > +	if (!spi_mem_supports_op(mem, op))
> > +		return -ENOTSUPP;
> > +
> > +	if (ctlr->mem_ops) {
> > +		if (ctlr->auto_runtime_pm) {
> > +			ret = pm_runtime_get_sync(ctlr->dev.parent);
> > +			if (ret < 0) {
> > +				dev_err(&ctlr->dev,
> > +					"Failed to power device: %d\n",
> > +					ret);
> > +				return ret;
> > +			}
> > +		}
> > +
> > +		mutex_lock(&ctlr->bus_lock_mutex);
> > +		mutex_lock(&ctlr->io_mutex);
> > +		ret = ctlr->mem_ops->exec_op(mem, op);
> > +		mutex_unlock(&ctlr->io_mutex);
> > +		mutex_unlock(&ctlr->bus_lock_mutex);  
> 
> Is not this a bit dangerous? I guess that no one should release the bus
> lock without having already released the IO lock but maybe this should
> be clearly mentioned in a comment in the original structure definition?

It's not something new, spi_flash_read() was doing the same [1]. This
being said, if Mark agrees, I can add a comment in the spi_controller
struct def stating that ->bus_lock_mutex should always be acquired
before ->io_mutex.

Thanks for your review.

Boris

[1]http://elixir.free-electrons.com/linux/v4.15.2/source/drivers/spi/spi.c#L3045
-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
