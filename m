From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH 2/3] Doc: spi: document the transfer_one spi_master
 callback
Date: Sat, 25 Jan 2014 20:52:15 +0200
Message-ID: <20140125185215.GB5596@tarshish>
References: <cover.1390544495.git.baruch@tkos.co.il>
 <8b6ee8b5a08cd9fa9a94d16d2621e28b4f087098.1390544495.git.baruch@tkos.co.il>
 <20140124134517.GY20094@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140124134517.GY20094-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Gerhard,

On Fri, Jan 24, 2014 at 02:45:17PM +0100, Gerhard Sittig wrote:
> On Fri, Jan 24, 2014 at 08:28 +0200, Baruch Siach wrote:
> > 
> > --- a/Documentation/spi/spi-summary
> > +++ b/Documentation/spi/spi-summary
> > @@ -545,6 +545,16 @@ SPI MASTER METHODS
> >  	spi_finalize_current_message() so the subsystem can issue the next
> >  	transfer. This may sleep.
> >  
> > +    master->transfer_one(struct spi_master *master, struct spi_device *spi,
> > +			 struct spi_transfer *transfer)
> > +	The subsystem calls the driver to transfer a single transfer while
> > +	queuing transfers that arrive in the meantime. When the driver is
> > +	finished with this message, it must call
>                            ^^^^^^^ transfer?

Right. Will fix.

Thanks,
baruch

> > +	spi_finalize_current_transfer() so the subsystem can issue the next
> > +	transfer. This may sleep. Note: transfer_one and transfer_one_message
> > +	are mutually exclusive; when both are set, transfer_one takes
> > +	precedence.
> > +
> >      DEPRECATED METHODS

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
