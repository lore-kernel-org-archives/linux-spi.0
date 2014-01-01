From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH v2 0/3] spi: dw: fixes, and manages resources migration
Date: Wed, 1 Jan 2014 18:47:07 +0200
Message-ID: <20140101164707.GK4470@tarshish>
References: <cover.1388427564.git.baruch@tkos.co.il>
 <20140102002513.10e775b6@feng-snb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140102002513.10e775b6@feng-snb>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Feng,

On Thu, Jan 02, 2014 at 12:25:13AM +0800, Feng Tang wrote:
> On Mon, 30 Dec 2013 20:30:43 +0200
> Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:
> > This series migration the spi-dw driver and its mmio wrapper to manges
> > resources, and adds a few small fixes. I have a few more patches in the queue
> > for adding device tree support, gpio chip selects, and generic spi queue, but
> > I'm waiting with time until I get a chance to test them properly.
> 
> Looks good to me, thanks!

Have you tested this or real hardware? I don't have access to a Moorestone 
with PCI, so it would be nice to verify that this series doesn't break 
anything.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
