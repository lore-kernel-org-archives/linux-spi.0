From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] SPI: BCM2835: enable support of 3-wire mode
Date: Fri, 20 Mar 2015 07:17:42 +0100
Message-ID: <E14CA860-07F3-455A-8504-86CF7367B738@martin.sperl.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <1426755714-28130-4-git-send-email-kernel@martin.sperl.org> <550BAC49.3000105@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <550BAC49.3000105-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 20.03.2015, at 06:12, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> I can see how that tells the HW which direction to transfer data in
> 3WIRE mode, but how does the HW know whether it's in 3WIRE mode or has
> separate RX/TX lines?

The HW assumes with this flag that MISO (=RX) sits on the same physical
line as MOSI (=TX). This flag essentially just changes directions of
the TX GPIO pin from out to in and samples the level on the TX pin.

Without this patch what you would need to do to make such a device
work is connecting RX with TX and that with the MIMO pin of the final
device (maybe add a pullup). This flag is essentially just a shortcut.

Note that the SPI-framework does the testing so that either RX or TX
can be set in SPI-3WIRE mode (not both).

Ciao,
	Martin



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
