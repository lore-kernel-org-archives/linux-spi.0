From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Spinlock vs mutexes for spi network driver
Date: Thu, 18 Mar 2010 13:28:17 -0400
Message-ID: <4BA262B1.5050001@whoi.edu>
References: <20100317204915.GB6358@canoga.com> <4BA14970.3050603@whoi.edu>
	<20100318164641.GA22298@canoga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Amit Uttamchandani <amit.uttam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100318164641.GA22298-QCuvCd35e3/QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 03/18/2010 12:46 PM, Amit Uttamchandani wrote:
> On Wed, Mar 17, 2010 at 05:28:16PM -0400, Ned Forrester wrote:
> 
> [...]
> 
>> If I recall correctly, the work queue does NOT run in interrupt context
>> (are allowed to sleep), and therefore mutexs are permitted (for locking
>> with other non-interrupt activity).  The interrupt handler definitely
>> runs in interrupt context.  If the locking protects data that is shared
>> between interrupt context and non-interrupt context, then it will have
>> to be done with a spinlock.  pxa2xx_spi.c (the driver I am familiar
>> with) does not use any mutexes, because the protected data structure is
>> used in the interrupt handlers.
>>
> 
> Thanks for the explanation. It fixed a few issues I was having.
> 
> Regarding mutexes and spi reads and transfers. Is it possible for
> multiple SPI reads to be 'overwriting' each other thus resulting in
> wrong reads? Which is why mutexes should be used to lock SPI bus? I
> understand there is a patch waiting to be included to the mainline that
> has functions to lock the bus before doing a transfer.
> 
> e.g. You issue a read and while that read is happening, a second spi
> read call from another function uses the bus and thus results in wrong
> data being returned to the first read.

The model of SPI transactions this is embodied in the SPI core:
      drivers/spi/spi.c,
      include/linux/spi/spi.h

defines SPI "messages", which contain any number of "transfers".
Messages are queued by a protocol driver (one for each type of chip or
device attached to a physical bus), and are executed by the controller
driver (one for each physical bus).  The controller driver (also
sometimes referred to as the master driver) manipulates the physical bus
to do all the reading and writing of all the devices/chips attached to
the bus.

The message is atomic in the sense that the controller driver guarantees
to complete all the transfers defined in the message (assuming no
errors) before it handles the next message.  Each transfer may change
the clock or bits/word, and may also ask for the chip select to
manipulated (or not) at the end of the transfer.  There is no guarantee
that the next message processed by the controller driver will be for the
same device as the previous message; the controller driver just takes
the next message in the queue, which could have come from any of the
protocol drivers that is operating devices on the bus.  Only when there
is a single device on the bus is the next device certain to be the same
as the last device.

Normally, there is no locking used with SPI bus messages (except for
spinlocks within the controller driver and its interrupt routines).
Each protocol driver sends messages that accomplish complete tasks,
after which the chip select to the device can be de-asserted.

Apparently, there is an issue with certain types of memory cards (SD,
MMC?), that prevents these cards from being used on a multi-device bus
within the present transaction model of the SPI core.  I am not familiar
with the details, but I gather that the chip select must stay asserted
between messages, and the needed operations cannot be combined into a
single message (probably because the next action depends on the results
of previous actions).  These devices are traditionally accommodated by
making them the only device on the bus, which is somewhat inconvenient.
 To get around this problem there have been recent proposals to
introduce some form of locking so that the protocol driver for a memory
device can be assured of exclusive access to the bus for a short period
of time.  I suspect that this is patch set you are referring to.

In general, the design of the SPI core and controller drivers prevents
the type of collision that you describe above.  The controller driver
can only respond to one message at a time, and will complete that
message before taking the next in the queue.  Only if you need to
guarantee an un-interrupted sequence of messages, such as seems to be
necessary for those memories, would locking be necessary.  The bus can
only be locked in a cooperative or centralized way; there is no way to
prevent another protocol driver from inserting a message in the
controller driver's queue, unless all drivers have been programmed to
respect the locks, or unless the queue mechanism is altered to pass
messages to the controller driver only from a protocol driver that is
holding the lock, and to put all messages from other, non lock-aware,
drivers in a separate holding queue.  I think the latter is the method
implemented by the proposed locking patches, but I'm not sure (I haven't
been paying a lot of attention to that).

I'm assuming that you are using the SPI-core/protocol driver/controller
driver model in the system that you have having trouble with.  If you
are somehow attaching two controller drivers to the same bus, there
there is only trouble to be had.  I hope the kernel prevents assignment
of the same hardware resources to two drivers.

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
