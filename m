From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2 2/2] spi: bitbang: convert to using core message queue
Date: Wed, 9 Jan 2013 15:44:02 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1301091535490.13376@axis700.grange>
References: <Pine.LNX.4.64.1301091502020.13376@axis700.grange>
 <Pine.LNX.4.64.1301091507120.13376@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Walleij <linus.walleij@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1301091507120.13376@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 9 Jan 2013, Guennadi Liakhovetski wrote:

> The SPI subsystem core now manages message queues internally. Remove the
> local message queue implementation from the spi-bitbang driver and
> migrate to the common one.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Argh... Actually I didn't intend to intensively test this - I've done it 
back when developing it, bitbang hasn't changed since then, so, why 
bother. And it did work with one card with no apparent problems. But then 
I did plug in another card... And then I've got

[   79.968000] mmc0: new SD card on SPI
[   79.976000] mmcblk0: mmc0:0000 SU02G 1.84 GiB
[   80.024000]  mmcblk0: p1
[   80.132000] mmcblk0: error -38 sending status command, retrying
[   80.136000] mmcblk0: error -38 sending status command, retrying
[   80.140000] mmcblk0: error -38 sending status command, aborting
[   81.028000] mmc0: SPI card removed
[   81.572000] mmc0: error -110 whilst initialising SD card

repeated a random number of times, until the card does get initialised 
eventually and then it works too. But the above failure can be repeated 
oce, twice, several times, sometimes it keeps repeating with no sign of 
success... Looks like something has changed in the SPI core queue 
processing, or maybe I didn't have this card back then. And yes, without 
this my patch the card initialises from the very first time. So, I think, 
this means a NAK. I don't think I have the time now to investigate this in 
detail, let's drop this for now until someone fixes it properly.

Thanks
Guennadi

> ---
> 
> v2: remove unrelated changes, partially dropping them and partially 
> extracting them into a separate patch.
> 
>  drivers/spi/spi-bitbang.c       |  266 +++++++++++++++------------------------
>  include/linux/spi/spi_bitbang.h |    7 -
>  2 files changed, 101 insertions(+), 172 deletions(-)
> 
> diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
> index 328c4dc..e989ad9 100644
> --- a/drivers/spi/spi-bitbang.c
> +++ b/drivers/spi/spi-bitbang.c
> @@ -244,161 +244,125 @@ static int spi_bitbang_bufs(struct spi_device *spi, struct spi_transfer *t)
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
> +					    struct spi_message *m)
>  {
> -	struct spi_bitbang	*bitbang =
> -		container_of(work, struct spi_bitbang, work);
> +	struct spi_bitbang	*bitbang = spi_master_get_devdata(master);
>  	unsigned long		flags;
> -	struct spi_message	*m, *_m;
> -
> +	struct spi_device	*spi;
> +	unsigned		nsecs;
> +	struct spi_transfer	*t = NULL;
> +	unsigned		cs_change;
> +	int			status;
> +	int			do_setup = -1;
> +
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
> +	spi = m->spi;
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
> +	list_for_each_entry (t, &m->transfers, transfer_list) {
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
> +			if (!m->is_dma_mapped)
> +				t->rx_dma = t->tx_dma = 0;
> +			status = bitbang->txrx_bufs(spi, t);
> +		}
> +		if (status > 0)
> +			m->actual_length += status;
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
> +		if (cs_change && !list_is_last(&t->transfer_list, &m->transfers)) {
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
> -
> -/**
> - * spi_bitbang_transfer - default submit to transfer queue
> - */
> -int spi_bitbang_transfer(struct spi_device *spi, struct spi_message *m)
> -{
> -	struct spi_bitbang	*bitbang;
> -	unsigned long		flags;
> -	int			status = 0;
>  
> -	m->actual_length = 0;
> -	m->status = -EINPROGRESS;
> +	m->status = status;
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
> @@ -407,9 +371,7 @@ EXPORT_SYMBOL_GPL(spi_bitbang_transfer);
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
> @@ -428,20 +390,19 @@ EXPORT_SYMBOL_GPL(spi_bitbang_transfer);
>  int spi_bitbang_start(struct spi_bitbang *bitbang)
>  {
>  	struct spi_master *master = bitbang->master;
> -	int status;
>  
>  	if (!master || !bitbang->chipselect)
>  		return -EINVAL;
>  
> -	INIT_WORK(&bitbang->work, bitbang_work);
>  	spin_lock_init(&bitbang->lock);
> -	INIT_LIST_HEAD(&bitbang->queue);
>  
>  	if (!master->mode_bits)
>  		master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
>  
> -	if (!master->transfer)
> -		master->transfer = spi_bitbang_transfer;
> +	master->transfer_one_message = spi_bitbang_transfer_one_message;
> +	master->prepare_transfer_hardware = spi_bitbang_dummy_prepare;
> +	master->unprepare_transfer_hardware = spi_bitbang_dummy_prepare;
> +
>  	if (!bitbang->txrx_bufs) {
>  		bitbang->use_dma = 0;
>  		bitbang->txrx_bufs = spi_bitbang_bufs;
> @@ -454,32 +415,11 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
>  		}
>  	} else if (!master->setup)
>  		return -EINVAL;
> -	if (master->transfer == spi_bitbang_transfer &&
> -			!bitbang->setup_transfer)
> -		return -EINVAL;
> -
> -	/* this task is the only thing to touch the SPI bits */
> -	bitbang->busy = 0;
> -	bitbang->workqueue = create_singlethread_workqueue(
> -			dev_name(master->dev.parent));
> -	if (bitbang->workqueue == NULL) {
> -		status = -EBUSY;
> -		goto err1;
> -	}
>  
>  	/* driver may get busy before register() returns, especially
>  	 * if someone registered boardinfo for devices
>  	 */
> -	status = spi_register_master(master);
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
> @@ -490,10 +430,6 @@ int spi_bitbang_stop(struct spi_bitbang *bitbang)
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
