From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH v3 0/5] spi: dw: device tree and generic queue support
Date: Sun, 2 Feb 2014 17:24:48 +0200
Message-ID: <20140202152448.GH9184@tarshish>
References: <cover.1391162172.git.baruch@tkos.co.il>
 <20140202124941.GS20094@book.gsilab.sittig.org>
 <20140202133235.GF9184@tarshish>
 <20140202143148.GT20094@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140202143148.GT20094-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Gerhard,

On Sun, Feb 02, 2014 at 03:31:48PM +0100, Gerhard Sittig wrote:
> On Sun, Feb 02, 2014 at 15:32 +0200, Baruch Siach wrote:
> > On Sun, Feb 02, 2014 at 01:49:41PM +0100, Gerhard Sittig wrote:
> > > On Fri, Jan 31, 2014 at 12:07 +0200, Baruch Siach wrote:
> > > > Unfortunately, I probably have no chance access to thest this series on
> > > > hardware, I's only compile tested. So I'm sending this as RFC for code review.
> > > > If this series doesn't get merged, it may be used at least as a starting point
> > > > for someone with hardware access.
> > > 
> > > Which repo and branch is the code based on?  I can't apply it
> > > here, neither to v3.13 nor torvald's master nor broonie's
> > > topic/dw nor broonie's for-next.
> > 
> > This sereis is based on the topic/dw branch as of 6d3a38819. Mark has applied 
> > patch no. 5 from this series to topic/dw. Is this the cause of your problem?
> 
> I was looking into how I could test the GPIO based chip select
> support.  Unfortunately I don't have much hardware around either,
> it turned out that none of the available boards allow me to run
> mainline kernels and access the signals or connect more slaves.
> So I'm sorry but cannot help beyond review either. :(

Just curious, what hardware do you have with DesignWare SPI master?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
