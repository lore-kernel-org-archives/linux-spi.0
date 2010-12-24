From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/4] spi/pl022: convert busy flag to a bool
Date: Thu, 23 Dec 2010 21:07:45 -0700
Message-ID: <20101224040745.GI2491@angua.secretlab.ca>
References: <1293056028-13198-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1293056028-13198-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 22, 2010 at 11:13:48PM +0100, Linus Walleij wrote:
> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Merged for -next, thanks.

g.

> ---
>  drivers/spi/amba-pl022.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 40189c5..91ba23a 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -369,7 +369,7 @@ struct pl022 {
>  	struct work_struct		pump_messages;
>  	spinlock_t			queue_lock;
>  	struct list_head		queue;
> -	int				busy;
> +	bool				busy;
>  	int				run;
>  	/* Message transfer pump */
>  	struct tasklet_struct		pump_transfers;
> @@ -1461,7 +1461,7 @@ static void pump_messages(struct work_struct *work)
>  	/* Lock queue and check for queue work */
>  	spin_lock_irqsave(&pl022->queue_lock, flags);
>  	if (list_empty(&pl022->queue) || pl022->run == QUEUE_STOPPED) {
> -		pl022->busy = 0;
> +		pl022->busy = false;
>  		spin_unlock_irqrestore(&pl022->queue_lock, flags);
>  		return;
>  	}
> @@ -1475,7 +1475,7 @@ static void pump_messages(struct work_struct *work)
>  	    list_entry(pl022->queue.next, struct spi_message, queue);
>  
>  	list_del_init(&pl022->cur_msg->queue);
> -	pl022->busy = 1;
> +	pl022->busy = true;
>  	spin_unlock_irqrestore(&pl022->queue_lock, flags);
>  
>  	/* Initial message state */
> @@ -1508,7 +1508,7 @@ static int __init init_queue(struct pl022 *pl022)
>  	spin_lock_init(&pl022->queue_lock);
>  
>  	pl022->run = QUEUE_STOPPED;
> -	pl022->busy = 0;
> +	pl022->busy = false;
>  
>  	tasklet_init(&pl022->pump_transfers,
>  			pump_transfers,	(unsigned long)pl022);
> -- 
> 1.7.3.3
> 

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
