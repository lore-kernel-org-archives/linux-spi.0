From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [PATCH] pxa2xx_spi: wait_rx_stall before
 deasserting CS on PIO mode
Date: Tue, 19 Aug 2008 01:58:44 -0400
Message-ID: <48AA6114.2060805@whoi.edu>
References: <6669365c0808171553i3f64b667t18fcea589d94411a@mail.gmail.com>	
	<48A9C515.3000908@whoi.edu>	
	<6669365c0808181227k2fa01d6fu570cebc10630f55d@mail.gmail.com>	
	<48A9DFD9.9000708@whoi.edu>
	<6669365c0808181606u4ead2f27h1f2286f9365e8a7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6669365c0808181606u4ead2f27h1f2286f9365e8a7a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
> On Mon, Aug 18, 2008 at 5:47 PM, Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrot=
e:
>> So far this looks good, but what have you declared about the chip in the
>> chip_info structure?  In particular, what timeout and FIFO thresholds?
>> What processor are you using, and which port on that processor; there is
>> a difference in the handling of the end of a transfer between the SSP
>> port on an PXA25x (which has no timeout interrupt) and all other ports
>> handled by this driver (including the NSSP port on the PXA25x and all
>> the ports on the PXA270).
> =

> .tx_threshold =3D 1,
> .rx_threshold =3D 1,
> .timeout =3D 1000,

The timeout is short (but may not be a problem for you, with only one
word transfers); we are having that discussion in another thread.  The
original author of this driver, Stephen Street, intended for the 1000
default timeout to be 1000usec.  Later we discovered that the
developer's manuals for the PXA25x and PXA270 processors do not specify
what frequency is being counted by the timer.  I have shown that on the
PXA255 it is counting 99.5MHz, but since both Stephen and I are using
PXA255, we do not know what clock is used on the PXA270 or the newer
PXA3xx.  Perhaps you could set up a test to answer that for the PXA 270,
but I digress.

At 99.5MHZ, a timer count of 1000 is only 10usec.  If the PXA270 uses
the same clock, you may be getting a timer interrupt before the hardware
even has time to clock out the bits, if you use a slow SSPSCLK.  I use a
value of 10000 with DMA driven transfers at 11MHZ, but I never want a
timeout to occur (my data flow is continuous, a timeout is an error); a
value of 100000 is more reasonable for PIO of large transfers, unless
you don't mind extra timeout interrupts that might occur when there are
latencies in processing (both PIO and DMA modes should be able to deal
with this, though in different ways).

I'm not sure that this has anything to do with your problem, though,
because with 1 word transfers, it should not matter if the single word
read is read by the read-while-transmit loop of int_transfer, or if it
is read (more commonly) by the timeout loop (higher in the same
routine); nor should it matter if the timeout interrupt is invoked more
than once to check the receiver fifo. The one data word should be there
already, or the driver will wait for the another timeout (the timer is
only stopped in int_transfer_complete, and that is only called after all
data is received).

Note that if the timeout interrupt occurs before the last (or in your
case, only) word arrives in the RX FIFO, then the timer will later be
reset when the word actually does arrive, and will thus timeout again.
There is a possible race condition that is correctly handled in the
driver by clearing the SSSR_TINT bit BEFORE checking for words in the
FIFO.  Otherwise, if the TINT bit were cleared afterward, the data word
might arrive after checking for data and before clearing the TINT bit,
thus setting up a situation where the timeout interrupt never gets set
again.

Hmmm... I guess all of the above is just me re-learning how the timeout
works, and is thus just for background information.  It looks like it
does not matter that much if the timeout is short or long: if it is too
short, there will be wasted interrupt services with nothing important to
do, and if it is too long then transfers are delayed unnecessarily, but
the data still flows.

> Its a PXA270, SSP1.
> =

>>> pcap_read: reg_num:3 value:00edf48a
>>> pcap_write: reg_num:3 value:00123456
>>> pcap_read: reg_num:3 value:00edf48a
>>> pcap_read: reg_num:3 value:00edf48a
>>>
>>> With the patch, or with an udelay(300) call instead of wait_ssp_rx_stal=
l:
>>> pcap_read: reg_num:3 value:00edf48a
>>> pcap_write: reg_num:3 value:00123456
>>> pcap_read: reg_num:3 value:00123456
>>> pcap_read: reg_num:3 value:00123456
>>>
>>> Since the udelay(300) call works, and it doesnt touch the ssp registers,
>>> it looks like int_transfer_complete is being called before it should.
>> Very strange, but I can't draw the same conclusion.
>> int_transfer_complete is only called from 4 places in int_transfer, and
>> then only after verifying that the full count of receive characters has
>> been transfered to memory.  Even if the transfer was not complete in
>> hardware, or if the CS was dropped too soon, this delay would not fix
>> the problem.  There has to be something else going on.
>> I am not familiar with the chip you are using.  Are you certain that
>> when you write a register, you should expect back the same value that
>> you wrote, when received on the same transfer.  It makes sense that the
>> chip might do this, but I thought I should ask, because there are other
>> possibilities.
> =

> Its not the same transfer. pcap_read and pcap_write each call pcap_putget.
> So, to _write_a_register_ i write then read a spi word. And to _read_a_re=
gister_
> i write then read another spi word. Those write/read register operations =
can=B4t
> happen on the same CS assertion.

Ahhh...  Sorry for the confusion.  I thought the above results were
supposed to show what was received during the receive portion of the
same transfer that was doing the writing.  No wonder we are talking at
cross purposes.  So, if I now understand, the write is simply failing,
and subsequent reads show the data unchanged from before the write.

>> One thing that is odd about the setup of your message is the use of the
>> same buffer for transmit and receive.  I agree that this should be
>> possible, as nothing is received until the corresponding word has been
>> transmitted.  However, this might be obscuring some of the symptoms.
>> Can you try assigning separate buffers for tx and rx, and then test to
>> see what the results are with and without the added delay?  This might
>> shed some more light on what is happening.
> =

> I tried this already, used different buffers, and it makes no difference,=
 same
> wrong behaviour without the delay, and the same correct behaviour with the
> delay. The fact of using the same buffer is not the issue.

OK. Thanks for the info.

>> Also try setting up the pxa2xx_spi driver to the correct bits-per-word
>> though chip_info and spi_setup(), and turn off (make 0) the per-transfer
>> bits-per-word, above.  This will test to see if there is an error
>> handling the per-transfer changes.  I don't think many applications use
>> the per-transfer changes, so that is another possible source of problems.
> =

> Same. This doesnt seem to be the issue, as it only changes the ->read and
> ->write pointers from u8_(reader|writer) to u32_(reader|writer), i
> certified that
> the u32 functions are being used, this is enough for me.

Well, the u32 functions will be used regardless of whether you specify
32 bits/word as the default (through setup) or whether you specify it
per-transfer.  In any case, you tested this also, and it is ok.

> It seems that checking the full count of receive/transmit bytes that
> _gets_in/out_the_FIFO_ is not enough to assert that the data is actually
> _transfered_to_the_hardware_.

Now that I realize that you are talking about separate write and read
transfers, I will try to explain in that context.  Note that we are
discussing PIO mode below, DMA has similar but different considerations.

Checking the received bytes is a perfect measure of bytes transmitted.
Every SPI transfer, whether one word or many, and whether intended for
the purpose of writing or reading a chip, consists of both transmitting
and receiving.  It is the transmit that causes SSPSCLK to be generated,
and that simultaneously shifts out the transmit data and shifts in the
receive data.  Thus the RX fifo cannot register a received word until
all the clocks have occurred, and all data must be shifted out, and also
all data shifted in.

However, that does not say that the correct thing happened with the chip
select, just that there is a clock pulse on the wire for every bit of
the transfer.

> I will try to explain how i came to this patch a little more verbose, see=
 if
> agree with me now:
> =

> do {
>       if (drv_data->read(drv_data)) {
>          int_transfer_complete(drv_data);
>          return IRQ_HANDLED;
>       }
>    } while (drv_data->write(drv_data));
> =

> So, if i use u32_writer/u32_reader (t.bits_per_word =3D 32)
> to write/read a _single_ 32bits word (t.len =3D 4),
> the relevant code path on the above loop would be:
> =

> first u32_reader call:
> read_SSSR(reg) & SSSR_RNE /* FIFO is still empty, u32_reader returns 0 */

Yes.

> first u32_writer call:
> write_SSDR(*(u32 *)(drv_data->tx), reg);
> drv_data->tx +=3D 4;
> /* data is transfered to FIFO, writer returns 1 */

Yes.

> second u32_reader call:
> *(u32 *)(drv_data->rx) =3D read_SSDR(reg);
> drv_data->rx +=3D 4;
> /* u32_reader doesnt loop becase rx =3D=3D rx_end, reader returns 1 */

Not necessarily.  The most likely action at this point is that
u32_reader will find that the RX FIFO is still empty and thus will
return without actually reading; it takes 2.4us to clock out 32 bits at
the maximum clock rate of 13MHz (I think that rate is possible on a
PXA270).  All those extra reads are there, not necessarily to read
anything, but make sure, if anything is in the RX FIFO, that it is read
out to make room for whatever has been put in the TX FIFO.  Without all
these attempted reads, some of which might succeed, it is possible, with
higher TX and RX FIFO thresholds, to overrun the RX FIFO by having more
words in the TX FIFO then there are spaces in the RX FIFO.

At this point, in your case of a one word transfer, the int_transfer
notes that all words have been placed in the TX FIFO and thus disables
the TX Interrupt (TIE).  Then int_transfer returns from interrupt
service, and the processor waits for the timeout interrupt.

When the timeout interrupt occurs, the receiver will be emptied by the
earlier code in int_transfer, at: if (irq_status & SSSR_TINT) {

Then...

> then it calls int_transfer_complete.

Yes, after all the the expected characters have been received, whether
or not that happened during one call to int_transfer or during a second
call responding to the timeout interrupt.

> I dont see where it asserts that the hardware transfer was done. Or
> read_SSDR/write_SSDR do blocking???

u32_reader will not return true unless it has received all bytes, and it
will not receive bytes while the RX fifo is empty.  Thus the driver
blocks in the sense of return from interrupt, and then waits until there
is an interrupt (timeout), so that it can check the receiver again.

> Shouldnt the driver wait SSSR_RNE be cleared before assuming that the
> data was received?
> while(read_SSSR(reg) & SSSR_RNE) ;

It has to wait for SSSR_RNE to be SET to read data, and it does.  If
there are no hardware errors (clock glitches or whatever), then the
receiver cannot have words in it after the last expected one is read
out; none transmitted, none received.  At that point the receiver must
be empty; there is no need to check.

> Shouldnt it wait SSSR_TNF be set, before assuming the data was written?
> while(!(read_SSSR(reg) & SSSR_TNF)) ;

No.  If all data has been received, then, by definition, it was all
transmitted.  The receiver needs a clock to receive, and the clock is
enabled by transmit.  In any case, I don't think you are interpreting
SSSR_TNF correctly.  It is only clear if there are 16 words in the FIFO,
the setting of the threshold is not related to this bit.

Incidentally, in the writers, the actual fifo count is checked for 15,
because the logic of preventing receiver overruns requires that we never
put more than 15 in the transmit fifo; that is, we never want it full
and SSSR_TNF will never be clear.  The loop above will never evaluate
more than once. There must be a delay associated with reading SSSR.  I
don't know what that delay would be, but you may find out, below.

> Shouldnt it check if the SSP port is not doing IO (SSSR_BSY) before
> calling int_transfer_done?
> while(read_SSSR(reg) & SSSR_BSY) ;

That is not necessary.  All data has been clocked.

> Any of the above 3 blocking loops on the first line of
> int_transfer_complete() fixes the problem. :)
> (yes, TNF works too, because threshold =3D 1. ;) )

See above about TNF.  So it is not the value of TNF, but perhaps the
time spent reading it that matters.  I would be interested to know if
putting a printk inside the above while loops ever indicates that they
were evaluated more than once.

The first of your three is effectively part of the readers, you can't
get to int_transfer_complete without satisfying it, so I don't accept
your point.  But keep reading....

> And finally, note that ssp_rx_stall() doesnt reads/discards any _data_
> from the port as you claimed,
> it is just a busy loop, equivalent to the third (SSSR_BSY) example above.
> And it IS called on dma_transfer_complete (by the way, when i
> configure the driver to use DMA,
> everything works as it should).

My apologies.  I misread read_SSSR(ioaddr) as read_SSDR(ioaddr).  It has
been two years since my first descent into the details of this driver,
and I have not revisited wait_ssp_rx_stall recently.  I should not
operate on memory at my age.

Some of the extra work done in dma_transfer complete, prior to clearing
chip select (delay), *might* account for why it works and
int_transfer_complete does not work.

--

It remains to figure out why your fixes help, and what the real problem is.

I think it may go back to your original statement: "I did some tests,
and it looks like CS is being deasserted before the IO is done."

I gather you can scope these signals and measure the timing of CS as it
relates to clock and data.  What does the chip spec say about the
required relationship between CS and the other signals? I gather that
some chips require CS to stay asserted briefly after the end of the
clocks; this is the reason for having spi_transfer.delay_usecs.  Please
measure the delay from the last clock to dropping CS and compare that
with the requirements of the chip, with and without the changes you
tested above.  Does this shed light on the problem?

If the insertion of the register reads you tested above helped (they may
have added 100ns to the time CS is active after the last clock) then you
have stumbled on a known bug in the driver, that had not yet been fixed.
 This bug regarding CS changes was discussed in:

Re: [spi-devel-general] [PATCH] atmel_spi: support zero length transfer

See David's reply of: 2008-02-23 02:37
I raised the question but, since I don't use chip select at all, I have
not produced a patch.  There are other issues discussed there about zero
length transfers in DMA mode, and about doing DMA mapping in transfer(),
rather than in pump_transfers(), just in case you have time on your
hands. :-)

Basically, the spi_transfer.delay_usecs value is supposed to be applied
between the end of a transfer and any change in CS specified by a
spi_transfer.cs_change request.  In this driver, the order is mistakenly
reversed, and the delay is honored AFTER the CS has already changed.
Thus if your chip requires a delay between the end of a transfer and the
change in CS, and you set delay_usecs to request that, it will not be
honored as intended.

-- =

Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=3D7212
http://www.whoi.edu/hpb/Site.do?id=3D1532
http://www.whoi.edu/page.do?pid=3D10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
