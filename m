From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] SPI: spi_sh_msiof: fix a wrong free_irq() parameter
Date: Mon, 17 Jan 2011 10:26:33 -0700
Message-ID: <20110117172633.GA29462@angua.secretlab.ca>
References: <Pine.LNX.4.64.1101171700370.16051@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net, linux-sh@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1101171700370.16051@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 17, 2011 at 05:01:07PM +0100, Guennadi Liakhovetski wrote:
> Without this fix reloading of the driver is impossible.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.

g.

> ---
>  drivers/spi/spi_sh_msiof.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi_sh_msiof.c b/drivers/spi/spi_sh_msiof.c
> index d93b667..56f60c8 100644
> --- a/drivers/spi/spi_sh_msiof.c
> +++ b/drivers/spi/spi_sh_msiof.c
> @@ -635,7 +635,7 @@ static int sh_msiof_spi_remove(struct platform_device *pdev)
>  	ret = spi_bitbang_stop(&p->bitbang);
>  	if (!ret) {
>  		pm_runtime_disable(&pdev->dev);
> -		free_irq(platform_get_irq(pdev, 0), sh_msiof_spi_irq);
> +		free_irq(platform_get_irq(pdev, 0), p);
>  		iounmap(p->mapbase);
>  		clk_put(p->clk);
>  		spi_master_put(p->bitbang.master);
> -- 
> 1.7.2.3
> 
> 
> ------------------------------------------------------------------------------
> Protect Your Site and Customers from Malware Attacks
> Learn about various malware tactics and how to avoid them. Understand 
> malware threats, the impact they can have on your business, and how you 
> can protect your company and customers by using code signing.
> http://p.sf.net/sfu/oracle-sfdevnl
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
