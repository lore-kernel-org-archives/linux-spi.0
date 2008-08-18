From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: pxa2xx_spi with SFRM
Date: Mon, 18 Aug 2008 14:34:56 -0400
Message-ID: <48A9C0D0.5050304@whoi.edu>
References: <1218182539.489bfd8b24a3d@webmail.whoi.edu>	<489C1B23.6040804@cam.ac.uk>	<48A0C35D.5010606@gmail.com>	<48A44F77.1020908@whoi.edu>	<48A4ED85.1030803@gmail.com>	<48A5D44D.6040106@whoi.edu>
	<20080815223307.02db86aa@vsauder-lx.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080815223307.02db86aa-W37fpRALFaH6NKmgiXY+hA0JkcsJGQge@public.gmane.org>
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

Vernon Sauder wrote:
> Ned Forrester wrote:
> 
>> I'm not sure that implementing defaults is a good idea.  I prefer the
>> current scheme of forcing the user to make a considered choice.  In
>> particular, 0 is a valid value for the timeout and thresholds (it means
>> none in the case of timeout and one in the case of thresholds), so if
>> these structure elements weren't already defined as unsigned, -1 would
>> be a better flag to trigger use of a default.
> 
> I added the defaults because there is an inconsistency in the API. When
> I added cs_control, it did not force me to make a "considered
> choice"; it forced me to debug a driver to determine why it didn't
> work anymore. The .h file mentions that the settings are for "DMA
> tuning" so I did not initialize them. I only added cs_control and left
> the other members zero. Either the code or the documentation needs a
> small update, IMHO. I can send a patch but it looks like I might be
> duplicating work that has already been done and got lost somewhere.

Granted, documentation can always be improved.  I don't know of any
other proposed patches that would address your concern.

> Zero is not a valid timeout if the driver relies on the timeout
> interrupt to receive trailing bytes. If timeout is zero, the
> timeout interrupt will not happen, right?

Whether zero is valid depends on the application.  If the data never
stop and the user does not want a timeout interrupt to be serviced then
either zero or a large number is appropriate; alternatively, if the data
always come in bursts that exactly match the FIFO threshold, then a
timeout is not required.  I freely admit that both of these scenarios
border on implausible, and in each case a long timeout would suffice.

The substantive issue is that Intel/Marvel failed to correctly/clearly
identify the clock that is used for the timeout.  This makes it
impossible to put a number in the register that means anything.  The
number might even have to change for each member of PXA series, but we
don't have enough information to know that.

The other issue is that one application's trailing byte timeout is
another application's disrupted transfer.  That is to say, what is long
enough for one application is likely too short for another, and
likewise: what is long enough for the slow application is likely too
long for a fast one.

How about you propose a number to use a default.  I can't think of a
good value that would work for most.  I use 10000 which translates to
100us on a PXA255, but I don't know what that means on other processors,
and it may not be long enough for some PIO applications.

> A threshold of 0 is invalid. It will actually become 16:
> 
> #define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..16] */

Darn, I forgot about the macro.  I dealt with all the basics of this
driver about 2 years ago, and I have forgotten much.

>> More specifically, I don't see in the patch where there is a default
>> for timeout; you simply leave it undefined if a value of 0 was
>> specified; there is no "else" for "if (chip_info->timeout)".  
> 
> The timeout default is set a couple lines above when the chip struct is
> malloc'd. The patch just does not overwrite it.

Sorry, I forgot that, too.  I see that Stephen did put 1000 in the code,
but that dates from the time that he was trying to scale it to
microseconds and the value was not changed when he removed the scaling.
 Now that we know that the clock on a PXA255 is 99.5MHz and not
3.6864MHz, 1000 is probably much too small for a default (10us).  The
problem is that we don't know the timer clock on any other processor in
the PXA series.  If you want to add to the knowledge you can measure it
for the PXA270.

>> In any
>> case, it would be difficult at best to offer a default value, since
>> this is a division of an unspecified clock.  It turns out that the
>> developer's manuals for both PXA255 and PXA270 do not adequately
>> specify what clock is used for the timer.  Thus a numerical value that
>> is appropriate for one may not be appropriate for another, nor for the
>> new PXA3xx processors.  We just don't know.  Furthermore, an
>> appropriate default depends on the rate of SSPSCLK, which is a
>> variable.  There are also application specific considerations.
> 
> Which again leads me to ask, how would I know if the value I picked is
> good, or right, or wrong?

If you need faster response to trailing bytes, make the value smaller.
If you don't want timeouts to happen in the middle of a transfer,
probably terminating the transfer early, make it longer.  If we knew
what the scaling to real time was supposed to be on all PXA processors,
then it would be easier for users to pick an appropriate value based on
how long they would like to wait before assuming that there are only
trailing bytes left to process.  Even the driver author does not know
what the processor load is on the target machine, so it is hard to know
how long one should wait to declare the transfer done.

I agree that it is tricky to know what the driver is doing without
putting in GPIO probes (for a scope) or additional printks.  If a
timeout happens too soon in a transaction, the remainder of the
transaction will happen in polled mode, which is likely to be slow.

>> The defaults of 12 and 4 that you specified above for thresholds are
>> not actually the preferred values.  When I was working with Stephen on
>> some issues with this driver, we concluded that 8 and 8 were better
>> choices.
> 
> The 12/4 values are the defaults used in _probe(). No real comment there
> on why those values are chosen. The defaults if chip_info is missing are
> 1 & 1. All these defaults could be consolidated a little. :)  And maybe
> explained. Or maybe not needed at all if the platform *must* pass them
> in!

I guess the default value business is really half baked, a historical
accident.  probe() sets some hardware registers, but nothing is really
used until pump_transfers() loads the first transfer, and that is done
from values set in setup().  Probably all these values should be set
from the same #define to avoid this confusion.  12/4 will work for PIO
mode, but 8/8 is better for DMA and will also work for PIO (at least on
the PXA255, where the maximum SSPSCLK is 3.6864MHz; I think the PXA270
can have an internal clock of 13MHZ).

>> I am curious about the kernel hanging with a zero timeout.  I would
>> expect that the trailing bytes would never be read, but this driver
>> should not hang waiting for them, because it simply is not responding
>> to an interrupt that never happens.  Perhaps the hang occurs at a
>> higher level when the message is never given back.  Do you really mean
>> that the kernel hangs (all processes stop) or just that the MMC
>> operation never finishes?  Are you using PIO (interrupt) mode or DMA
>> when you access the driver (or is that hidden from you by the MMC
>> drivers that you are using)?
> 
> I believe this was PIO. You are correct, only the MMC hung, not the
> kernel, my bad. I think it was stuck in this code:
> 
> static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
> <snip>
> 	if (drv_data->tx == drv_data->tx_end) {
> 		write_SSCR1(read_SSCR1(reg) & ~SSCR1_TIE, reg);
> 		/* PXA25x_SSP has no timeout, read trailing bytes */
> 		if (drv_data->ssp_type == PXA25x_SSP) {
> 			if (!wait_ssp_rx_stall(reg))
> 			{
> 				int_error_stop(drv_data, "interrupt_transfer: "
> 						"rx stall failed");
> 				return IRQ_HANDLED;
> 			}
> 			if (!drv_data->read(drv_data))
> 			{
> 				int_error_stop(drv_data,
> 						"interrupt_transfer: "
> 						"trailing byte read failed");
> 				return IRQ_HANDLED;
> 			}
> 			int_transfer_complete(drv_data);
> 		}
> 	}
> 
> 	/* We did something */
> 	return IRQ_HANDLED;
> }
> 
> It basically thought the TX was done but it was missing RX data. I can
> try to recreate this if you need.

I don't think it can be "stuck" there.  Surely if the timeout interrupt
never happens, the driver will never read the trailing bytes and thus
will never giveback the message, but the code fragment above has no
loops in it, and it is only executed when there is an interrupt to
service.  All the above code does is turn off the TX interrupt if all
characters have been transmitted.  (The rest reads trailing bytes on the
SSP (not NSSP) port of a PXA25x, but that type of port does not even
exist on a PXA270).  This code turns off tx interrupts and then the
driver waits for the already enabled timeout interrupt (which never
happens if timeout is zero).

>>> ** Thresholds are now as set by defaults. Do you have a good way to 
>>> figure out what they should be?
>> See comments above about good values of thresholds, and defaults as
>> policy.  In general, I found the driver fairly robust for all values of
>> the thresholds when in PIO mode.  Personally, I use 8 and 8 for
>> 11Mbit/sec DMA mode. I think it is fair to use whatever works in your
>> application.  Here is a slightly relevant comment from my discussion
>> with Stephen on Oct 1, 2006 (which somehow never made onto the
>> spi-devel mailing list, in spite of being addressed there):
>>
>>>>
>>>> [snip] 
>>>>
> 
> How do I calculate this? What is the symptom if it is too short?

Do you mean the timeout or the threshold?

In PIO mode, if the threshold is too low, too many interrupts are
fielded, and processor load increases.  If the threshold is too large,
there is more danger of RX FIFO overruns, though I don't think that can
actually happen anymore in PIO mode (since the 1/27/07 commit-date patch).

In DMA mode, the threshold must be set so that there is TX room in the
FIFO for burst-size bytes, or sufficient words in the RX FIFO for
burst-size bytes. (remembering that that the FIFO is 16 words deep,
regardless of word size, while the burst size is measured in bytes).
The frequency with which the DMA engine must service the FIFO is
determined more by the burst size than by the threshold.  If the first
rule is followed, then I don't think that there can be any
overrun/underrun occurrences.  Note that DMA thresholds are computed
internally by the driver for DMA mode, based on the requested burst
size; poor choices of burst size are over-ridden, and if that happens in
setup (rather than per-transfer), a kernel warning is issued.

With the timeout, if it is too short, and it occurs in the middle of a
transfer, rather than for just the trailing bytes, then the interrupt
service routine will read until the FIFO is empty and then stop.  This
will likely cause the transfer to be short with the actual_length
parameter having the expected value.  If the timeout is too long, then
you are forced to wait for the data, making the operation of the
interface slow.

>> I think the  "1" and "15" above correspond to threshold register values
>> of "0" and "14"; that is the above numbers are the number of words in
>> the FIFO that trigger the interrupt/service request.
> 
> All this still leaves me slightly confused. (And I didn't even touch the
> dma_burst_size member yet.) I assume that the correct value for all of
> these settings must be determined empirically, not just theoretically.
> How can I tell what the correct or optimum values are? Do I just use a
> performance test on the Flash chip or MMC device? Or can I look at the
> logic analyzer output and see what they should be? Or is there a debug
> printk that needs to be enabled?

I think it is empirical for the most part.  I realize that is not a very
satisfactory answer, but this is a relatively new driver, and my sense
is that only a dozen or so people are using it, each for a very targeted
purpose (maybe there are many silent users, but as you found, it is hard
to use this silently; it needs help).  Perhaps the ability to attach
memory cards will make that the "default" application that the driver
should be tuned for, though it was originally written for handling A/D
converters.

> To the point of my setup, I may not have the right settings yet because 
> the clock is stopping between each byte transferred. See attached logic
> analyzer printout. Is this normal? 

Hard to say.  I only use DMA mode, transferring blocks of 1024 32-bit
words.  I suspect that you are using PIO mode (not sure on that).  Still
I am puzzled about the gaps between bytes, even in PIO mode, I would
think the driver would load the TX FIFO faster than 1us.  Gaps between
FIFO loads don't surprise me; interrupt latency for Linux running on a
PXA255 seems to be about 100-200us on average.

> Does this indicate a setting that
> needs to be tweaked? Is the DMA not keeping up? 

Is this really DMA mode?  I can't see why there would be gaps unless the
 burst was set low.  I have never actually looked at the bus, so I don't
know if this is normal.  My system runs on an external 11.2MHz clock,
and uses read-without-transmit (RWOT) (this driver is really runs as a
slave, but it does not have to know that) so there is no way to measure
what the DMA engine is doing internally between the FIFO and the memory.

Burst and threshold should have defaulted to 8/8/8 for DMA mode and
8-bit transfers.  Those should be the best settings.

In this protocol, are the transfers that you show single byte transfers
or should they have been many bytes?  If each is a single transfer, then
I am not surprise to see 1us gaps; there is a lot more processing that
goes on between transfers, than between the bytes of one transfer.

I debug this stuff with a large /proc file that shows me all the
register and variable values at the last entry to an interrupt routine.
 This is one of the things that makes my version of the driver huge, by
comparison with the standard driver. Every time I look back at where I
started, I am surprised by the simplicity of the original! :-)

> The chip should be
> capable of up to 75MHz, and in the printout, it is obvious that the
> chip is ready before the PXA. I also tested PIO mode and it looks
> identical.

Since the interface only operates a 13MHz max, I doubt you expect to
reach 75MHz.  :-)

> The gaps indicate a 1MHZ period so I tried 1MHz. That was fine. I tried
> 2MHz and it is still fine. Requesting 4MHz (actual 3.125), there is a
> short pause after the first byte, but then it is fine. It might be a PXA
> SSP controller "bug"?

OK, now I am confused again.  Your trace shows about 600ns/byte, which
is a bit-clock of 13MHz, not 1, 2 or 3.1.  I'm not sure what you are
asking here.  I am not aware of any bugs that would make the interface
slow.  Are you saying that the byte rate is actually faster if you
request a slower SSPSCLK?

> <opinion> As a user, it would seem that the SSP should work with
> minimum fuss. If there are values that enable 99% of devices to work,
> then why would you *not* want them to be the defaults? If the user
> needs to tweak the values because they need more performance, then they
> can. But if they only need a low bandwidth connection, causing
> transfers to hang because they did not provide a "know-able" value
> seems less than useful. I know it took me entirely too long to get this
> working. I am only trying to help the next user that needs this.
> </opinion>

I agree with your sentiment.  What I am not sure of is whether there are
even 90% of applications that could use a single group of settings.  I
think the DMA burst and the thresholds could likely be set to reasonable
defaults: burst = bits/word (for 8, 16, and 32 bit words, this results
in burst equaling half the FIFO), and thresholds of 8/8 (again, half the
FIFO).  For the timeout, I'm less sure of the best approach; probably it
should be very long, a millisecond or more (if we know what that
translates to on a PXA270), and let users reduce it if they want faster
response.  My main concern is the poor documentation of this in the PXA
developer's manuals.

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
