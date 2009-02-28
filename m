From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/2] spi: Add support for
	non-blocking synchronous transfers
Date: Sat, 28 Feb 2009 15:19:55 -0800
Message-ID: <200902281519.55341.david-b@pacbell.net>
References: <20090228081036.31964.80618.stgit@fedora.yogi>
	<200902281233.50612.david-b@pacbell.net>
	<20090228221247.GA3107@fedora.yogi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andy Green <andy-4Bgg8jF3iZdWk0Htik3J/w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Balaji Rao <balajirrao-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090228221247.GA3107-bnrf61MYqdMYW0ZX77RX+A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Saturday 28 February 2009, Balaji Rao wrote:
> On Sat, Feb 28, 2009 at 12:33:50PM -0800, David Brownell wrote:
> > Note that $SUBJECT concept is nonsense.
> > Synchronous calls are by definition blocking ones...
> 
> FWIW, it is exactly this that we want to change.

This seems like

#define UP	DOWN
#define GOOD	BAD
#define LEFT	RIGHT
#define 1	2

... etc ...

How can you possibly be synchronous without blocking the
caller?


> > On Saturday 28 February 2009, Balaji Rao wrote:
> > > During the course of development of an accelerometer driver, we saw the
> > > necessity to execute spi transfers synchronously within an interrupt handler.
> > 
> > This sounds like a bad design.  How can you know that no other
> > transfers are going on ... or are queued in front of the transfer
> > you're requesting?
> > 
> > You'd need to wait for all the other transfers to work their
> > way through the transfer queue.  There are *much* better things
> > to do in interrupt handlers.
> > 
> 
> Please do look at the patches. We *don't* use a transfer queue.

Another example of a conceptual bug.  Because SPI is a shared
bus, transfers to some other device may be happening when you
issue a request.  And accordingly, you'd need to wait for that
transfer to complete.  The SPI I/O queue is at least a logical
abstraction for that reality.  I have a hard time imagining any
spi_master driver not having some kind of queue data structure.

Plus, see Documentation/spi/spi-summary:

| SPI requests always go into I/O queues.  Requests for a given SPI device
| are always executed in FIFO order, and complete asynchronously through
| completion callbacks.  There are also some simple synchronous wrappers
| for those calls, including ones for common transaction types like writing
| a command and then reading its response.

Note that the queueing discipline is explicitly unspecified,
except in the context of a given spi_device.  If you want
your spi_master controller to prioritize one device, that's
fine ... but it's not part of the interface used by portable
drivers (it'd be platform-specific).


> Transfers requested through our proposed function should/will complete the
> transfer when it returns without sleeping in between. (Which is the whole
> point of this patch).

So instead of "non-blocking" you mean "non-sleeping".

That leaves un-answered the question of what to do when
the SPI bus is busy performing some other transfer.  I
looked at your [2/2] patch, and saw it ignoring that very
basic issue ... this new call will just poke at the bus,
trashing any transfer that was ongoing.

I hope you understand why that would be bad.  It can
cause data corruption, and in some cases worse (like
hardware damage).

 
> > > When using a workqueue instead, we observed a huge number of overruns
> > > with very high cpu utlization, which is unacceptable.
> > 
> > Sure, but at least part of that seems to be caused by some
> > broken design assumptions.
> > 
> 
> No, it's not. Read below.

I've already identified several broken assumptions you
have made; so "part of that" seems pretty clearly right.

 
> > Why are you even trying to touch SPI devices from hardirq
> > context?  That's never going to be OK; "can't-sleep" contexts
> > don't mix with "must-sleep" calls.
> 
> Accelerometers can produce a huge amount of data and we need to quickly
> read them to avoid overruns. Also, scheduling workers for this greatly
> increases the number of context switches, unnecessarily.

That sounds like a performance issue with the spi_master driver
you're using.  Using the bitbang framework, and worker tasks, is
a good way to get something going quickly.  But if I wanted high
performance, I'd likely use a more traditional driver structure
(with no tasks, IRQ driven, DMA).  Or I might just increase the
priority of the relevant tasks; depends on what bottlenecks turn
up when I measure things.

That might combine with sub-optimal design for your accelerometer
driver or hardware.  Can you keep multiple transfers queued?  Are
you using async messaging intelligently?


> > > This series adds a new interface for this and modifies no existing ones.
> > 
> > NAK on these two patches.
> > 
> 
> Ok, it will be helpful if you please suggest an alternative keeping in
> mind the huge amount of data produced by the accelerometer and the need
> to read them quickly ?

If your spi_master driver isn't using DMA, fix that.  Nothing
else addresses "huge amount of data" well at all.

If some driver -- spi_master, accelerometer, or whatever -- is
introducing context switch delays in critical paths, get rid of
those.  The gap between one DMA transfer and the next can be on
the order of one IRQ latency, using current interfaces, if the
drivers are decently written.

- Dave

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
