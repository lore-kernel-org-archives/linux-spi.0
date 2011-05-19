From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] spi: spi_tegra: calling spi_unregister_master
 instead of spi_master_put in spi_tegra_remove
Date: Thu, 19 May 2011 13:02:23 -0600
Message-ID: <20110519190223.GH5109@ponder.secretlab.ca>
References: <1305120420.6324.6.camel@phoenix>
 <1305120496.6324.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, Erik Gilling <konkers@android.com>,
	spi-devel-general@lists.sourceforge.net
To: Axel Lin <axel.lin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1305120496.6324.8.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 11, 2011 at 09:28:16PM +0800, Axel Lin wrote:
> spi_master_put() should only be used in error handling.
> Once spi_register_master() returns success, we should call
> spi_unregister_master() instead.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.

g.

> ---
>  drivers/spi/spi_tegra.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi_tegra.c b/drivers/spi/spi_tegra.c
> index 891e590..6c3aa6e 100644
> --- a/drivers/spi/spi_tegra.c
> +++ b/drivers/spi/spi_tegra.c
> @@ -578,6 +578,7 @@ static int __devexit spi_tegra_remove(struct platform_device *pdev)
>  	master = dev_get_drvdata(&pdev->dev);
>  	tspi = spi_master_get_devdata(master);
>  
> +	spi_unregister_master(master);
>  	tegra_dma_free_channel(tspi->rx_dma);
>  
>  	dma_free_coherent(&pdev->dev, sizeof(u32) * BB_LEN,
> @@ -586,7 +587,6 @@ static int __devexit spi_tegra_remove(struct platform_device *pdev)
>  	clk_put(tspi->clk);
>  	iounmap(tspi->base);
>  
> -	spi_master_put(master);
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(r->start, (r->end - r->start) + 1);
>  
> -- 
> 1.7.1
> 
> 
> 
