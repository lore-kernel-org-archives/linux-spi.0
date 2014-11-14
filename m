From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Fix mapping from vmalloc-ed buffer to scatter
	list
Date: Fri, 14 Nov 2014 17:11:33 +0000
Message-ID: <20141114171133.GC12443@opensource.wolfsonmicro.com>
References: <1415979645-26264-1-git-send-email-ckeepax@opensource.wolfsonmicro.com> <20141114155222.GF3815@sirena.org.uk> <20141114160607.GB12443@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141114160607.GB12443-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Nov 14, 2014 at 04:06:07PM +0000, Charles Keepax wrote:
> On Fri, Nov 14, 2014 at 03:52:22PM +0000, Mark Brown wrote:
> > On Fri, Nov 14, 2014 at 03:40:44PM +0000, Charles Keepax wrote:
> > > We can only use page_address on memory that has been mapped using kmap,
> > > when the buffer passed to the SPI has been allocated by vmalloc the page
> > > has not necessarily been mapped through kmap. This means sometimes
> > > page_address will return NULL causing the pointer we pass to sg_set_buf
> > > to be invalid.
> > 
> > Hrm, this is a bug in the mxs driver (which is where we copied the core
> > code from) - care to fix that too?
> 
> Yeah no problem, won't be able to test it, but should be a fairly
> trivial change and hopefully someone else can test.

Ah... ok I think I see the difference here. The MXS architecture
has CONFIG_HIGHMEM=n whereas Arndale has CONFIG_HIGHMEM=y. So
that means on MXS all the pages will always be in low mem so I
think will always be mapped into the kernel logical address space
hence no problems. Not sure if it would be worth updating the
driver or not, what do you think?

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
