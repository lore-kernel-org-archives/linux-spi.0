From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] spi/mmc_spi: SPI bus locking
	API, using mutex
Date: Thu, 25 Feb 2010 18:25:56 +0100
Message-ID: <20100225182556.10b5a3b8.eschwab@online.de>
References: <20100218124425.599c4d76.eschwab@online.de>
	<20100218131057.40f9e623.eschwab@online.de>
	<fa686aa41002241232x6b6d92fci73ce7597c6e38b0@mail.gmail.com>
	<20100225113601.fc8cf2c1.eschwab@online.de>
	<fa686aa41002250838q3189d1e6q828428c521242742@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa41002250838q3189d1e6q828428c521242742-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 25 Feb 2010 09:38:48 -0700 Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> I looked at them all this morning.  Without exception, every single
> driver follows this pattern:
> - [maybe check some stuff]
> - spin_lock_irqsave()
> - list_add_tail()
> - <trigger workqueue or other way to kick off transfer>
> - spin_unlock_irqrestore()
> 
> Yet every driver implements its own transfer list and spin lock in the
> private data structure.  That says to me that the spi layer is
> abstracting at the wrong level.  I'm cautious about taking away the
> ability for drivers to make their own decisions about how to manage
> transfers, but it seems like the transfer queue and spin lock should
> be provided by the common code.  The trick is how to do it while
> providing a migration path for drivers.
> 
> One option is to deprecate the ->transfer hook and allow drivers to
> provide a .request() hook to signal the driver that new transfers have
> been added to the list.  Something like how the block layer works.
> That would keep the critical region in spi_async() small.  Another
> option is to let drivers provide a .prepare() hook that validates and
> prepares a message before entering the critical region.  The
> .prepare() option is probably the simplest to implement and has the
> lowest impact on existing device drivers to use the new functionality,
> but the .request() option might be better in the long run.

I'd vote for the .request() hook.

> The spinlock is absolutely required.  Otherwise the test of
> bus_lock_flag is racy.  
[...]
> See?  Without the spinlock there is nothing preventing B3 from getting
> called in the midst of A's bus lock.

Ok, now, I see; an interrupt being executed on a different core than
the process context will manage it to malfunction if the spinlock is
missing.

> > A possible solution would be to add an extra queue, handled in the
> > spi.c module, stored in the master's data structure, that stores all
> > messages coming in while the bus lock is active. The queue can be
> > flushed by calling __spi_async() for each message as soon as the bus
> > lock is removed.
> 
> That also works.  In fact, this would work well with the .request()
> hook suggestion I made above because when the lock is removed, the
> delayed list could just be appended to the normal request list.  A
> .prepare() hook would also be useful because the message can still be
> pre-checked for validity outside of the critical region before being
> added to the delay list.

Maybe all of the list/queue handling should be done in spi.c, and (inline) 
functions in spi.h; then, the driver could call a 'spi_get_next_message()' 
function and will get a message out of one of the two queues:

spi_sync_locked() and spi_async_locked() 
	will add to 'direct' queue, and call .request()
spi_sync() and spi_async()
        will add to 'delayed' queue if spi bus is locked
 	will add to 'direct' queue if unlocked, and call .request()
 
spi_bus_unlock() 
        will append entire 'delayed' to 'direct' queue, and call .request()

spi_get_next_message()
	will get next message from 'direct' queue
 
> If you want to attempt this, maintain it as a separate patch on top of
> the core bus locking patch.

I will look at it if I find the time...

Regards 
Ernst

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
