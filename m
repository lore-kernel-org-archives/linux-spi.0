From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [Patch v2 1/3] spi/dw_spi: Fix too short timeout in spi
	polling loop
Date: Fri, 24 Dec 2010 01:10:47 -0700
Message-ID: <20101224081047.GA5544@angua.secretlab.ca>
References: <1293170351-7426-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1293170351-7426-1-git-send-email-feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Dec 24, 2010 at 01:59:09PM +0800, Feng Tang wrote:
> The SPI polling loop timeout only works with HZ=100 as the loop was
> actually too short.
> 
> Also add appropriate cpu_relax() in the busy wait loops...
> 
> Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Signed-off-by: Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Where is your s-o-b line?  :-)

Applied for -next, thanks.

g.

> ---
>  drivers/spi/dw_spi.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
> index 0838c79..25238a8 100644
> --- a/drivers/spi/dw_spi.c
> +++ b/drivers/spi/dw_spi.c
> @@ -164,20 +164,23 @@ static inline void mrst_spi_debugfs_remove(struct dw_spi *dws)
>  
>  static void wait_till_not_busy(struct dw_spi *dws)
>  {
> -	unsigned long end = jiffies + 1 + usecs_to_jiffies(1000);
> +	unsigned long end = jiffies + 1 + usecs_to_jiffies(5000);
>  
>  	while (time_before(jiffies, end)) {
>  		if (!(dw_readw(dws, sr) & SR_BUSY))
>  			return;
> +		cpu_relax();
>  	}
>  	dev_err(&dws->master->dev,
> -		"DW SPI: Status keeps busy for 1000us after a read/write!\n");
> +		"DW SPI: Status keeps busy for 5000us after a read/write!\n");
>  }
>  
>  static void flush(struct dw_spi *dws)
>  {
> -	while (dw_readw(dws, sr) & SR_RF_NOT_EMPT)
> +	while (dw_readw(dws, sr) & SR_RF_NOT_EMPT) {
>  		dw_readw(dws, dr);
> +		cpu_relax();
> +	}
>  
>  	wait_till_not_busy(dws);
>  }
> -- 
> 1.7.0.4
> 

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
