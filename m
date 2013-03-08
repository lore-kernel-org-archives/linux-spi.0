From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] spi: add driver for BCM2835
Date: Thu, 07 Mar 2013 22:48:09 -0700
Message-ID: <51397B99.5000504@wwwdotorg.org>
References: <1362538142-19246-1-git-send-email-swarren@wwwdotorg.org>
	<20130306040520.GA4896@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130306040520.GA4896-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 03/05/2013 09:05 PM, Mark Brown wrote:
> On Tue, Mar 05, 2013 at 07:49:02PM -0700, Stephen Warren wrote:

>> +static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id) 
>> +{
>> 
>> if (cs & BCM2835_SPI_CS_DONE) { if (bs->len) { /* first interrupt
>> in a transfer */ /* fill the TX fifo with up to 16 bytes */ 
>> bcm2835_wr_fifo(bs, 16); } else { /* transfer complete */ /*
>> disable SPI interrupts */ cs &= ~(BCM2835_SPI_CS_INTR |
>> BCM2835_SPI_CS_INTD); bcm2835_wr(bs, BCM2835_SPI_CS, cs);
>> 
>> /* wake up our bh */ complete(&bs->done); } } else if (cs &
>> BCM2835_SPI_CS_RXR) { /* read 12 bytes of data */ 
>> bcm2835_rd_fifo(bs, 12);
>> 
>> /* write up to 12 bytes */ bcm2835_wr_fifo(bs, 12); }
> 
> I'd feel happier if these were independent statements in case both
> are asserted simultaneously.

I don't think it would be correct to make that change.

As background, CS_DONE is really "TX FIFO EMPTY" per the description
in the documentation.

When TA (Transfer Active) is set by bcm2835_spi_start_transfer(),
CS_DONE will immediately become set, and cause an interrupt. This will
cause the if/if (first interrupt in a transfer) case above to execute,
and the FIFO to be filled with up to 16 bytes. Once 12 of those bytes
have been transferred, CS_RXR (RX FIFO needs Reading) will be set
causing an interrupt, which will trigger the else case. At the end of
the message, we stop filling the TX FIFO, and so it eventually drains
completely, and CS_DONE fires again, causing the if/else (transfer
complete) path to be taken.

In the end-of-transfer case, it's possible CS_RXR may also be set,
since the last chunk of the transfer might just happen to be 12 bytes.
However, we don't want to execute the else cause to drain the FIFO,
since the CS_DONE case completes the completion, which then allows
bcm2835_spi_finish_transfer() to drain the FIFO based on the RXD (RX
FIFO has Data) field. Doing it in the IRQ handler too would confuse
things. I guess this SoC only has a CPU so it'd work out fine, but
it's probably best not to rely on it.

Also, I do wonder what happens if we process the CS_RXR interrupt too
late though, and CS_DONE gets set before we've transferred the entire
message simply because the FIFO drained unexpectedly.

With the current code, we'd simply write 16 bytes to the TX FIFO and
not read the RX FIFO, thus likely falling out of sync and overflowing
the TX FIFO next time around.

Equally, with your suggestion modification, we'd fill the TX FIFO with
16 bytes in the first if block, then again with 12 more bytes in the
second if block, and likely overflow the FIFO.

Perhaps the test order should be more like:

if (cs & RXR) {
    drain 12 bytes from RX FIFO
    write up to 12 bytes to TX FIFO
} else if (cs & DONE) {
    if (len)
        write up to 16 bytes to TX FIFO
    else
        finish transfer
}

And again the second block should be an else not an independent if, so
that if RXR was processed late, we don't end up writing first 12 then
16 bytes to the TX FIFO at once.

Does that all make sense?

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
