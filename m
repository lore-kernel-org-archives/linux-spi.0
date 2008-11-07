From: "J. Scott Merritt" <merrij3-IL7dBOYR4Vg@public.gmane.org>
Subject: PXA270 SSP DMA Corruption
Date: Fri, 7 Nov 2008 11:43:12 -0500
Message-ID: <20081107114312.2f34b389.merrij3@rpi.edu>
References: <20080211174339.73ca7ed5.merrij3@rpi.edu>
	<47B0D9A4.6080104@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47B0D9A4.6080104-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Long ago, I posted a message on linux-arm-kernel describing data corruption
that I was seeing on PXA270 SSP transfers using DMA:
http://marc.info/?l=linux-arm-kernel&m=117780219128682&w=2

I have recently upgraded to Kernel 2.6.27.4 and am now using the IOCTL
interface provided by spidev ... and unfortunately am still seeing
data corruption with DMA transfers.

I have a user program that is sending single blocks (1-255 words) of
fabricated, non-zero data to an outbound processor (at 300 kHz).  I
find that after a small number of blocks (10-20), the outboard processor
will receive a packet that begins with multiple zeros, rather than the
intended data.

I have put printk statements into spidev that show that the correct,
non-zero data is always present in the DMA bounce buffer before and
after the transfer - even on the packets that fail to arrive.

If I display the DMA flag in the platform data, then the transfers
continue indefinitely without any problems.  More interestingly, while
using DMA, if I simply insert a sched_yield (on an otherwise unoccupied
processor), before each transfer from user land, the problem
disappears !

In my original posting last year, I suspected a cache coherency problem.
However, based on the latest symptoms, I'm wondering if the SSP
transfer might be initiated before the DMA controller is ready/able
to provide source data ....

Thanks, Scott.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
