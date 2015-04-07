From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts
 to
Date: Tue, 07 Apr 2015 09:39:03 -0600
Message-ID: <5523FA17.6040009@wwwdotorg.org>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org> <551A1185.6060502@wwwdotorg.org> <20150331052519.GZ2869@sirena.org.uk> <552094B5.3050109@wwwdotorg.org> <20150406172130.GU6023@sirena.org.uk> <B9B4E3CA-D9F2-4A79-BC78-C3BD4B3844F2@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B9B4E3CA-D9F2-4A79-BC78-C3BD4B3844F2-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 04/07/2015 12:25 AM, Martin Sperl wrote:
>
>> On 06.04.2015, at 19:21, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> Right, and I have to say I do suspect that the underlying thing is that
>> the FIFO is underrunning, but as far as the optimization is concerned
>> that's a separate thing.  The reason this isn't enabled for native chip
>> selects is that it's not working, the reason it's not working is
>> something that should indeed probably be investigated.
 >
> Actually it happens exactly when setting the CS-register with the
> interrupt flags enabled - typically observed in the middle of a transmit
> of a byte the CS jumps, but the clock and data continue the transfers
> correctly
>
> As the CS register contains the interrupt flags as well as the
> control for the native-chip-selects this is impacting the chip select
> lines in native mode.

Is the driver simply programming the HW incorrectly then? I would expect 
the driver to do something roughly like:

* Set up the HW to execute the transaction; everything except enabling 
IRQs and telling the HW to "go"
* Clear stale IRQ status (perhaps do this right at the start)
* Enable IRQs
* Tell the HW to "go"

... then not touch any CS-related register for the entire transfer. 
There shouldn't be a need to enable/disable IRQs during the transfer; 
just leave them enabled the entire time, until all bytes have been 
transferred.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
