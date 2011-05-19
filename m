From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] spi: spi_nuc900: Use spi_bitbang_stop instead of
 spi_unregister_master in nuc900_spi_remove
Date: Thu, 19 May 2011 13:31:32 -0600
Message-ID: <20110519193132.GQ5109@ponder.secretlab.ca>
References: <1305416008.24670.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>,
	spi-devel-general@lists.sourceforge.net
To: Axel Lin <axel.lin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1305416008.24670.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, May 15, 2011 at 07:33:28AM +0800, Axel Lin wrote:
> Calling spi_bitbang_stop() will also destroy bitbang->workqueue,
> which is created by calling spi_bitbang_start() in nuc900_spi_probe().
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.

g.

> ---
>  drivers/spi/spi_nuc900.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi_nuc900.c b/drivers/spi/spi_nuc900.c
> index d5be18b..3cd15f6 100644
> --- a/drivers/spi/spi_nuc900.c
> +++ b/drivers/spi/spi_nuc900.c
> @@ -463,7 +463,7 @@ static int __devexit nuc900_spi_remove(struct platform_device *dev)
>  
>  	platform_set_drvdata(dev, NULL);
>  
> -	spi_unregister_master(hw->master);
> +	spi_bitbang_stop(&hw->bitbang);
>  
>  	clk_disable(hw->clk);
>  	clk_put(hw->clk);
> -- 
> 1.7.1
> 
> 
> 
