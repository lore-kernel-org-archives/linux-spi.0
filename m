From: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] pxa2xx_spi: fix memory corruption
Date: Sun, 10 Jul 2011 09:57:06 +0200
Message-ID: <201107100957.06377.marek.vasut@gmail.com>
References: <1310246098-21208-1-git-send-email-anarsoul@gmail.com>
	<20110709231108.GQ4812@n2100.arm.linux.org.uk>
	<201107100914.45452.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: "Russell King - ARM Linux" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201107100914.45452.marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sunday, July 10, 2011 09:14:45 AM Marek Vasut wrote:
> On Sunday, July 10, 2011 01:11:09 AM Russell King - ARM Linux wrote:
> > On Sun, Jul 10, 2011 at 01:05:48AM +0200, Marek Vasut wrote:
> > > On Saturday, July 09, 2011 11:14:58 PM Vasily Khoruzhick wrote:
> > > > pxa2xx_spi_probe allocates struct driver_data and null_dma_buf
> > > > at same time via spi_alloc_master(), but then calculates
> > > > null_dma_buf pointer incorrectly, and it causes memory corruption
> > > > later if DMA usage is enabled.
> > > > 
> > > > Signed-off-by: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > ---
> > > > 
> > > >  drivers/spi/pxa2xx_spi.c |    2 +-
> > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > > 
> > > > diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> > > > index dc25bee..ef38fbf 100644
> > > > --- a/drivers/spi/pxa2xx_spi.c
> > > > +++ b/drivers/spi/pxa2xx_spi.c
> > > > @@ -1569,7 +1569,7 @@ static int __devinit pxa2xx_spi_probe(struct
> > > > platform_device *pdev) master->transfer = transfer;
> > > > 
> > > >  	drv_data->ssp_type = ssp->type;
> > > > 
> > > > -	drv_data->null_dma_buf = (u32 *)ALIGN((u32)(drv_data +
> > > > +	drv_data->null_dma_buf = (u32 *)ALIGN(((u32)drv_data +
> > > > 
> > > >  						sizeof(struct driver_data)), 8);
> > > 
> > > This thing looks a bit disturbing in itself. Like, where the heck is
> > > that thing pointing in the end ? Since some data are written to
> > > address in "null_dma_buf" ... isn't this just changing the corruption
> > > impact ?
> > > 
> >         /* Allocate master with space for drv_data and null dma buffer */
> >         master = spi_alloc_master(dev, sizeof(struct driver_data) + 16);
> > 
> > So there's 16 bytes at the end of driver_data.
> > 
> > However:
> > 	(u32)(drv_data + sizeof(struct driver_data))
> > 
> > is pointer arithmetic.  drv_data points at an object of sizeof(struct
> > driver_data).  Adding one to this increments the pointer by
> > sizeof(struct driver_data) bytes.  So the above expression increments
> > the pointer by sizeof(struct driver_data)*sizeof(struct driver_data)
> > bytes, which is obviously complete rubbish.
> > 
> > 	((u32)drv_data + sizeof(struct driver_data))
> > 
> > casts drv_data to a u32 first, then adds the sizeof(struct driver_data)
> > which moves us into the 16 bytes allocated off the end of the struct.
> 
> The ptr arritmetic is clear, it was the 16 bytes after the structure I was
> missing ... if it's allocated there, it's fine. Thanks for clearing this.

Actually ... why don't we just add char null_buf[16] at the end of the structure 
instead of allocating +16 bytes and then doing this strange crap ? Or even 
better ... kzalloc() the buffer in probe(), then kfree() it in remove()?

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
