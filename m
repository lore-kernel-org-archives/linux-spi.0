From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Spinlock vs mutexes for spi network driver
Date: Thu, 18 Mar 2010 18:11:00 -0400
Message-ID: <4BA2A4F4.60207@whoi.edu>
References: <20100317204915.GB6358@canoga.com> <4BA14970.3050603@whoi.edu>
	<20100318164641.GA22298@canoga.com> <4BA262B1.5050001@whoi.edu>
	<20100318200940.GC16834@canoga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Amit Uttamchandani <amit.uttam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100318200940.GC16834-QCuvCd35e3/QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 03/18/2010 04:09 PM, Amit Uttamchandani wrote:
> On Thu, Mar 18, 2010 at 01:28:17PM -0400, Ned Forrester wrote:
> 
> [...]
> 
>>
>> The message is atomic in the sense that the controller driver guarantees
>> to complete all the transfers defined in the message (assuming no
>> errors) before it handles the next message.  Each transfer may change
>> the clock or bits/word, and may also ask for the chip select to
>> manipulated (or not) at the end of the transfer.  There is no guarantee
>> that the next message processed by the controller driver will be for the
>> same device as the previous message; the controller driver just takes
>> the next message in the queue, which could have come from any of the
>> protocol drivers that is operating devices on the bus.  Only when there
>> is a single device on the bus is the next device certain to be the same
>> as the last device.
> 
> That's good to know that it is queuing the messages. I am assuming that
> this goes for all messages going into the controller right? Not just for
> one specific spi message? (e.g. different spi messages from different
> function calls in the same driver).

A message is a message. If it is sent through spi_async or spi_sync,
then it goes in the queue (there is no other way to queue a message, so
far as I know).  Of course, it is up to the controller drivers to be
well behaved, and to read the queue in order, but I don't think any of
them would have passed review if they did not.

>> In general, the design of the SPI core and controller drivers prevents
>> the type of collision that you describe above.  The controller driver
>> can only respond to one message at a time, and will complete that
>> message before taking the next in the queue.  Only if you need to
>> guarantee an un-interrupted sequence of messages, such as seems to be
>> necessary for those memories, would locking be necessary.  The bus can
>> only be locked in a cooperative or centralized way; there is no way to
>> prevent another protocol driver from inserting a message in the
>> controller driver's queue, unless all drivers have been programmed to
>> respect the locks, or unless the queue mechanism is altered to pass
>> messages to the controller driver only from a protocol driver that is
>> holding the lock, and to put all messages from other, non lock-aware,
>> drivers in a separate holding queue.  I think the latter is the method
>> implemented by the proposed locking patches, but I'm not sure (I haven't
>> been paying a lot of attention to that).
>>
> 
> So using spi_read and spi_write functions (which in turn calls spi_sync)
> guarantees a blocking transfer. Which in my understanding means in the
> code, the spi transfer will complete before moving onto the next line.

I'm not familiar with spi_read and spi_write.  I guess those may be part
of the user space driver: spidev?  (I wrote a dedicated protocol driver
for my device.)

That is the way that spi_sync is supposed to work: accept a message, and
wait until that message is returned by the controller driver, prior to
spi_sync returning to from the call to it.  That does not mean that
messages from other protocol drivers were not handled before or after,
except when, as in your case, there is only one device on the bus.

> e.g.:
> 
>  -> private data manipulation code
>  
>  -> use spi transfer to read large amounts of data
>  will it wait here until transfer is complete before moving to next
>  line?
> 
>  -> use data read from spi transfer

I'm not sure what you are suggesting here.  I can't tell if your use of
the word "transfer" is meant in the strictly defined sense of the SPI
core: it is a single exchange of n-bytes that may or may not be the only
one in a message.  If the code ultimately calls spi_sync, it should wait
at the call until the message is complete.

>> I'm assuming that you are using the SPI-core/protocol driver/controller
>> driver model in the system that you have having trouble with.  If you
>> are somehow attaching two controller drivers to the same bus, there
>> there is only trouble to be had.  I hope the kernel prevents assignment
>> of the same hardware resources to two drivers.
>>
> 
> Yes, I am only using one controller. In this case it is the
> omap2_mcspi.c. I only have one SPI device connected.
> 
> I guess my problem seems to lie elsewhere. It could be a flaky hardware
> from my end. I am transferring data to and fro an FPGA.

It could be a lot of places, from bug in your code to bug in the
controller driver.  I'm not sure how much testing omap2_mcspi.c has
received.  When I first started using pxa2xx_spi.c, less than a year
after it appeared in the kernel, I found a variety of bugs.  I then
spent about 6 months re-writing the driver to handle a high data-rate
read-only master.  It was much harder for me than I expected.

> Could I be using SPI with dma to improve speed and maybe have access to
> more resource in system memory?

Way too short a question, with way too many unspecified variables.  I
really can't help you with that, because I know nothing about omap.  DMA
is useful if you are transmitting/receiving lots of data.  If your
device requires short exchanges (bytes, not Kbytes or Mbytes) with
decision making in between, then DMA might not help.  Many of the
controller drivers have DMA built-in, and it is not hard to enable it,
but I don't know about omap2_mcspi.c.

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
