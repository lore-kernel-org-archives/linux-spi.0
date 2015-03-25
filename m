From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2 - RESEND] SPI: BCM2835: allow arbitrary GPIO to act as SPI-chip_select
Date: Wed, 25 Mar 2015 17:13:13 +0100
Message-ID: <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <1426755714-28130-2-git-send-email-kernel@martin.sperl.org> <550BAA89.5090707@wwwdotorg.org> <20150320095247.GE2869@sirena.org.uk> <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org> <20150325151611.GA3572@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150325151611.GA3572-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 25.03.2015, at 16:16, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> This appears to be open coding the core spi_set_cs() support for GPIOs,
> why are we not just setting cs_gpio and letting the core take care of
> things?
In principle yes - the problem is that the core method is not exported.
If you agree to export it then I will create a patch using that.
Maybe even exporting it in that patch).

The problem with the core framework as is is that it currently does
not support handling multiple spi_transfers in the irq-handler itself.
Instead we have to wake up the worker-thread to handle the next
spi_transfer which will - at some point - will trigger another irq,
where the overhead is again 5-6us until the spi-irq-handler runs.
This obviously adds unnecessary overhead.

Note that it takes about 5us after the IRQ-handler itself exits for
the irq framework to release the CPU and then some more overhead (2-3us)
to schedule the worker-thread. This is obviously an unnecessary waste of
CPU and adds unnecessary waits on the SPI bus - especially when running
spi_write_then_read style requests.

So I would like to test that portion out with something stable and as I am
testing against 4 devices right now, so I need some kernel that supports
4 devices...

If we come up with some improvements which we might be able to generalize,
then we can move these things into core and convert the whole driver to 
the new model.

Keeping it as is means we can easily backport(=copy) it to the kernel
that the RPI foundation maintains and that gets lots of exposure and
testing.

Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
