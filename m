From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: dw: fix memory leak on error path
Date: Mon, 30 Dec 2013 15:24:52 +0200
Message-ID: <20131230132452.GC4361@tarshish>
References: <cover.1388040447.git.baruch@tkos.co.il>
 <4ed40da8c93766ac05ee8d3507ae1d9fdc0a68a7.1388040447.git.baruch@tkos.co.il>
 <20131230130814.GY31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131230130814.GY31886-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Mon, Dec 30, 2013 at 01:08:14PM +0000, Mark Brown wrote:
> On Thu, Dec 26, 2013 at 09:00:14AM +0200, Baruch Siach wrote:
> > @@ -669,6 +671,11 @@ static int dw_spi_setup(struct spi_device *spi)
> >  
> >  	spi_set_ctldata(spi, chip);
> >  	return 0;
> > +
> > +err_kfree:
> > +	kfree(chip);
> > +
> > +	return ret;
> >  }
> 
> A better fix would be to convert to devm_kzalloc() so there is no
> possibility of paths that don't free (and move the ctldata set earlier
> so we don't forget about it on creation).

Good idea. Will do.

> Indeed this patch will introduce a bug - on the second call to this
> function if we hit an error then the struct will be freed but ctldata
> won't be cleared.  This will mean that if there is a further call then
> ctldata will still point at the old struct and the function will try to
> use it rather than allocating a new one.

Thanks for reviewing.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
