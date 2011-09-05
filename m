From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/2] SPI: spi_sh_msiof: implement DMA support
Date: Mon, 5 Sep 2011 13:59:11 +0900
Message-ID: <20110905045911.GE22142@linux-sh.org>
References: <Pine.LNX.4.64.1109021706480.4731@axis700.grange> <Pine.LNX.4.64.1109021712180.4731@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net, linux-sh@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1109021712180.4731@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 02, 2011 at 05:13:31PM +0200, Guennadi Liakhovetski wrote:
> Use the sh_dma dmaengine driver to support DMA on MSIOF.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

No real opinion one way or the other, just a couple observations.

> +static void sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
> +{
..
> +	p->dummypage = alloc_page(GFP_KERNEL);
> +	if (!p->dummypage)
> +		return;
> +
..
> +echantx:
> +	__free_pages(p->dummypage, 0);
> +}
> +
alloc_page() can be balanced out with __free_page().

> @@ -695,11 +1030,11 @@ static int sh_msiof_spi_remove(struct platform_device *pdev)
>  
>  	ret = spi_bitbang_stop(&p->bitbang);
>  	if (!ret) {
> +		sh_msiof_release_dma(p);
>  		pm_runtime_disable(&pdev->dev);
>  		free_irq(platform_get_irq(pdev, 0), p);
>  		iounmap(p->mapbase);
>  		clk_put(p->clk);
> -		spi_master_put(p->bitbang.master);
>  	}
>  	return ret;
>  }

You've also killed off the spi_master_put() here.
