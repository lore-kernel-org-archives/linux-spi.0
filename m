From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH v3 4/8] spi: core: added spi_split_transfers_unaligned
Date: Wed, 16 Dec 2015 17:11:17 +0100
Message-ID: <55E2C0B8-EE1C-40C8-A3AA-0A1F75BFA860@martin.sperl.org>
References: <1450106426-2277-1-git-send-email-kernel@martin.sperl.org> <1450106426-2277-5-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450106426-2277-5-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 14.12.2015, at 16:20, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> +	/* the number of bytes by which we need to shift to align */
> +	alignment_shift = BIT(alignment) - alignment_to_correct;

This actually needs to be:
	alignment_shift = alignment - alignment_to_correct

> +
> +	/* calculate the values */
> +	alignment_mask = (1 << alignment) - 1;
This actually needs to be:
	 alignment_mask = alignment - 1

This was due to a misconception of @spi_master.dma_alignment...

I will wait for other feedback before creating v4 of the
patchset.

Martin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
