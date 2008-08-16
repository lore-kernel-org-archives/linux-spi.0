From: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: pxa2xx_spi with SFRM
Date: Fri, 15 Aug 2008 22:33:07 -0400
Message-ID: <20080815223307.02db86aa@vsauder-lx.localdomain>
References: <1218182539.489bfd8b24a3d@webmail.whoi.edu>
	<489C1B23.6040804@cam.ac.uk> <48A0C35D.5010606@gmail.com>
	<48A44F77.1020908@whoi.edu> <48A4ED85.1030803@gmail.com>
	<48A5D44D.6040106@whoi.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/+h8cAXZhOuswi/t2byX8.fj"
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48A5D44D.6040106-/d+BM93fTQY@public.gmane.org>
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

--MP_/+h8cAXZhOuswi/t2byX8.fj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ned Forrester wrote:

>I'm not sure that implementing defaults is a good idea.  I prefer the
>current scheme of forcing the user to make a considered choice.  In
>particular, 0 is a valid value for the timeout and thresholds (it means
>none in the case of timeout and one in the case of thresholds), so if
>these structure elements weren't already defined as unsigned, -1 would
>be a better flag to trigger use of a default.

I added the defaults because there is an inconsistency in the API. When
I added cs_control, it did not force me to make a "considered
choice"; it forced me to debug a driver to determine why it didn't
work anymore. The .h file mentions that the settings are for "DMA
tuning" so I did not initialize them. I only added cs_control and left
the other members zero. Either the code or the documentation needs a
small update, IMHO. I can send a patch but it looks like I might be
duplicating work that has already been done and got lost somewhere.

Zero is not a valid timeout if the driver relies on the timeout
interrupt to receive trailing bytes. If timeout is zero, the
timeout interrupt will not happen, right?

A threshold of 0 is invalid. It will actually become 16:

#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..16] */

>More specifically, I don't see in the patch where there is a default
>for timeout; you simply leave it undefined if a value of 0 was
>specified; there is no "else" for "if (chip_info->timeout)".  

The timeout default is set a couple lines above when the chip struct is
malloc'd. The patch just does not overwrite it.

>In any
>case, it would be difficult at best to offer a default value, since
>this is a division of an unspecified clock.  It turns out that the
>developer's manuals for both PXA255 and PXA270 do not adequately
>specify what clock is used for the timer.  Thus a numerical value that
>is appropriate for one may not be appropriate for another, nor for the
>new PXA3xx processors.  We just don't know.  Furthermore, an
>appropriate default depends on the rate of SSPSCLK, which is a
>variable.  There are also application specific considerations.

Which again leads me to ask, how would I know if the value I picked is
good, or right, or wrong?

>The defaults of 12 and 4 that you specified above for thresholds are
>not actually the preferred values.  When I was working with Stephen on
>some issues with this driver, we concluded that 8 and 8 were better
>choices.

The 12/4 values are the defaults used in _probe(). No real comment there
on why those values are chosen. The defaults if chip_info is missing are
1 & 1. All these defaults could be consolidated a little. :)  And maybe
explained. Or maybe not needed at all if the platform *must* pass them
in!

>I am curious about the kernel hanging with a zero timeout.  I would
>expect that the trailing bytes would never be read, but this driver
>should not hang waiting for them, because it simply is not responding
>to an interrupt that never happens.  Perhaps the hang occurs at a
>higher level when the message is never given back.  Do you really mean
>that the kernel hangs (all processes stop) or just that the MMC
>operation never finishes?  Are you using PIO (interrupt) mode or DMA
>when you access the driver (or is that hidden from you by the MMC
>drivers that you are using)?

I believe this was PIO. You are correct, only the MMC hung, not the
kernel, my bad. I think it was stuck in this code:

static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
<snip>
	if (drv_data->tx == drv_data->tx_end) {
		write_SSCR1(read_SSCR1(reg) & ~SSCR1_TIE, reg);
		/* PXA25x_SSP has no timeout, read trailing bytes */
		if (drv_data->ssp_type == PXA25x_SSP) {
			if (!wait_ssp_rx_stall(reg))
			{
				int_error_stop(drv_data, "interrupt_transfer: "
						"rx stall failed");
				return IRQ_HANDLED;
			}
			if (!drv_data->read(drv_data))
			{
				int_error_stop(drv_data,
						"interrupt_transfer: "
						"trailing byte read failed");
				return IRQ_HANDLED;
			}
			int_transfer_complete(drv_data);
		}
	}

	/* We did something */
	return IRQ_HANDLED;
}

It basically thought the TX was done but it was missing RX data. I can
try to recreate this if you need.

>> 
>> ** Thresholds are now as set by defaults. Do you have a good way to 
>> figure out what they should be?
>
>See comments above about good values of thresholds, and defaults as
>policy.  In general, I found the driver fairly robust for all values of
>the thresholds when in PIO mode.  Personally, I use 8 and 8 for
>11Mbit/sec DMA mode. I think it is fair to use whatever works in your
>application.  Here is a slightly relevant comment from my discussion
>with Stephen on Oct 1, 2006 (which somehow never made onto the
>spi-devel mailing list, in spite of being addressed there):
>
>>> 5. Coding of threshold as a function of bits/word and dma burst
>>> size:
>>> 
>>> This change was a lot more complicated than I thought, partly
>>> because there are two places in the driver where this computation
>>> needs to be done: in setup, and also in pump_transfers if a new
>>> bits/word is attached to an spi_transfer.  I have created a new
>>> routine that computes the proper dma_threshold from bits/word and
>>> burst_size, and I have called it from setup and pump_transfers.  In
>>> setup, it changes the values stored in struct chip_data, but in
>>> pump_transfers it only changes local "use once" values.  It is
>>> possible for a combination of bits/word and burst_size to yield
>>> invalid threshold settings (any threshold more than 1/2 the fifo, 8
>>> words, because only 2, 4, 8 and 16 would match the burst size, but
>>> 16 causes overruns).  To deal with this, the burst size is reduced
>>> as required to keep the threshold at 8.  If this reduction occurs
>>> in setup, a dev_warn is issued to let the user know; if the
>>> reduction happens in pump_transfers, the change is silent.  Change
>>> the reporting if you think something else is better.
>>> 
>>> [snip] 
>>>
>>> ----Testing
>>> 
>>> This patch has been tested for reading the correct number of bytes 
>>> without overruns or permanent timeouts; I did not use loopback and
>>> pass test data to verify on read, but I could do that.  The test
>>> was done with randomized transfer lengths between 4 and >4096 bytes
>>> (in multiples of 4 bytes, I suppose I could do it in integer
>>> bytes), with all word sizes from 4 to 32 bits.  Baud rate was
>>> changed from 3.6864MHZ to 100kHz.  Both DMA and PIO mode were
>>> tested.  In DMA mode various combinations of word size and burst
>>> size were used.  In PIO mode various threshold settings from tx=1
>>> and rx=15, to tx=15 and rx=1 were tested. All modes worked.  With
>>> PIO mode fixed to prevent overruns, the operation becomes
>>> insensitive to values of threshold and timeout.  In DMA mode, it is
>>> necessary to keep timeout longer than one word time

How do I calculate this? What is the symptom if it is too short?

>I think the  "1" and "15" above correspond to threshold register values
>of "0" and "14"; that is the above numbers are the number of words in
>the FIFO that trigger the interrupt/service request.

All this still leaves me slightly confused. (And I didn't even touch the
dma_burst_size member yet.) I assume that the correct value for all of
these settings must be determined empirically, not just theoretically.
How can I tell what the correct or optimum values are? Do I just use a
performance test on the Flash chip or MMC device? Or can I look at the
logic analyzer output and see what they should be? Or is there a debug
printk that needs to be enabled?

To the point of my setup, I may not have the right settings yet because 
the clock is stopping between each byte transferred. See attached logic
analyzer printout. Is this normal? Does this indicate a setting that
needs to be tweaked? Is the DMA not keeping up? The chip should be
capable of up to 75MHz, and in the printout, it is obvious that the
chip is ready before the PXA. I also tested PIO mode and it looks
identical.

The gaps indicate a 1MHZ period so I tried 1MHz. That was fine. I tried
2MHz and it is still fine. Requesting 4MHz (actual 3.125), there is a
short pause after the first byte, but then it is fine. It might be a PXA
SSP controller "bug"?

<opinion> As a user, it would seem that the SSP should work with
minimum fuss. If there are values that enable 99% of devices to work,
then why would you *not* want them to be the defaults? If the user
needs to tweak the values because they need more performance, then they
can. But if they only need a low bandwidth connection, causing
transfers to hang because they did not provide a "know-able" value
seems less than useful. I know it took me entirely too long to get this
working. I am only trying to help the next user that needs this.
</opinion>

I'll follow up on the MTD bug on the other thread.

--
Thanks again for your help and have a good day,
Vern

--MP_/+h8cAXZhOuswi/t2byX8.fj
Content-Type: image/png; name=SpiStutter.PNG
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=SpiStutter.PNG

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

--MP_/+h8cAXZhOuswi/t2byX8.fj
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--MP_/+h8cAXZhOuswi/t2byX8.fj
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--MP_/+h8cAXZhOuswi/t2byX8.fj--
