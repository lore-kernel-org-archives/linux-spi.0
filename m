From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [PATCH] pxa2xx_spi: wait_rx_stall before
 deasserting CS on PIO mode
Date: Tue, 19 Aug 2008 12:48:59 -0400
Message-ID: <48AAF97B.8000800@whoi.edu>
References: <6669365c0808171553i3f64b667t18fcea589d94411a@mail.gmail.com>	
	<48A9C515.3000908@whoi.edu>	
	<6669365c0808181227k2fa01d6fu570cebc10630f55d@mail.gmail.com>	
	<48A9DFD9.9000708@whoi.edu>	
	<6669365c0808181606u4ead2f27h1f2286f9365e8a7a@mail.gmail.com>
	<6669365c0808182258t6c4a5086xd9425435930e6d8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6669365c0808182258t6c4a5086xd9425435930e6d8f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Daniel Ribeiro wrote:
> Hi!
> 
> You were right, there is nothing wrong with the spi transfer.
> 
> The problem is the hardware. This chip really needs some delay before
> deasserting CS on register writes. Otherwise it just silently ignores
> the register write.
> 
> I no longer think that anything is wrong with spi communication, i can
> reliably read any chip register. The problem only occurs on register
> writes, and not even on all registers.
> 
> On giveback(), if i add a delay _before_ cs_control(CS_DEASSERT), it works.
> If i add it just _after_ cs_control() it does not work.
> 
> I see that there is a .delay_usecs field on spi_transfer:
> 
>  * @delay_usecs: microseconds to delay after this transfer before
>  *      (optionally) changing the chipselect status, then starting
>  *      the next transfer or completing this @spi_message.
> 
> But it is only called for the previous transfer when on RUNNING_STATE,
> so a second spi_transfer is needed on the same spi_message to actually
> use this feature.

It is true that the delay is implemented only for the case of a message
continuing with another transfer (which is wrong), but also that the
delay is implemented after the CS change that occurs in either
int_transfer_complete or dma_transfer_complete.  Because of this, your
code fragment below works, not because you made the delay_usecs
parameter non-zero, but because you did not make the cs_change parameter
true.  Thus, when the double transfer is executed, the default behavior
of the driver is (correctly) to leave CS asserted through the next
transfer; the delay_usecs parameter adds additional delay, but I bet
that just executing the next zero-length transfer was sufficient delay.

The real problem is that either the delay or the call to deassert CS is
implemented in the wrong place.  It needs to be invoked prior to each
test and call of the cs_change parameter.  There are 3 places where this
could be done: giveback, dma_transfer_complete, and
int_transfer_complete.  By the time pump_transfers is executed, the CS
change, if any, has already taken place, and the next transfer has
already been selected so that pump_transfers has to reach back to
"previous" to fetch the delay, kind of awkward.

The down side of putting the delay in the logical place (before each
test/call for cs_change) is that it moves the udelay() call from soft
interrupt context (pump_transfers executing as a tasklet) to hard
interrupt context.  This is probably a bad idea.  See alternate below.

> Should i submit a patch to use this delay_usecs field also on
> DONE_STATE, so it actually do something when set on the last
> spi_transfer? Or should i just cheat pxa2xx_spi with:
> 
>         struct spi_transfer t[2];
>         struct spi_message m;
> 
>         spi_message_init(&m);
>         t[0].len = 4;
>         t[0].tx_buf = (u8 *)data;
>         t[0].rx_buf = (u8 *)data;
>         t[0].bits_per_word = 32;
>         t[0].delay_usecs = 300;
>         spi_message_add_tail(&t[0], &m);
> 
>         /* trick pxa2xx_spi so it uses t[0].delay_usecs */
>         t[1].len = 0;
>         spi_message_add_tail(&t[1], &m);
> 
>         return spi_sync(pcap.spi, &m);
> 
> (with the above code my chip works great without changes to pxa2xx_spi.c)

Agreed, but the driver still needs to be fixed because it does not
conform to the standard of the SPI core.

Interestingly, you have also stressed another known weakness in the
driver that was the main topic of the thread I pointed you to last
night: that the driver is not guaranteed to handle zero length transfers
properly.  That problem should be fixed at the same time.  One reason
that I have not fixed these known problems lack of time, but the other
reason is that I have no easy way to test them.  Now that there is a
willing tester, it is time to write a patch.

> My opinion is that this field should be used to delay also on
> DONE_STATE: "microseconds to delay after this transfer before changing
> the chipselect status, then starting the next transfer
> *or*completing*this*spi_message*"

I agree the driver needs a patch, but I think the right way to do it is
as follows:

1. Add a check for non-zero delay_usecs and resulting call to udelay in
giveback(), just before the test for cs_change and call to cs_control.
giveback() is executed in tasklet context (soft interrupt) and so this
will be no worst than the current udelay call.

2. Move the test for cs_change and call to cs_control out of both of
int_transfer_complete and dma_transfer complete, and put a single
test/call based on the "previous" pointer within the RUNNING_STATE test
of pump_transfers, and just after the test/execution of the delay.  This

3. Fix any issues with the execution of zero-length transfers.  (I still
have to look at that, but I think that only zero-length, non-descriptor
DMA fails; the current driver does not use descriptor DMA, but my
version does).

4. See if the driver has to handle transfers longer than 8191 bytes.  I
have this question open with David Brownell, and I await an answer, so
there may be action needed with that, though it could be implemented
separately at a later time.

> I will be happy to submit a patch to change this if you think the
> delay on DONE_STATE is acceptable.

Given that there is a bit more to this, and that we should try to make
this apply to earlier stable kernels, maybe I should try to write the
patch.  I will get back, hopefully today, with something.

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
