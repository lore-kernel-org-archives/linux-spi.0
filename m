From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] SPI: spi_sh_msiof: implement DMA support
Date: Mon, 5 Sep 2011 09:26:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1109050925170.13066@axis700.grange>
References: <Pine.LNX.4.64.1109021706480.4731@axis700.grange>
 <Pine.LNX.4.64.1109021712180.4731@axis700.grange> <20110905045911.GE22142@linux-sh.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: spi-devel-general@lists.sourceforge.net, linux-sh@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>
To: Paul Mundt <lethal@linux-sh.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110905045911.GE22142@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Paul

On Mon, 5 Sep 2011, Paul Mundt wrote:

> On Fri, Sep 02, 2011 at 05:13:31PM +0200, Guennadi Liakhovetski wrote:
> > Use the sh_dma dmaengine driver to support DMA on MSIOF.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> No real opinion one way or the other, just a couple observations.
> 
> > +static void sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
> > +{
> ..
> > +	p->dummypage = alloc_page(GFP_KERNEL);
> > +	if (!p->dummypage)
> > +		return;
> > +
> ..
> > +echantx:
> > +	__free_pages(p->dummypage, 0);
> > +}
> > +
> alloc_page() can be balanced out with __free_page().

Hm, indeed, wondering, how I missed it.

> > @@ -695,11 +1030,11 @@ static int sh_msiof_spi_remove(struct platform_device *pdev)
> >  
> >  	ret = spi_bitbang_stop(&p->bitbang);
> >  	if (!ret) {
> > +		sh_msiof_release_dma(p);
> >  		pm_runtime_disable(&pdev->dev);
> >  		free_irq(platform_get_irq(pdev, 0), p);
> >  		iounmap(p->mapbase);
> >  		clk_put(p->clk);
> > -		spi_master_put(p->bitbang.master);
> >  	}
> >  	return ret;
> >  }
> 
> You've also killed off the spi_master_put() here.

Yes, spi_bitbang_stop() does it all already.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
