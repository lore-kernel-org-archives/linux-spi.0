From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] SPI: bcm2835: move to the transfer_one driver model
Date: Sat, 28 Mar 2015 19:11:59 +0100
Message-ID: <AB966507-3A94-4421-8153-AB4090E309AF@martin.sperl.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <1426755714-28130-2-git-send-email-kernel@martin.sperl.org> <550BAA89.5090707@wwwdotorg.org> <20150320095247.GE2869@sirena.org.uk> <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org> <20150325151611.GA3572@sirena.org.uk> <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org> <20150325165441.GI3572@sirena.org.uk> <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA@martin.sperl.org> <20150325185007.GL3572@sirena.org.uk> <561486F6-3580-4884-8A6A-8477D8C3BDC9@martin.sperl.org> <30057D30-6A2D-4517-B374-76FF2448E455@martin.sperl.org> <5516296A.2030505@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	notro-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5516296A.2030505-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 28.03.2015, at 05:09, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> Can you expand on that a bit more?
> 
> Are you planning on implementing code in the driver so it always uses
> GPIO CS even when GPIOs aren't specified in the DT, or disabling those
> optimizations when native CS is in use?

>> So the question is if we should depreciate native chip-selects for this
>> driver with one of those future improvements listed below.
> 
> Only if you can make the driver transparently use GPIO CS mode even when
> no GPIOs are specified in the DT. DT is an ABI, and old DTs need to
> continue to work on newer kernels.
No I think I will just have a case where some optimization only get used
when using gpio - even though it adds a bit of complexity/code to maintain.

The code to alter the pin-mode from ALT1 to OUT is probably more complex
than just adding a "dev_warn" during probe to indicate that it is 
depreciated/no longer recommended and an if statement to discriminate the
situation.

If you know how to change the Mode of a pin on the fly, then we can add
that at a some point.

> 
>> As for testing: I have also tried to test with mmc_spi, but I have not
>> been able to make that driver work reliably in any recent kernel
>> versions.
>> Most of the time I see timeouts - and with lots of different SD-cards...
>> 
>> IIRC the last time I tested it successfully was with 3.12.
> 
> It'd be great if you could use "git bisect" to track down the change
> that broke this.

The problem is that it is a lot of kernel-versions I would have to test
to figure out why and with the rpi used for compiling the kernel it 
becomes a prohibitive long exercise...

Also I may have a slightly different setup now compared to when I did
the test initially, so this may be the trigger as well. 
Hence I was asking if someone had similar issues/has a working setup 
with an up to date kernel. (Also I think the last time I tried it was
still based on the foundation kernels before an upstream kernel existed)

I will give it a try running an old kernel, but it may take some time...



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
