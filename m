From: Maxwell Bottiger <sleepylight-9vDAOyxKyZDkeZwj4yWH3g@public.gmane.org>
Subject: SPI driver causing kernel panic
Date: Wed, 9 Apr 2014 09:23:10 -0400
Message-ID: <CADi-vswXfqo4o2h8bD8saU36JnwV2FXnhyyG2t0voBR2feNwFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I'm working on a driver which uses the SPI bus to talk to an FPGA.
The FPGA raises an interrupt every 200us, and the driver reads 4 bytes
off of the SPI bus and into a buffer.  The input is double buffered,
so once the IRQ handler fills one of the buffers, it switches to a
second empty buffer, and returns the first one to user space.

Under most circumstances, the driver works well.  I can read from the
chip, and there isn't a noticeable impact on system performance.
However, under certain circumstances the driver causes a kernel panic,
and the whole system goes down.  The board I've implemented this on is
an Atmel AT91SAM9x25 SoC.  Since it's an ARM architecture and it uses
specialized hardware, I've been unable to debug this problem on my
desktop.  I was hoping someone on this mailing list might have some
insight into what's causing the crash.  So far, I've found it to occur
under the following conditions:

HTTP transfers over eth0, which are at least 1MB (ssh, nfs, and ftp are ok)
Scanning the device with nmap
At the end of init 6 or init 0.


I'm happy to share driver code upon request, but for starters I'll
just list the kernel panic below.  Any help is greatly appreciated, as
this is my first SPI driver, my first kernel panic, and I'm quite
stuck.

Thank you.

Unable to handle kernel paging request at virtual address 00100104
pgd = c7bbc000
[00100104] *pgd=2714e831, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1] PREEMPT ARM
Modules linked in:
CPU: 0    Not tainted  (3.6.9-yocto-standard #1)
PC is at atmel_spi_msg_done+0x48/0xe4
LR is at __gpio_set_value+0x98/0xa8
pc : [<c01e4830>]    lr : [<c017b2d0>]    psr: 20000093
sp : c709bd48  ip : c7a34720  fp : c04422f8
r10: 00400140  r9 : 00000101  r8 : c046b62c
r7 : c7a2b600  r6 : c7a2b600  r5 : c046b62c  r4 : c7a2b750
r3 : 00200200  r2 : 00100100  r1 : 80000000  r0 : c7a2b750
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 27bbc000  DAC: 00000015
Process lighttpd (pid: 894, stack limit = 0xc709a270)
Stack: (0xc709bd48 to 0xc709c000)
bd40:                   c7a2b750 c046b7cc c046b64c c01e4da4 c0440784 00000000
bd60: 00000000 00000008 3fb9f49c c0022430 00000001 c0460b7c c709a000 c0021bc8
bd80: 00000001 c0035a60 00000006 00000000 00000000 60000013 fffffff5 c7022980
bda0: 00000000 00000000 00000000 00000040 00000040 c0021e4c b6e54430 c0021fb8
bdc0: b6e54430 c0278e8c c709be14 c01e2824 0000b3a0 00000020 00000040 00010430
bde0: 000005a8 0002fbd0 00000002 00000000 00000000 000005a8 00000000 c709bec0
be00: c7a2b750 00000000 c046b728 000005a8 00000000 00000000 c04422f8 c7022980
be20: c709bec0 c709be78 00040000 00000001 c709a000 c709bec0 00026154 c0297358
be40: 00040000 c729edc0 00000000 c709bec0 c709beb8 c023eef4 c709bebc c6439460
be60: 00000012 00040000 c749e820 c00220a0 00000000 c709be78 00000000 00000000
be80: c709beb8 00000001 00000000 00000000 00000040 c709bec0 c709bec0 fffffdee
bea0: c709bf88 00040000 c729edc0 c007f140 00000000 00000000 b6e44000 00040000
bec0: 00000000 00000000 00000000 00000001 ffffffff c729edc0 00000000 00000000
bee0: 00000000 00000000 c7108ac0 00000000 00000000 00000000 00000000 00000000
bf00: c709be58 00000000 00040000 00000000 00040000 00000000 00000000 00000000
bf20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bf40: 00000000 00040000 c729edc0 b6e44000 c709bf88 00040000 00000000 c007f9d4
bf60: c729edc0 b6e44000 00000000 00000000 c729edc0 b6e44000 00040000 c007fc1c
bf80: 00000007 00000000 00000000 00000000 00040000 00000000 00040000 00000004
bfa0: c000dea4 c000dd40 00040000 00000000 00000007 b6e44000 00040000 00000000
bfc0: 00040000 00000000 00040000 00000004 00080000 00000000 00083740 00026154
bfe0: 00000000 beb494cc 00024330 48a9155c 40000010 00000007 00000000 00000000
[<c01e4830>] (atmel_spi_msg_done+0x48/0xe4) from [<c01e4da4>]
(atmel_spi_tasklet_func+0xe0/
0x150)
[<c01e4da4>] (atmel_spi_tasklet_func+0xe0/0x150) from [<c0022430>]
(tasklet_action+0x84/0xcc)
[<c0022430>] (tasklet_action+0x84/0xcc) from [<c0021bc8>]
(__do_softirq+0xb0/0x174)
[<c0021bc8>] (__do_softirq+0xb0/0x174) from [<c0021e4c>] (do_softirq+0x48/0x54)
[<c0021e4c>] (do_softirq+0x48/0x54) from [<c0021fb8>]
(local_bh_enable+0x88/0xd8)
[<c0021fb8>] (local_bh_enable+0x88/0xd8) from [<c0278e8c>]
(tcp_sendmsg+0xbb8/0xd6c)
[<c0278e8c>] (tcp_sendmsg+0xbb8/0xd6c) from [<c0297358>]
(inet_sendmsg+0x40/0x70)
[<c0297358>] (inet_sendmsg+0x40/0x70) from [<c023eef4>]
(sock_aio_write+0xf4/0x114)
[<c023eef4>] (sock_aio_write+0xf4/0x114) from [<c007f140>]
(do_sync_write+0x90/0xcc)
[<c007f140>] (do_sync_write+0x90/0xcc) from [<c007f9d4>] (vfs_write+0xb0/0x130)
[<c007f9d4>] (vfs_write+0xb0/0x130) from [<c007fc1c>] (sys_write+0x34/0x68)
[<c007fc1c>] (sys_write+0x34/0x68) from [<c000dd40>] (ret_fast_syscall+0x0/0x2c)
Code: eaffffff e5952020 e5953024 e1a00004 (e5823004)
---[ end trace 1a4012977dfa9a0e ]---
Kernel panic - not syncing: Fatal exception in interrupt
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
