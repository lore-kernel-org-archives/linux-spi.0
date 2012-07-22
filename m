From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] kthread_worker: reimplement flush_kthread_work()
	to allow freeing the work item being executed
Date: Sun, 22 Jul 2012 09:49:53 -0700
Message-ID: <20120722164953.GC5144@dhcp-172-17-108-109.mtv.corp.google.com>
References: <20120719211510.GA32763@google.com>
	<20120719211629.GC32763@google.com>
	<1342894814.2504.31.camel@palomino.walls.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	ivtv-devel-jGorlIydJmRM656bX5wj8A@public.gmane.org, Avi Kivity <avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Walls <awalls-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1342894814.2504.31.camel-xioobY1GIEhKttHedORAlB2eb7JE58TQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello,

On Sat, Jul 21, 2012 at 02:20:06PM -0400, Andy Walls wrote:
> > +	worker->current_work = work;
> >  	spin_unlock_irq(&worker->lock);
> >  
> >  	if (work) {
> >  		__set_current_state(TASK_RUNNING);
> >  		work->func(work);
> 
> If the call to 'work->func(work);' frees the memory pointed to by
> 'work', 'worker->current_work' points to deallocated memory.
> So 'worker->current_work' will only ever used as a unique 'work'
> identifier to handle, correct?

Yeah.  flush_kthread_work(@work) which can only be called if @work is
known to be alive looks at the pointer to determine whether it's the
current work item on the worker.

> >  void flush_kthread_work(struct kthread_work *work)
> >  {
> > -	int seq = work->queue_seq;
> > +	struct kthread_flush_work fwork = {
> > +		KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
> > +		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> > +	};
> > +	struct kthread_worker *worker;
> > +	bool noop = false;
> > +
> 
> You might want a check for 'work == NULL' here, to gracefully handle
> code like the following:
> 
> void driver_work_handler(struct kthread_work *work)
> {
> 	...
> 	kfree(work);
> }
> 
> struct kthread_work *driver_queue_batch(void)
> {
> 	struct kthread_work *work = NULL;
> 	...
> 	while (driver_more_stuff_todo()) {
> 		work = kzalloc(sizeof(struct kthread work), GFP_WHATEVER);
> 		...
> 		queue_kthread_work(&driver_worker, work);
> 	}
> 	return work;
> }
> 
> void driver_foobar(void)
> {
> 	...
> 	flush_kthread_work(driver_queue_batch());
> 	...
> }

workqueue's flush_work() doesn't allow %NULL pointer.  I don't want to
make the behaviors deviate and don't see much point in changing
workqueue's behavior at this point.

Thanks.

-- 
tejun

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
