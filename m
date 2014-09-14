From: Jeff Epler <jepler-ixP+gI44yfQ4d9/VWYMlNA@public.gmane.org>
Subject: [RFC 0/4] Improving SPI driver latency (vs v3.8.13.14-rt31)
Date: Sun, 14 Sep 2014 09:45:04 -0500
Message-ID: <1410705908-20847-1-git-send-email-jepler@unpythonic.net>
To: linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I recently became interested in realtime access to an SPI device on the
Odroid U3 platform, with a goal of running a repetitive task every 1ms
that performs two SPI transactions totalling around 200 bytes.  (for
http://linuxcnc.org/ interfacing to a http://mesanet.com/ "Anything I/O"
card)

Unfortunately, I found that there were frequent large latencies, some
over 10ms, when using /dev/spidev.  This seems to be typical of others'
experience using it (for instance, one can find threads discussing
disappointing RT performance of SPI on the beaglebone and pandaboard; at
least one Raspberry PI project chose to implement a pure userspace SPI
driver instead of using spidev)

At all levels of the SPI stack, I found things that could be improved if
lowest delays are the goal.  I doubt that in their current form these
changes are suitable to be incorporated in linux, but I hope that
this might spur some discussion that would ultimately lead to better
realtime performance of SPI particularly in the preempt-rt kernel.

As you may know, the kernel's spi driver stack consists of
    spidev    - implementation of the /dev/spidev* device
    spi       - hardware-independent kernel layer
    spi-xyzzy - hardware-dependent driver for xyzzy hardware
                (s3c64xx in my device)

I fixed causes of latency at each layer
 * First, I eliminated per-ioctl memory allocations in spidev
 * Second, I made __spi_sync *actually* synchronous, rather than
   being a wrapper over spi_async + wait_for_completion; and changed
   spidev to use spi_sync.  This is probably the most controversial
   aspect of my patches.
 * Third, in the hardware-dependent code I moved DMA acquisition to
   device initialization time rather than transaction time

With these changes, I have been able to run at a 500us repetitive rate,
performing two transactions per repetition, with no transaction over 250us,
for over 24 hours.  This is in contrast to the original performance, in
which transactions taking over 10ms were seen multiple times per hour.
(24 hours is about 340 million spi transactions)  This means there's plenty
of margin for the other activities LinuxCNC needs to perform while still
running at a 1ms repetitive rate.

I know that 3.8 is by no means current, but 3.8.y is the default kernel
shipped by hardkernel for their U3 devices so it was a rational version
choice for me.  I did skim spi changes from version 3.8 to the present
and didn't see anything that looked like it was directed at improving
SPI latency, though the underlying code has probably changed enough over
time that I assume my patches wouldn't actually apply at the tip of the
latest and greatest branches.

Jeff Epler (4):
  spi: reenable sync SPI transfers
  spidev: Avoid runtime memory allocations
  spidev: actually use synchronous transfers
  spidev-s3c64xx: allocate dma channel at startup

 drivers/spi/spi-s3c64xx.c | 15 +++++++--------
 drivers/spi/spi.c         | 22 ++++++++++++++++------
 drivers/spi/spidev.c      | 43 ++++++++++++++++++++++++++++++-------------
 3 files changed, 53 insertions(+), 27 deletions(-)

-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
