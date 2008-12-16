From: Domen Puncer <domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org>
Subject: "concurrent" transfers list corruption
	(spi_async) with atmel_spi
Date: Tue, 16 Dec 2008 10:42:21 +0100
Message-ID: <20081216094221.GN1924@domen-work>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello!

At least I think this is the reason.

I'm doing spi_async transfers, and in the middle, I get an interrupt
which triggers another spi_async (presumably in the middle of spi
callback) , to read status register.

The resulting backtrace is:

[42949455.730000] ------------[ cut here ]------------
[42949455.730000] WARNING: at /home/domen/arm9/linux/linux-2.6.27-at91/lib/list_debug.c:30 __list_add+0x6c/0x90()
[42949455.730000] list_add corruption. prev->next should be next (c39a1018), but was 00000000. (prev=c3a33170).
[42949455.730000] Modules linked in: nordic
[42949455.730000] [<c0246470>] (dump_stack+0x0/0x14) from [<c003cf44>] (warn_slowpath+0x64/0x80)
[42949455.730000] [<c003cee0>] (warn_slowpath+0x0/0x80) from [<c012e050>] (__list_add+0x6c/0x90)
[42949455.730000]  r3:c39a1018 r2:c02bddcc
[42949455.730000]  r6:c3a33170 r5:c39a1018 r4:c3a33170
[42949455.730000] [<c012dfe4>] (__list_add+0x0/0x90) from [<c01789d8>] (atmel_spi_transfer+0x140/0x180)
[42949455.730000]  r6:c3a33150 r5:60000093 r4:c3a33134
[42949455.730000] [<c0178898>] (atmel_spi_transfer+0x0/0x180) from [<bf00081c>] (nordic_spi_async+0x78/0x7c [nordic])
[42949455.730000]  r9:00000004 r8:00000001 r7:c3a331d1 r6:c3a331d1 r5:c3a33150
[42949455.730000] r4:c3a33000
[42949455.730000] [<bf0007a4>] (nordic_spi_async+0x0/0x7c [nordic]) from [<bf000874>] (nordic_irq+0x54/0x64 [nordic])
[42949455.730000]  r9:00000004 r8:fefff800 r7:00000066 r6:00000000 r5:00000000
[42949455.730000] r4:c3af67c0
[42949455.730000] [<bf000820>] (nordic_irq+0x0/0x64 [nordic]) from [<c0064e9c>] (handle_IRQ_event+0x2c/0x6c)
[42949455.730000] [<c0064e70>] (handle_IRQ_event+0x0/0x6c) from [<c00664c8>] (handle_simple_irq+0x7c/0xc4)
[42949455.730000]  r7:c02f571c r6:00000066 r5:c3af67c0 r4:c02f56ec
[42949455.730000] [<c006644c>] (handle_simple_irq+0x0/0xc4) from [<c0030bfc>] (gpio_irq_handler+0x94/0xc0)
[42949455.730000]  r7:c02eebcc r6:00000001 r5:00000066 r4:c02f56ec
[42949455.730000] [<c0030b68>] (gpio_irq_handler+0x0/0xc0) from [<c0026044>] (__exception_text_start+0x44/0x6c)
[42949455.730000] [<c0026000>] (__exception_text_start+0x0/0x6c) from [<c0026874>] (__irq_svc+0x34/0x60)
[42949455.730000] Exception stack(0xc3b3fd90 to 0xc3b3fdd8)
[42949455.730000] fd80:                                     c02f35f8 c3b3e000 c03112a0 20000013 
[42949455.730000] fda0: c02f35c8 00000082 0000000a c39a0fe0 c3994510 c3a330a0 c3a33100 c3b3fdf4 
[42949455.730000] fdc0: c3b3fdf8 c3b3fdd8 c00420fc c0042034 20000013 ffffffff                   
[42949455.730000]  r7:c39a0fe0 r6:00000004 r5:fefff000 r4:ffffffff
[42949455.730000] [<c0041fec>] (__do_softirq+0x0/0xc8) from [<c00420fc>] (irq_exit+0x48/0x50)
[42949455.730000]  r7:c39a0fe0 r6:00000000 r5:00000001 r4:c02f35c8
[42949455.730000] [<c00420b4>] (irq_exit+0x0/0x50) from [<c0026054>] (__exception_text_start+0x54/0x6c)
[42949455.730000] [<c0026000>] (__exception_text_start+0x0/0x6c) from [<c0026874>] (__irq_svc+0x34/0x60)
[42949455.730000] Exception stack(0xc3b3fe28 to 0xc3b3fe70)
[42949455.730000] fe20:                   c39a0fe0 000002e0 ffffffff 00000001 c39a0fe0 60000013 
[42949455.730000] fe40: c3a33150 c39a0fe0 c3994510 c3a330a0 c3a33100 c3b3fe84 c3b3fe70 c3b3fe70 
[42949455.730000] fe60: c0248bb8 c0248bbc 60000013 ffffffff                                     
[42949455.730000]  r7:c39a0fe0 r6:00000001 r5:fefff000 r4:ffffffff
[42949455.730000] [<c0248b8c>] (_spin_unlock_irqrestore+0x0/0x34) from [<c01789f8>] (atmel_spi_transfer+0x160/0x180)
[42949455.730000]  r5:60000013 r4:c3a33134
[42949455.730000] [<c0178898>] (atmel_spi_transfer+0x0/0x180) from [<bf00081c>] (nordic_spi_async+0x78/0x7c [nordic])
[42949455.730000]  r9:c3a330a0 r8:00000001 r7:c3a331d3 r6:c3a331d3 r5:c3a33150
[42949455.730000] r4:c3a33000
[42949455.730000] [<bf0007a4>] (nordic_spi_async+0x0/0x7c [nordic]) from [<bf0012e0>] (nordic_write+0x204/0x338 [nordic])
[42949455.730000]  r9:c3a330a0 r8:bf0044c0 r7:0000001f r6:c3a331d3 r5:c3a33000
[42949455.730000] r4:00000001
[42949455.730000] [<bf0010dc>] (nordic_write+0x0/0x338 [nordic]) from [<c008a344>] (vfs_write+0xb8/0x148)
[42949455.730000] [<c008a28c>] (vfs_write+0x0/0x148) from [<c008a498>] (sys_write+0x44/0x70)
[42949455.730000]  r7:00000408 r6:c3b4a6f0 r5:00000000 r4:00000000
[42949455.730000] [<c008a454>] (sys_write+0x0/0x70) from [<c0026c00>] (ret_fast_syscall+0x0/0x2c)
[42949455.730000]  r8:c0026da8 r7:00000004 r6:00008790 r5:00000000 r4:0000915c
[42949455.730000] ---[ end trace f4eb31538b67de43 ]---


------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
