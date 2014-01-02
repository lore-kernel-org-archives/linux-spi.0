From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/3] spi: dw: fixes, and manages resources migration
Date: Thu, 2 Jan 2014 10:09:12 +0800
Message-ID: <20140102100912.4e72558b@feng-snb>
References: <cover.1388427564.git.baruch@tkos.co.il>
	<20140102002513.10e775b6@feng-snb>
	<20140101164707.GK4470@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140101164707.GK4470@tarshish>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Baruch,

On Wed, 1 Jan 2014 18:47:07 +0200
Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:

> Hi Feng,
> 
> On Thu, Jan 02, 2014 at 12:25:13AM +0800, Feng Tang wrote:
> > On Mon, 30 Dec 2013 20:30:43 +0200
> > Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:
> > > This series migration the spi-dw driver and its mmio wrapper to manges
> > > resources, and adds a few small fixes. I have a few more patches in the queue
> > > for adding device tree support, gpio chip selects, and generic spi queue, but
> > > I'm waiting with time until I get a chance to test them properly.
> > 
> > Looks good to me, thanks!
> 
> Have you tested this or real hardware? I don't have access to a Moorestone 
> with PCI, so it would be nice to verify that this series doesn't break 
> anything.

Aha, it's interesting that you don't have the HW. I thought you have
tested them.

Since these patches are mostly straight-forward patch, I simply did a
 pure "code review" :) (Also the spi-dw-mmio was developed by Jean-Hugues
 Deschenes, and I have no "mmio" device at hand)

Thanks,
Feng


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
