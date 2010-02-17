From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: spi_lock_bus and
	spi_unlock_bus
Date: Tue, 16 Feb 2010 20:48:08 -0700
Message-ID: <fa686aa41002161948o31a48fc9kac263b0ac34f1a8d@mail.gmail.com>
References: <20100216204450.e043eed8.eschwab@online.de>
	<20100216205720.ebe949a1.eschwab@online.de>
	<fa686aa41002161243y6e24e439yff54a28cbe295de3@mail.gmail.com>
	<8bd0f97a1002161607m3c748ccegaffb83c42667287a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8bd0f97a1002161607m3c748ccegaffb83c42667287a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 16, 2010 at 5:07 PM, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
> On Tue, Feb 16, 2010 at 15:43, Grant Likely wrote:
>> On Tue, Feb 16, 2010 at 12:57 PM, Ernst Schwab wrote:
>>> From: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>>
>>> For some MMC cards over SPI bus, it needs to lock the SPI bus for its o=
wn
>>> use. =A0The SPI transfer must not be interrupted by other SPI devices t=
hat
>>> share the SPI bus with SPI MMC card.
>>>
>>> This patch introduces 2 APIs for SPI bus locking operation.
>>>
>>> Signed-off-by: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>> Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>> Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
>>> ---
>>> Andrew: we've posted these in the past with no response. =A0could you p=
ick
>>> =A0 =A0 =A0 =A0them up please ?
>>> =A0drivers/spi/spi.c =A0 =A0 =A0 | =A0 48 +++++++++++++++++++++++++++++=
++++++++++++++++++
>>> =A0include/linux/spi/spi.h | =A0 =A07 ++++++
>>> =A02 files changed, 55 insertions(+), 0 deletions(-)
>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>>> index 70845cc..b82b8ad 100644
>>> --- a/drivers/spi/spi.c
>>> +++ b/drivers/spi/spi.c
>>> @@ -653,6 +653,54 @@ static void spi_complete(void *arg)
>>> =A0}
>>>
>>> =A0/**
>>> + * spi_lock_bus - lock SPI bus for exclusive access
>>> + * @spi: device which want to lock the bus
>>> + * Context: any
>>> + *
>>> + * Once the caller owns exclusive access to the SPI bus,
>>> + * only messages for this device will be transferred.
>>> + * Messages for other devices are queued but not transferred until
>>> + * the bus owner unlock the bus.
>>> + *
>>> + * The caller may call spi_lock_bus() before spi_sync() or spi_async().
>>> + * So this call may be used in irq and other contexts which can't slee=
p,
>>> + * as well as from task contexts which can sleep.
>>> + *
>>> + * It returns zero on success, else a negative error code.
>>> + */
>>> +int spi_lock_bus(struct spi_device *spi)
>>> +{
>>> + =A0 =A0 =A0 if (spi->master->lock_bus)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return spi->master->lock_bus(spi);
>>> + =A0 =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(spi_lock_bus);
>>
>> This series seems to try and solve the problem the hard way, and by
>> creating a new locking scheme (and as history shows, new locking
>> schemes are *alwasy* broken).
>>
>> Why is the locking getting pushed down to the bus driver level? =A0It
>> seems to me that the whole thing could be handled with common code and
>> a mutex in the spi_master structure. =A0spi_sync would be easy to handle
>> by putting a mutex around the spi_message submission. =A0spi_async would
>> be a little harder since it needs to be atomic, but that could also be
>> handled with a flag protected by a spinlock.
>>
>> Basically, the idea is that existing drivers continue to use the API as-=
is
>>
>> Drivers that want to lock the bus for exclusive access must call
>> spi_lock_bus() which should take the mutex and then sleep until all
>> in-flight spi_messages are processed. =A0After that, anyone calling
>> spi_async() will simply sleep until the locker unlocks the bus again.
>>
>> To handle spi_sync() would probably require a flag protected by a
>> spinlock. =A0If the flag is set, then spi_sync() would simply fail.
>>
>> Finally, the locking driver would need locked versions of spi_sync()
>> and spi_async() that sidestep the lock checks. =A0It would only be valid
>> to call these versions when holding the SPI bus lock.
>>
>> There is no need to specify the spi_device in the lock request. =A0Since
>> the lock is exclusive, it is known that the only driver calling the
>> locked API version must already hold the lock.
>
> this is what i proposed last time, but we havent gotten around to
> implementing it:
>
> there's nothing Blackfin-specific in the implementation of these
> functions. =A0i think the way we should be handling these is by doing:
> =A0- remove {lock,unlock}_bus functions from spi_master
> =A0- move the {lock,unlock}_bus code from spi_bfin5xx.c to spi.c
> =A0- drop the SPI_BFIN_LOCK Kconfig

Am I missing something. I cannot find any lock related functions in
the spi code.  Is this stuff in mainline?

g.

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
