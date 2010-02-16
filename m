From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: spi_lock_bus and
	spi_unlock_bus
Date: Tue, 16 Feb 2010 16:23:01 -0700
Message-ID: <fa686aa41002161523v6da23d5dl9952a05e940ea4f2@mail.gmail.com>
References: <20100216204450.e043eed8.eschwab@online.de>
	<20100216205720.ebe949a1.eschwab@online.de>
	<fa686aa41002161243y6e24e439yff54a28cbe295de3@mail.gmail.com>
	<4B7B0B1C.8050407@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4B7B0B1C.8050407-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 16, 2010 at 2:16 PM, Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:
> On 02/16/2010 03:43 PM, Grant Likely wrote:
>> On Tue, Feb 16, 2010 at 12:57 PM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
>>> From: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>>
>>> For some MMC cards over SPI bus, it needs to lock the SPI bus for its o=
wn
>>> use. =A0The SPI transfer must not be interrupted by other SPI devices t=
hat
>>> share the SPI bus with SPI MMC card.
>>>
>>> This patch introduces 2 APIs for SPI bus locking operation.
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
>>
>> Have I got this wrong?
>
> Not sure. =A0Does your proposal account for the case of a system with more
> than one SPI bus? =A0In such a case, there should be a lock per bus.

Yes.  One lock per bus.  In the spi_master structure.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
