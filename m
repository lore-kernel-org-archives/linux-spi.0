From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: dw: use managed resources
Date: Mon, 30 Dec 2013 16:48:38 +0200
Message-ID: <20131230144838.GD4361@tarshish>
References: <cover.1388040447.git.baruch@tkos.co.il>
 <406b0c452cfa4e58b8d4c565beb861da30ebead7.1388040447.git.baruch@tkos.co.il>
 <20131230132420.GZ31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131230132420.GZ31886-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Mon, Dec 30, 2013 at 01:24:20PM +0000, Mark Brown wrote:
> On Thu, Dec 26, 2013 at 09:00:12AM +0200, Baruch Siach wrote:
> > This commit doesn't migrate the PCI specific code to managed resources, 
> > because I can't test that code.
> 
> Given that this is a simple mechanical transition I don't see that as a
> big concern...  I'd be more worried about bugs being introduced due to
> the order in which things get unwound than I would about errors from a
> conversion to devm unless the unwinding code is already complex.

OK. Will do.

> > -	dws->regs = ioremap_nocache(mem->start, resource_size(mem));
> > +	dws->regs = devm_ioremap_nocache(&pdev->dev, mem->start,
> > +			resource_size(mem));
> 
> You can just use devm_ioremap_resource() - it will check if the resource
> is cacheable and map it nocache otherwise.

Will do.

> > -int dw_spi_add_host(struct dw_spi *dws)
> > +int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
> 
> >  	master = spi_alloc_master(dws->parent_dev, 0);
> > -	if (!master) {
> 
> Why is the device we're passing in ever going to be different to
> dws->parent_dev, or alternatively can we just remove dws->parent_dev
> instead and keep the signature change?

I'm not sure I follow. What's exactly the alternative to dws->parent_dev?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
