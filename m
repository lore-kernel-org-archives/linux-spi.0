From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: spi.h: clarify the documentation of transfer_one
Date: Fri, 24 Jan 2014 10:12:46 +0200
Message-ID: <20140124081246.GN12751@tarshish>
References: <cover.1390544495.git.baruch@tkos.co.il>
 <39ffc897bd2e5fd48a3141ed4cd122a80c5bbb20.1390544495.git.baruch@tkos.co.il>
 <CAMuHMdW05ANcRJW8dPwLuvONoXD+Fny=Txd-wuwXVJHCqmva1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdW05ANcRJW8dPwLuvONoXD+Fny=Txd-wuwXVJHCqmva1A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Gerrt,

On Fri, Jan 24, 2014 at 08:44:32AM +0100, Geert Uytterhoeven wrote:
> On Fri, Jan 24, 2014 at 7:28 AM, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -285,7 +285,9 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
> >   * @transfer_one: transfer a single spi_transfer. When the
> >   *               driver is finished with this transfer it must call
> >   *               spi_finalize_current_transfer() so the subsystem can issue
> > - *                the next transfer
> > + *                the next transfer. Note: transfer_one and
> > + *                transfer_one_message are mutually exclusive; when both are
> > + *                set, transfer_one takes precedence.
> 
> I find this a bit difficult to grasp. What does "take precedence" mean in
> this context?
> 
> The default spi_transfer_one_message() uses .transfer_one().
> But if .transfer_one_message() is set, it depends on your own driver if
> .transfer_one() is used or not.

Of course. I misread the code. How about this:

Note: transfer_one and transfer_one_message are mutually exclusive; when both 
are set, the transfer_one callback is not called by the generic subsystem.

Thanks again,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
