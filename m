From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 5/6] spi: bcm2835: add polling mode for transfers below 30us
Date: Tue, 31 Mar 2015 08:00:11 +0200
Message-ID: <E15DA84C-4EF9-432A-ADA9-81789EAE379F@martin.sperl.org>
References: <808DC596-35BB-4A08-8CF4-DFAB6294636E@martin.sperl.org> <551A1466.2020706@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <551A1466.2020706-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 31.03.2015, at 05:28, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>> +	/* check if we shall run in polling mode */
>> +	xfer_time_us = tfr->len * 9 * 1000000 / spi_used_hz;
> 
> Why 9 not 8; presumably thats bits per byte, and IIRC SPI doesn't have
> anything like I2C's ack bit per byte?

Well - the bcm2835 make a 1 cycle wait after each byte transferred.
Hence 9 bit actual length we need to account for.

Actually on top of that there are 3 more cycles when bringing the SPI
hardware active (at least with native CS) - but these are minimal
offsets.

Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
