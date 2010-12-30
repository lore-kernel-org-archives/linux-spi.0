From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [uClinux-dev] [PATCH] m68knommu: Coldfire QSPI platform support
Date: Wed, 29 Dec 2010 23:20:01 -0700
Message-ID: <20101230062001.GA843@angua.secretlab.ca>
References: <201001221243.04045.sfking@fdwdc.com>
	<4CA17F2D.7000407@snapgear.com>
	<6C2434209962DC46B88345CA85C334A2A434E65AF7@Courier.syntech.org>
	<201012100846.36080.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jate Sujjavanich <jsujjavanich-oI4RZb1+6EReLsYL91UIxL5dPsmED6B0@public.gmane.org>,
	'Greg Ungerer' <gerg-XXXsiaCtIV5Wk0Htik3J/w@public.gmane.org>,
	"'spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201012100846.36080.sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Dec 10, 2010 at 08:46:35AM -0800, Steven King wrote:
> On Wednesday 29 September 2010 06:44:32 Jate Sujjavanich wrote:
> > Here's a patch for your review.
> >
> >
> > After grabbing a msg from the msgq, the mcfqspi_work function calls
> > list_del_init on the mcfqspi->msgq which unintentionally deletes the rest
> > of the list before it can be processed. If qspi call was made using
> > spi_sync, this can result in a process hang.
> >
> > Signed-off by Jate Sujjavanich<jsujjavanich-oI4RZb1+6EReLsYL91UIxL5dPsmED6B0@public.gmane.org>
> > -----------
> > diff --git a/drivers/spi/coldfire_qspi.c b/drivers/spi/coldfire_qspi.c
> > index 59be3ef..0aa00af 100644
> > --- a/drivers/spi/coldfire_qspi.c
> > +++ b/drivers/spi/coldfire_qspi.c
> > @@ -316,7 +316,7 @@ static void mcfqspi_work(struct work_struct *work)
> >                  msg = container_of(mcfqspi->msgq.next, struct spi_message,
> >                                     queue);
> > -               list_del_init(&mcfqspi->msgq);
> > +               list_del_init(&msg->queue);
> >                  spin_unlock_irqrestore(&mcfqspi->lock, flags);
> >                  spi = msg->spi;
> >
> 
> 
> A belated ack.
> 
> Grant, can we still get this into .37?

Applied manually (patch was mailer-damaged).  I'll see if Linux will still pick it up for .37.

thanks.
g.

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
