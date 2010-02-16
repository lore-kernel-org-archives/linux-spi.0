From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: spi_lock_bus
	and	spi_unlock_bus
Date: Tue, 16 Feb 2010 16:16:12 -0500
Message-ID: <4B7B0B1C.8050407@whoi.edu>
References: <20100216204450.e043eed8.eschwab@online.de>	<20100216205720.ebe949a1.eschwab@online.de>
	<fa686aa41002161243y6e24e439yff54a28cbe295de3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa41002161243y6e24e439yff54a28cbe295de3-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 02/16/2010 03:43 PM, Grant Likely wrote:
> On Tue, Feb 16, 2010 at 12:57 PM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
>> From: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>
>> For some MMC cards over SPI bus, it needs to lock the SPI bus for its own
>> use.  The SPI transfer must not be interrupted by other SPI devices that
>> share the SPI bus with SPI MMC card.
>>
>> This patch introduces 2 APIs for SPI bus locking operation.
> 
> This series seems to try and solve the problem the hard way, and by
> creating a new locking scheme (and as history shows, new locking
> schemes are *alwasy* broken).
> 
> Why is the locking getting pushed down to the bus driver level?  It
> seems to me that the whole thing could be handled with common code and
> a mutex in the spi_master structure.  spi_sync would be easy to handle
> by putting a mutex around the spi_message submission.  spi_async would
> be a little harder since it needs to be atomic, but that could also be
> handled with a flag protected by a spinlock.
> 
> Basically, the idea is that existing drivers continue to use the API as-is
> 
> Drivers that want to lock the bus for exclusive access must call
> spi_lock_bus() which should take the mutex and then sleep until all
> in-flight spi_messages are processed.  After that, anyone calling
> spi_async() will simply sleep until the locker unlocks the bus again.
> 
> To handle spi_sync() would probably require a flag protected by a
> spinlock.  If the flag is set, then spi_sync() would simply fail.
> 
> Finally, the locking driver would need locked versions of spi_sync()
> and spi_async() that sidestep the lock checks.  It would only be valid
> to call these versions when holding the SPI bus lock.
> 
> There is no need to specify the spi_device in the lock request.  Since
> the lock is exclusive, it is known that the only driver calling the
> locked API version must already hold the lock.
> 
> Have I got this wrong?

Not sure.  Does your proposal account for the case of a system with more
than one SPI bus?  In such a case, there should be a lock per bus.

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
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
