From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [patch] spi: release lock on error path in spi_pump_messages()
Date: Sun, 11 Mar 2012 07:02:40 -0600
Message-ID: <20120311130240.2DB083E0892@localhost>
References: <20120310085729.GB4647@elgon.mountain> <4F5B2113.3060103@bfs.de>
	<20120311024307.AA5E33E0950@localhost>
	<20120311062059.GB3337@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wharms-fPG8STNUNVg@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120311062059.GB3337@mwanda>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, 11 Mar 2012 09:20:59 +0300, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> On Sat, Mar 10, 2012 at 07:43:07PM -0700, Grant Likely wrote:
> > On Sat, 10 Mar 2012 10:38:27 +0100, walter harms <wharms-fPG8STNUNVg@public.gmane.org> wrote:
> > > hi Dan,
> > > do you want to protect dev_err() by a spn_lock ?
> > 
> > Applied, after moving unlock above the dev_err.
> > 
> 
> Thanks.
> 
> I was going to resend this with Walter's change btw.  I wasn't going
> to ignore his review comments.

I assumed you would.  It was just simpler for me to pick it up with the
trivial change.

g.


------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
