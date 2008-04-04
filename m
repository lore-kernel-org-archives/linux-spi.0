From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH]  jffs2 summary allocation
Date: Fri, 4 Apr 2008 12:48:12 -0700
Message-ID: <20080404124812.d39fa640.akpm@linux-foundation.org>
References: <713171.37644.qm@web26213.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Michael Trimarchi <trimarchimichael-whZMOeQn8C0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <713171.37644.qm-nTp0C3JUvazGRxTy+Q50vsz6deESKz/lQQ4Iyu8u01E@public.gmane.org>
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

On Fri, 4 Apr 2008 10:23:55 +0000 (GMT)
Michael Trimarchi <trimarchimichael-whZMOeQn8C0@public.gmane.org> wrote:

> Hi,
> 
> I apply this patch to fix this oops.
> 
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> stopped custom tracer.
> Internal error: Oops: 817 [#1] PREEMPT
> Modules linked in:
> CPU: 0    Not tainted  (2.6.24-rc5-rt1 #37)
> PC is at dma_cache_maint+0x40/0x80
> LR is at atmel_spi_transfer+0x94/0x178
> pc : [<c002488c>]    lr : [<c013eedc>]    psr: 20000013
> sp : c044db84  ip : c044db94  fp : c044db90
> r10: ffffffff  r9 : 00000000  r8 : c04e4c00
> r7 : c03ee310  r6 : c044dcfc  r5 : c109d3bc  r4 : c044dcd8
> r3 : 00000000  r2 : 00000001  r1 : c109d7dc  r0 : c109d3bc
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 0005317f  Table: 20588000  DAC: 00000017
> Process jffs2_gcd_mtd1 (pid: 313, stack limit = 0xc044c258)
> Stack: (0xc044db84 to 0xc044e000)
> ...
> Backtrace:
> [<c002484c>] (dma_cache_maint+0x0/0x80) from [<c013eedc>] (atmel_spi_transfer+0x94/0x178)
> [<c013ee48>] (atmel_spi_transfer+0x0/0x178) from [<c013e124>] (spi_sync+0x74/0x98)
> [<c013e0b0>] (spi_sync+0x0/0x98) from [<c013dcb0>] (dataflash_write+0x1b0/0x270)
>  r8:000014bf r7:00000420 r6:c0446000 r5:00000420 r4:00a5f800
> [<c013db00>] (dataflash_write+0x0/0x270) from [<c013a00c>] (part_write+0xa8/0xb0)
> [<c0139f64>] (part_write+0x0/0xb0) from [<c00e0724>] (jffs2_flash_writev+0x278/0x434)
>  r6:c04d9000 r5:00000420 r4:00000420
> [<c00e04b0>] (jffs2_flash_writev+0x4/0x434) from [<c00e1f40>] (jffs2_sum_write_sumnode+0x334/0x420)
> [<c00e1c0c>] (jffs2_sum_write_sumnode+0x0/0x420) from [<c00d5ca0>] (jffs2_do_reserve_space+0x94/0x3c8)
> [<c00d5c0c>] (jffs2_do_reserve_space+0x0/0x3c8) from [<c00d6014>] (jffs2_reserve_space_gc+0x40/0x78)
> [<c00d5fd4>] (jffs2_reserve_space_gc+0x0/0x78) from [<c00da938>] (jffs2_garbage_collect_pristine+0x5c/0x3a8)
> [<c00da8dc>] (jffs2_garbage_collect_pristine+0x0/0x3a8) from [<c00dc32c>] (jffs2_garbage_collect_pass+0x590/0x714)
> [<c00dbd9c>] (jffs2_garbage_collect_pass+0x0/0x714) from [<c00dd730>] (jffs2_garbage_collect_thread+0x100/0x18c)
> [<c00dd630>] (jffs2_garbage_collect_thread+0x0/0x18c) from [<c0039818>] (do_exit+0x0/0x73c)
> Code: 9a000001 e15c0003 3a000001 e3a03000 (e5833000)
> 

--- a/fs/jffs2/summary.c~jffs2-summary-allocation
+++ a/fs/jffs2/summary.c
@@ -17,7 +17,6 @@
 #include <linux/pagemap.h>
 #include <linux/crc32.h>
 #include <linux/compiler.h>
-#include <linux/vmalloc.h>
 #include "nodelist.h"
 #include "debug.h"
 
@@ -30,7 +29,7 @@ int jffs2_sum_init(struct jffs2_sb_info 
 		return -ENOMEM;
 	}
 
-	c->summary->sum_buf = vmalloc(c->sector_size);
+	c->summary->sum_buf = kmalloc(c->sector_size, GFP_KERNEL);
 
 	if (!c->summary->sum_buf) {
 		JFFS2_WARNING("Can't allocate buffer for writing out summary information!\n");
@@ -49,7 +48,7 @@ void jffs2_sum_exit(struct jffs2_sb_info
 
 	jffs2_sum_disable_collecting(c->summary);
 
-	vfree(c->summary->sum_buf);
+	kfree(c->summary->sum_buf);
 	c->summary->sum_buf = NULL;
 
 	kfree(c->summary);
_

All this does is switch sum_buf from vmalloced-memory over to
kmalloced-memory.

I'm assuming from the trace that the arm code tried to put that memory
under DMA (or at least, passed it into part of the DMA management code to
get the various caches sorted out) and that the arm DMA support code
doesn't like being given vmalloced memory.

So the question is: who is wrong here?  Is jffs wrong to use vmalloced
memory in this application, or is arm wrong to not handle it?


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
