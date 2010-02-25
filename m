From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] spi/mmc_spi: SPI bus locking
	API, using mutex
Date: Thu, 25 Feb 2010 11:36:01 +0100
Message-ID: <20100225113601.fc8cf2c1.eschwab@online.de>
References: <20100218124425.599c4d76.eschwab@online.de>
	<20100218131057.40f9e623.eschwab@online.de>
	<fa686aa41002241232x6b6d92fci73ce7597c6e38b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa41002241232x6b6d92fci73ce7597c6e38b0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 24 Feb 2010 13:32:43 -0700 Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> On Thu, Feb 18, 2010 at 5:10 AM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
[...]
> > I have concerns on the use of the spin lock around the
> > __spi_async() call, as Mike Frysinger already remarked.
[...]

> I think the spinlock should always be held when calling the bus
> drivers ->transfer() hook.  That will also allow us to remove
> driver-specific locking from the bus drivers.  Otherwise we've got an
> inconsistent locking scheme which is asking for trouble down the road.

Hm, I do not agree to that. I think it is a bad idea to have a spinlock
around a function call that may do a lot of things (we don't know about
it in the spi.c module) and may block multiple CPU cores or disable
interrupts for an indefinite time. The list_for_each_entry(xfer,...)
loop may process many elements, during that time, all other cores are
locked off without need.
The implementation present in the kernel (without patches) apparently
made the assumption, that master->transfer() itself can be called 
from process and interrupt context concurrently and does its own locking.
This is true for the (few) drivers I looked it up.
The list_for_each_entry(xfer, &message->transfers, transfer_list) loop
seems to be safe (although I'm not absolutely sure about it) without 
locking, since it only seems to access data stored in the message passed 
as a function argument.

With our additional spinlocking around the whole stuff we add significant
additional locking time without a need.
I suggest to remove the spinlocking in spi_async (see patch below).

> > But: This all is true for the original design, there seems to be no
> > protection against accidental reentrant use of spi_async().
> 
> spi_async() is intended to be callable from atomic context so that IRQ
> handers can trigger a new transfer without waiting around for it to
> complete.  It is also totally valid for both process and IRQ contexts
> to call spi_async() at the same time, which is exactly why the
> spinlock should be required.

Seems the spinlock is already in master->transfer() (I missed that, because
I checked the wrong function...), so it is valid that multiple contexts
(process, IRQ) call master->transfer() concurrently.
 
> Hmmm.  Are you concerned about a code path where an spi_async() call
> will call the bus driver, which will end up calling spi_async() on
> itself?  I cannot think of a use case where that would be desirable.

No, I didn't think of this - this isn't desirable, I agree.

Regards
Ernst

=8<=====================================================
From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>

Followup-Patch: Remove spin lock around __spi_async call.

Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
---
diff -uprN a/drivers/spi/spi.c b/drivers/spi/spi.c
--- a/drivers/spi/spi.c	2010-02-23 16:51:35.000000000 +0100
+++ b/drivers/spi/spi.c	2010-02-25 11:21:45.000000000 +0100
@@ -731,15 +731,11 @@ int spi_async(struct spi_device *spi, st
 	int ret;
 	unsigned long flags;
 
-	spin_lock_irqsave(&master->bus_lock_spinlock, flags);
-
 	if (master->bus_lock_flag)
 		ret = -EBUSY;
 	else
 		ret = __spi_async(spi, message);
 
-	spin_unlock_irqrestore(&master->bus_lock_spinlock, flags);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_async);




------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
