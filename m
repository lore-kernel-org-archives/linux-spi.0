From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: __spi_async: why the check for a callback as a requirement?
Date: Mon, 17 Mar 2014 09:21:47 +0100
Message-ID: <E6C88A40-D009-4434-A4A1-A77D4A76DDE3@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

I found out that with commit 24a0013a04e81e9519 there was a check included 
that checks for a valid callback.

Why would a callback be an _absolute_ requirement for a SPI message?

In the case of my driver for the can/mcp2515 I have to send out 3 messages:

* Read the basic status to get an Idea what is the reason for the IRQ
* Read additional error information as well as speculatively prefetching
  a message buffer for which there is a high probability that it contains a
  valid message and thus is the root cause of the interrupt from the device.
* doing cleanup work depending on flags read with the first

The first and second get scheduled together, so that while the interrupt 
for the first complete is getting handled (with its latencies) the HW
(in principle) could continue with the second SPI transfer, which is also
bigger in size than the first.

The complete handler of the 1st will schedule the 3rd message according to
flags read with the first message.

The complete handler of the 3rd message will also process the speculative 
data read by the second transfer, so that there is no real need for an 
explicit complete handler for the 2nd transfer.

The second transfer is effectively hiding interrupt latencies of the system
and thus is making better use of the available bandwidth.

So with a spi-bus driver that does all the transfers in DMA (even including
the pipelining of different spi_messages) that means that instead of an 
ideal 3 interrupts for the whole sequence (1 for the HW interrupt itself
plus an IRQ each for the completion of the 1st and 3rd message) we now have 
4 interrupts just due to the requirement for the complete call of message 2.

So I wonder why we really have this check:
	if (!message->complete)
		return -EINVAL;

Thanks,
	Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
