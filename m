From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Question about pxa2xx_spi.c
Date: Wed, 09 Jul 2008 10:45:40 -0400
Message-ID: <4874CF14.1030606@whoi.edu>
References: <961055.62866.qm@web15812.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Martin Qiu <martin_sjtu-/E1597aS9LRv1O+Z8WTAqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <961055.62866.qm-VrLyXnEWYAPFTsyTBrxSqPhMsxRAUFZ5QQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Martin Qiu wrote:
> Hiall,
> 
> I am newcomer for SPI devleopment. Here is one
> question regarding the pxa2xx_spi.c:
> 
> Why does it use tasklet to handle each spi_transfer,
> as spi_message is already use work queue thread to
> handle? 

This is the standard (if there is such a thing), or at least the
typical, way to design Linux device drivers.  See "Linux Device Drivers"
by Corbet, et al., from O'Reilly.  The workqueue services the message
queue in response to calls from the protocol driver, while the tasklet
is connected to the interrupt service routine (and also scheduled
directly from the workqueue).  Splitting the interrupt service routine
into two parts (often called "top half" and "bottom half"), allows a
separation of the tasks that must be performed immediately from the
tasks that can be deferred.  The top half, triggered directly by the
hardware interrupt, does all the things required to be handled
immediately, such as unloading hardware buffers and changing hardware
registers.  The bottom half is used for any further processing of the
data associated with the interrupt that is not as time critical. This
design allows the kernel to be more responsive to other hardware
interrupts, and generally improves latency for all tasks.

In the case of pxa2xx_spi.c, the bottom half (performed in a tasklet)
cleans up of the previous transfer (calling giveback) and sets up the
next transfer.  Neither of these tasks is hardware time critical, though
of course, any delay does affect the overall throughput of SPI messages.

> If one protocol driver wants to write a char to the
> device, then one spi_msg with only one spi_transfer is
> created, the spi_msg will first added to the
> workqueue, when it scheduled to run, it will put the
> spi_transfer to tasklet list waiting for handling,
> here is a 2 step wating, will it be effective for
> pxa2xx_spi.c? Is there any specail design thought for
> it? Thanks!

It seems to work well enough.  I read SPI data at 11Mbit/sec, and while
I added an internal DMA descriptor queue to the driver to reduce the
sensitivity to latency, I was able to read 98% of the data at full speed
without the extra queue.  Even with the DMA descriptor queue, I still
maintain all the workqueue and tasklet structure of the driver, and it
keeps up on average.  About 10-20% of CPU time is spent servicing the
SPI at 11MBit/sec: adding all the time spent in workqueue, tasklet,
interrupt service, protocol driver and userspace.  Far more time is
spent writing the data out to the network; I think because there is no
DMA support on transmit in the driver for the 91c111 network chip used
with the Gumstix.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
