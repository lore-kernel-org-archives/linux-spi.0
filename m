From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Fri, 1 Jul 2016 20:56:44 +0200
Message-ID: <CAOMqctR8mdjzCpfJodHO6MDUEMZubKmnT_eZZs+48xJXQfragA@mail.gmail.com>
References: <20160628183825.GS17217@sirena.org.uk> <CAOMqctTNmcg32PFVOZaA99GpFba9GOGOuOqmi3ujzxcHRFZsOA@mail.gmail.com>
 <20160628205736.GE17217@sirena.org.uk> <CAOMqctS2xGCgfXschxudcAEYq-mcfPDmFS_pTzCuXa0bFBE0NA@mail.gmail.com>
 <20160629180211.GF6247@sirena.org.uk> <CAOMqctR-f+dNBiWk8LEqkeYMhpvACjMi8aH3GpHY==RjfANf8Q@mail.gmail.com>
 <20160701082548.GE6247@sirena.org.uk> <CAOMqctRp+ua1DM82W35Df17TvhoF2suxALBaYqECWtTRrTWXCw@mail.gmail.com>
 <20160701150015.GQ6247@sirena.org.uk> <CAOMqctSfDKJRYf7bY7pz7LE9obUxMvV-v=Ntz3_mk0WGMKbPtA@mail.gmail.com>
 <20160701162228.GZ6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160701162228.GZ6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 1 July 2016 at 18:22, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Jul 01, 2016 at 05:37:53PM +0200, Michal Suchanek wrote:
>
>> Can you, please, specify what problems this patch creates for other users
>> and maintainability?
>
> To repeat yet again a major design goal for DT is to describe the
> hardware rather than implementation details of the software you plan to
> run on the system.  Not doing this breaks upgrades or changes in our
> ideas of how we control a given bit of hardware.
>
>> Without stating the problems of this solution clearly or proposing alternate
>> workable solution there is not much that can be done.
>
> You are rejecting out of hand any suggestion that is not the one
> solution you are demanding.

Your only suggestion is that hardware that is not driven by kernel is
described to the kernel. I have written in great detail why this does
not make sense.

So to me it seems that you reject out of hand any suggestion that
is not the one solution you are demanding. You have not raised any
concrete reason against the proposed solution other than it does not
describe the hardware. The hardware cannot be described for practical
usability reasons.

>
> I'm done with this thread, please come back with new code that fits in
> with the device model and device tree designs.

Is there any solution that fits the driver model and allows using spidev with
arbitrary device without describing said device in devicetree?

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
