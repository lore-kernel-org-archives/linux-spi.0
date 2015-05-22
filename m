From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: SPI_MASTER_MUST_* with scatter-gather only option and avoiding realloc
Date: Fri, 22 May 2015 16:09:06 +0200
Message-ID: <2B971A09-33E3-42BC-B13D-49B6DD3D2E7A@martin.sperl.org>
References: <20150512165053.GE3066@sirena.org.uk> <1431597524-7907-1-git-send-email-kernel@martin.sperl.org> <20150519124632.GN2761@sirena.org.uk> <CA52E701-A9BF-45F1-AE2A-CD3E680CEAFC@martin.sperl.org> <20150522113421.GE21391@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150522113421.GE21391-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 22.05.2015, at 13:34, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> Quite a few process issues here which are rather annoying so I'm just
> going to ignore the technical content for now.
> 
Accepting those - thanks for the clarifications.

> 
>> If you can tell me that:
>> 	(master->flags & (SPI_MASTER_MUST_TX | SPI_MASTER_MUST_RX)) &&
>> 	master->can_dma && master->can_dma(...) 
>> means that we do NOT need real memory allocated in the first place but
>> we only expect a scatter list to be created 
>> and memory allocated in all other cases then that be it.
> 
> I replied to your last mail on this in the other thread.
Well - I will take that as a yes.

With the logic based only on can_dma we still would be allocating memory
for those cases where can_dma returns false - even if the driver only
requires the scatter/gather list but would not require memory for those
rx/tx_buf == NULL cases (which is the case for the spi-bcm2835).

The extra flags solve that requirement cleanly.

An alternative would be that we provide a spi_map_dummy function
that the driver could call explicitly if it just needs the scatter_gather
list for null-buffers and leave the master->flags = 0.

One other reasons was that with this logic we need to run can_dma several
times in the process at different stages which is a waste of CPU-resources
(especially as the compiler can not inline those function pointer calls).

To reduce that overhead, would it be acceptable if we add a field to
spi_transfer (and possibly to spi_message) - say bool can_dma -  that is
filled during the loop over all the transfers in __spi_validate?

Essentially adding something like this to __spi_validate:
	message->can_dma = false;
	list_for_each_entry(xfer, &message->transfers, transfer_list) {
		/* calculate can_dma once and cache it */
		xfer->can_dma = master->can_dma ? master->can_dma(xfer) : false;
		/* and set it also in the message itself */
		message->can_dma |= xfer->can_dma
	}


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
