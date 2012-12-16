From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Sun, 16 Dec 2012 21:32:36 +0000
Message-ID: <20121216213237.069B63E0BDD@localhost>
References: <1353464203.20353.6.camel@bichao>
	<20121206123856.002683E0AE3@localhost>
	<1355216311.30354.166.camel@bichao>
	<20121211164658.4DBAD3E0C3E@localhost>
	<1355389774.3876.67.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1355389774.3876.67.camel@bichao>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 13 Dec 2012 17:09:34 +0800, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, 2012-12-11 at 16:46 +0000, Grant Likely wrote:
> > On Tue, 11 Dec 2012 16:58:31 +0800, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > > On Thu, 2012-12-06 at 12:38 +0000, Grant Likely wrote:
> > > > On Wed, 21 Nov 2012 10:16:43 +0800, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > > 
> > > > > +	master->mode_bits = SPI_CPOL | SPI_CPHA;
> > > > > +	master->bus_num = SSP_CFG_GET_SPI_BUS_NB(ssp_cfg);
> > > > > +	master->num_chipselect = 1;
> > > > > +	master->cleanup = cleanup;
> > > > > +	master->setup = setup;
> > > > > +	master->transfer = transfer;
> > > > > +	drv_context->dma_wq = create_workqueue("intel_mid_ssp_spi");
> > > > > +	INIT_WORK(&drv_context->complete_work, int_transfer_complete_work);
> > > > 
> > > > Workqueue management is integrated into the core spi infrastructure now.
> > > > SPI drivers should no longer be creating their own workqueues.
> > > > 
> > > > Instead, replace the ->transfer hook with prepare_transfer_hardware(),
> > > > unprepare_transfer_hardware() and transfer_one_message(). See
> > > > Documentation/spi/spi-summary for details.
> > > 
> > > Hi Grant,
> > > I'd like to talk about my understanding here, please correct me if I was wrong:
> > > 
> > > 1. I understand the workqueue in spi core is for driving message
> > > transfer, so SPI driver should not create new workqueue for this usage.
> > > However, the workqueue created here is not for this usage it's to call
> > > back to SPI protocol driver (ifx6x60.c) when DMA data transfer is
> > > finished, so it seems not conflict with spi core. Am I right?
> > 
> > It appears to me like all the stuff in int_transfer_complete() can be
> > performed at interrupt context, or gets removed in moving to the new
> > system. Am I mistaken here?
> > 
> 
> Yes, we can make use of new SPI core interface to callback to protocol driver
> (through spi_finalize_current_message()), but looks like it's better to call
> spi_finalize_current_message() inside workqueue than DMA interrupt context, 
> because the callback function for protocol driver would cost much time, it's 
> better to move this part out of interrupt context. Therefore, I prefer to keep 
> the workqueue here if you agree, what's your opinion? 

It would be better to work within the context of the kthread that is
already managing transfers. Otherwise you've got multiple contexts that
could be competing. Plus the kthread may be running in realtime context,
but that would be useless since the workqueue would never have the same
priority.

It currently isn't documented whether or not protocol drivers can sleep
in the complete callback. I think it is assumed that it cannot, but that
should be verified. If it is a problem for the complete callback to
requre atomicity, then maybe we should have a separate .complete_atomic
hook for those that can handle it, and call .complete() in the kthread
context.

Linusw, you did a bunch of work on this. What do you think?

g.


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
