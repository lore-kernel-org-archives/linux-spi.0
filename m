From: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Subject: Re: [PATCH] spi: Split bus and I/O locking
Date: Thu, 21 Jul 2016 20:17:45 -0400
Message-ID: <20160722001745.GI15995@brightrain.aerifal.cx>
References: <1469142737-2814-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1469142737-2814-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jul 22, 2016 at 12:12:17AM +0100, Mark Brown wrote:
> The current SPI code attempts to use bus_lock_mutex for two purposes. One
> is to implement spi_bus_lock() which grants exclusive access to the bus.
> The other is to serialize access to the physical hardware. This duplicate
> purpose causes confusion which leads to cases where access is not locked
> when a caller holds the bus lock mutex. Fix this by splitting out the I/O
> functionality into a new io_mutex.
> 
> This means taking both mutexes in the DMA path, replacing the existing
> mutex with the new I/O one in the message pump (the mutex now always
> being taken in the message pump) and taking the bus lock mutex in
> spi_sync(), allowing __spi_sync() to have no mutex handling.
> 
> While we're at it hoist the mutex further up the message pump before we
> power up the device so that all power up/down of the block is covered by
> it and there are no races with in-line pumping of messages.
> 
> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> 
> *Completely* untested, I've not even tried to run this yet - just
> quickly throwing it out for testing.
> 
>  drivers/spi/spi.c       | 38 ++++++++++++++++++--------------------
>  include/linux/spi/spi.h |  6 +++++-
>  2 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index be96fcd072e4..fd32dcf599a8 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1088,7 +1088,6 @@ EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
>   * __spi_pump_messages - function which processes spi message queue
>   * @master: master to process queue for
>   * @in_kthread: true if we are in the context of the message pump thread
> - * @bus_locked: true if the bus mutex is held when calling this function
>   *
>   * This function checks if there is any spi message in the queue that
>   * needs processing and if so call out to the driver to initialize hardware
> @@ -1098,8 +1097,7 @@ EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
>   * inside spi_sync(); the queue extraction handling at the top of the
>   * function should deal with this safely.
>   */
> -static void __spi_pump_messages(struct spi_master *master, bool in_kthread,
> -				bool bus_locked)
> +static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
>  {
>  	unsigned long flags;
>  	bool was_busy = false;
> @@ -1171,6 +1169,8 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread,
>  		master->busy = true;
>  	spin_unlock_irqrestore(&master->queue_lock, flags);
>  
> +	mutex_lock(&master->io_mutex);
> +
>  	if (!was_busy && master->auto_runtime_pm) {
>  		ret = pm_runtime_get_sync(master->dev.parent);
>  		if (ret < 0) {
> @@ -1195,9 +1195,6 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread,
>  		}
>  	}
>  
> -	if (!bus_locked)
> -		mutex_lock(&master->bus_lock_mutex);
> -
>  	trace_spi_message_start(master->cur_msg);
>  
>  	if (master->prepare_message) {
> @@ -1227,8 +1224,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread,
>  	}
>  
>  out:
> -	if (!bus_locked)
> -		mutex_unlock(&master->bus_lock_mutex);
> +	mutex_unlock(&master->io_mutex);
>  
>  	/* Prod the scheduler in case transfer_one() was busy waiting */
>  	if (!ret)
> @@ -1244,7 +1240,7 @@ static void spi_pump_messages(struct kthread_work *work)
>  	struct spi_master *master =
>  		container_of(work, struct spi_master, pump_messages);
>  
> -	__spi_pump_messages(master, true, master->bus_lock_flag);
> +	__spi_pump_messages(master, true);
>  }
>  
>  static int spi_init_queue(struct spi_master *master)
> @@ -1917,6 +1913,7 @@ int spi_register_master(struct spi_master *master)
>  	spin_lock_init(&master->queue_lock);
>  	spin_lock_init(&master->bus_lock_spinlock);
>  	mutex_init(&master->bus_lock_mutex);
> +	mutex_init(&master->io_mutex);
>  	master->bus_lock_flag = 0;
>  	init_completion(&master->xfer_completion);
>  	if (!master->max_dma_len)
> @@ -2800,6 +2797,7 @@ int spi_flash_read(struct spi_device *spi,
>  	}
>  
>  	mutex_lock(&master->bus_lock_mutex);
> +	mutex_lock(&master->io_mutex);
>  	if (master->dma_rx) {
>  		rx_dev = master->dma_rx->device->dev;
>  		ret = spi_map_buf(master, rx_dev, &msg->rx_sg,
> @@ -2812,6 +2810,7 @@ int spi_flash_read(struct spi_device *spi,
>  	if (msg->cur_msg_mapped)
>  		spi_unmap_buf(master, rx_dev, &msg->rx_sg,
>  			      DMA_FROM_DEVICE);
> +	mutex_unlock(&master->io_mutex);
>  	mutex_unlock(&master->bus_lock_mutex);
>  
>  	if (master->auto_runtime_pm)

This chunk does not apply cleanly to upstream kernel; I assume it
depends on other changes in your development branch. After
compensating for that, it seems to be working correctly.

Aside from the point that it works, I like this patch a lot because it
clarifies what's going on with the code and what the locks are used
for. It took a lot of effort to even start to make sense of what was
wrong with the old locking, whereas now it's pretty self-explanatory.

Rich
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
