From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2 - RESEND] SPI: BCM2835: allow arbitrary GPIO to act as SPI-chip_select
Date: Wed, 25 Mar 2015 18:59:22 +0100
Message-ID: <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA@martin.sperl.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <1426755714-28130-2-git-send-email-kernel@martin.sperl.org> <550BAA89.5090707@wwwdotorg.org> <20150320095247.GE2869@sirena.org.uk> <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org> <20150325151611.GA3572@sirena.org.uk> <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org> <20150325165441.GI3572@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150325165441.GI3572-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 25.03.2015, at 17:54, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> There is no need for it to be exported, as I said you simply need to set
> cs_gpio and it will be used.

That is not true, because for that to work you need to move the driver
away from using transfer_one_message to use transfer_one.

But then, as explained I have to revert back to transfer_one_message
to implement the "aggregating/handling" of transfers inside the interrupt
handler itself without having to call complete(master->xfer_completion)
on every spi_transfer. If I wrap it arround transfer_one the code will
look ugly, as it needs to work arround limitations of this api.
> 
> We've been round this loop repeatedly, as we've discussed improving the
> framework is a good idea.

That is what I try to do provide something we can take as a template
and then come up with approaches how we can generalize it to other
use-cases.

>From my perspective I want to minimize the dependencies while I create
this proof of concept.
And for my testing this with several different devices I need support
for multiple devices and for that I need this patch go in first.
Taking baby steps here.

Also there is another point here, that Stephen pointed out:
Would not a switch from the use of the "native-cs" to "gpio-only" mean
a required change in Device-tree? And isn't DT assumed to be a stabe API?

>> Keeping it as is means we can easily backport(=copy) it to the kernel
>> that the RPI foundation maintains and that gets lots of exposure and
>> testing.
> The thing to do here is to get this code upstream, supporting out of
> tree code isn't particularly persuasive here - people commonly try to
> use their out of tree requirements as a reason to merge code that's
> got problems upstream and I don't want people to get the idea that this
> is an argument that's going to work.

That is what I am doing: I am developing on spi/for-next and if we get
something of interest we will merge into the 3.18 kernel that the 
foundation is using - not the other way around!

Note that in principle you can take: bcm2835_spi_start_transfer
and use that as transfer_one (it needs master as an extra argument)
also there is the bcm2835_spi_finish_transfer that we would need to
move to some other place...

So to summarize: do you want me to move to transfer_one instead and
then revert back for the optimizations?

Thanks,
	Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
