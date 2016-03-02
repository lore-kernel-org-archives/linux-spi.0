From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: spi-imx: hung task caused by vfs_read
Date: Wed, 2 Mar 2016 09:34:07 +0100
Message-ID: <CAH9NwWf_aDqnd3bbuYs+Fn8E50kh9bR3g8BYvVnFNKSAJe34dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi.

I am currently investigating on an issue with spi-imx on a imx6d based
platform. It looks like that between 4.1.7 and 4.1.17 a regression was
introduced.
A user space application tries to read from an eeprom via /dev/mtd0ro
and from time to time the task hungs during reading that eeprom. I
will start
to run a bisect but as the problem does not occur every read it can
take some time to tell if the problem still does exist or not. The
thing that makes it
harder is that only during boot the application reads that eeprom -
lets see if I can speed up the process.


-----------------------------------------------------
[ 212.455942] sysrq: SysRq : Changing Loglevel
[ 212.456068] sysrq: Loglevel set to 1
[ 240.246067] INFO: task lconfigd:1660 blocked for more than 120 seconds.
[ 240.246089] Not tainted 4.1.17 0000001
[ 240.246099] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 240.246109] lconfigd D c0575548 0 1660 1 0x00000000
[ 240.246132] Backtrace:
[ 240.246166] [<c057524c>] (__schedule) from [<c0575a84>] (schedule+0x40/0xa4)
[ 240.246176] r10:00000000 r9:c07f1300 r8:c07b8408 r7:c0576518
r6:7fffffff r5:7fffffff
[ 240.246210] r4:ee972e7c
[ 240.246233] [<c0575a44>] (schedule) from [<c0578544>]
(schedule_timeout+0x174/0x274)
[ 240.246254] [<c05783d0>] (schedule_timeout) from [<c0576518>]
(wait_for_common+0xc0/0x164)
[ 240.246263] r10:00000000 r9:c07f1300 r8:00000002 r7:00000000
r6:7fffffff r5:ee972e78
[ 240.246294] r4:ee972e7c
[ 240.246314] [<c0576458>] (wait_for_common) from [<c05765dc>]
(wait_for_completion+0x20/0x24)
[ 240.246324] r10:ee972e50 r8:00000001 r7:c3976200 r6:ee972c00
r5:ee972e50 r4:c2c87d28
[ 240.246367] [<c05765bc>] (wait_for_completion) from [<c03f6b04>]
(spi_imx_transfer+0xe8/0x3cc)
[ 240.246393] [<c03f6a1c>] (spi_imx_transfer) from [<c03f50e4>]
(spi_bitbang_transfer_one+0xb4/0x250)
[ 240.246403] r10:ee972e50 r8:00000001 r7:00000000 r6:c2c87da0
r5:00000000 r4:c2c87d28
[ 240.246443] [<c03f5030>] (spi_bitbang_transfer_one) from
[<c03f36e8>] (__spi_pump_messages+0x36c/0x6b4)
[ 240.246452] r10:ee9e5010 r9:00000001 r8:ee9e5010 r7:00000000
r6:c2c87da0 r5:c2c87d6c
[ 240.246483] r4:ee972c00
[ 240.246503] [<c03f337c>] (__spi_pump_messages) from [<c03f3b68>]
(__spi_sync+0x138/0x1e4)
[ 240.246512] r10:00000000 r9:00000000 r8:c03f25a8 r7:00000000
r6:ee972c00 r5:c3976200
[ 240.246542] r4:c2c87da0
[ 240.246562] [<c03f3a30>] (__spi_sync) from [<c03f3c50>] (spi_sync+0x1c/0x20)
[ 240.246571] r10:00040000 r9:00000000 r8:c3976200 r7:00000000
r6:ee973300 r5:c2c87da0
[ 240.246602] r4:ee973014
[ 240.246623] [<c03f3c34>] (spi_sync) from [<c03f0210>] (m25p80_read+0xf8/0x124)
[ 240.246641] [<c03f0118>] (m25p80_read) from [<c03f1528>]
(spi_nor_read+0x64/0x80)
[ 240.246651] r10:00004000 r8:00004000 r7:00000000 r6:00040000
r5:00000000 r4:ee973014
[ 240.246698] [<c03f14c4>] (spi_nor_read) from [<c03cdcb4>] (mtd_read+0x98/0xcc)
[ 240.246708] r7:c2c87ea0 r6:ee973098 r5:00000000 r4:001c0000
[ 240.246740] [<c03cdc1c>] (mtd_read) from [<c03d300c>]
(mtdchar_read+0xcc/0x204)
[ 240.246750] r9:ed424000 r8:00000000 r7:b495d018 r6:c2c87f78
r5:00000000 r4:00040000
[ 240.246793] [<c03d2f40>] (mtdchar_read) from [<c013b1c4>]
(__vfs_read+0x3c/0xe0)
[ 240.246803] r10:00004000 r9:00000000 r8:c2c87f78 r7:b495d018
r6:c2c87f78 r5:c05c8104
[ 240.246833] r4:c32fe600
[ 240.246852] [<c013b188>] (__vfs_read) from [<c013befc>] (vfs_read+0x98/0x154)
[ 240.246861] r10:00000000 r8:00040000 r7:00004000 r6:c2c87f78
r5:b495d018 r4:c32fe600
[ 240.246899] [<c013be64>] (vfs_read) from [<c013c008>] (SyS_read+0x50/0x90)
[ 240.246908] r10:00000000 r8:00040000 r7:b495d018 r6:00004000
r5:c32fe601 r4:c32fe600
[ 240.246953] [<c013bfb8>] (SyS_read) from [<c000fa60>]
(ret_fast_syscall+0x0/0x3c)
[ 240.246962] r9:c2c86000 r8:c000fc04 r7:00000003 r6:00004000
r5:00000000 r4:b495d018





[    0.000000] Linux version 4.1.17 (buildserver-au@deb7armhf) (gcc
version 4.6.3 (Debian 4.6.3-14) ) #1 SMP PREEMPT Mon Feb 8 15:31:10
UTC 2016
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
..
[    3.276077] m25p80 spi2.0: m25p16 (2048 Kbytes)
[    3.290864] spi_imx 2010000.ecspi: probed
..


greets
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
