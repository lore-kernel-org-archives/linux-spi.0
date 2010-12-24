From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 4/4] spi/pl022: convert running variable
Date: Thu, 23 Dec 2010 21:07:56 -0700
Message-ID: <20101224040756.GJ2491@angua.secretlab.ca>
References: <1293056039-13465-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1293056039-13465-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 22, 2010 at 11:13:59PM +0100, Linus Walleij wrote:
> This variable is a bool but defined an int and defined completely
> backwards. This makes the code more readable.
> 
> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Merged for -next, thanks.

g.

> ---
>  drivers/spi/amba-pl022.c |   24 ++++++++++--------------
>  1 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 91ba23a..546e714 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -253,11 +253,6 @@
>  #define STATE_ERROR			((void *) -1)
>  
>  /*
> - * Queue State
> - */
> -#define QUEUE_RUNNING			(0)
> -#define QUEUE_STOPPED			(1)
> -/*
>   * SSP State - Whether Enabled or Disabled
>   */
>  #define SSP_DISABLED			(0)
> @@ -344,7 +339,7 @@ struct vendor_data {
>   * @lock: spinlock to syncronise access to driver data
>   * @workqueue: a workqueue on which any spi_message request is queued
>   * @busy: workqueue is busy
> - * @run: workqueue is running
> + * @running: workqueue is running
>   * @pump_transfers: Tasklet used in Interrupt Transfer mode
>   * @cur_msg: Pointer to current spi_message being processed
>   * @cur_transfer: Pointer to current spi_transfer
> @@ -370,7 +365,7 @@ struct pl022 {
>  	spinlock_t			queue_lock;
>  	struct list_head		queue;
>  	bool				busy;
> -	int				run;
> +	bool				running;
>  	/* Message transfer pump */
>  	struct tasklet_struct		pump_transfers;
>  	struct spi_message		*cur_msg;
> @@ -1460,7 +1455,7 @@ static void pump_messages(struct work_struct *work)
>  
>  	/* Lock queue and check for queue work */
>  	spin_lock_irqsave(&pl022->queue_lock, flags);
> -	if (list_empty(&pl022->queue) || pl022->run == QUEUE_STOPPED) {
> +	if (list_empty(&pl022->queue) || !pl022->running) {
>  		pl022->busy = false;
>  		spin_unlock_irqrestore(&pl022->queue_lock, flags);
>  		return;
> @@ -1507,7 +1502,7 @@ static int __init init_queue(struct pl022 *pl022)
>  	INIT_LIST_HEAD(&pl022->queue);
>  	spin_lock_init(&pl022->queue_lock);
>  
> -	pl022->run = QUEUE_STOPPED;
> +	pl022->running = false;
>  	pl022->busy = false;
>  
>  	tasklet_init(&pl022->pump_transfers,
> @@ -1529,12 +1524,12 @@ static int start_queue(struct pl022 *pl022)
>  
>  	spin_lock_irqsave(&pl022->queue_lock, flags);
>  
> -	if (pl022->run == QUEUE_RUNNING || pl022->busy) {
> +	if (pl022->running || pl022->busy) {
>  		spin_unlock_irqrestore(&pl022->queue_lock, flags);
>  		return -EBUSY;
>  	}
>  
> -	pl022->run = QUEUE_RUNNING;
> +	pl022->running = true;
>  	pl022->cur_msg = NULL;
>  	pl022->cur_transfer = NULL;
>  	pl022->cur_chip = NULL;
> @@ -1566,7 +1561,8 @@ static int stop_queue(struct pl022 *pl022)
>  
>  	if (!list_empty(&pl022->queue) || pl022->busy)
>  		status = -EBUSY;
> -	else pl022->run = QUEUE_STOPPED;
> +	else
> +		pl022->running = false;
>  
>  	spin_unlock_irqrestore(&pl022->queue_lock, flags);
>  
> @@ -1684,7 +1680,7 @@ static int pl022_transfer(struct spi_device *spi, struct spi_message *msg)
>  
>  	spin_lock_irqsave(&pl022->queue_lock, flags);
>  
> -	if (pl022->run == QUEUE_STOPPED) {
> +	if (!pl022->running) {
>  		spin_unlock_irqrestore(&pl022->queue_lock, flags);
>  		return -ESHUTDOWN;
>  	}
> @@ -1693,7 +1689,7 @@ static int pl022_transfer(struct spi_device *spi, struct spi_message *msg)
>  	msg->state = STATE_START;
>  
>  	list_add_tail(&msg->queue, &pl022->queue);
> -	if (pl022->run == QUEUE_RUNNING && !pl022->busy)
> +	if (pl022->running && !pl022->busy)
>  		queue_work(pl022->workqueue, &pl022->pump_messages);
>  
>  	spin_unlock_irqrestore(&pl022->queue_lock, flags);
> -- 
> 1.7.3.3
> 

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
