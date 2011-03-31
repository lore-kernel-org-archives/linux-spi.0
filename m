From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 2/4] spi/dw_spi: remove the un-necessary flush()
Date: Wed, 30 Mar 2011 21:32:34 -0600
Message-ID: <20110331033234.GD19333@ponder.secretlab.ca>
References: <1301497795-6924-1-git-send-email-feng.tang@intel.com>
	<1301497795-6924-3-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1301497795-6924-3-git-send-email-feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Mar 30, 2011 at 11:09:53PM +0800, Feng Tang wrote:
> From: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> The flush() is used to drain all the left data in rx fifo, currently
> is is always called together with disabling hw. But from spec, disabling
> hw will also reset all the fifo, so flush() is not needed.
> 
> Signed-off-by: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/dw_spi.c |   15 +--------------
>  1 files changed, 1 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
> index c4fca3d..d3aaf8d 100644
> --- a/drivers/spi/dw_spi.c
> +++ b/drivers/spi/dw_spi.c
> @@ -173,17 +173,6 @@ static void wait_till_not_busy(struct dw_spi *dws)
>  		"DW SPI: Status keeps busy for 5000us after a read/write!\n");
>  }
>  
> -static void flush(struct dw_spi *dws)
> -{
> -	while (dw_readw(dws, sr) & SR_RF_NOT_EMPT) {
> -		dw_readw(dws, dr);
> -		cpu_relax();
> -	}
> -
> -	wait_till_not_busy(dws);
> -}
> -
> -
>  static int dw_writer(struct dw_spi *dws)
>  {
>  	u16 txw = 0;
> @@ -297,8 +286,7 @@ static void giveback(struct dw_spi *dws)
>  
>  static void int_error_stop(struct dw_spi *dws, const char *msg)
>  {
> -	/* Stop and reset hw */
> -	flush(dws);
> +	/* Stop the hw */
>  	spi_enable_chip(dws, 0);
>  
>  	dev_err(&dws->master->dev, "%s\n", msg);
> @@ -800,7 +788,6 @@ static void spi_hw_init(struct dw_spi *dws)
>  	spi_enable_chip(dws, 0);
>  	spi_mask_intr(dws, 0xff);
>  	spi_enable_chip(dws, 1);
> -	flush(dws);
>  
>  	/*
>  	 * Try to detect the FIFO depth if not set by interface driver,
> -- 
> 1.7.0.4
> 

------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf
