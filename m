From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH v3 2/5] spi: dw: document device tree binding
Date: Mon, 3 Feb 2014 07:30:43 +0200
Message-ID: <20140203053043.GJ9184@tarshish>
References: <cover.1391162172.git.baruch@tkos.co.il>
 <a978b266a9b8827747054a689e014ca9efbec235.1391162172.git.baruch@tkos.co.il>
 <20140202122320.GQ20094@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140202122320.GQ20094-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Gerhard,

Thanks for reviewing.

On Sun, Feb 02, 2014 at 01:23:20PM +0100, Gerhard Sittig wrote:
> On Fri, Jan 31, 2014 at 12:07 +0200, Baruch Siach wrote:
> > 
> > Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-dw.txt | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt
> 
> You introduce a new binding, but don't Cc: the devicetree list
> for review.

I wanted to do that but forgot.

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-dw.txt
> > @@ -0,0 +1,24 @@
> > +Synopsys DesignWare SPI master
> > +
> > +Required properties:
> > +- compatible: should be "snps,designware-spi"
> > +- #address-cells: see spi-bus.txt
> > +- #size-cells: see spi-bus.txt
> > +- reg: address and length of the spi master registers
> > +- interrupts: should contain one interrupt
> > +- clocks: spi clock phandle
> > +- num-cs: see spi-bus.txt
> 
> You may want to check Mark Rutland's replies in the DT list
> archives with his nits about speaking of phandles only where
> specifiers are involved as well, and how he several times
> suggested improved descriptions that you can adopt or copy.

I've see one of these messages last week. I'll try to look them up and update 
the wording. If you have a pointer to a properly written in-tree 'clocks' 
description please let me know.

> Is 'num-cs' really required and not optional?  (It may be, I'm
> just asking.  Given that there has not been a binding before,
> there is no compatibility issue either.)

Yes. With this version of the series 'num-cs' is mandatory for the DT case. In 
the non-DT case the deriver defaults to 4 as before.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
