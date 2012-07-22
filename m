From: Andy Walls <awalls-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>
Subject: Re: [PATCH 1/2] kthread_worker: reorganize to prepare for
	flush_kthread_work() reimplementation
Date: Sun, 22 Jul 2012 16:42:12 -0400
Message-ID: <1342989735.2487.15.camel@palomino.walls.org>
References: <20120719211510.GA32763@google.com>
	<20120719211541.GB32763@google.com>
	<1342890808.2504.3.camel@palomino.walls.org>
	<20120722164607.GB5144@dhcp-172-17-108-109.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ivtv-devel-jGorlIydJmRM656bX5wj8A@public.gmane.org,
	Avi Kivity <avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus,
	linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120722164607.GB5144-RcKxWJ4Cfj1J2suj2OqeGauc2jM2gXBXkQQo+JxHRPFibQn6LdNjmg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, 2012-07-22 at 09:46 -0700, Tejun Heo wrote:
> Hello,
> 
> On Sat, Jul 21, 2012 at 01:13:27PM -0400, Andy Walls wrote:
> > > +/* insert @work before @pos in @worker */
> > 
> > Hi Tejun,
> > 
> > Would a comment that the caller should be holding worker->lock be useful
> > here?  Anyway, comment or not:
> > 
> > Acked-by: Andy Walls <awall-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>
> 
> Will add lockdep_assert_held().  Thanks!
> 

Great!  Thank you.

Regards,
Andy 


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
