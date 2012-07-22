From: Andy Walls <awalls-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>
Subject: Re: [PATCH 2/2] kthread_worker: reimplement flush_kthread_work() to
	allow freeing the work item being executed
Date: Sun, 22 Jul 2012 16:46:54 -0400
Message-ID: <1342990015.2487.19.camel@palomino.walls.org>
References: <20120719211510.GA32763@google.com>
	<20120719211629.GC32763@google.com>
	<1342894814.2504.31.camel@palomino.walls.org>
	<20120722164953.GC5144@dhcp-172-17-108-109.mtv.corp.google.com>
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
In-Reply-To: <20120722164953.GC5144-RcKxWJ4Cfj1J2suj2OqeGauc2jM2gXBXkQQo+JxHRPFibQn6LdNjmg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, 2012-07-22 at 09:49 -0700, Tejun Heo wrote:
> Hello,
> 
> On Sat, Jul 21, 2012 at 02:20:06PM -0400, Andy Walls wrote:
> > > +	worker->current_work = work;
> > >  	spin_unlock_irq(&worker->lock);
> > >  
> > >  	if (work) {
> > >  		__set_current_state(TASK_RUNNING);
> > >  		work->func(work);
> > 
> > If the call to 'work->func(work);' frees the memory pointed to by
> > 'work', 'worker->current_work' points to deallocated memory.
> > So 'worker->current_work' will only ever used as a unique 'work'
> > identifier to handle, correct?
> 
> Yeah.  flush_kthread_work(@work) which can only be called if @work is
> known to be alive looks at the pointer to determine whether it's the
> current work item on the worker.

OK.  Thanks.

Hmmm, I didn't know about the constraint about 'known to be alive' in
the other email I just sent.

That might make calling flush_kthread_work() hard for a user to use, if
the user lets the work get freed by another thread executing the work.


> > >  void flush_kthread_work(struct kthread_work *work)
> > >  {
> > > -	int seq = work->queue_seq;
> > > +	struct kthread_flush_work fwork = {
> > > +		KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
> > > +		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> > > +	};
> > > +	struct kthread_worker *worker;
> > > +	bool noop = false;
> > > +
> > 
> > You might want a check for 'work == NULL' here, to gracefully handle
> > code like the following:

> workqueue's flush_work() doesn't allow %NULL pointer.  I don't want to
> make the behaviors deviate and don't see much point in changing
> workqueue's behavior at this point.

OK.  Fair enough.

Thanks.

Regards,
Andy



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
