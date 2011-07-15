From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3] pxa2xx_spi: fix memory corruption
Date: Thu, 14 Jul 2011 20:53:31 -0600
Message-ID: <20110715025331.GL2927@ponder.secretlab.ca>
References: <201107101609.31405.anarsoul@gmail.com>
	<1310311099-24638-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1310311099-24638-1-git-send-email-anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jul 10, 2011 at 06:18:19PM +0300, Vasily Khoruzhick wrote:
> pxa2xx_spi_probe allocates struct driver_data and null_dma_buf
> at same time via spi_alloc_master(), but then calculates
> null_dma_buf pointer incorrectly, and it causes memory corruption
> later if DMA usage is enabled.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> v2: - add u8 __null_dma_buf[16] to the end of driver_data structure
>     and use it as null_dma_buf after alignment.
>     - use PTR_ALIGN instead of ALIGN
> v3: - drop (u8 *) cast, use & operator instead, change array name
>  drivers/spi/pxa2xx_spi.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> index dc25bee..b25fe27 100644
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -106,6 +106,7 @@ struct driver_data {
>  	int rx_channel;
>  	int tx_channel;
>  	u32 *null_dma_buf;
> +	u8 null_dma_buf_unaligned[16];

Don't dma buffers need to be cache-line aligned?  How large is the
actual transfer?  Using the __aligned() or __cacheline_aligned
attribute is the correct way to make sure you've got a data buffer
that can be used for DMA mixed with other stuff.  Then you don't need
to fool around with PTR_ALIGN or anything.

g.

>  
>  	/* SSP register addresses */
>  	void __iomem *ioaddr;
> @@ -1543,8 +1544,8 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	/* Allocate master with space for drv_data and null dma buffer */
> -	master = spi_alloc_master(dev, sizeof(struct driver_data) + 16);
> +	/* Allocate master with space for drv_data */
> +	master = spi_alloc_master(dev, sizeof(struct driver_data));
>  	if (!master) {
>  		dev_err(&pdev->dev, "cannot alloc spi_master\n");
>  		pxa_ssp_free(ssp);
> @@ -1569,8 +1570,8 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
>  	master->transfer = transfer;
>  
>  	drv_data->ssp_type = ssp->type;
> -	drv_data->null_dma_buf = (u32 *)ALIGN((u32)(drv_data +
> -						sizeof(struct driver_data)), 8);
> +	drv_data->null_dma_buf =
> +		(u32 *)PTR_ALIGN(&drv_data->null_dma_buf_unaligned, 8);
>  
>  	drv_data->ioaddr = ssp->mmio_base;
>  	drv_data->ssdr_physical = ssp->phys_base + SSDR;
> -- 
> 1.7.5.rc3
> 

------------------------------------------------------------------------------
AppSumo Presents a FREE Video for the SourceForge Community by Eric 
Ries, the creator of the Lean Startup Methodology on "Lean Startup 
Secrets Revealed." This video shows you how to validate your ideas, 
optimize your ideas and identify your business strategy.
http://p.sf.net/sfu/appsumosfdev2dev
