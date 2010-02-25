From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] spi/mmc_spi: SPI bus locking
 API, using mutex
Date: Thu, 25 Feb 2010 14:07:48 -0500
Message-ID: <4B86CA84.5030705@whoi.edu>
References: <20100218124425.599c4d76.eschwab@online.de>	<20100218131057.40f9e623.eschwab@online.de>
	<fa686aa41002241232x6b6d92fci73ce7597c6e38b0@mail.gmail.com>
	<20100225113601.fc8cf2c1.eschwab@online.de>
	<fa686aa41002250838q3189d1e6q828428c521242742@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
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

On 02/25/2010 11:38 AM, Grant Likely wrote:
> On Thu, Feb 25, 2010 at 3:36 AM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
>> On Wed, 24 Feb 2010 13:32:43 -0700 Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>>> On Thu, Feb 18, 2010 at 5:10 AM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
>> [...]
>>>> I have concerns on the use of the spin lock around the
>>>> __spi_async() call, as Mike Frysinger already remarked.
>> [...]
>>
>>> I think the spinlock should always be held when calling the bus
>>> drivers ->transfer() hook.  That will also allow us to remove
>>> driver-specific locking from the bus drivers.  Otherwise we've got an
>>> inconsistent locking scheme which is asking for trouble down the road.
>>
>> Hm, I do not agree to that. I think it is a bad idea to have a spinlock
>> around a function call that may do a lot of things (we don't know about
>> it in the spi.c module) and may block multiple CPU cores or disable
>> interrupts for an indefinite time. The list_for_each_entry(xfer,...)
>> loop may process many elements, during that time, all other cores are
>> locked off without need.
>> The implementation present in the kernel (without patches) apparently
>> made the assumption, that master->transfer() itself can be called
>> from process and interrupt context concurrently and does its own locking.
>> This is true for the (few) drivers I looked it up.
>> The list_for_each_entry(xfer, &message->transfers, transfer_list) loop
>> seems to be safe (although I'm not absolutely sure about it) without
>> locking, since it only seems to access data stored in the message passed
>> as a function argument.
> 
> I looked at them all this morning.  Without exception, every single
> driver follows this pattern:
> - [maybe check some stuff]
> - spin_lock_irqsave()
> - list_add_tail()
> - <trigger workqueue or other way to kick off transfer>
> - spin_unlock_irqrestore()

I am only familiar with the px2xx_spi.c driver.  This driver has a lock
in ->transfer() that is constructed as above.  The lock protects
internal data structures that are shared between ->transfer(), a
workqueue that pulls the next message from the queue, and a tasklet that
prepares each transfer within a message for processing by the hardware
and returns any completed messages.  In addition to the list_add_tail()
mentioned above, there is also private (perhaps could be public) message
state information that gets set.

As a side note: I noticed that the data being protected in ->transfer()
is only accessed in workqueue and tasklet context, never in interrupt
context.  Thus, in my (greatly extended) private version of
pxa2xx_spi.c, I added a new lock to the private driver data and swapped
the spinlock_irqsave for spinlock_bh in all places that protect the
message queue and state, so that there would be less (however small)
impact on hardware interrupts.

> Yet every driver implements its own transfer list and spin lock in the
> private data structure.  That says to me that the spi layer is
> abstracting at the wrong level.  I'm cautious about taking away the
> ability for drivers to make their own decisions about how to manage
> transfers, but it seems like the transfer queue and spin lock should
> be provided by the common code.  The trick is how to do it while
> providing a migration path for drivers.

I don't see how migrating the queue and locking to the core saves a lot.
 You still need a queue per controller driver.  It would provide
standardization of the function, but the function is not complicated, as
you point out above.  Most of the manipulation of the queue still exists
inside the driver. The existing spi core design allows drivers to add
whatever other state information they need within the same lock.  I'm
not sure if every driver's private state is standard enough that it
could become public.  If not, it is important (helpful, required?) that
the state be updated atomically with the queue entry.

> One option is to deprecate the ->transfer hook and allow drivers to
> provide a .request() hook to signal the driver that new transfers have
> been added to the list.  Something like how the block layer works.
> That would keep the critical region in spi_async() small.  Another
> option is to let drivers provide a .prepare() hook that validates and
> prepares a message before entering the critical region.  The
> .prepare() option is probably the simplest to implement and has the
> lowest impact on existing device drivers to use the new functionality,
> but the .request() option might be better in the long run.

You definitely need something like .prepare, if this change is made.  As
David Brownell has pointed out in the past, the driver is responsible
for rejecting any message that it cannot implement, preferably at the
time ->transfer() is called.  This principal is not universally
implemented in all drivers (pxa2xx_spi rejects some messages at the time
it tries to execute a transfer, rather than checking the whole message
when queued, as it should).  Reasons for rejection include
unimplementable: clock speed, length, bits/word, etc.  Only the driver
knows the capability of the hardware; that function cannot be centralized.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
