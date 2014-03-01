From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: core: make zero length transfer valid again
Date: Sat, 1 Mar 2014 12:40:39 +0100
Message-ID: <4D0588EB-C20C-4B24-B656-6175C2309352@martin.sperl.org>
References: <1393596196-8652-1-git-send-email-anemo@mba.ocn.ne.jp> <20140301041330.GO29849@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>, iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org,
	gsi-ynQEQJNshbs@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140301041330.GO29849-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 01.03.2014, at 05:13, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Feb 28, 2014 at 11:03:16PM +0900, Atsushi Nemoto wrote:
>> Zero length transfer becomes invalid since
>> "spi: core: Validate length of the transfers in message" commit,
>> but it should be valid to support an odd device, for example, which
>> requires long delay between chipselect and the first transfer, etc.

This "odd-device support" described sounds a like a work-arround
for missing functionality in spi_core.

Would it not be better to implement this as a separate member -
say: spi_transfer.pre_transfer_delay_usecs - and keep the 
spi_transfer.len > 0 requirement? 
Initially maybe make it a warning to find those odd-devices...

I am not sure if it might make some bus-drivers more complicated
/inefficient just to support this zero length.

For example: the spi-bcm2835.c driver would do the following with a 
spi_transfer.len == 0 in the transfer_on method:
* enables SPI and wait for interrupt completion
* the above which will trigger an interrupt
** in the interrupt we find out that there is nothing to transfer,
    so we signal completion to transfer_one, so it may continue.
* the main transfer_one will get woken up
** it will do a delay_usecs
** it will handle CS_CHANGE
** it will disable SPI/reset HW again

So this implementation shows that there is a lot of inefficient 
overhead/delay just to trigger a delay...
This example requires 2 context switches (dwait for completion)
and its corresponding delays to get back to processing - so the
effective delay may be longer than 2ms just because of the delays 
introduced via the scheduler and thus way above the delay requested
by the transfer...

OK - for the spi-bcm2835.c driver the following in 
bcm2835_spi_start_transfer:
    if (xfer->len == 0) 
	return 0;
would solve it, but then we might implement this:
    if (xfer->pre_transfer_delay_usecs)
        udelay(xfer->pre_transfer_delay_usecs);
instead and be more explicit about this delay.

I guess other drivers will show similar code-artefacts and
some may even make the implicit assumption it has to be non-zero,
which would break functionality those odd devices.


Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
