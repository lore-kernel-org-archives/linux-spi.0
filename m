From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Thu, 22 Nov 2012 12:31:38 +0530
Message-ID: <CAM=Q2cuCZni2DyzDux-E5H4-djgNrUURTYJ+f=_oMBeJE7eGMw@mail.gmail.com>
References: <1353464203.20353.6.camel@bichao>
	<CAM=Q2cu6ReS-6sJxdacnw=FYGdoFed9bM1gA6yFEtmVjs8KQTA@mail.gmail.com>
	<20121121122630.13fc2087@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121121122630.13fc2087-Z/y2cZnRghHXmaaqVzeoHQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 21, 2012 at 5:56 PM, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> On Wed, 21 Nov 2012 17:44:21 +0530
> Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> > On Wed, Nov 21, 2012 at 7:46 AM, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> >
> > > +       /* Create the PM_QOS request */
> > > +       if (drv_context->quirks & QUIRKS_USE_PM_QOS)
> > > +               pm_qos_add_request(&drv_context->pm_qos_req,
> > > +               PM_QOS_CPU_DMA_LATENCY,
> > > +               PM_QOS_DEFAULT_VALUE);
> > >
> >
> > What happens if the flag is not set if it is absolutely necessary for
> > the driver it should not be a
> > configurable option
>
> If you read through the code it's set only when the device is
> Moorestown/Oaktrail based and only in slave mode. It is not necessary
> in other configurations.
>

Thats what I was trying to understand.

If I am not wrong the latency is time related.
Why only some platforms / modes need it also the value is not speed
dependent.


My doubt is that the time taken for the dma will be more in lower speed so
the
latency constraint could be relaxed.

Also the spi core today doesnt have slave mode support thats a different
discussion altogether may be we can leave it for now.




>
> Alan
>
------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
