From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [PATCH] pxa2xx_spi: wait_rx_stall before
 deasserting CS on PIO mode
Date: Mon, 18 Aug 2008 16:47:21 -0400
Message-ID: <48A9DFD9.9000708@whoi.edu>
References: <6669365c0808171553i3f64b667t18fcea589d94411a@mail.gmail.com>	
	<48A9C515.3000908@whoi.edu>
	<6669365c0808181227k2fa01d6fu570cebc10630f55d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6669365c0808181227k2fa01d6fu570cebc10630f55d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
> On Mon, Aug 18, 2008 at 3:53 PM, Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrot=
e:
>> Can you be more specific about your problem?  If CS is not being
>> asserted/deasserted at the right times, then that needs to be fixed.
>> What are you using for CS; this driver only works correctly when a GPIO
>> pin is assigned for CS, and is controlled with the cs_control() callback.
> =

> Yes, I=B4m using a gpio for CS. cs_control is OK.

OK.

>> The below patch seems to paper over some other problem.
>> wait_ssp_rx_stall() is used to recover from errors, by flushing and
>> discarding words from the RX fifo.  Also, int_transfer_complete() is
>> only called from places where we know that all expected characters have
>> been received and transferred to memory.
> =

> Not really, something is really wrong with the call to int_transfer_compl=
ete.
> If i replace the wait_ssp_rx_stall() call with a simple printk() call eve=
rything
> works just fine. Same with an udelay(300).
> I may be wrong, but it seems that interrupt_transfer calls int_transfer_c=
omplete
> after the total amount of data is put on the FIFO, but it does not
> guarantee that
> the IO is actually done before calling it.

Well, if you get the same effect by using a delay, then the problem is
not extra data in the fifo.  If you read the code in the driver
carefully, I think you will find that int_transfer_complete is called
after every expected character is read from the FIFO and after that
point, there is no opportunity to read anymore characters to memory.  I
am puzzled as to why a delay in int_transfer_complete would have any
influence because nothing is read from the FIFO to memory after it is
called.  See a suggestion below.

>> This patch would "fix" a situation where extra words are in the RX FIFO
>> after the expected number have been read.  If there are more characters
>> in the FIFO than were transmitted, then that needs to be fixed and not
>> ignored.
>>
>> Can you provide a patch or more information that addresses the
>> underlying problem?
> =

> As I already said, i am converting a working driver from ssp.c=B4s
> ssp_read_word/ssp_write_word to pxa2xx_spi. The driver works just
> fine with:
> =

> gpio_set_value(cs, 0);
> ssp_write_word(&ssp_dev, data);
> ssp_read_word(&ssp_dev, &ret);
> gpio_set_value(cs, 1);
> =

> After the conversion i ended with this code:
> static int ezx_pcap_putget(u32 *data)
> {
>         struct spi_transfer t;
>         struct spi_message m;
> =

>         spi_message_init(&m);
>         t.len =3D 4;
>         t.tx_buf =3D (u8 *)data;
>         t.rx_buf =3D (u8 *)data;
>         t.bits_per_word =3D 32;
>         spi_message_add_tail(&t, &m);
>         return spi_sync(pcap.spi, &m);
> }

So far this looks good, but what have you declared about the chip in the
chip_info structure?  In particular, what timeout and FIFO thresholds?
What processor are you using, and which port on that processor; there is
a difference in the handling of the end of a transfer between the SSP
port on an PXA25x (which has no timeout interrupt) and all other ports
handled by this driver (including the NSSP port on the PXA25x and all
the ports on the PXA270).

> The driver is a for a PMIC, it has 32 25bit registers, which i need to
> access trough 32bit spi IO.
> Without the wait_ssp_rx_stall patch (or any other delay before the
> CS_DEASSERT) this is what i get:

OK, this should be possible.

> pcap_read: reg_num:3 value:00edf48a
> pcap_write: reg_num:3 value:00123456
> pcap_read: reg_num:3 value:00edf48a
> pcap_read: reg_num:3 value:00edf48a
> =

> With the patch, or with an udelay(300) call instead of wait_ssp_rx_stall:
> pcap_read: reg_num:3 value:00edf48a
> pcap_write: reg_num:3 value:00123456
> pcap_read: reg_num:3 value:00123456
> pcap_read: reg_num:3 value:00123456
> =

> Since the udelay(300) call works, and it doesnt touch the ssp registers,
> it looks like int_transfer_complete is being called before it should.

Very strange, but I can't draw the same conclusion.
int_transfer_complete is only called from 4 places in int_transfer, and
then only after verifying that the full count of receive characters has
been transfered to memory.  Even if the transfer was not complete in
hardware, or if the CS was dropped too soon, this delay would not fix
the problem.  There has to be something else going on.

I am not familiar with the chip you are using.  Are you certain that
when you write a register, you should expect back the same value that
you wrote, when received on the same transfer.  It makes sense that the
chip might do this, but I thought I should ask, because there are other
possibilities.

One thing that is odd about the setup of your message is the use of the
same buffer for transmit and receive.  I agree that this should be
possible, as nothing is received until the corresponding word has been
transmitted.  However, this might be obscuring some of the symptoms.
Can you try assigning separate buffers for tx and rx, and then test to
see what the results are with and without the added delay?  This might
shed some more light on what is happening.

Also try setting up the pxa2xx_spi driver to the correct bits-per-word
though chip_info and spi_setup(), and turn off (make 0) the per-transfer
bits-per-word, above.  This will test to see if there is an error
handling the per-transfer changes.  I don't think many applications use
the per-transfer changes, so that is another possible source of problems.

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
