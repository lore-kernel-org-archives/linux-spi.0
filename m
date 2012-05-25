From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: bitbang: convert to using core message queue
Date: Fri, 25 May 2012 17:29:49 -0600
Message-ID: <20120525232949.753D43E0BAA@localhost>
References: <Pine.LNX.4.64.1205211319520.30522@axis700.grange>
	<Pine.LNX.4.64.1205211324370.30522@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.1205211324370.30522-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 21 May 2012 13:25:23 +0200 (CEST), Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> The SPI subsystem core now manages message queues internally. Remove the
> local message queue implementation from the spi-bitbang driver and
> migrate to the common one.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>

Okay, I'm going to be really nitpicky here.  The change is fine, but the
diff is too big; particularly for anyone trying to figure out what has
changed if it causes breakage.  I wouldn't worry about this as much
for an individual driver, but spi_bitbang is common infrastructure.

For example, "struct spi_master *master = bitbang->master;" is added
to spi_bitbang start, and then all the references are changed from
bitbang->master to master; bloating the diffstat (with the -w flag to
ignore whitespace changes).  I have no problem with that change, but
it must be in a seperate patch so readers have a fighting chance to
understand what actually changed functionally.

Ditto in spi_bitbang_transfer_one_message which changes 'm' to 'msg'.
Ditto in spi_bitbang_transfer_one_message moving the assignment of
spi = m->spi.

There are other things that change unnecessarily.  Take a look at the
output of git show -w and try to cut down the diff.

Here is the diff of things that I've undone to make the diffstat a lot
smaller:

g.

> ---
>  drivers/spi/spi-bitbang.c       |  278 +++++++++++++++------------------------
>  include/linux/spi/spi_bitbang.h |    7 -
>  2 files changed, 107 insertions(+), 178 deletions(-)
> 
> diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
> index 8b3d8ef..e0f8a14 100644
> --- a/drivers/spi/spi-bitbang.c
> +++ b/drivers/spi/spi-bitbang.c
> @@ -244,161 +244,124 @@ static int spi_bitbang_bufs(struct spi_device *spi, struct spi_transfer *t)
>  
>  /*----------------------------------------------------------------------*/
>  
> -/*
> - * SECOND PART ... simple transfer queue runner.
> - *
> - * This costs a task context per controller, running the queue by
> - * performing each transfer in sequence.  Smarter hardware can queue
> - * several DMA transfers at once, and process several controller queues
> - * in parallel; this driver doesn't match such hardware very well.
> - *
> - * Drivers can provide word-at-a-time i/o primitives, or provide
> - * transfer-at-a-time ones to leverage dma or fifo hardware.
> - */
> -static void bitbang_work(struct work_struct *work)
> +static int spi_bitbang_transfer_one_message(struct spi_master *master,
> +					    struct spi_message *msg)
>  {
> -	struct spi_bitbang	*bitbang =
> -		container_of(work, struct spi_bitbang, work);
> +	struct spi_bitbang	*bitbang = spi_master_get_devdata(master);
> +	struct spi_device	*spi = msg->spi;
> +	unsigned		nsecs;
> +	struct spi_transfer	*t = NULL;
>  	unsigned long		flags;
> -	struct spi_message	*m, *_m;
> +	unsigned		cs_change;
> +	int			status;
> +	int			do_setup = -1;
>  
> +	/* Protect against chip-select release in .setup() */
>  	spin_lock_irqsave(&bitbang->lock, flags);
>  	bitbang->busy = 1;
> -	list_for_each_entry_safe(m, _m, &bitbang->queue, queue) {
> -		struct spi_device	*spi;
> -		unsigned		nsecs;
> -		struct spi_transfer	*t = NULL;
> -		unsigned		tmp;
> -		unsigned		cs_change;
> -		int			status;
> -		int			do_setup = -1;
> -
> -		list_del(&m->queue);
> -		spin_unlock_irqrestore(&bitbang->lock, flags);
> -
> -		/* FIXME this is made-up ... the correct value is known to
> -		 * word-at-a-time bitbang code, and presumably chipselect()
> -		 * should enforce these requirements too?
> -		 */
> -		nsecs = 100;
> +	spin_unlock_irqrestore(&bitbang->lock, flags);
>  
> -		spi = m->spi;
> -		tmp = 0;
> -		cs_change = 1;
> -		status = 0;
> +	/* FIXME this is made-up ... the correct value is known to
> +	 * word-at-a-time bitbang code, and presumably chipselect()
> +	 * should enforce these requirements too?
> +	 */
> +	nsecs = 100;
>  
> -		list_for_each_entry (t, &m->transfers, transfer_list) {
> -
> -			/* override speed or wordsize? */
> -			if (t->speed_hz || t->bits_per_word)
> -				do_setup = 1;
> -
> -			/* init (-1) or override (1) transfer params */
> -			if (do_setup != 0) {
> -				status = bitbang->setup_transfer(spi, t);
> -				if (status < 0)
> -					break;
> -				if (do_setup == -1)
> -					do_setup = 0;
> -			}
> -
> -			/* set up default clock polarity, and activate chip;
> -			 * this implicitly updates clock and spi modes as
> -			 * previously recorded for this device via setup().
> -			 * (and also deselects any other chip that might be
> -			 * selected ...)
> -			 */
> -			if (cs_change) {
> -				bitbang->chipselect(spi, BITBANG_CS_ACTIVE);
> -				ndelay(nsecs);
> -			}
> -			cs_change = t->cs_change;
> -			if (!t->tx_buf && !t->rx_buf && t->len) {
> -				status = -EINVAL;
> -				break;
> -			}
> +	cs_change = 1;
> +	status = 0;
>  
> -			/* transfer data.  the lower level code handles any
> -			 * new dma mappings it needs. our caller always gave
> -			 * us dma-safe buffers.
> -			 */
> -			if (t->len) {
> -				/* REVISIT dma API still needs a designated
> -				 * DMA_ADDR_INVALID; ~0 might be better.
> -				 */
> -				if (!m->is_dma_mapped)
> -					t->rx_dma = t->tx_dma = 0;
> -				status = bitbang->txrx_bufs(spi, t);
> -			}
> -			if (status > 0)
> -				m->actual_length += status;
> -			if (status != t->len) {
> -				/* always report some kind of error */
> -				if (status >= 0)
> -					status = -EREMOTEIO;
> +	list_for_each_entry (t, &msg->transfers, transfer_list) {
> +
> +		/* override speed or wordsize? */
> +		if (t->speed_hz || t->bits_per_word)
> +			do_setup = 1;
> +
> +		/* init (-1) or override (1) transfer params */
> +		if (do_setup != 0) {
> +			status = bitbang->setup_transfer(spi, t);
> +			if (status < 0)
>  				break;
> -			}
> -			status = 0;
> -
> -			/* protocol tweaks before next transfer */
> -			if (t->delay_usecs)
> -				udelay(t->delay_usecs);
> -
> -			if (cs_change && !list_is_last(&t->transfer_list, &m->transfers)) {
> -				/* sometimes a short mid-message deselect of the chip
> -				 * may be needed to terminate a mode or command
> -				 */
> -				ndelay(nsecs);
> -				bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
> -				ndelay(nsecs);
> -			}
> +			if (do_setup == -1)
> +				do_setup = 0;
>  		}
>  
> -		m->status = status;
> -		m->complete(m->context);
> +		/* set up default clock polarity, and activate chip;
> +		 * this implicitly updates clock and spi modes as
> +		 * previously recorded for this device via setup().
> +		 * (and also deselects any other chip that might be
> +		 * selected ...)
> +		 */
> +		if (cs_change) {
> +			bitbang->chipselect(spi, BITBANG_CS_ACTIVE);
> +			ndelay(nsecs);
> +		}
> +		cs_change = t->cs_change;
> +		if (!t->tx_buf && !t->rx_buf && t->len) {
> +			status = -EINVAL;
> +			break;
> +		}
>  
> -		/* normally deactivate chipselect ... unless no error and
> -		 * cs_change has hinted that the next message will probably
> -		 * be for this chip too.
> +		/* transfer data.  the lower level code handles any
> +		 * new dma mappings it needs. our caller always gave
> +		 * us dma-safe buffers.
>  		 */
> -		if (!(status == 0 && cs_change)) {
> +		if (t->len) {
> +			/* REVISIT dma API still needs a designated
> +			 * DMA_ADDR_INVALID; ~0 might be better.
> +			 */
> +			if (!msg->is_dma_mapped)
> +				t->rx_dma = t->tx_dma = 0;
> +			status = bitbang->txrx_bufs(spi, t);
> +		}
> +		if (status > 0)
> +			msg->actual_length += status;
> +		if (status != t->len) {
> +			/* always report some kind of error */
> +			if (status >= 0)
> +				status = -EREMOTEIO;
> +			break;
> +		}
> +		status = 0;
> +
> +		/* protocol tweaks before next transfer */
> +		if (t->delay_usecs)
> +			udelay(t->delay_usecs);
> +
> +		if (cs_change && !list_is_last(&t->transfer_list, &msg->transfers)) {
> +			/* sometimes a short mid-message deselect of the chip
> +			 * may be needed to terminate a mode or command
> +			 */
>  			ndelay(nsecs);
>  			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
>  			ndelay(nsecs);
>  		}
> -
> -		spin_lock_irqsave(&bitbang->lock, flags);
>  	}
> -	bitbang->busy = 0;
> -	spin_unlock_irqrestore(&bitbang->lock, flags);
> -}
>  
> -/**
> - * spi_bitbang_transfer - default submit to transfer queue
> - */
> -int spi_bitbang_transfer(struct spi_device *spi, struct spi_message *m)
> -{
> -	struct spi_bitbang	*bitbang;
> -	unsigned long		flags;
> -	int			status = 0;
> -
> -	m->actual_length = 0;
> -	m->status = -EINPROGRESS;
> +	msg->status = status;
>  
> -	bitbang = spi_master_get_devdata(spi->master);
> +	/* normally deactivate chipselect ... unless no error and
> +	 * cs_change has hinted that the next message will probably
> +	 * be for this chip too.
> +	 */
> +	if (!(status == 0 && cs_change)) {
> +		ndelay(nsecs);
> +		bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
> +		ndelay(nsecs);
> +	}
>  
>  	spin_lock_irqsave(&bitbang->lock, flags);
> -	if (!spi->max_speed_hz)
> -		status = -ENETDOWN;
> -	else {
> -		list_add_tail(&m->queue, &bitbang->queue);
> -		queue_work(bitbang->workqueue, &bitbang->work);
> -	}
> +	bitbang->busy = 0;
>  	spin_unlock_irqrestore(&bitbang->lock, flags);
>  
> -	return status;
> +	spi_finalize_current_message(master);
> +
> +	return 0;
> +}
> +
> +static int spi_bitbang_dummy_prepare(struct spi_master *master)
> +{
> +	return 0;
>  }
> -EXPORT_SYMBOL_GPL(spi_bitbang_transfer);
>  
>  /*----------------------------------------------------------------------*/
>  
> @@ -407,9 +370,7 @@ EXPORT_SYMBOL_GPL(spi_bitbang_transfer);
>   * @bitbang: driver handle
>   *
>   * Caller should have zero-initialized all parts of the structure, and then
> - * provided callbacks for chip selection and I/O loops.  If the master has
> - * a transfer method, its final step should call spi_bitbang_transfer; or,
> - * that's the default if the transfer routine is not initialized.  It should
> + * provided callbacks for chip selection and I/O loops.  It should
>   * also set up the bus number and number of chipselects.
>   *
>   * For i/o loops, provide callbacks either per-word (for bitbanging, or for
> @@ -427,58 +388,37 @@ EXPORT_SYMBOL_GPL(spi_bitbang_transfer);
>   */
>  int spi_bitbang_start(struct spi_bitbang *bitbang)
>  {
> -	int	status;
> +	struct spi_master *master = bitbang->master;
>  
> -	if (!bitbang->master || !bitbang->chipselect)
> +	if (!master || !bitbang->chipselect)
>  		return -EINVAL;
>  
> -	INIT_WORK(&bitbang->work, bitbang_work);
>  	spin_lock_init(&bitbang->lock);
> -	INIT_LIST_HEAD(&bitbang->queue);
>  
> -	if (!bitbang->master->mode_bits)
> -		bitbang->master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
> +	if (!master->mode_bits)
> +		master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
> +
> +	master->transfer_one_message = spi_bitbang_transfer_one_message;
> +	master->prepare_transfer_hardware = spi_bitbang_dummy_prepare;
> +	master->unprepare_transfer_hardware = spi_bitbang_dummy_prepare;
>  
> -	if (!bitbang->master->transfer)
> -		bitbang->master->transfer = spi_bitbang_transfer;
>  	if (!bitbang->txrx_bufs) {
>  		bitbang->use_dma = 0;
>  		bitbang->txrx_bufs = spi_bitbang_bufs;
> -		if (!bitbang->master->setup) {
> +		if (!master->setup) {
>  			if (!bitbang->setup_transfer)
>  				bitbang->setup_transfer =
>  					 spi_bitbang_setup_transfer;
> -			bitbang->master->setup = spi_bitbang_setup;
> -			bitbang->master->cleanup = spi_bitbang_cleanup;
> +			master->setup = spi_bitbang_setup;
> +			master->cleanup = spi_bitbang_cleanup;
>  		}
> -	} else if (!bitbang->master->setup)
> -		return -EINVAL;
> -	if (bitbang->master->transfer == spi_bitbang_transfer &&
> -			!bitbang->setup_transfer)
> +	} else if (!master->setup)
>  		return -EINVAL;
>  
> -	/* this task is the only thing to touch the SPI bits */
> -	bitbang->busy = 0;
> -	bitbang->workqueue = create_singlethread_workqueue(
> -			dev_name(bitbang->master->dev.parent));
> -	if (bitbang->workqueue == NULL) {
> -		status = -EBUSY;
> -		goto err1;
> -	}
> -
>  	/* driver may get busy before register() returns, especially
>  	 * if someone registered boardinfo for devices
>  	 */
> -	status = spi_register_master(bitbang->master);
> -	if (status < 0)
> -		goto err2;
> -
> -	return status;
> -
> -err2:
> -	destroy_workqueue(bitbang->workqueue);
> -err1:
> -	return status;
> +	return spi_register_master(master);
>  }
>  EXPORT_SYMBOL_GPL(spi_bitbang_start);
>  
> @@ -489,10 +429,6 @@ int spi_bitbang_stop(struct spi_bitbang *bitbang)
>  {
>  	spi_unregister_master(bitbang->master);
>  
> -	WARN_ON(!list_empty(&bitbang->queue));
> -
> -	destroy_workqueue(bitbang->workqueue);
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(spi_bitbang_stop);
> diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
> index f987a2b..f85a7b8 100644
> --- a/include/linux/spi/spi_bitbang.h
> +++ b/include/linux/spi/spi_bitbang.h
> @@ -1,14 +1,8 @@
>  #ifndef	__SPI_BITBANG_H
>  #define	__SPI_BITBANG_H
>  
> -#include <linux/workqueue.h>
> -
>  struct spi_bitbang {
> -	struct workqueue_struct	*workqueue;
> -	struct work_struct	work;
> -
>  	spinlock_t		lock;
> -	struct list_head	queue;
>  	u8			busy;
>  	u8			use_dma;
>  	u8			flags;		/* extra spi->mode support */
> @@ -41,7 +35,6 @@ struct spi_bitbang {
>   */
>  extern int spi_bitbang_setup(struct spi_device *spi);
>  extern void spi_bitbang_cleanup(struct spi_device *spi);
> -extern int spi_bitbang_transfer(struct spi_device *spi, struct spi_message *m);
>  extern int spi_bitbang_setup_transfer(struct spi_device *spi,
>  				      struct spi_transfer *t);
>  
> -- 
> 1.7.2.5
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
