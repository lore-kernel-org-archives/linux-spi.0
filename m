From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: bitbang: add PM QoS support
Date: Thu, 15 Mar 2012 03:29:23 -0600
Message-ID: <20120315092923.951203E04FD@localhost>
References: <Pine.LNX.4.64.1203141837170.30291@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.1203141837170.30291-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 14 Mar 2012 22:04:25 +0100 (CET), Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> This patch adds a PM QoS requirement to the spi-bitbang driver, preventing
> the underlying SPI hardware driver to suspend for too long a time, as long
> as there are transfers on the queue.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>

Shouldn't this be part of the core spi infrastructure?  Particularly since queuing
is moving into the core.

g.

> ---
> 
> RFC, because a patch set has been developed recently, adding a PM QoS 
> sysfs attribute to all supporting devices per 
> dev_pm_qos_expose_latency_limit(). But I'm not sure, whether and how to 
> combine user-space supplied constraint with driver's own idea of which 
> code paths should be executed with amended latency requirements. Maybe 
> this should be discussed separately, though.
> 
>  drivers/spi/spi-bitbang.c       |    6 ++++++
>  include/linux/spi/spi_bitbang.h |    2 ++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
> index aef59b1..497e725 100644
> --- a/drivers/spi/spi-bitbang.c
> +++ b/drivers/spi/spi-bitbang.c
> @@ -24,6 +24,7 @@
>  #include <linux/delay.h>
>  #include <linux/errno.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_qos.h>
>  #include <linux/slab.h>
>  
>  #include <linux/spi/spi.h>
> @@ -260,6 +261,8 @@ static void bitbang_work(struct work_struct *work)
>  	struct spi_bitbang	*bitbang =
>  		container_of(work, struct spi_bitbang, work);
>  	unsigned long		flags;
> +	int pmrq = dev_pm_qos_add_request(bitbang->master->dev.parent,
> +					  &bitbang->pm_qos, 100);
>  
>  	spin_lock_irqsave(&bitbang->lock, flags);
>  	bitbang->busy = 1;
> @@ -376,6 +379,9 @@ static void bitbang_work(struct work_struct *work)
>  	}
>  	bitbang->busy = 0;
>  	spin_unlock_irqrestore(&bitbang->lock, flags);
> +
> +	if (pmrq >= 0)
> +		dev_pm_qos_remove_request(&bitbang->pm_qos);
>  }
>  
>  /**
> diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
> index f987a2b..bed583f1 100644
> --- a/include/linux/spi/spi_bitbang.h
> +++ b/include/linux/spi/spi_bitbang.h
> @@ -1,6 +1,7 @@
>  #ifndef	__SPI_BITBANG_H
>  #define	__SPI_BITBANG_H
>  
> +#include <linux/pm_qos.h>
>  #include <linux/workqueue.h>
>  
>  struct spi_bitbang {
> @@ -12,6 +13,7 @@ struct spi_bitbang {
>  	u8			busy;
>  	u8			use_dma;
>  	u8			flags;		/* extra spi->mode support */
> +	struct dev_pm_qos_request pm_qos;
>  
>  	struct spi_master	*master;
>  
> -- 
> 1.7.2.5
> 
> 
> ------------------------------------------------------------------------------
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing 
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
