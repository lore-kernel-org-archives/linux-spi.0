From: "Daniel Ribeiro" <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] pxa2xx_spi: wait_rx_stall before
	deasserting CS on PIO mode
Date: Mon, 18 Aug 2008 20:06:36 -0300
Message-ID: <6669365c0808181606u4ead2f27h1f2286f9365e8a7a@mail.gmail.com>
References: <6669365c0808171553i3f64b667t18fcea589d94411a@mail.gmail.com>
	<48A9C515.3000908@whoi.edu>
	<6669365c0808181227k2fa01d6fu570cebc10630f55d@mail.gmail.com>
	<48A9DFD9.9000708@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48A9DFD9.9000708-/d+BM93fTQY@public.gmane.org>
Content-Disposition: inline
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

On Mon, Aug 18, 2008 at 5:47 PM, Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:
> So far this looks good, but what have you declared about the chip in the
> chip_info structure?  In particular, what timeout and FIFO thresholds?
> What processor are you using, and which port on that processor; there is
> a difference in the handling of the end of a transfer between the SSP
> port on an PXA25x (which has no timeout interrupt) and all other ports
> handled by this driver (including the NSSP port on the PXA25x and all
> the ports on the PXA270).

.tx_threshold =3D 1,
.rx_threshold =3D 1,
.timeout =3D 1000,

Its a PXA270, SSP1.

>> pcap_read: reg_num:3 value:00edf48a
>> pcap_write: reg_num:3 value:00123456
>> pcap_read: reg_num:3 value:00edf48a
>> pcap_read: reg_num:3 value:00edf48a
>>
>> With the patch, or with an udelay(300) call instead of wait_ssp_rx_stall:
>> pcap_read: reg_num:3 value:00edf48a
>> pcap_write: reg_num:3 value:00123456
>> pcap_read: reg_num:3 value:00123456
>> pcap_read: reg_num:3 value:00123456
>>
>> Since the udelay(300) call works, and it doesnt touch the ssp registers,
>> it looks like int_transfer_complete is being called before it should.
>
> Very strange, but I can't draw the same conclusion.
> int_transfer_complete is only called from 4 places in int_transfer, and
> then only after verifying that the full count of receive characters has
> been transfered to memory.  Even if the transfer was not complete in
> hardware, or if the CS was dropped too soon, this delay would not fix
> the problem.  There has to be something else going on.
> I am not familiar with the chip you are using.  Are you certain that
> when you write a register, you should expect back the same value that
> you wrote, when received on the same transfer.  It makes sense that the
> chip might do this, but I thought I should ask, because there are other
> possibilities.

Its not the same transfer. pcap_read and pcap_write each call pcap_putget.
So, to _write_a_register_ i write then read a spi word. And to _read_a_regi=
ster_
i write then read another spi word. Those write/read register operations ca=
n=B4t
happen on the same CS assertion.

> One thing that is odd about the setup of your message is the use of the
> same buffer for transmit and receive.  I agree that this should be
> possible, as nothing is received until the corresponding word has been
> transmitted.  However, this might be obscuring some of the symptoms.
> Can you try assigning separate buffers for tx and rx, and then test to
> see what the results are with and without the added delay?  This might
> shed some more light on what is happening.

I tried this already, used different buffers, and it makes no difference, s=
ame
wrong behaviour without the delay, and the same correct behaviour with the
delay. The fact of using the same buffer is not the issue.

> Also try setting up the pxa2xx_spi driver to the correct bits-per-word
> though chip_info and spi_setup(), and turn off (make 0) the per-transfer
> bits-per-word, above.  This will test to see if there is an error
> handling the per-transfer changes.  I don't think many applications use
> the per-transfer changes, so that is another possible source of problems.

Same. This doesnt seem to be the issue, as it only changes the ->read and
->write pointers from u8_(reader|writer) to u32_(reader|writer), i
certified that
the u32 functions are being used, this is enough for me.
It seems that checking the full count of receive/transmit bytes that
_gets_in/out_the_FIFO_ is not enough to assert that the data is actually
_transfered_to_the_hardware_.


I will try to explain how i came to this patch a little more verbose, see if
agree with me now:

do {
      if (drv_data->read(drv_data)) {
         int_transfer_complete(drv_data);
         return IRQ_HANDLED;
      }
   } while (drv_data->write(drv_data));

So, if i use u32_writer/u32_reader (t.bits_per_word =3D 32)
to write/read a _single_ 32bits word (t.len =3D 4),
the relevant code path on the above loop would be:

first u32_reader call:
read_SSSR(reg) & SSSR_RNE /* FIFO is still empty, u32_reader returns 0 */

first u32_writer call:
write_SSDR(*(u32 *)(drv_data->tx), reg);
drv_data->tx +=3D 4;
/* data is transfered to FIFO, writer returns 1 */

second u32_reader call:
*(u32 *)(drv_data->rx) =3D read_SSDR(reg);
drv_data->rx +=3D 4;
/* u32_reader doesnt loop becase rx =3D=3D rx_end, reader returns 1 */

then it calls int_transfer_complete.

I dont see where it asserts that the hardware transfer was done. Or
read_SSDR/write_SSDR do blocking???

Shouldnt the driver wait SSSR_RNE be cleared before assuming that the
data was received?
while(read_SSSR(reg) & SSSR_RNE) ;

Shouldnt it wait SSSR_TNF be set, before assuming the data was written?
while(!(read_SSSR(reg) & SSSR_TNF)) ;

Shouldnt it check if the SSP port is not doing IO (SSSR_BSY) before
calling int_transfer_done?
while(read_SSSR(reg) & SSSR_BSY) ;

Any of the above 3 blocking loops on the first line of
int_transfer_complete() fixes the problem. :)
(yes, TNF works too, because threshold =3D 1. ;) )

And finally, note that ssp_rx_stall() doesnt reads/discards any _data_
from the port as you claimed,
it is just a busy loop, equivalent to the third (SSSR_BSY) example above.
And it IS called on dma_transfer_complete (by the way, when i
configure the driver to use DMA,
everything works as it should).

-- =

Daniel Ribeiro

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
