From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3] pxa2xx_spi: fix memory corruption
Date: Fri, 15 Jul 2011 13:50:03 -0600
Message-ID: <20110715195003.GG2833@ponder.secretlab.ca>
References: <201107101609.31405.anarsoul@gmail.com>
	<1310311099-24638-1-git-send-email-anarsoul@gmail.com>
	<20110715025331.GL2927@ponder.secretlab.ca>
	<20110715081242.GM23270@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110715081242.GM23270-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 15, 2011 at 09:12:42AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 14, 2011 at 08:53:31PM -0600, Grant Likely wrote:
> > > +	u8 null_dma_buf_unaligned[16];
> > 
> > Don't dma buffers need to be cache-line aligned?  How large is the
> > actual transfer?  Using the __aligned() or __cacheline_aligned
> > attribute is the correct way to make sure you've got a data buffer
> > that can be used for DMA mixed with other stuff.  Then you don't need
> > to fool around with PTR_ALIGN or anything.
> 
> Err, did you not read the whole patch?
> 
> > > +	drv_data->null_dma_buf =
> > > +		(u32 *)PTR_ALIGN(&drv_data->null_dma_buf_unaligned, 8);

I read a lot of patches yesterday.  I may very well have missed
something.  I still don't see what you're referring to though.  If
the __aligned() was used inside the structure definition, then there
would be no need to have both the null_dma_buf pointer and the
null_dma_buf_unaligned buffer.  It would just be a correctly aligned
null_dma_buf.

Plus, I was asking about whether it was valid to use the structure as
allocated in DMA operations since it may very well end up in the same
cache line as the allocated structure.  Firstly, that could mean DMA
and the cache referencing the same memory which could cause
corruption, and secondly on ARM isn't it a problem to have DMA buffers
in memory that is also cache mapped?

That said, I've not read the entire driver, so I haven't checked
null_dma_buffer is used in a real dma operation.

g.

------------------------------------------------------------------------------
AppSumo Presents a FREE Video for the SourceForge Community by Eric 
Ries, the creator of the Lean Startup Methodology on "Lean Startup 
Secrets Revealed." This video shows you how to validate your ideas, 
optimize your ideas and identify your business strategy.
http://p.sf.net/sfu/appsumosfdev2dev
