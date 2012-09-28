From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHSET] kthread_worker: reimplement flush_kthread_work() to
	allow freeing during execution
Date: Thu, 27 Sep 2012 17:19:11 -0700
Message-ID: <20120928001911.GL29949@kroah.com>
References: <20120719211510.GA32763@google.com>
	<CAMbhsRQs+2MCXq0M-eTeezwPR=KMnBKtJny1rjiUJL-wNYctMQ@mail.gmail.com>
	<20120917194016.GI18677@google.com>
	<20120917202850.GA18910@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andy Walls <awalls-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, ivtv-devel-jGorlIydJmRM656bX5wj8A@public.gmane.org,
	Avi Kivity <avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120917202850.GA18910-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 17, 2012 at 01:28:50PM -0700, Greg KH wrote:
> On Mon, Sep 17, 2012 at 12:40:16PM -0700, Tejun Heo wrote:
> > On Fri, Sep 14, 2012 at 03:50:40PM -0700, Colin Cross wrote:
> > > This patch set fixes a reproducible crash I'm seeing on a 3.4.10
> > > kernel.  flush_kthread_worker (which is different from
> > > flush_kthread_work) is initializing a kthread_work and a completion on
> > > the stack, then queuing it and calling wait_for_completion.  Once the
> > > completion is signaled, flush_kthread_worker exits and the stack
> > > region used by the kthread_work may be immediately reused by another
> > > object on the stack, but kthread_worker_fn continues accessing its
> > > work pointer:
> > >                 work->func(work);         <- calls complete,
> > > effectively frees work
> > >                 smp_wmb();      /* wmb worker-b0 paired with flush-b1 */
> > >                 work->done_seq = work->queue_seq;   <- overwrites a
> > > new stack object
> > >                 smp_mb();       /* mb worker-b1 paired with flush-b0 */
> > >                 if (atomic_read(&work->flushing))
> > >                         wake_up_all(&work->done);  <- or crashes here
> > > 
> > > These patches fix the problem by not accessing work after work->func
> > > is called, and should be backported to stable.  They apply cleanly to
> > > 3.4.10.  Upstream commits are 9a2e03d8ed518a61154f18d83d6466628e519f94
> > > and 46f3d976213452350f9d10b0c2780c2681f7075b.
> > 
> > Yeah, you're right.  I wonder why this didn't come up before.  Greg,
> > can you please pick up these two commits?
> 
> Ok, will do, thanks for letting me know.

Now applied, thanks.

greg k-h

------------------------------------------------------------------------------
Got visibility?
Most devs has no idea what their production app looks like.
Find out how fast your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219671;13503038;y?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
