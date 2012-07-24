From: Andy Walls <awalls-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>
Subject: Re: [PATCH 2/2] kthread_worker: reimplement flush_kthread_work() to
	allow freeing the work item being executed
Date: Tue, 24 Jul 2012 07:17:45 -0400
Message-ID: <1343128667.2488.6.camel@palomino.walls.org>
References: <20120719211510.GA32763@google.com>
	<20120719211629.GC32763@google.com>
	<1342894814.2504.31.camel@palomino.walls.org>
	<20120722164953.GC5144@dhcp-172-17-108-109.mtv.corp.google.com>
	<1342990015.2487.19.camel@palomino.walls.org>
	<20120723171215.GA5776@google.com>
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
In-Reply-To: <20120723171215.GA5776-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 2012-07-23 at 10:12 -0700, Tejun Heo wrote:
> Hello,
> 
> On Sun, Jul 22, 2012 at 04:46:54PM -0400, Andy Walls wrote:
> > Hmmm, I didn't know about the constraint about 'known to be alive' in
> > the other email I just sent.
> > 
> > That might make calling flush_kthread_work() hard for a user to use, if
> > the user lets the work get freed by another thread executing the work.
> 
> Umm... flushing a freed work item doesn't make any sense at all.  The
> pointer itself loses the ability to identify anything.  What if it
> gets recycled to another work item which happens to depend on the
> flusher to make forward progress?  You now have a circular dependency
> through a recycled memory area.  Good luck hunting that down.
> 
> For pretty much any API, allowing dangling pointers as argument is
> insane.  If you want to flush self-freeing work items, flush the
> kthread_worker.  That's how it is with workqueue and how it should be
> with kthread_worker too.

Hi,

Ah.  My problem was that I mentally assigned the wrong rationale for why
you reworked flush_kthread_work().

Thank you for your patience and explanations.
Sorry for the noise.

For patch 2/2:

Reviewed-by: Andy Walls <awalls-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>

Regards,
Andy


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
