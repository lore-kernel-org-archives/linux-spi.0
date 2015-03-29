From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] SPI: bcm2835: move to the transfer_one driver model
Date: Sat, 28 Mar 2015 21:24:38 -0600
Message-ID: <55177076.9000208@wwwdotorg.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <1426755714-28130-2-git-send-email-kernel@martin.sperl.org> <550BAA89.5090707@wwwdotorg.org> <20150320095247.GE2869@sirena.org.uk> <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org> <20150325151611.GA3572@sirena.org.uk> <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org> <20150325165441.GI3572@sirena.org.uk> <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA@martin.sperl.org> <20150325185007.GL3572@sirena.org.uk> <561486F6-3580-4884-8A6A-8477D8C3BDC9@martin.sperl.org> <30057D30-6A2D-4517-B374-76FF2448E455@martin.sperl.org> <5516296A.2030505@wwwdotorg.org> <AB966507-3A94-4421-8153-AB4090E309AF@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	notro-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AB966507-3A94-4421-8153-AB4090E309AF-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/28/2015 12:11 PM, Martin Sperl wrote:
>> On 28.03.2015, at 05:09, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
...
>>> As for testing: I have also tried to test with mmc_spi, but I have not
>>> been able to make that driver work reliably in any recent kernel
>>> versions.
>>> Most of the time I see timeouts - and with lots of different SD-cards...
>>>
>>> IIRC the last time I tested it successfully was with 3.12.
>>
>> It'd be great if you could use "git bisect" to track down the change
>> that broke this.
> 
> The problem is that it is a lot of kernel-versions I would have to test
> to figure out why and with the rpi used for compiling the kernel it 
> becomes a prohibitive long exercise...

Why not just cross-compile from a faster machine? It probably only takes
a few minutes per commit to test (and git bisect is pretty optimal
w.r.t. the number of commits you need to test).

> Also I may have a slightly different setup now compared to when I did
> the test initially, so this may be the trigger as well. 

That's also pretty easy to test; just go back and retest the old kernel
version that you believe was working. If it's still working but the
latest kernel is broken, there's been a regression. If the old kernel
also doesn't work, then something has changed in your setup.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
