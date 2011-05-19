From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] spi: spi_sh: calling spi_unregister_master instead
 of spi_master_put in spi_sh_remove
Date: Thu, 19 May 2011 13:01:38 -0600
Message-ID: <20110519190138.GG5109@ponder.secretlab.ca>
References: <1305120420.6324.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	spi-devel-general@lists.sourceforge.net
To: Axel Lin <axel.lin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1305120420.6324.6.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 11, 2011 at 09:27:00PM +0800, Axel Lin wrote:
> spi_master_put() should only be used in error handling.
> Once spi_register_master() returns success, we should call
> spi_unregister_master() instead.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.

g.

> ---
>  drivers/spi/spi_sh.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi_sh.c b/drivers/spi/spi_sh.c
> index 869a07d..9eedd71 100644
> --- a/drivers/spi/spi_sh.c
> +++ b/drivers/spi/spi_sh.c
> @@ -427,10 +427,10 @@ static int __devexit spi_sh_remove(struct platform_device *pdev)
>  {
>  	struct spi_sh_data *ss = dev_get_drvdata(&pdev->dev);
>  
> +	spi_unregister_master(ss->master);
>  	destroy_workqueue(ss->workqueue);
>  	free_irq(ss->irq, ss);
>  	iounmap(ss->addr);
> -	spi_master_put(ss->master);
>  
>  	return 0;
>  }
> -- 
> 1.7.1
> 
> 
> 
