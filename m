From: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] pxa2xx_spi: fix memory corruption
Date: Tue, 29 Nov 2011 17:05:04 +0300
Message-ID: <1322575504.7024.0.camel@anarsoul-laptop>
References: <201107101609.31405.anarsoul@gmail.com>
	<1310311099-24638-1-git-send-email-anarsoul@gmail.com>
	<20110715025331.GL2927@ponder.secretlab.ca>
	<201107181056.51782.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201107181056.51782.anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 2011-07-18 at 10:56 +0300, Vasily Khoruzhick wrote:
> On Friday 15 July 2011 05:53:31 Grant Likely wrote:
> > On Sun, Jul 10, 2011 at 06:18:19PM +0300, Vasily Khoruzhick wrote:
> > > pxa2xx_spi_probe allocates struct driver_data and null_dma_buf
> > > at same time via spi_alloc_master(), but then calculates
> > > null_dma_buf pointer incorrectly, and it causes memory corruption
> > > later if DMA usage is enabled.
> > > 
> > > Signed-off-by: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > ---
> > > v2: - add u8 __null_dma_buf[16] to the end of driver_data structure
> > > 
> > >     and use it as null_dma_buf after alignment.
> > >     - use PTR_ALIGN instead of ALIGN
> > > 
> > > v3: - drop (u8 *) cast, use & operator instead, change array name
> > > 
> > >  drivers/spi/pxa2xx_spi.c |    9 +++++----
> > >  1 files changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> > > index dc25bee..b25fe27 100644
> > > --- a/drivers/spi/pxa2xx_spi.c
> > > +++ b/drivers/spi/pxa2xx_spi.c
> > > @@ -106,6 +106,7 @@ struct driver_data {
> > > 
> > >  	int rx_channel;
> > >  	int tx_channel;
> > >  	u32 *null_dma_buf;
> > > 
> > > +	u8 null_dma_buf_unaligned[16];
> > 
> > Don't dma buffers need to be cache-line aligned? 
> 
> No, on PXA2xx they need to be 8-bytes aligned (according to PXA27x developer's 
> manual)
> 
> > How large is the actual transfer?
> 
> Looks like 8 bytes, but I'm not sure, I'm not author of driver and did not dig 
> deeply into its code. Just attempting to fix memory corruption.
> 
> > Using the __aligned() or __cacheline_aligned
> > attribute is the correct way to make sure you've got a data buffer
> > that can be used for DMA mixed with other stuff.  Then you don't need
> > to fool around with PTR_ALIGN or anything.
> 
> Errr, it can't be applied to struct field, right? But driver needs per-device 
> null_dma_buf (there's 3 SPI controllers on PXA2xx)
> 
> > g.
> 
> Regards
> Vasily

So, any chance to see this patch merged?

Regards
Vasily


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
