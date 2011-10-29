From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] OMAP: SPI: call pm_runtime_disable in error path and
 remove
Date: Sat, 29 Oct 2011 14:06:55 +0200
Message-ID: <20111029120655.GE22592@ponder.secretlab.ca>
References: <1319802259-16565-1-git-send-email-shubhrajyoti@ti.com>
 <1319802259-16565-3-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	"Hebbar, Gururaja" <gururaja.hebbar@ti.com>,
	linux-kernel@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1319802259-16565-3-git-send-email-shubhrajyoti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 28, 2011 at 05:14:18PM +0530, Shubhrajyoti D wrote:
> omap mcspi probe() doesnt call pm_runtime  disable functions
> in case of failure. remove() doesnt call pm_runtime disable. This could
> lead to warnings as below on subsequent insmod.
> 
> ~# insmod spi-omap2-mcspi.ko
> [  255.383671] omap2_mcspi omap2_mcspi.1: Unbalanced pm_runtime_enable!
> ...
> 
> This patch adds the pm_runtime disable() at appropriate stages.
> 
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Nitpick: please use the format "spi/<device>: ...." for the subject
line of spi patches.  It's just a consistency thing that I like.

Picked up for v3.3, thanks.

g.

> ---
>  drivers/spi/spi-omap2-mcspi.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 471b0f3..6875a0b 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -1195,6 +1195,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
>  err4:
>  	spi_master_put(master);
>  err3:
> +	pm_runtime_disable(&pdev->dev);
>  	kfree(mcspi->dma_channels);
>  err2:
>  	release_mem_region(r->start, resource_size(r));
> @@ -1216,6 +1217,7 @@ static int __exit omap2_mcspi_remove(struct platform_device *pdev)
>  	dma_channels = mcspi->dma_channels;
>  
>  	omap2_mcspi_disable_clocks(mcspi);
> +	pm_runtime_disable(&pdev->dev);
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(r->start, resource_size(r));
>  
> -- 
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> The demand for IT networking professionals continues to grow, and the
> demand for specialized networking skills is growing even more rapidly.
> Take a complimentary Learning@Cisco Self-Assessment and learn 
> about Cisco certifications, training, and career opportunities. 
> http://p.sf.net/sfu/cisco-dev2dev
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
