From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar spi1 and spi2
Date: Tue, 14 Jul 2015 22:39:20 +1000
Message-ID: <2768BFA9-7FE9-4EDC-8692-AC3F070BD874@martin.sperl.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <55A0A150.3060809@wwwdotorg.org> <ECFBB7BF-1316-4565-B1F2-FB2651131882@martin.sperl.org> <55A49662.3000706@wwwdotorg.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55A49662.3000706-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 14.07.2015, at 14:56, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> 
> I don't care so much about the internal code details; anything there can
> be trivially changed. But please do make sure the DT correctly
> represents the HW by:
> 
> * Having a separate DT node for each HW block (SPI controller, UART, and
> any shared interrupt mux/demux/controller/...)

That is what we have with the v3 patch:
* spi1
* spi2
* syscon controlling the aux-enable register
  (only used to enable/disable the hw block)

> * If e.g. the SPI controller driver is going to need to manipulate the
> "shared interrupt mux/demux/controller/...", there should be a phandle
> from the SPI controller node to the "shared interrupt
> mux/demux/controller/..." node, rather than listing the shared registers
> in each "client"'s reg property.
That is not what is in the v3 release of the patch any longer.

Each of the above dt-nodes has their own (non-overlapping) register
ranges and interrupts are enabled/disabled in the respective ranges
for spi1/spi2. Also the status register of spi1/2 contain the
corresponding flags for the reason of an interrupt - so no need
to access any of the shared aux registers for that - hence the use
of IRQF_SHARED.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
