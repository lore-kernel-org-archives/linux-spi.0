From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/mmc_spi: SPI bus locking
	API, using mutex
Date: Wed, 17 Feb 2010 13:06:36 -0700
Message-ID: <fa686aa41002171206o6cbb7477r7f427ef7be0e8450@mail.gmail.com>
References: <20100217191513.52392dd6.eschwab@online.de>
	<20100217191709.2fd1028c.eschwab@online.de>
	<8bd0f97a1002171103g3e08ee02pf761866f3c57f391@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8bd0f97a1002171103g3e08ee02pf761866f3c57f391-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 17, 2010 at 12:03 PM, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
> On Wed, Feb 17, 2010 at 13:17, Ernst Schwab wrote:
>> The current runtime API looks like this:
>> spi_async(struct spi_device*, struct spi_message*);
>> spi_sync(struct spi_device*, struct spi_message*);
>>
>> The API needs to be extended to this:
>> spi_async(struct spi_device*, struct spi_message*)
>> spi_sync(struct spi_device*, struct spi_message*)
>> spi_bus_lock(struct spi_master*) =A0/* although struct spi_device* might
>> be easier */
>> spi_bus_unlock(struct spi_master*)
>> spi_async_locked(struct spi_device*, struct spi_message*)
>> spi_sync_locked(struct spi_device*, struct spi_message*)
>>
>> Drivers can only call the last two if they already hold the spi_master_l=
ock().
>>
>> spi_bus_lock() obtains the mutex, obtains the spin lock, sets the
>> flag, and releases the spin lock before returning. =A0It doesn't even
>> need to sleep while waiting for "in-flight" spi_transactions to
>> complete because its purpose is to guarantee no additional
>> transactions are added. =A0It does not guarantee that the bus is idle.
>>
>> spi_bus_unlock() clears the flag and releases the mutex, which will
>> wake up any waiters.
>>
>> The difference between spi_async() and spi_async_locked() is that the
>> locked version bypasses the check of the lock flag. =A0Both versions
>> need to obtain the spinlock.
>>
>> The difference between spi_sync() and spi_sync_locked() is that
>> spi_sync() must hold the mutex while enqueuing a new transfer.
>> spi_sync_locked() doesn't because the mutex is already held. =A0Note
>> however that spi_sync must *not* continue to hold the mutex while
>> waiting for the transfer to complete, otherwise only one transfer
>> could be queued up at a time!
>>
>> Almost no code needs to be written. =A0The current spi_async() and
>> spi_sync() can probably be renamed to __spi_async() and __spi_sync()
>> so that spi_async(), spi_sync(), spi_async_locked() and
>> spi_sync_locked() can just become wrappers around the common code.
>>
>> spi_sync() is protected by a mutex because it can sleep
>> spi_async() needs to be protected with a flag and a spinlock because
>> it can be called atomically and must not sleep
>
> i dont think these new "_locked" versions are a good idea. =A0why cant
> it be handled transparently to the caller in the core ? =A0the spi core
> already requires the CS field of the spi device to be unique per bus.
> re-use that to check ownership of the mutex.

No.  the bus locking operation is completely orthogonal to the spi
device being used for the transfer.  A driver could even obtain the
lock, and then use multiple spi_devices to execute transfers before
releasing it.

The API addition is definitely required.  Callers locking the bus
*absolutely* must understand what they are doing.

If anything, I'd consent to a debug option that does a WARN_ON if the
wrong function is called when the bus isn't locked.  ie. _locked
version called when bus isn't locked.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
