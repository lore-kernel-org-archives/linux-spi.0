From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] spi/mmc_spi: SPI bus locking
	API, using mutex
Date: Thu, 25 Feb 2010 09:38:48 -0700
Message-ID: <fa686aa41002250838q3189d1e6q828428c521242742@mail.gmail.com>
References: <20100218124425.599c4d76.eschwab@online.de>
	<20100218131057.40f9e623.eschwab@online.de>
	<fa686aa41002241232x6b6d92fci73ce7597c6e38b0@mail.gmail.com>
	<20100225113601.fc8cf2c1.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100225113601.fc8cf2c1.eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Feb 25, 2010 at 3:36 AM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
> On Wed, 24 Feb 2010 13:32:43 -0700 Grant Likely <grant.likely@secretlab.c=
a> wrote:
>> On Thu, Feb 18, 2010 at 5:10 AM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
> [...]
>> > I have concerns on the use of the spin lock around the
>> > __spi_async() call, as Mike Frysinger already remarked.
> [...]
>
>> I think the spinlock should always be held when calling the bus
>> drivers ->transfer() hook. =A0That will also allow us to remove
>> driver-specific locking from the bus drivers. =A0Otherwise we've got an
>> inconsistent locking scheme which is asking for trouble down the road.
>
> Hm, I do not agree to that. I think it is a bad idea to have a spinlock
> around a function call that may do a lot of things (we don't know about
> it in the spi.c module) and may block multiple CPU cores or disable
> interrupts for an indefinite time. The list_for_each_entry(xfer,...)
> loop may process many elements, during that time, all other cores are
> locked off without need.
> The implementation present in the kernel (without patches) apparently
> made the assumption, that master->transfer() itself can be called
> from process and interrupt context concurrently and does its own locking.
> This is true for the (few) drivers I looked it up.
> The list_for_each_entry(xfer, &message->transfers, transfer_list) loop
> seems to be safe (although I'm not absolutely sure about it) without
> locking, since it only seems to access data stored in the message passed
> as a function argument.

I looked at them all this morning.  Without exception, every single
driver follows this pattern:
- [maybe check some stuff]
- spin_lock_irqsave()
- list_add_tail()
- <trigger workqueue or other way to kick off transfer>
- spin_unlock_irqrestore()

Yet every driver implements its own transfer list and spin lock in the
private data structure.  That says to me that the spi layer is
abstracting at the wrong level.  I'm cautious about taking away the
ability for drivers to make their own decisions about how to manage
transfers, but it seems like the transfer queue and spin lock should
be provided by the common code.  The trick is how to do it while
providing a migration path for drivers.

One option is to deprecate the ->transfer hook and allow drivers to
provide a .request() hook to signal the driver that new transfers have
been added to the list.  Something like how the block layer works.
That would keep the critical region in spi_async() small.  Another
option is to let drivers provide a .prepare() hook that validates and
prepares a message before entering the critical region.  The
.prepare() option is probably the simplest to implement and has the
lowest impact on existing device drivers to use the new functionality,
but the .request() option might be better in the long run.

> With our additional spinlocking around the whole stuff we add significant
> additional locking time without a need.
> I suggest to remove the spinlocking in spi_async (see patch below).

The spinlock is absolutely required.  Otherwise the test of
bus_lock_flag is racy.  For example, in the mmc case, a non-mmc
message could get queued after the mmc code obtains the bus lock.
Consider two threads, A & B.  A is running mmc code.  Consider the
following sequence of events:

A1: obtain mutex
A2: obtain spinlock
A3: set flag
A4: release spinlock
A5: call async_transfer_locked()
A6: call async_transfer_locked()
A7: call async_transfer_locked()
A8: clear flag
A9: release mutex

B1: obtain spinlock
B2: check flag; bail if set
B3: call .transfer() hook
B4: release spinlock

In this case, there is no way for the B-3 transfer to occur between
A-2 and A8.  However, if B1 and B4 are omitted, you can get this
sequence:

A1: obtain mutex
A2: obtain spinlock
B2: check flag; bail if set
A3: set flag
A4: release spinlock
A5: call async_transfer_locked()
B3: call .transfer() hook
A6: call async_transfer_locked()
A7: call async_transfer_locked()
A8: clear flag
A9: release mutex

See?  Without the spinlock there is nothing preventing B3 from getting
called in the midst of A's bus lock.

>> > But: This all is true for the original design, there seems to be no
>> > protection against accidental reentrant use of spi_async().
>>
>> spi_async() is intended to be callable from atomic context so that IRQ
>> handers can trigger a new transfer without waiting around for it to
>> complete. =A0It is also totally valid for both process and IRQ contexts
>> to call spi_async() at the same time, which is exactly why the
>> spinlock should be required.
>
> Seems the spinlock is already in master->transfer() (I missed that, becau=
se
> I checked the wrong function...), so it is valid that multiple contexts
> (process, IRQ) call master->transfer() concurrently.

On Thu, Feb 25, 2010 at 3:57 AM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
> Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
>
>>  int spi_async(struct spi_device *spi, struct spi_message *message)
>>  {
> [...]
>> +     if (master->bus_lock_flag)
>> +             ret =3D -EBUSY;
>> +     else
>> +             ret =3D __spi_async(spi, message);
>>
>> +     return ret;
>>  }
>
> I'm still not satisfied with this.
>
> The code present in the kernel (without patches) allows spi_async() to be
> called concurrently from interrupt context and process context, without
> any loss of data.
>
> With the first patch attempt (bus lock implemented in the master driver)
> no messages were lost during the bus lock.
>
> With the current patch, drivers calling spi_async() from the interrupt
> context (are there any??) will get an error code, which they cannot
> handle without adding additional queuing code in the driver.

Yes there are.  I've written drivers that submit new SPI messages at
IRQ context.

> A possible solution would be to add an extra queue, handled in the
> spi.c module, stored in the master's data structure, that stores all
> messages coming in while the bus lock is active. The queue can be
> flushed by calling __spi_async() for each message as soon as the bus
> lock is removed.

That also works.  In fact, this would work well with the .request()
hook suggestion I made above because when the lock is removed, the
delayed list could just be appended to the normal request list.  A
.prepare() hook would also be useful because the message can still be
pre-checked for validity outside of the critical region before being
added to the delay list.

If you want to attempt this, maintain it as a separate patch on top of
the core bus locking patch.

Cheers,
g.

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
