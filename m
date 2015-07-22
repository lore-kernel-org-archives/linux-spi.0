From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar
 spi1 and spi2
Date: Tue, 21 Jul 2015 19:55:52 -0600
Message-ID: <55AEF828.20908@wwwdotorg.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <55A0A150.3060809@wwwdotorg.org> <ECFBB7BF-1316-4565-B1F2-FB2651131882@martin.sperl.org> <55A49662.3000706@wwwdotorg.org> <2768BFA9-7FE9-4EDC-8692-AC3F070BD874@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2768BFA9-7FE9-4EDC-8692-AC3F070BD874-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 07/14/2015 06:39 AM, Martin Sperl wrote:
> 
>> On 14.07.2015, at 14:56, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>>
>> I don't care so much about the internal code details; anything there can
>> be trivially changed. But please do make sure the DT correctly
>> represents the HW by:
>>
>> * Having a separate DT node for each HW block (SPI controller, UART, and
>> any shared interrupt mux/demux/controller/...)
> 
> That is what we have with the v3 patch:
> * spi1
> * spi2
> * syscon controlling the aux-enable register
>   (only used to enable/disable the hw block)

OK, having separate nodes is great.

However, I'd like to see a "semantic" driver for the shared register
region rather than a "syscon". IIUC, "syscon" simply provides a stylized
way for one driver to touch some shared registers directly without any
semantics. I'd strongly prefer to see a real driver inside Linux rather
than something that just lets drivers fiddle with the shared registers
willy nilly. Still, this aspect is an internal implementation detail
inside the kernel that we can change without external impact later if we
need.

More concerning: The bcm283x HW doesn't implement a "syscon" module, but
some semantic IP block. The DT should contain a real compatible value
that describes what the HW block really is, not just "syscon". We could
bind the syscon driver to this compatible value if we have to for now.

>> * If e.g. the SPI controller driver is going to need to manipulate the
>> "shared interrupt mux/demux/controller/...", there should be a phandle
>> from the SPI controller node to the "shared interrupt
>> mux/demux/controller/..." node, rather than listing the shared registers
>> in each "client"'s reg property.
> That is not what is in the v3 release of the patch any longer.
> 
> Each of the above dt-nodes has their own (non-overlapping) register
> ranges and interrupts are enabled/disabled in the respective ranges
> for spi1/spi2. Also the status register of spi1/2 contain the
> corresponding flags for the reason of an interrupt - so no need
> to access any of the shared aux registers for that - hence the use
> of IRQF_SHARED.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
