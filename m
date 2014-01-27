From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH v2 4/5] spi: dw: document device tree binding
Date: Mon, 27 Jan 2014 21:18:10 +0200
Message-ID: <20140127191810.GV5596@tarshish>
References: <cover.1390723880.git.baruch@tkos.co.il>
 <211f8d2101fff1790526f7dff766d0d9efff9280.1390723880.git.baruch@tkos.co.il>
 <20140127190839.GN11841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140127190839.GN11841-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Mon, Jan 27, 2014 at 07:08:39PM +0000, Mark Brown wrote:
> On Sun, Jan 26, 2014 at 10:14:35AM +0200, Baruch Siach wrote:
> 
> > +Required properties:
> 
> > +- num-cs: see spi-bus.txt
> 
> Why is this mandatory, in the code it was optional?  One or the other
> ought to be updated.

The code defaults to 4. I guess that's what the hardware this code was tested 
on had. But this default doesn't make much sense in the general case. Anyway, 
for backwards compatibility I'll document this property as optional, note that 
the default is 4, and recommend to add this property anyway. Does this sound 
reasonable?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
