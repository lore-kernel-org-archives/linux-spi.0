From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bitbang: support the new
	SPI_BOARD_FLAG_RELEASE_CS flag
Date: Fri, 13 Apr 2012 16:43:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204131625230.16773@axis700.grange>
References: <Pine.LNX.4.64.1203152228430.2988@axis700.grange>
	<Pine.LNX.4.64.1203152230190.2988@axis700.grange>
	<20120317224213.ED0FF3E03CC@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120317224213.ED0FF3E03CC@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant

On Sat, 17 Mar 2012, Grant Likely wrote:

> On Thu, 15 Mar 2012 22:32:14 +0100 (CET), Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> > By supporting the new SPI_BOARD_FLAG_RELEASE_CS flag we let underlying
> > hardware drivers implement more efficient runtime power-management.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
> > ---
> >  drivers/spi/spi-bitbang.c |   22 ++++++++++------------
> >  1 files changed, 10 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
> > index fe06e1b..c895d85 100644
> > --- a/drivers/spi/spi-bitbang.c
> > +++ b/drivers/spi/spi-bitbang.c
> > @@ -347,17 +347,14 @@ static void bitbang_work(struct work_struct *work)
> >  			if (t->delay_usecs)
> >  				udelay(t->delay_usecs);
> >  
> > -			if (!cs_change)
> > -				continue;
> > -			if (t->transfer_list.next == &m->transfers)
> > -				break;
> > -
> > -			/* sometimes a short mid-message deselect of the chip
> > -			 * may be needed to terminate a mode or command
> > -			 */
> > -			ndelay(nsecs);
> > -			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
> > -			ndelay(nsecs);
> > +			if (cs_change && !list_is_last(&t->transfer_list, &m->transfers)) {
> > +				/* sometimes a short mid-message deselect of the chip
> > +				 * may be needed to terminate a mode or command
> > +				 */
> > +				ndelay(nsecs);
> > +				bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
> > +				ndelay(nsecs);
> > +			}
> >  		}
> >  
> >  		m->status = status;
> > @@ -367,7 +364,8 @@ static void bitbang_work(struct work_struct *work)
> >  		 * cs_change has hinted that the next message will probably
> >  		 * be for this chip too.
> >  		 */
> > -		if (!(status == 0 && cs_change)) {
> > +		if (!(status == 0 && cs_change) ||
> > +		    spi->flags & SPI_BOARD_FLAG_RELEASE_CS) {
> 
> That's rather heavy handed, and will probably break drivers that lock the spi
> bus to guarantee concurrent messages (like the MMC layer).  I don't think you
> can do it this way.
> 
> It might be okay to force CS disable if the spi bus hasn't been exclusively
> locked.  I know the comment talks about hinting (possibly for performance reasonse),
> but I'm more interested in correctness at this point.

I understand your concerns about breaking existing configurations, but let 
us not forget, that this behaviour would only be activated by a new 
platform flag. This means, no existing set up should be affected and any 
new users should know what they are doing...

But let's think about the bus-lock too. A comment in spi.c says:

 * This call should be used by drivers that require exclusive access to the
 * SPI bus.

"Exclusive access" also means, that the chip-select stays active, which 
also means, the bus shall behave sanely, right? In other words, it shall 
not be suspended. It is easy to add a check in the above patch for 
master->bus_lock_flag, but we also probably want to retry releasing the 
CS, when the bus is unlocked. So, we need to inform the bus-driver, that 
the bus has just been released. We could add a callback for that, but 
wouldn't it be better to use runtime PM? Calls to spi_bus_lock() / 
unlock() are balanced, so, we could just add 
pm_runtime_get_sync(&master->dev) and pm_runtime_put(&master->dev) to them 
respectively? Would this be acceptable?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
