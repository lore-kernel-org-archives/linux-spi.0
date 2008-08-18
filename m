From: "Daniel Ribeiro" <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] pxa2xx_spi: wait_rx_stall before
	deasserting CS on PIO mode
Date: Mon, 18 Aug 2008 16:27:32 -0300
Message-ID: <6669365c0808181227k2fa01d6fu570cebc10630f55d@mail.gmail.com>
References: <6669365c0808171553i3f64b667t18fcea589d94411a@mail.gmail.com>
	<48A9C515.3000908@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48A9C515.3000908-/d+BM93fTQY@public.gmane.org>
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

On Mon, Aug 18, 2008 at 3:53 PM, Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:
> Can you be more specific about your problem?  If CS is not being
> asserted/deasserted at the right times, then that needs to be fixed.
> What are you using for CS; this driver only works correctly when a GPIO
> pin is assigned for CS, and is controlled with the cs_control() callback.

Yes, I=B4m using a gpio for CS. cs_control is OK.

> The below patch seems to paper over some other problem.
> wait_ssp_rx_stall() is used to recover from errors, by flushing and
> discarding words from the RX fifo.  Also, int_transfer_complete() is
> only called from places where we know that all expected characters have
> been received and transferred to memory.

Not really, something is really wrong with the call to int_transfer_complet=
e.
If i replace the wait_ssp_rx_stall() call with a simple printk() call every=
thing
works just fine. Same with an udelay(300).
I may be wrong, but it seems that interrupt_transfer calls int_transfer_com=
plete
after the total amount of data is put on the FIFO, but it does not
guarantee that
the IO is actually done before calling it.

> This patch would "fix" a situation where extra words are in the RX FIFO
> after the expected number have been read.  If there are more characters
> in the FIFO than were transmitted, then that needs to be fixed and not
> ignored.
>
> Can you provide a patch or more information that addresses the
> underlying problem?

As I already said, i am converting a working driver from ssp.c=B4s
ssp_read_word/ssp_write_word to pxa2xx_spi. The driver works just
fine with:

gpio_set_value(cs, 0);
ssp_write_word(&ssp_dev, data);
ssp_read_word(&ssp_dev, &ret);
gpio_set_value(cs, 1);

After the conversion i ended with this code:
static int ezx_pcap_putget(u32 *data)
{
        struct spi_transfer t;
        struct spi_message m;

        spi_message_init(&m);
        t.len =3D 4;
        t.tx_buf =3D (u8 *)data;
        t.rx_buf =3D (u8 *)data;
        t.bits_per_word =3D 32;
        spi_message_add_tail(&t, &m);
        return spi_sync(pcap.spi, &m);
}

The driver is a for a PMIC, it has 32 25bit registers, which i need to
access trough 32bit spi IO.
Without the wait_ssp_rx_stall patch (or any other delay before the
CS_DEASSERT) this is what i get:

pcap_read: reg_num:3 value:00edf48a
pcap_write: reg_num:3 value:00123456
pcap_read: reg_num:3 value:00edf48a
pcap_read: reg_num:3 value:00edf48a

With the patch, or with an udelay(300) call instead of wait_ssp_rx_stall:
pcap_read: reg_num:3 value:00edf48a
pcap_write: reg_num:3 value:00123456
pcap_read: reg_num:3 value:00123456
pcap_read: reg_num:3 value:00123456

Since the udelay(300) call works, and it doesnt touch the ssp registers,
it looks like int_transfer_complete is being called before it should.

-- =

Daniel Ribeiro

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
