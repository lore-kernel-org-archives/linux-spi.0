From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Limitations on transfer length [was:
	pxa2xx_spi with SFRM]
Date: Wed, 12 Nov 2008 20:31:54 -0500
Message-ID: <491B838A.5080103@whoi.edu>
References: <1218182539.489bfd8b24a3d@webmail.whoi.edu>
	<489C1B23.6040804@cam.ac.uk> <48A0C35D.5010606@gmail.com>
	<48A44F77.1020908@whoi.edu> <48A4ED85.1030803@gmail.com>
	<48A5D272.1070804@whoi.edu> <490158E8.8060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <490158E8.8060502-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Sorry for the delayed response....

Vernon Sauder wrote:
> I finally had some time to test this again. For refreshing, this is
> testing an m25p80 MTD device on the PXA270 SPI bus.
> 
> Good news and Bad news. Good  news is that the error is gone with your
> patch on 2.6.24.4. Bad news is that it there are still cases where the
> kernel crashes or locks up using 2.6.27-rc8.

if you snapshotted 2.6.27-rc8, pxa2xx_spi would not have built properly.
 There was an error in a patch of mine that was fixed by a 2008-10-01
patch by Mike Rapoport, which would have been included in 2.6.27-rc9.
You probably figured that out.

> One time, this much of an error message got out before the kernel
> completely locked up:
> 
> root@inhand-ft4 [~] # cat /tmp/k > /dev/mtd_spi
> cat: Write Error: Bad address
> [  151.497694] ------------[ cut here ]------------
> [  151.503356] WARNING: at kernel/mutex.c:135
> __mutex_lock_slowpath+0x9c/0x200()
> [  151.510452] Modules linked in: spidev
> 
> And here is another dump that appeared after multiple writes: (Notice
> first the failed writes. I don't know what is causing that. The HW setup
> is slightly different.)

[snip crash dump]

I don't know if it could be related, but there is another thread "PXA270
SSP DMA Corruption" in which Scott Merritt reports trouble with the
combination of spidev and pxa2xx_spi.  He is also up-to-date with
2.6.27. He does not report kernel crashes, but simply corrupted data.

I looked at spidev today (for the first time) and noticed that it uses
the same buffer for rx and tx.  That should be alright, except that I
don't think that pxa2xx_spi handles that case correctly in DMA mode.
pxa2xx_spi will try to dma_map_single() the same buffer twice, once in
each direction.

Are you using PIO or DMA mode?  If DMA, can you try setting
struct pxa2xx_spi_master.enable_dma = 0;

If that works better, then maybe you have the same problem.

> I wanted to send this so you know. There is the possibility that the
> 2.6.27 I am using is not completely configured and/or patched. It was
> based on Linus' git tree but I have not completed testing all my board
> patches. This feature is not being requested any longer so I don't have
> a lot of pressure to fix it right now. As I get closer to finishing the
> project, I might need to resolve this.

Maybe if you have some other issues, that would explain the difference
in symptoms between your application and Merritt's.  Alternatively, it
could be different ways that messages are formatted by the chain of code
that accesses MTD.  Merritt is directly using the ioctl interface of spidev.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
