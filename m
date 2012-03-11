From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [patch] spi: release lock on error path in spi_pump_messages()
Date: Sat, 10 Mar 2012 19:43:07 -0700
Message-ID: <20120311024307.AA5E33E0950@localhost>
References: <20120310085729.GB4647@elgon.mountain> <4F5B2113.3060103@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wharms-fPG8STNUNVg@public.gmane.org, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4F5B2113.3060103-fPG8STNUNVg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, 10 Mar 2012 10:38:27 +0100, walter harms <wharms-fPG8STNUNVg@public.gmane.org> wrote:
> 
> 
> Am 10.03.2012 09:57, schrieb Dan Carpenter:
> > We should release the lock here and enable IRQs before returning.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> > 
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 5ae1e84..ab1bdce 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -535,6 +535,7 @@ static void spi_pump_messages(struct kthread_work *work)
> >  			if (ret) {
> >  				dev_err(&master->dev,
> >  					"failed to unprepare transfer hardware\n");
> > +				spin_unlock_irqrestore(&master->queue_lock, flags);
> >  				return;
> >  			}
> >  		}
> 
> 
> hi Dan,
> do you want to protect dev_err() by a spn_lock ?

Applied, after moving unlock above the dev_err.

g.


------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
