From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2] spi: bcm2835: enabling polling mode for transfers shorter than 30us
Date: Tue, 14 Apr 2015 16:29:49 +0200
Message-ID: <F35B7C71-1917-40AE-BA42-CB3E63B877EF@martin.sperl.org>
References: <1428340592-3196-1-git-send-email-kernel@martin.sperl.org> <20150410185132.GU6023@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150410185132.GU6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 10.04.2015, at 20:51, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> On Mon, Apr 06, 2015 at 05:16:30PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>> 
>> In cases of short transfer times the CPU is spending lots of time
>> in the interrupt handler and scheduler to reschedule the worker thread.
> 
> Applied, thanks.

I have been running a heavy CAN-based spi load with the following parameters:
* about 3000 can messages/second received by 2 mcp2515 can controller
  (so a total of 6000 can-messages passing thru the system)
* each can message producing 3 SPI transfers with all of them running <30us
  which means that all of them run in polling mode of the spi-bcm2835.
* 10% user CPU
* 76% system CPU
* most time spent inside the interrupt handler for the mcp2515 which
  triggers spi_sync commands, so these mostly run locally
  see also the information from the kernel threads via ps:
root     26986  4.3  0.0      0     0 ?        S    12:54   0:23 [spi32762]
root     27091 37.0  0.0      0     0 ?        S    12:54   3:20 [irq/104-mcp251x]
root     27096 27.0  0.0      0     0 ?        S    12:54   2:26 [irq/105-mcp251x]
  so most of the time is spent in the threaded irq handlers of the mcp251x
* 17000 interrupts/s - 8000+ interrupts for USB + 
     1 interrupt per can-message per mcp2515 so about 6000)
  here the content of /proc/interrupts:
           CPU0
 27:     722456  ARMCTRL-level  35  timer
 33:   90007770  ARMCTRL-level  41  20980000.usb, dwc2_hsotg:usb1
 73:   18381921  ARMCTRL-level  81  20200000.gpio:bank0
 74:          0  ARMCTRL-level  82  20200000.gpio:bank1
 77:          0  ARMCTRL-level  85  20205000.i2c, 20804000.i2c
 78:          0  ARMCTRL-level  86  20204000.spi
 81:        791  ARMCTRL-level  89  uart-pl011
 86:      56425  ARMCTRL-level  94  mmc0
104:   17086956  pinctrl-bcm2835  16  mcp251x
105:   18300261  pinctrl-bcm2835  17  mcp251x
Err:          0
* 10000 to 13000 context switches/s

With nothing else happening on the system everything works fine and I
can receive 100M can messages without issues on both controllers (about 9 hours)

But if I start a compile of the kernel (or even just linking the kernel
modules) I get a stalled can driver and messages like this:

[ 7529.270495] mcp251x spi32763.0: SPI transfer failed: -110
[ 7529.270541] spi_master spi32763: failed to transfer one message from queue
[ 7529.270563] mcp251x spi32763.0: spi transfer failed: ret = -110

The last one is from the mcp251x driver, which subsequently does not
handle interrupts any longer.

I have some captures of the bus, interrupt lines,... and the issue is
related to the fact that the kernel-thread gets interrupted while the
driver is polling SPI-HW for the HW to terminate the traffic.
I got some examples where it takes 78ms where the worker thread
not running.

This is obviously way longer than the timeout limit of the max of:
  * 2 jiffies
  * 4x expected transfer time on the bus
which means we return -ETIMEDOUT.

For reference here a screenshot of the capture with the gap:
https://cloud.githubusercontent.com/assets/2638784/7137494/622dafb0-e2ba-11e4-8e25-840d702e04df.png

It shows that the cs is asserted, and then before anything can get written
to the fifo the thread gets rescheduled (or an interrupt triggers) and only
when it continues the fifo is filled and then the timeout check happens.

Obviously it depends heavily on in which code passage the process is
interrupted. Putting the spi-worker-thread in RT mode does not help,
as most of the transfers are now running inside the callers thread
due to spi_sync now calling __spi_pump_message directly if the queue
is empty and that way avoiding the scheduling overhead and latencies.

Here for completeness also the statistics on context switches for the
3 threads (spi worker and irq-mcp251x) listed above:
grep ctxt /proc/26986/status /proc/27091/status /proc/27096/status
/proc/26986/status:voluntary_ctxt_switches:	11503960
/proc/26986/status:nonvoluntary_ctxt_switches:	123465
/proc/27091/status:voluntary_ctxt_switches:	12117492
/proc/27091/status:nonvoluntary_ctxt_switches:	292
/proc/27096/status:voluntary_ctxt_switches:	11934367
/proc/27096/status:nonvoluntary_ctxt_switches:	247

So we have a probability of 0.002% that the mcp251x-irq threads
gets interrupted.
The spi-worker thread has a 1% chance of getting interrupted while
running its work.

Those values are for a system that is idle - no compile or anything
except for some minimal monitoring.

Approaches I can think of to solve the issue:
* accept this fact as a reality - drivers should be able to handle
  such situations in a well-behaved manner
* remove polling mode completely from the spi-bcm2835 driver
* remove the timeout code when polling
* make the timeout a warning
* set the timeout to something much longer say 200ms
* stop the system from interrupting (either scheduler or interrupt
  handler) for the next 30us or the calculated timeout-period.
  Maybe by holding a spinlock (or similar) / disabling interrupts /
  ...?
* others

So the question is: which approach should get implemented?

Thanks,
	Martin

P.s: Obviously the mcp251x driver should also handle this gracefully,
but that is a different story.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
