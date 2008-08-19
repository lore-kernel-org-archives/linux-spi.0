From: "Daniel Ribeiro" <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] pxa2xx_spi: wait_rx_stall before
	deasserting CS on PIO mode
Date: Tue, 19 Aug 2008 02:58:58 -0300
Message-ID: <6669365c0808182258t6c4a5086xd9425435930e6d8f@mail.gmail.com>
References: <6669365c0808171553i3f64b667t18fcea589d94411a@mail.gmail.com>
	<48A9C515.3000908@whoi.edu>
	<6669365c0808181227k2fa01d6fu570cebc10630f55d@mail.gmail.com>
	<48A9DFD9.9000708@whoi.edu>
	<6669365c0808181606u4ead2f27h1f2286f9365e8a7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6669365c0808181606u4ead2f27h1f2286f9365e8a7a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Hi!

You were right, there is nothing wrong with the spi transfer.

The problem is the hardware. This chip really needs some delay before
deasserting CS on register writes. Otherwise it just silently ignores
the register write.

I no longer think that anything is wrong with spi communication, i can
reliably read any chip register. The problem only occurs on register
writes, and not even on all registers.

On giveback(), if i add a delay _before_ cs_control(CS_DEASSERT), it works.
If i add it just _after_ cs_control() it does not work.

I see that there is a .delay_usecs field on spi_transfer:

 * @delay_usecs: microseconds to delay after this transfer before
 *      (optionally) changing the chipselect status, then starting
 *      the next transfer or completing this @spi_message.

But it is only called for the previous transfer when on RUNNING_STATE,
so a second spi_transfer is needed on the same spi_message to actually
use this feature.

Should i submit a patch to use this delay_usecs field also on
DONE_STATE, so it actually do something when set on the last
spi_transfer? Or should i just cheat pxa2xx_spi with:

        struct spi_transfer t[2];
        struct spi_message m;

        spi_message_init(&m);
        t[0].len = 4;
        t[0].tx_buf = (u8 *)data;
        t[0].rx_buf = (u8 *)data;
        t[0].bits_per_word = 32;
        t[0].delay_usecs = 300;
        spi_message_add_tail(&t[0], &m);

        /* trick pxa2xx_spi so it uses t[0].delay_usecs */
        t[1].len = 0;
        spi_message_add_tail(&t[1], &m);

        return spi_sync(pcap.spi, &m);

(with the above code my chip works great without changes to pxa2xx_spi.c)

My opinion is that this field should be used to delay also on
DONE_STATE: "microseconds to delay after this transfer before changing
the chipselect status, then starting the next transfer
*or*completing*this*spi_message*"

I will be happy to submit a patch to change this if you think the
delay on DONE_STATE is acceptable.

-- 
Daniel Ribeiro

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
