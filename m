From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RESEND] spi/tegra114: Correct support for cs_change
Date: Mon, 23 Sep 2013 16:08:09 -0700
Message-ID: <CA+7tXiiNMwyQh9sCsW4Qkid9Tn8RTcQ-uUmNse+kK-PZro1pyQ@mail.gmail.com>
References: <1379528245-6283-1-git-send-email-rklein@nvidia.com>
	<52408DC8.3020407@wwwdotorg.org>
	<52409B1E.3030405@nvidia.com>
	<52409D63.3020909@wwwdotorg.org>
	<5240AC3A.9060206@nvidia.com>
	<5240AF20.8030301@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5240AF20.8030301-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 23, 2013 at 2:14 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>
> That sounds broken. Normally, shouldn't CS assert before a transaction,
> stay asserted during a transaction, then deassert after the transaction?
> It shouldn't rise and fall very quickly in between parts of the transaction.

That is normal, where a transaction is a spi_message made up of
multiple spi_transfers.  The cs_change bit for a transfer will insert
a de-asserted pulse after a transfer or leave CS de-asserted after the
last transfer.

>>>> need to generate a falling-edge to trigger the beginning of a SPI
>>>> transaction. Doing this write with the default value of SPI_COMMAND1
>>>> causes a brief rise and fall of CS, giving us our falling-edge.

I wonder, is the real problem that the spi layer allows CS to possibly
remain asserted between transactions to the same device?  Normally you
would expect it to be de-asserted at the end of a spi_message, but I
believe the Linux spi semantics are that it may or may not actually be
de-asserted at that time.  It only guarantees that is will be
de-asserted before a message to a different device starts.

I guess this is supposed to be an optimization.  Some drivers, like
gpio bit-banging, probably have a cost associated with any CS change.
Usually many messages in a row are to the same device.  Most devices
don't care if CS pulses between messages.  Thus not pulsing CS between
each message is faster.

>>
>> Otherwise, this logic allows us to skip the spi of COMMAND1 which would
>> normally be used to create the falling edge to start a new transaction,
>> leaving the previous one open for more transfers.
>
> This sounds like something the SPI core should be managing. If a driver
> is using the SPI bus to communicate with a device in a way that needs CS
> left active while outside a transaction, it shouldn't be possible for
> another driver to come along and communicate with another device before
> the first transaction is all complete. The bus should be locked.
> Allowing anything else could corrupt the protocol that required specific
> CS states outside the transaction.

If the transaction is one message, which can be multiple transfers and
multiple CS pulses, then the spi core always does it atomically.  The
limitation is the driver can't get the result of the transaction until
the entire transaction is finished.

If a driver needs to get part of a transaction to complete the rest,
e.g. read a 16-bit length from the device and then read that many
bytes, it can still be done.  It doesn't seem to be documented in
spi-summary, but the way to do this is with spi_bus_(un)lock() and
spi_(a)sync_locked() calls.  The driver must lock the bus, used the
_locked versions to issue spi_messages, then unlock when done.  This
should prevent another device on the bus from getting a messages, and
thus CS pulses, in the middle of the transaction.
