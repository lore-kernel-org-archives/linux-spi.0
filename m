From: Sebastian Siewior <bigeasy-kttTfShzVuc@public.gmane.org>
Subject: Re: [RFC / PATCH] [SPI] get_module while using
	it.
Date: Thu, 8 May 2008 16:57:33 +0200
Message-ID: <20080508145733.GA18821@www.tglx.de>
References: <20080414194549.GA1363@www.tglx.de>
	<200805021055.11267.david-b@pacbell.net>
	<20080502192929.GA20326@www.tglx.de>
	<200805021258.06573.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200805021258.06573.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

* David Brownell | 2008-05-02 12:58:06 [-0700]:

>On Friday 02 May 2008, Sebastian Siewior wrote:
>> >That memory is freed only by spidev_classdev_release(), so
>> >it looks like this particular issue is a refcounting bug.
>> >I'll look at it later (unless you make time for it first).
>>
>> I try what I can do tomorrow but I probably can't before sunday.
>
>Looks to me like the refcounting on spidev->users is insufficient.
>That covers the buffer.  Separately, each open and each release
>should probably update the refcount on spidev->dev itself.

Yep, spidev->users protects only spidev->buffer while the spidev struct
is unprotected. Here an example: I remove my spi device driver (the
pointer is the address of my spidev struct):

| Removing: df159460
| ------------[ cut here ]------------
| Badness at /home/bigeasy/git/linux-2.6-powerpc/drivers/spi/spidev.c:617
| NIP: c01b4518 LR: c01b4518 CTR: 00000000
| REGS: df1f9c40 TRAP: 0700   Not tainted  (2.6.25)
| MSR: 00029000 <EE,ME>  CR: 28000488  XER: 20000000
| TASK = df894000[2155] 'rmmod' THREAD: df1f8000
| GPR00: c01b4518 df1f9cf0 df894000 00000025 bbbbbbbb 00000004 df395bcc c0be52a0 
| GPR08: 00000000 00000000 00000040 df1f8000 00000000 1001a2a8 28004422 00000000 
| GPR16: 100e9fa8 100d0000 100b0000 100d0000 00000000 100b0000 10013008 00000000 
| GPR24: bf8082f0 00000000 e1065158 df159690 df159460 df159690 c037bc54 df159690 
| NIP [c01b4518] spidev_remove+0x28/0xcc
| LR [c01b4518] spidev_remove+0x28/0xcc
| Call Trace:
| [df1f9cf0] [c01b4518] spidev_remove+0x28/0xcc (unreliable)
| [df1f9d10] [c01b433c] spi_drv_remove+0x2c/0x3c
| [df1f9d20] [c0185f08] __device_release_driver+0x88/0xb4
| [df1f9d30] [c0186024] device_release_driver+0x28/0x44
| [df1f9d50] [c0185208] bus_remove_device+0x8c/0xb8
| [df1f9d70] [c018389c] device_del+0xf8/0x16c
| [df1f9d90] [c0183928] device_unregister+0x18/0x30
| [df1f9db0] [c01b3d38] __unregister+0x20/0x34
| [df1f9dc0] [c01830dc] device_for_each_child+0x30/0x74
| [df1f9df0] [c01b3cfc] spi_unregister_master+0x28/0x44
| [df1f9e10] [e10641ac] fpga_spi_of_remove+0x48/0xb0 [fpga_spi]
| [df1f9e30] [c01e27fc] of_platform_device_remove+0x30/0x44
| [df1f9e40] [c0185f08] __device_release_driver+0x88/0xb4
| [df1f9e50] [c0185fd4] driver_detach+0xa0/0xc8
| [df1f9e70] [c018509c] bus_remove_driver+0x98/0xd4
| [df1f9e90] [c01864f8] driver_unregister+0x48/0x5c
| [df1f9eb0] [c01e2908] of_unregister_driver+0x14/0x24
| [df1f9ec0] [e1064c04] fpga_spi_exit+0x18/0x28 [fpga_spi]
| [df1f9ed0] [c004c38c] sys_delete_module+0x1b4/0x204
| [df1f9f40] [c000ded8] ret_from_syscall+0x0/0x3c
| Instruction dump:
| 7c0803a6 4e800020 9421ffe0 7c0802a6 bf410008 7c7b1b78 90010024 8383010c 
| 3c60c031 3863a4d8 7f84e378 4be720fd <0fe00000> 3bbc0178 7fa3eb78 3b400000 

Now, I use my userspace program to do an ioctl:

| Touching: df159460
| BUG: spinlock bad magic on CPU#0, spidev_test/2153
| Unable to handle kernel paging request for data at address 0x6b6b6d5f
| Faulting instruction address: 0xc0142d74
| PREEMPT 
| Modules linked in: bluetooth libertas [last unloaded: fg
| REGS: df2efd50 TRAP: 0300   Not tainted  (2.6.25)
| MSR: 00021000 <ME>  CR: 22000424  XER: 20000000
| TASK = df895840[2153] 'spidev_test' THREAD: df2ee000
| GPR00: c0142d5c df2efe00 df895840 00000045 00000001 6b6b6b6b c02e64e4 ffffffff 
| GPR08: 00000000 c02e0000 00005634 df2ee000 ffffe3c0 10019ad4 28004422 00000000 
| GPR16: 100e9ac8 100d0000 100b0000 100d0000 00000000 100b0000 100e9948 100e9be8 
| GPR24: 00000000 100e0008 df159460 80206b00 00000004 c02fa3f8 df1595d8 6b6b6b6b 
| NIP [c0142d74] spin_bug+0x6c/0xd0
| LR [c0142d5c] spin_bug+0x54/0xd0
| Call Trace:
| [df2efe00] [c0142d5c] spin_bug+0x54/0xd0 (unreliable)
| [df2efe20] [c0142f18] _raw_spin_lock+0x34/0x118
| [df2efe40] [c025e50c] _spin_lock_irq+0x24/0x34
| [df2efe50] [c01b4d50] spidev_ioctl+0xac/0x748
| [df2efec0] [c00861c0] vfs_ioctl+0x88/0xa8
| [df2efee0] [c00865e0] do_vfs_ioctl+0x400/0x444
| [df2eff10] [c0086664] sys_ioctl+0x40/0x70
| [df2eff40] [c000ded8] ret_from_syscall+0x0/0x3c
| Instruction dump:
| 386aa41c 38c20304 38a00000 419d0048 80e201f4 4bee38b9 2f9f0000 3d20c02e 
| 80be0004 38c964e4 38e0ffff 419e000c <80ff01f4> 38df0304 811e0008 3c60c030 
| ---[ end trace 4ccbf52b28cfbf39 ]---

"Touching" is just before the spinlock.
So, spidev is all gone while userspace has still an open handle. Now,
what do recommend? Solving this by refcounting in spidev_remove() or
spi_drv_remove()?

>
>- dave
Sebastian

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
