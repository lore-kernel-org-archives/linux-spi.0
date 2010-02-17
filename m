From: "Ernst Schwab" <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: spi_lock_bus and
	spi_unlock_bus
Date: Wed, 17 Feb 2010 01:16:44 +0100
Message-ID: <552DB282258F46CE995A09EF352B1094@pces>
References: <20100216204450.e043eed8.eschwab@online.de>
	<20100216205720.ebe949a1.eschwab@online.de>
	<fa686aa41002161243y6e24e439yff54a28cbe295de3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Grant Likely wrote:

> This series seems to try and solve the problem the hard way, and by
> creating a new locking scheme (and as history shows, new locking
> schemes are *alwasy* broken).
> Why is the locking getting pushed down to the bus driver level?  

The proposal, as well as the proposal of the underlying patches
for the blackfin uClinux solution, wants to minimize the risk
introduced by changes to the SPI layer - it tries to be as
noninvasive as possible.
Thus, it allows the use of the mmc_spi driver under the same conditions
as before (only one SPI device present), and makes its use even
safer than before - in case an SPI device is registered after the mmc_spi
driver. 
The mechanism to have the atomic transmission of SPI sequences moved 
to the SPI master driver is existent in (now) two master drivers 
and working, and until now, we have only the choice between
the "ASSUMING SPI bus stays unshared!/can't share SPI bus" 
pestilence now present in the kernel and the "need to modify the 
SPI master" cholera. 
I think anything beyond this would be a new locking scheme, which...

> It
> seems to me that the whole thing could be handled with common code and
> a mutex in the spi_master structure.  spi_sync would be easy to handle
> by putting a mutex around the spi_message submission.  spi_async would
> be a little harder since it needs to be atomic, but that could also be
> handled with a flag protected by a spinlock.

Maybe, but who can implement that in a quality required to make it to
the kernel? Any volunteers ;-)? I will test it.

> There is no need to specify the spi_device in the lock request.  Since
> the lock is exclusive, it is known that the only driver calling the
> locked API version must already hold the lock.

On multiple SPI buses, there can be one lock per master, as Ned mentioned.

I want to summarize the properties of the suggested patches:

- with only one SPI device requiring the locking (the mmc_spi), 
  the patches should not cause any change in timing / locking / sleeping,
  neither with an unmodified SPI master nor with a modified.
- with multiple SPI devices not requiring the locking, the patches
  should not cause any change in timing / locking / sleeping,
  neither with an unmodified SPI master nor with a modified.
- if the mmc_spi driver is registered before other SPI devices, 
  used with an unmodified master, malfunction or data loss will now
  be prevented by disabling the SPI devices coming after the mmc_spi; 
  the current solution is not able to do so beside the "ASSUMING SPI 
  bus stays unshared!" message.
- the mmc_spi driver is working together with other SPI devices and a
  modified master - two modified masters exist.
- the spi_lock_bus calls added to the mmc_spi can be used for an advanced
  locking scheme (any volunteers?)

For me, there seems to be no disadvantage in having this or a similar
solution as an intermediate step to the perfect solution 
(any volunteers?). 

Regards
Ernst

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
