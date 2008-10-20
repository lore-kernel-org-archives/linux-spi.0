From: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: a question about atmel_spi Linux driver
Date: Mon, 20 Oct 2008 11:45:08 +0200
Message-ID: <20081020114508.3b5575b5@hskinnemo-gx745.norway.atmel.com>
References: <106f03a70810200045o7108a090ka29fb5ba505b6f01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Andrei Rylin" <port777-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <106f03a70810200045o7108a090ka29fb5ba505b6f01-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

"Andrei Rylin" <port777-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Haavard,
> sorry to indrude, I have a quick question about
> cs_change in the last spi_transfer of spi_message chain,
> as handled by atmel_spi driver:
> 
> in atmel_spi_interrupt():
> 
> if (atmel_spi_xfer_is_last(msg, xfer)) {
>         /* report completed message */
>         atmel_spi_msg_done(master, as, msg, 0,
>                         xfer->cs_change);
> 
> That shall de-assert CS if cs_change != 0, right ?

Not necessarily.

> Now look in atmel_spi_msg_done():
> 
> static void
> atmel_spi_msg_done(struct spi_master *master, struct atmel_spi *as,
>                 struct spi_message *msg, int status, int stay)
> {
>         if (!stay || status < 0)
>                 cs_deactivate(as, msg->spi);
> 
> I see the opposite: CS stays asserted.
> Is it a bug or intentional ?

It is intentional. For the last transfer in a message, the default is
to deassert CS. cs_change will change that default and make it stay
asserted (though if a message to a different device comes along, it
will eventually get deasserted.)

For a transfer which is not the last in a message, the default is for
CS to stay asserted, so cs_change will cause CS to be deasserted
briefly and then re-asserted.

I've been fooled by this before too, but the latest documentation is
pretty clear.

Haavard

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
