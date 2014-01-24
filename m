From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] Doc: spi: document the transfer_one spi_master
 callback
Date: Fri, 24 Jan 2014 11:08:06 +0200
Message-ID: <20140124090806.GP12751@tarshish>
References: <cover.1390552232.git.baruch@tkos.co.il>
 <1abe062855111800754477d1340635b5a69d5635.1390552232.git.baruch@tkos.co.il>
 <CAMuHMdVrNcs0uWfVNdXGw+HTuGHy2nGXR=tMqdzz236LGFHVoQ@mail.gmail.com>
 <20140124084934.GO12751@tarshish>
 <CAMuHMdVH9XDcVGXt2CcqkABGbz4Kz9bA5M1NPSAyOnwm6u4j2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVH9XDcVGXt2CcqkABGbz4Kz9bA5M1NPSAyOnwm6u4j2A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

On Fri, Jan 24, 2014 at 09:57:38AM +0100, Geert Uytterhoeven wrote:
> On Fri, Jan 24, 2014 at 9:49 AM, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:
> >> > +    master->transfer_one(struct spi_master *master, struct spi_device *spi,
> >> > +                        struct spi_transfer *transfer)
> >> > +       The subsystem calls the driver to transfer a single transfer while
> >> > +       queuing transfers that arrive in the meantime. When the driver is
> >> > +       finished with this message, it must call
> >> > +       spi_finalize_current_transfer() so the subsystem can issue the next
> >> > +       transfer. This may sleep. Note: transfer_one and transfer_one_message
> >> > +       are mutually exclusive; when both are set, the generic subsystem does
> >> > +       not call your transfer_one callback.
> >>
> >> You still forgot the updates I made in
> >> http://lkml.indiana.edu/hypermail/linux/kernel/1401.2/02465.html
> >
> > AFAICS, your patch touches spi.h, not spi-summary. Am I missing something
> > here?
> 
> I think the description in spi-summary should be updated to match the
> changes to spi.h.

OK. Will do.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
