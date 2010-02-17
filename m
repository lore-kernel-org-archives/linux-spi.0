From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: spi_lock_bus and
	spi_unlock_bus
Date: Tue, 16 Feb 2010 21:32:53 -0700
Message-ID: <fa686aa41002162032l2a2bc065t1f53d7b79760b2dd@mail.gmail.com>
References: <20100216204450.e043eed8.eschwab@online.de>
	<20100216205720.ebe949a1.eschwab@online.de>
	<fa686aa41002161243y6e24e439yff54a28cbe295de3@mail.gmail.com>
	<552DB282258F46CE995A09EF352B1094@pces>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <552DB282258F46CE995A09EF352B1094@pces>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 16, 2010 at 5:16 PM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
> Grant Likely wrote:
>
>> This series seems to try and solve the problem the hard way, and by
>> creating a new locking scheme (and as history shows, new locking
>> schemes are *alwasy* broken).
>> Why is the locking getting pushed down to the bus driver level?
>
> The proposal, as well as the proposal of the underlying patches
> for the blackfin uClinux solution, wants to minimize the risk
> introduced by changes to the SPI layer - it tries to be as
> noninvasive as possible.

It sounds like you're very worried about making changes to the core
code, and jumping through hopes to push as much as possible out to the
device drivers (working around instead of fixing a limitation of the
SPI bus infrastructure).  However, it ends up being ugly, complex, and
probably wrong.

Simplicity and correctness is far more important that trying to avoid
churn in the core code.  It is far better to change the core code
because then you'll get more testing and review, and you'll reduce the
burden on driver writers.

> Thus, it allows the use of the mmc_spi driver under the same conditions
> as before (only one SPI device present), and makes its use even
> safer than before - in case an SPI device is registered after the mmc_spi
> driver. The mechanism to have the atomic transmission of SPI sequences mo=
ved
> to the SPI master driver is existent in (now) two master drivers and
> working, and until now, we have only the choice between
> the "ASSUMING SPI bus stays unshared!/can't share SPI bus" pestilence now
> present in the kernel and the "need to modify the SPI master" cholera. I
> think anything beyond this would be a new locking scheme, which...
>
>> It
>> seems to me that the whole thing could be handled with common code and
>> a mutex in the spi_master structure. =A0spi_sync would be easy to handle
>> by putting a mutex around the spi_message submission. =A0spi_async would
>> be a little harder since it needs to be atomic, but that could also be
>> handled with a flag protected by a spinlock.
>
> Maybe, but who can implement that in a quality required to make it to
> the kernel? Any volunteers ;-)? I will test it.

You do it.  You write good code.  You're just approaching the problem
from the wrong angle.  You may not get it right on the first posting,
but there are lots of people who are here who will help you and
review.  As long as you are responsive to review you will do just
fine.

It will require 2 patches, plus another cleanup patch for each
spi_master driver.

1) add new locking API and implementation to core SPI code
- no drivers or mmc stuff has to change at this point

2) make mmc layer use the new api and remove the old hacks
- Clean cutover to new locking scheme.  Immediately stops using old
driver-specific hacks

3) remove the old hacks from spi_master driver
- because now the code isn't used anymore.  (But as far as I can tell,
none of this is actually mainlined, so this might not be necessary).
- However, by moving locking into the spi core, it may be that
spi_master drivers can become simpler and remove a lot of driver-local
locking.
- Regardless, neither patch 1 nor 2 force changes to the spi_master drivers.

In fact, now that I've had an evening to think about it, the solution
is even simpler than what I said earlier.  It requires 3 things to be
added to struct spi_master.
- 1 Mutex
- 1 spin lock
- 1 flag.

The mutex protects spi_async, and provides sleeping "for free"
The spinlock protects the atomic spi_sync call.
The flag is set when the lock is obtained, and checked while holding
the spinlock in spi_sync().  If the flag is checked, then spi_sync()
must fail immediately.

The current runtime API looks like this:
spi_sync(struct spi_device*, struct spi_message*);
spi_async(struct spi_device*, struct spi_message*);

The API needs to be extended to this:
spi_sync(struct spi_device*, struct spi_message*)
spi_async(struct spi_device*, struct spi_message*)
spi_bus_lock(struct spi_master*)  /* although struct spi_device* might
be easier */
spi_bus_unlock(struct spi_master*)
spi_sync_locked(struct spi_device*, struct spi_message*)
spi_async_locked(struct spi_device*, struct spi_message*)

Drivers can only call the last two if they already hold the spi_master_lock=
().

spi_bus_lock() obtains the mutex, obtains the spin lock, sets the
flag, and releases the spin lock before returning.  It doesn't even
need to sleep while waiting for "in-flight" spi_transactions to
complete because its purpose is to guarantee no additional
transactions are added.  It does not guarantee that the bus is idle.

spi_bus_unlock() clears the flag and releases the mutex, which will
wake up any waiters.

The difference between spi_sync() and spi_sync_locked() is that the
locked version bypasses the check of the lock flag.  Both versions
need to obtain the spinlock.

The difference between spi_async() and spi_async_locked() is that
spi_async() must hold the mutex while enqueuing a new transfer.
spi_async_locked() doesn't because the mutex is already held.  Note
however that spi_async must *not* continue to hold the mutex while
waiting for the transfer to complete, otherwise only one transfer
could be queued up at a time!

Almost no code needs to be written.  The current spi_sync() and
spi_async() can probably be renamed to __spi_sync() and __spI_async()
so that spi_sync(), spi_async(), spi_sync_locked() and
spi_async_locked() can just become wrappers around the common code.

That's it.  Easy to implement, low risk, simple and above all passes
the correctness test.

> For me, there seems to be no disadvantage in having this or a similar
> solution as an intermediate step to the perfect solution (any volunteers?=
).

The intermediate step is worse that the current situation.  It reduces
the pain for some users (which reduces motivation) while complicating
the code and inventing a new (and guaranteed to be subtly broken)
locking scheme.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
