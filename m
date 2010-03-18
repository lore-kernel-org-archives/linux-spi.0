From: Amit Uttamchandani <amit.uttam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Spinlock vs mutexes for spi network driver
Date: Thu, 18 Mar 2010 13:09:40 -0700
Message-ID: <20100318200940.GC16834@canoga.com>
References: <20100317204915.GB6358@canoga.com> <4BA14970.3050603@whoi.edu>
	<20100318164641.GA22298@canoga.com> <4BA262B1.5050001@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4BA262B1.5050001-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Mar 18, 2010 at 01:28:17PM -0400, Ned Forrester wrote:

[...]

> 
> The message is atomic in the sense that the controller driver guarantees
> to complete all the transfers defined in the message (assuming no
> errors) before it handles the next message.  Each transfer may change
> the clock or bits/word, and may also ask for the chip select to
> manipulated (or not) at the end of the transfer.  There is no guarantee
> that the next message processed by the controller driver will be for the
> same device as the previous message; the controller driver just takes
> the next message in the queue, which could have come from any of the
> protocol drivers that is operating devices on the bus.  Only when there
> is a single device on the bus is the next device certain to be the same
> as the last device.

That's good to know that it is queuing the messages. I am assuming that
this goes for all messages going into the controller right? Not just for
one specific spi message? (e.g. different spi messages from different
function calls in the same driver).

> 
> Normally, there is no locking used with SPI bus messages (except for
> spinlocks within the controller driver and its interrupt routines).
> Each protocol driver sends messages that accomplish complete tasks,
> after which the chip select to the device can be de-asserted.
> 
> Apparently, there is an issue with certain types of memory cards (SD,
> MMC?), that prevents these cards from being used on a multi-device bus
> within the present transaction model of the SPI core.  I am not familiar
> with the details, but I gather that the chip select must stay asserted
> between messages, and the needed operations cannot be combined into a
> single message (probably because the next action depends on the results
> of previous actions).  These devices are traditionally accommodated by
> making them the only device on the bus, which is somewhat inconvenient.
>  To get around this problem there have been recent proposals to
> introduce some form of locking so that the protocol driver for a memory
> device can be assured of exclusive access to the bus for a short period
> of time.  I suspect that this is patch set you are referring to.
> 

Yes, I think those are the ones I was talking about.

> In general, the design of the SPI core and controller drivers prevents
> the type of collision that you describe above.  The controller driver
> can only respond to one message at a time, and will complete that
> message before taking the next in the queue.  Only if you need to
> guarantee an un-interrupted sequence of messages, such as seems to be
> necessary for those memories, would locking be necessary.  The bus can
> only be locked in a cooperative or centralized way; there is no way to
> prevent another protocol driver from inserting a message in the
> controller driver's queue, unless all drivers have been programmed to
> respect the locks, or unless the queue mechanism is altered to pass
> messages to the controller driver only from a protocol driver that is
> holding the lock, and to put all messages from other, non lock-aware,
> drivers in a separate holding queue.  I think the latter is the method
> implemented by the proposed locking patches, but I'm not sure (I haven't
> been paying a lot of attention to that).
> 

So using spi_read and spi_write functions (which in turn calls spi_sync)
guarantees a blocking transfer. Which in my understanding means in the
code, the spi transfer will complete before moving onto the next line.

e.g.:

 -> private data manipulation code
 
 -> use spi transfer to read large amounts of data
 will it wait here until transfer is complete before moving to next
 line?

 -> use data read from spi transfer

> I'm assuming that you are using the SPI-core/protocol driver/controller
> driver model in the system that you have having trouble with.  If you
> are somehow attaching two controller drivers to the same bus, there
> there is only trouble to be had.  I hope the kernel prevents assignment
> of the same hardware resources to two drivers.
> 

Yes, I am only using one controller. In this case it is the
omap2_mcspi.c. I only have one SPI device connected.

I guess my problem seems to lie elsewhere. It could be a flaky hardware
from my end. I am transferring data to and fro an FPGA.

Could I be using SPI with dma to improve speed and maybe have access to
more resource in system memory?

Thanks again for the explanation,
Amit

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
