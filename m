From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: dw: use managed resources
Date: Mon, 30 Dec 2013 18:36:18 +0200
Message-ID: <20131230163618.GE4361@tarshish>
References: <cover.1388040447.git.baruch@tkos.co.il>
 <406b0c452cfa4e58b8d4c565beb861da30ebead7.1388040447.git.baruch@tkos.co.il>
 <20131230132420.GZ31886@sirena.org.uk>
 <20131230144838.GD4361@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131230144838.GD4361@tarshish>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Mon, Dec 30, 2013 at 04:48:38PM +0200, Baruch Siach wrote:
> > >  	master = spi_alloc_master(dws->parent_dev, 0);
> > > -	if (!master) {
> > 
> > Why is the device we're passing in ever going to be different to
> > dws->parent_dev, or alternatively can we just remove dws->parent_dev
> > instead and keep the signature change?
> 
> I'm not sure I follow. What's exactly the alternative to dws->parent_dev?

OK. Got it now. Patches are on the way.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
