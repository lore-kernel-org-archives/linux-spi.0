From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH] spi/pl022: Add high priority message pump support
Date: Wed, 25 Jan 2012 09:06:10 +0530
Message-ID: <4F1F78AA.4050404@st.com>
References: <1327439672-638-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Christopher BLAIR <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Linus WALLEIJ <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1327439672-638-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 1/25/2012 2:44 AM, Linus WALLEIJ wrote:
> From: Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> 
> This switches the PL022 worker to a kthread in order to get
> hold of a mechanism to control the message pump priority. On
> low-latency systems elevating the message kthread to realtime
> priority give a real sleek response curve. This has been
> confirmed by measurements. Realtime priority elevation for
> a certain PL022 port can be requested from platform data.
> 
> Signed-off-by: Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/spi/spi-pl022.c    |   77 +++++++++++++++++++++++++++++--------------
>  include/linux/amba/pl022.h |    3 ++
>  2 files changed, 55 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 2f9cb43..81847c9 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -29,7 +29,7 @@
>  #include <linux/errno.h>
>  #include <linux/interrupt.h>
>  #include <linux/spi/spi.h>
> -#include <linux/workqueue.h>
> +#include <linux/kthread.h>
>  #include <linux/delay.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> @@ -41,6 +41,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/scatterlist.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/sched.h>
>  
>  /*
>   * This macro is used to define some register default values.
> @@ -330,12 +331,13 @@ struct vendor_data {
>   * @clk: outgoing clock "SPICLK" for the SPI bus
>   * @master: SPI framework hookup
>   * @master_info: controller-specific data from machine setup
> - * @workqueue: a workqueue on which any spi_message request is queued
> - * @pump_messages: work struct for scheduling work to the workqueue
> + * @kworker: thread struct for message pump
> + * @kworker_task: pointer to task for message pump kworker thread
> + * @pump_messages: work struct for scheduling work to the message pump
>   * @queue_lock: spinlock to syncronise access to message queue
>   * @queue: message queue
> - * @busy: workqueue is busy
> - * @running: workqueue is running
> + * @busy: message pump is busy
> + * @running: message pump is running
>   * @pump_transfers: Tasklet used in Interrupt Transfer mode
>   * @cur_msg: Pointer to current spi_message being processed
>   * @cur_transfer: Pointer to current spi_transfer
> @@ -365,9 +367,10 @@ struct pl022 {
>  	struct clk			*clk;
>  	struct spi_master		*master;
>  	struct pl022_ssp_controller	*master_info;
> -	/* Driver message queue */
> -	struct workqueue_struct		*workqueue;
> -	struct work_struct		pump_messages;
> +	/* Driver message pump */
> +	struct kthread_worker		kworker;
> +	struct task_struct		*kworker_task;
> +	struct kthread_work		pump_messages;
>  	spinlock_t			queue_lock;
>  	struct list_head		queue;
>  	bool				busy;
> @@ -504,7 +507,7 @@ static void giveback(struct pl022 *pl022)
>  	pl022->cur_msg = NULL;
>  	pl022->cur_transfer = NULL;
>  	pl022->cur_chip = NULL;
> -	queue_work(pl022->workqueue, &pl022->pump_messages);
> +	queue_kthread_work(&pl022->kworker, &pl022->pump_messages);
>  	spin_unlock_irqrestore(&pl022->queue_lock, flags);
>  
>  	msg->state = NULL;
> @@ -1494,8 +1497,8 @@ out:
>  }
>  
>  /**
> - * pump_messages - Workqueue function which processes spi message queue
> - * @data: pointer to private data of SSP driver
> + * pump_messages - kthread work function which processes spi message queue
> + * @work: pointer to kthread work struct contained in the pl022 private struct
>   *
>   * This function checks if there is any spi message in the queue that
>   * needs processing and delegate control to appropriate function
> @@ -1503,7 +1506,7 @@ out:
>   * based on the kind of the transfer
>   *
>   */
> -static void pump_messages(struct work_struct *work)
> +static void pump_messages(struct kthread_work *work)
>  {
>  	struct pl022 *pl022 =
>  		container_of(work, struct pl022, pump_messages);
> @@ -1556,7 +1559,7 @@ static void pump_messages(struct work_struct *work)
>  	if (!was_busy)
>  		/*
>  		 * We enable the core voltage and clocks here, then the clocks
> -		 * and core will be disabled when this workqueue is run again
> +		 * and core will be disabled when this thread is run again
>  		 * and there is no more work to be done.
>  		 */
>  		pm_runtime_get_sync(&pl022->adev->dev);
> @@ -1572,6 +1575,8 @@ static void pump_messages(struct work_struct *work)
>  
>  static int __init init_queue(struct pl022 *pl022)
>  {
> +	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
> +
>  	INIT_LIST_HEAD(&pl022->queue);
>  	spin_lock_init(&pl022->queue_lock);
>  
> @@ -1581,11 +1586,29 @@ static int __init init_queue(struct pl022 *pl022)
>  	tasklet_init(&pl022->pump_transfers, pump_transfers,
>  			(unsigned long)pl022);
>  
> -	INIT_WORK(&pl022->pump_messages, pump_messages);
> -	pl022->workqueue = create_singlethread_workqueue(
> +	init_kthread_worker(&pl022->kworker);
> +	pl022->kworker_task = kthread_run(kthread_worker_fn,
> +					&pl022->kworker,
>  					dev_name(pl022->master->dev.parent));
> -	if (pl022->workqueue == NULL)
> -		return -EBUSY;
> +	if (IS_ERR(pl022->kworker_task)) {
> +		dev_err(&pl022->adev->dev,
> +			"failed to create message pump task\n");
> +		return -ENOMEM;
> +	}
> +	init_kthread_work(&pl022->pump_messages, pump_messages);
> +
> +	/*
> +	 * Board config will indicate if this controller should run the
> +	 * message pump with high (realtime) priority to reduce the transfer
> +	 * latency on the bus by minimising the delay between a transfer
> +	 * request and the scheduling of the message pump thread. Without this
> +	 * setting the message pump thread will remain at default priority.
> +	 */
> +	if (pl022->master_info->rt) {
> +		dev_info(&pl022->adev->dev,
> +			"will run message pump with realtime priority\n");
> +		sched_setscheduler(pl022->kworker_task, SCHED_FIFO, &param);
> +	}
>  
>  	return 0;
>  }
> @@ -1608,7 +1631,7 @@ static int start_queue(struct pl022 *pl022)
>  	pl022->next_msg_cs_active = false;
>  	spin_unlock_irqrestore(&pl022->queue_lock, flags);
>  
> -	queue_work(pl022->workqueue, &pl022->pump_messages);
> +	queue_kthread_work(&pl022->kworker, &pl022->pump_messages);
>  
>  	return 0;
>  }
> @@ -1646,16 +1669,20 @@ static int destroy_queue(struct pl022 *pl022)
>  	int status;
>  
>  	status = stop_queue(pl022);
> -	/* we are unloading the module or failing to load (only two calls
> +
> +	/*
> +	 * We are unloading the module or failing to load (only two calls
>  	 * to this routine), and neither call can handle a return value.
> -	 * However, destroy_workqueue calls flush_workqueue, and that will
> -	 * block until all work is done.  If the reason that stop_queue
> -	 * timed out is that the work will never finish, then it does no
> -	 * good to call destroy_workqueue, so return anyway. */
> +	 * However, flush_kthread_worker will block until all work is done.
> +	 * If the reason that stop_queue timed out is that the work will never
> +	 * finish, then it does no good to call flush/stop thread, so
> +	 * return anyway.
> +	 */
>  	if (status != 0)
>  		return status;
>  
> -	destroy_workqueue(pl022->workqueue);
> +	flush_kthread_worker(&pl022->kworker);
> +	kthread_stop(pl022->kworker_task);
>  
>  	return 0;
>  }
> @@ -1802,7 +1829,7 @@ static int pl022_transfer(struct spi_device *spi, struct spi_message *msg)
>  
>  	list_add_tail(&msg->queue, &pl022->queue);
>  	if (pl022->running && !pl022->busy)
> -		queue_work(pl022->workqueue, &pl022->pump_messages);
> +		queue_kthread_work(&pl022->kworker, &pl022->pump_messages);
>  
>  	spin_unlock_irqrestore(&pl022->queue_lock, flags);
>  	return 0;
> diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
> index 572f637..3672f40 100644
> --- a/include/linux/amba/pl022.h
> +++ b/include/linux/amba/pl022.h
> @@ -241,6 +241,8 @@ struct dma_chan;
>   * @autosuspend_delay: delay in ms following transfer completion before the
>   *     runtime power management system suspends the device. A setting of 0
>   *     indicates no delay and the device will be suspended immediately.
> + * @rt: indicates the controller should run the message pump with realtime
> + *     priority to minimise the transfer latency on the bus.
>   */
>  struct pl022_ssp_controller {
>  	u16 bus_id;
> @@ -250,6 +252,7 @@ struct pl022_ssp_controller {
>  	void *dma_rx_param;
>  	void *dma_tx_param;
>  	int autosuspend_delay;
> +	bool rt;
>  };
>  
>  /**

Looks fine.

Acked-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>

-- 
viresh

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
