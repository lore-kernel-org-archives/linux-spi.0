From: chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Thu, 13 Dec 2012 17:09:34 +0800
Message-ID: <1355389774.3876.67.camel@bichao>
References: <1353464203.20353.6.camel@bichao>
	<20121206123856.002683E0AE3@localhost>
	<1355216311.30354.166.camel@bichao>
	<20121211164658.4DBAD3E0C3E@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121211164658.4DBAD3E0C3E@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


On Tue, 2012-12-11 at 16:36 +0000, Grant Likely wrote:
> > On Tue, 11 Dec 2012 10:00:16 +0800, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> wrote:
> > > > > +static void dump_trailer(const struct device *dev, char *buf, int len, int sz)
> > > > > +{
> > > > > +	int tlen1 = (len < sz ? len : sz);
> > > > > +	int tlen2 =  ((len - sz) > sz) ? sz : (len - sz);
> > > > > +	unsigned char *p;
> > > > > +	static char msg[MAX_SPI_TRANSFER_SIZE];
> > > > 
> > > > Is this size a limitation of the hardware, of of the driver?
> > > 
> > > I think this size is attributed to the DMA controller's maximum block size. 
> > > On Medfield platform, the DMA controller used by SSP SPI has defined its maximum 
> > > block size and word width, so SPI transfer size should not exceed the maximum size that 
> > > DMA could transfer in one block.
> > 
> > Typically what a driver should do here is to split up the transfer into
> > multiple DMA operations. I won't nack the driver over this issue, but
> > the driver should not have a maximum transfer size limitation in this
> > way.

Yes, agree with you. But I'm not 100% sure it's the only reason to set such limitation here. 
we'll keep tracking this issue, if it's as what we see, we shall implement an enhanced mechanism 
for multi DMA transfer the next step.



On Tue, 2012-12-11 at 16:46 +0000, Grant Likely wrote:
> On Tue, 11 Dec 2012 16:58:31 +0800, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > On Thu, 2012-12-06 at 12:38 +0000, Grant Likely wrote:
> > > On Wed, 21 Nov 2012 10:16:43 +0800, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > 
> > > > +	master->mode_bits = SPI_CPOL | SPI_CPHA;
> > > > +	master->bus_num = SSP_CFG_GET_SPI_BUS_NB(ssp_cfg);
> > > > +	master->num_chipselect = 1;
> > > > +	master->cleanup = cleanup;
> > > > +	master->setup = setup;
> > > > +	master->transfer = transfer;
> > > > +	drv_context->dma_wq = create_workqueue("intel_mid_ssp_spi");
> > > > +	INIT_WORK(&drv_context->complete_work, int_transfer_complete_work);
> > > 
> > > Workqueue management is integrated into the core spi infrastructure now.
> > > SPI drivers should no longer be creating their own workqueues.
> > > 
> > > Instead, replace the ->transfer hook with prepare_transfer_hardware(),
> > > unprepare_transfer_hardware() and transfer_one_message(). See
> > > Documentation/spi/spi-summary for details.
> > 
> > Hi Grant,
> > I'd like to talk about my understanding here, please correct me if I was wrong:
> > 
> > 1. I understand the workqueue in spi core is for driving message
> > transfer, so SPI driver should not create new workqueue for this usage.
> > However, the workqueue created here is not for this usage it's to call
> > back to SPI protocol driver (ifx6x60.c) when DMA data transfer is
> > finished, so it seems not conflict with spi core. Am I right?
> 
> It appears to me like all the stuff in int_transfer_complete() can be
> performed at interrupt context, or gets removed in moving to the new
> system. Am I mistaken here?
> 

Yes, we can make use of new SPI core interface to callback to protocol driver
(through spi_finalize_current_message()), but looks like it's better to call
spi_finalize_current_message() inside workqueue than DMA interrupt context, 
because the callback function for protocol driver would cost much time, it's 
better to move this part out of interrupt context. Therefore, I prefer to keep 
the workqueue here if you agree, what's your opinion? 

> > 2. Currently our Medfield Platform SW is based on linux-3.0, transfer_one_message() 
> > is not implemented, so in SPI driver, we're still use ->transfer(), this 
> > is with long-term validation. If we change to ->transfer_one_message() now, 
> > it's hardly to do thorough validation on our platform, so shall we complete 
> > this part by 2 steps, firstly we implement with ->transfer() hoot which can be 
> > validation on our hardware platform, next step, when our internal SW version 
> > is upgraded to latest Linux version, then we raise a patch to adapt new spi core.
> > what's your opinion?
> 
> Has it been tested on current mainline? I won't nak the driver if it
> doesn't use the common workqueue, but it does make it a lot

Agree with you, linux 3.7 SPI CORE interface is much better, we'll keep SSP driver 
align with it and test based on mainline SPI, now we're porting mainline SPI to our 
platform for test, it may takes a few time, after that we'll re-submit for you review.

Thanks,
chao


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
