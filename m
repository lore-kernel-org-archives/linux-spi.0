From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Continuous streaming SPI transfer
Date: Thu, 27 Sep 2012 21:30:25 -0400
Message-ID: <5064FDB1.9060304@whoi.edu>
References: <87zk4bazje.fsf@kiiro.xen-host.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Nuutti Kotivuori <naked-X3B1VOXEql0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87zk4bazje.fsf-Nc554NfcwGrUGg1qMAD/drNAH6kLmebB@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 09/27/2012 06:09 PM, Nuutti Kotivuori wrote:
> Hello,
> 
> I would like to use SPI in a streaming fashion, with a transfer being
> active all the time. This seems very difficult with the current kernel
> drivers. I am mainly looking at the Raspberry Pi BCM2708 SPI driver, but
> I have also tried to find similar features from other drivers.

You don't say whether you mean to transfer into or out of the external
device (or both). Nor do you say what clock rate you want to use (what's
the average bit/byte rate?).

I am not familiar with the hardware you want to use, but I have done
this on a PXA255 processor, at 11Mbit/sec from the external device to
the PXA processor.  For this I had to extensively modify the pxa2xx_spi
controller driver (that was with kernel 2.6.20, I think the name has
changed in recent kernels), and, of course, to write my own protocol
driver (the glue between the kernel side of Clib and the controller
driver).  I did not have to make any changes to the SPI core.

NOTE WELL: Please don't ask for this code, I cannot share it.

> There seems to be no way to prevent the deactivation and reactivation of
> the clock and everything between separate transfers - and a single
> transfer is bounded in size and no progress is reported for it. Even
> within a single transfer, it would seem that an earlier transfer is
> waited to receive a DONE signal (tx fifo empty, rx fifo has everything)
> before starting a new transfer, so there's always a small gap between
> transfers. (The RPi hardware stops sending SCLK if there ever is a
> condition where there is no byte ready in the FIFO to be sent, so if a
> DONE signal is receved that means that SCLK has already been stopped.)

To overcome this problem, I ran the PXA processor as a slave, with the
clocks supplied from external hardware.  The problem then becomes
keeping the receive FIFO from overflowing.  That was solved by enabling
chained DMA transfers (at enormous driver-writing expense; I'd never
written a device driver before).  DMA chaining allows the DMA hardware
to fetch its own next set of DMA parameters (addresses and byte count)
at the end of each DMA, thus avoiding the interrupt latency between each
buffer of data.  Using 256 buffers of 4096 bytes, interrupt latency of
100s of milliseconds becomes acceptable.

I used this to stream data from an external device, but I don't know of
any reason why it could not be used to stream data to a device, or to
both transmit and receive.  I have no idea whether your hardware has any
equivalent of DMA chaining, nor whether you have the experience/budget
for writing device drivers.  I don't think you can achieve what you want
without a dedicated effort, because the SPI model is not intended for
this type of application.

> Keeping a transfer active constantly would need some buffering on writes
> and reads to keep the TX FIFO always filled and RX FIFO not
> full. Otherwise I don't see any direct problems with it, atleast on the
> hardware level.
> 
> So, my questions are:
> 
>  1) Is there a fundamental problem in keeping an SPI transfer active for
>     extended periods of time (several hours)?

It depends on the clock rate, the features of the hardware you intend to
use, and your willingness to write your own driver.

>  2) Is this possible with the kernel API somehow?

The SPI core assumes a series of messages containing transfers.  It is
intended to support multiple chips attached to one (or more) bus(es).
Each chip has a protocol driver with corresponding user-space interface
provided by the Clib, and each protocol driver passes messages in mixed
fashion to the controller driver, which actually manipulates the bus and
chip selects.

What you want can be done through the SPI core only if there is a single
device on the bus (or if data to/from multiple devices is completely
predictable, eg. sequential).  I wrote my driver as a modification of
pxa2xx_spi, with all existing functionality intact and continuing to use
all the message mechanics of the SPI core.  That was probably a mistake,
as it would have taken me far less time to write a dedicated, single
purpose driver.

>  3) Is this possible from userland somehow?

Ultimately everything has to pass to userland to be useful.  Do you
mean: can this be done without writing a device driver?  I doubt it.

>  4) If it is not possible, what would be a good API for such a case?

Not sure.  Somehow you need to be able to execute a read() from user
space and get data.  I chose to read() a block of data equal to the
length of each DMA transfer (4096 bytes), so that each buffer could be
freed as it is read.  It should also work to model the device as
continuously streaming and then to read a number of bytes, either
blocking (returns only when byte count is satisfied) or non-blocking
(returns available bytes).

I am thinking of a device that streams data to the processor.  Note that
the chained DMA scheme involves considerable delay between when the
device actually sends data and when those data are ultimately read in
user space (10s or 100s of buffers later).  If you are sending AND
receiving data, the sent data must be queued with write() well in
advance, and the corresponding read data will not be returned until
later.  Some mechanism would be required to identify which received data
corresponded to which transmitted data.  In the normal SPI core model,
you would write the data for a message, then read the date from the
message, before starting the next message.

>  5) Would patches for such functionality be accepted?

Hard to say.  This sort of question has come up many times in the past
in connection with proposed (but never implemented) slave mode for
Linux.  I would not expect patches to be well received if they depart
from the multi-chip message model.

> 
> Thank you in advance,
> -- Naked
> 
> ------------------------------------------------------------------------------
> Everyone hates slow websites. So do we.
> Make your web apps faster with AppDynamics
> Download AppDynamics Lite for free today:
> http://ad.doubleclick.net/clk;258768047;13503038;j?
> http://info.appdynamics.com/FreeJavaPerformanceDownload.html
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
> 
> 


-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                           508-289-2226 Office
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/
http://www.whoi.edu/page.do?pid=29856
http://www.whoi.edu/hpb/Site.do?id=1532


------------------------------------------------------------------------------
Got visibility?
Most devs has no idea what their production app looks like.
Find out how fast your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219671;13503038;y?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
