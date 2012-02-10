From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RESEND] intel_mid_ssp_spi: Moorestown and Medfield SPI
	for SSP devices
Date: Fri, 10 Feb 2012 09:18:22 +0800
Message-ID: <20120210091822.6008453c@feng-i7>
References: <20120208104059.23036.78003.stgit@bob.linux.org.uk>
	<20120209153121.GC11249@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120209153121.GC11249-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

On Thu, 9 Feb 2012 07:31:21 -0800
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> On Wed, Feb 08, 2012 at 10:41:10AM +0000, Alan Cox wrote:
> > From: Mathieu SOULARD <mathieux.soulard-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > 
> > This driver is a fusion of various internal drivers into a single
> > driver for the SPI slave/master on the Intel Moorestown and Medfield
> > SSP devices.
> > 
> > Signed-off-by: Mathieu SOULARD <mathieux.soulard-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > [Queueing and runtime pm added]
> > Signed-off-by: Kristen Carlson Accardi <kristen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > [Ported to the -next tree DMA engine]
> > Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> > 
> >  drivers/spi/Kconfig             |    8 
> >  drivers/spi/Makefile            |    2 
> >  drivers/spi/spi-intel-mid-ssp.c | 1426
> > +++++++++++++++++++++++++++++++++++++++ drivers/spi/spi-intel-mid-ssp.h |
> > 308 ++++++++
> 
> If this is merging several of the drivers, what is the plan for the existing
> SPI_DESIGNWARE and SPI_TOPCLIFF_PCH drivers?  Or are those for different
> devices?

The DESIGNWARE controller has a different HW IP core, so the 2 drivers can't
be merged. And for the TOPCLIFF one, seems it also use a different HW IP than
this one, so I guess it can't be merged either.

Thanks,
Feng

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
