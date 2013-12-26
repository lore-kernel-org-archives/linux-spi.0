From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: dw: drop unused struct dw_spi field
Date: Thu, 26 Dec 2013 22:25:37 +0200
Message-ID: <20131226202537.GB3873@tarshish>
References: <cover.1388040447.git.baruch@tkos.co.il>
 <134cfa84519ca84268fc0ef502fba12773224133.1388040447.git.baruch@tkos.co.il>
 <20131226114258.GH8064@book.gsilab.sittig.org>
 <20131226115826.GY11794@sapphire.tkos.co.il>
 <20131226153346.GN8064@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131226153346.GN8064-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Gerhard,

On Thu, Dec 26, 2013 at 04:33:46PM +0100, Gerhard Sittig wrote:
> On Thu, Dec 26, 2013 at 13:58 +0200, Baruch Siach wrote:
> > On Thu, Dec 26, 2013 at 12:42:58PM +0100, Gerhard Sittig wrote:
> > > On Thu, Dec 26, 2013 at 09:00 +0200, Baruch Siach wrote:
> > > > diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> > > > index c3354e8..4e01019 100644
> > > > --- a/drivers/spi/spi-dw.c
> > > > +++ b/drivers/spi/spi-dw.c
> > > > @@ -427,7 +427,6 @@ static void pump_transfers(unsigned long data)
> > > >  	dws->tx_end = dws->tx + transfer->len;
> > > >  	dws->rx = transfer->rx_buf;
> > > >  	dws->rx_end = dws->rx + transfer->len;
> > > > -	dws->cs_change = transfer->cs_change;
> > > >  	dws->len = dws->cur_transfer->len;
> > > >  	if (chip != dws->prev_chip)
> > > >  		cs_change = 1;
> > > > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> > > > index 1ccfc18..cb52cfe 100644
> > > > --- a/drivers/spi/spi-dw.h
> > > > +++ b/drivers/spi/spi-dw.h
> > > > @@ -135,7 +135,6 @@ struct dw_spi {
> > > >  	u8			n_bytes;	/* current is a 1/2 bytes op */
> > > >  	u8			max_bits_per_word;	/* maxim is 16b */
> > > >  	u32			dma_width;
> > > > -	int			cs_change;
> > > >  	irqreturn_t		(*transfer_handler)(struct dw_spi *dws);
> > > >  	void			(*cs_control)(u32 command);
> > > >  
> > > > -- 
> > > 
> > > This looks suspicious.  Are you (the driver) ignoring the
> > > cs_change information which the caller (the code which emits the
> > > SPI message transfer call) provides?  This appears to be a
> > > deficiency in the SPI master's code then.  Callers should be able
> > > to control CS behaviour between the partial transfers of an SPI
> > > message.  It's part of the API.
> > 
> > The pump_transfers() local cs_change variable tracks chip select status 
> > between transfers. In practice this field is meaningless for this hardware 
> > without external chip select control, like GPIO.
> 
> Please re-check, or tell me if your code base is different from
> mainline and I'm missing something.
> 
> Inspection of local code (v3.13-rc5-4-gf399199c01c7) suggests
> that the local cs_change gets preset to 0 and enforced to 1 if
> the "chip" (the SPI slave?) changes.  I can't see any other
> condition that gets evaluated.  So the current driver does ignore
> the caller's request.

Right. I missed that.

> Your change removes the dws->cs_change member and its assignment
> from transfer->cs_change.  A ':grep cs_change drivers/spi/*dw*'
> suggests that the CS change condition as specified by callers
> completely gets ignored. :-O  This is a bug in my book.

Yes. But this patch doesn't change the situation.

> Regardless of whether the internal hardware implementation of the
> SPI controller's dedicated CS lines don't support software
> control of the line (which may be the cause of the bug, and
> causes trouble even for SPI messages which consist of a single
> transfer), and can get fixed or not, is just an implementation
> detail that's specific to this setup in combination with the
> internal CS line.  But please don't ignore the caller's spec and
> thus break the SPI master's use for all other setups as well.
> Especially when you already have GPIO controlled CS lines on your
> radar.  I still agree with others that the hardware CS line
> behaviour should be considered broken (dramatically reduces the
> usefulness of the controller), and only GPIO backed CS lines
> actually unbreak this master since they do introduce software
> control for the signal which previously was completely absent.

It seems that the cs_contorl callback is a driver specific hack that was meant 
to allow software control of the actual chip-select signal. However, there is 
no implementation of cs_control in current mainline code.

> > > While you are checking whether the SPI master obeys the caller's
> > > CS change spec, can you check the optional delay between partial
> > > transfers as well (I assume that both get handled in the same
> > > spots of the code path)?  ISTR that these two aspects (and the
> > > lack of GPIO backed chip selects given how the hardware CS line
> > > acts) were real obstacles when trying to use this DW SPI master.
> > 
> > The code in pump_transfers() seems to honor delay_usecs. What was the problem 
> > you encountered?
> 
> Since you made me look at the code:  The delay_usecs spec appears
> to only get obeyed _between_ transfers.  It gets ignored for the
> last or only transfer of a message.  Which may be unexpected, and
> differs from what other SPI controllers implement.  Can't tell
> whether this breaks existing SPI slaves, but the delay probably
> was introduced for some reason.  I guess deasserting CS while the
> slave still wants it does have implications...

Right. This is a bug.

> And I remember that the DW-SPI master code I've seen in the past
> may not have been outright wrong, but somehow was organized in
> unexpected ways.  IIRC it handled the end of a transfer and the
> end of a message in separate code paths, duplicating quite some
> code yet handling the last transfer in different ways.  I was
> irritated.  But that must have been a different implementation, I
> know for sure it wasn't mainline, or else I had done something
> about it.

Well, I once wrote a driver for this SPI master. I didn't get much response on 
the mailing list at the time, so I moved on, and this driver went in instead. 
I hope it's not my code that irritated you.

> Please also note that switching to common queue support for the
> SPI master (which you have in your queue as well) may in
> bypassing fix the last transfer's being special for the DW-SPI
> driver.  Then you should not care, it's all just transfers, no
> matter how many of them form a message.

Great. So this problem would solve itself if/when my common queue patch goes 
in.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
