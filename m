From: William Bourque <wfb-q1Y+AKCHEmHQT0dZR+AlfA@public.gmane.org>
Subject: SPI: Integer overflow cause timeout to be too small
Date: Tue, 19 Apr 2016 16:59:07 -0400
Message-ID: <57169C1B.7010100@xiphos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Hi

I bumped into a strange issue in the SPI driver that might be a bug.

We are developing hardware based on Xilinx Zynq; as storage we uses an 
N25Q512A NOR Flash over Xilinx Zynq Quad Spi driver.
The Quad SPI driver is _not_ in the upstream kernel but the overflowing 
integer that is the root cause of the issue is (see below).

As such, the bug may or may not be related to upstream kernel code. I 
tracked it down and found a fix but I am unsure if the whole issue isn't 
just something the calling driver is doing wrong.

The QSPI driver code can be found at:
https://github.com/Xilinx/linux-xlnx/blob/master/drivers/spi/spi-zynq-qspi.c

Recently, we noticed we can crash the SPI driver simply by using dd with 
an overly large block size.
Something like:
[root@test-spi ~]# dd if=/dev/mtd13 bs=4000000 count=1 | md5sum
m25p80 spi0.0: SPI transfer timed out
m25p80 spi0.0: flash operation timed out
m25p80 spi0.0: flash operation timed out
dd: /dev/mtd13: Connection timed out

At this point the QSPI is effectively dead, any access to the filesystem 
result in endless timeout. The system needs a reboot to recover.

[root@test-spi ~]# ls /etc
m25p80 spi0.0: flash operation timed out
m25p80 spi0.0: flash operation timed out
ubi0 warning: ubi_io_read: error -110 while reading 60 bytes from PEB 
167:54048, read only 0 bytes, retry
m25p80 spi0.0: flash operation timed out
...

By poking around, I found that the issue is caused by this line (ref: 
http://lxr.free-electrons.com/source/drivers/spi/spi.c#L972 ):
ms = xfer->len * 8 * 1000 / xfer->speed_hz;

ms is an unsigned long.
In the case shown above, "xfer->len" is 4,000,000 and xfer->speed_hz is 
62,499,599 (65MHz).
So here 4,000,000 * 8 * 1000 = 32,000,000,000. It overflows the uint32 
so the end result ends up being 1,935,228,928.
After being divided by xfer->speed_hz, ms is roughtly equal to 30.96ms, 
which is way too small for a transfer of this size.

When a timeout occurs, the transfer is stopped; this leave the QSPI in 
an incoherent state from which it never recover (this seem weird to me?).

I was able to workaround the issue by doing the math the other way, i.e. 
by dividing the frequency instead of mutiplying the length.
Since the frequency of SPI should always be in the MHz, it seems safe 
enough (although division IS slower on some platform).
The fix looks like this:
/* Use max() to avoid division by zero for very small frequency */
ms = xfer->len / max((unsigned long)1, (unsigned long)xfer->speed_hz / 8 
/ 1000);


Now, as I said, the bug may not lie in spi.c; the culprit may be Xilinx 
QSPI driver. Maybe it shouldn't have passed such a large length down to 
spi.c?
I don't know enough of the SPI architecture to know what's good practice 
and what's not.

This lead me to the following questions:
1- Is this an actual bug and if so, is the likely culprit spi.c or 
spi-zynq-qspi.c?
2- Should such large transfer length be handled in calling 
spi-zynq-qspi.c or down in spi.c?
3- Is it normal for the SPI to die after such timeout? Shouldn't the 
SPI/QSPI driver be expected to recover from it?


Thanks,

- William Bourque
Embedded Software Developer,
Xiphos Technologies
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
