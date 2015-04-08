From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts
 to
Date: Wed, 08 Apr 2015 11:41:15 +0200
Message-ID: <5524F7BB.8000905@martin.sperl.org>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org> <551A1185.6060502@wwwdotorg.org> <20150331052519.GZ2869@sirena.org.uk> <552094B5.3050109@wwwdotorg.org> <20150406172130.GU6023@sirena.org.uk> <B9B4E3CA-D9F2-4A79-BC78-C3BD4B3844F2@martin.sperl.org> <5523FA17.6040009@wwwdotorg.org> <20150407162857.GM6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150407162857.GM6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2015-04-07 18:28, Mark Brown wrote:
> On Tue, Apr 07, 2015 at 09:39:03AM -0600, Stephen Warren wrote:
>> On 04/07/2015 12:25 AM, Martin Sperl wrote:
>> ... then not touch any CS-related register for the entire transfer. There
>> shouldn't be a need to enable/disable IRQs during the transfer; just leave
>> them enabled the entire time, until all bytes have been transferred.
>
> We will need to make sure /CS is kept asserted between transfers in a
> message too.
The problem is here that you need to touch the CS-register when an
individual spi-transfer is finished, as only that way you can disable
the (level)interrupts, which would fire immediately again when you exit
chip-select.

So you are at the risk of it happening at that phase as well...
and during the next spi_transfer_one you need to reenable the
interrupts again.

Anyway: my latest incarnation of the driver does now implement full
cs_gpio operation with native-cs getting translated during the
new spi_register_cs phase when registering the bus using the (new)
function-pointer register_cs in spi_master.
So this issue goes away and the code becomes smaller at the same time.

This is also used to set up chip_selects to their defaults levels prior
to any activity on the SPI bus.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
