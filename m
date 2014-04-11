From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: core: Increase timeout value
Date: Fri, 11 Apr 2014 08:39:54 +0530
Message-ID: <CAFcVECL-G_JPZXmzBLT_cFo3vmjYZd8xGFf-7Vv2uXWa9-O37Q@mail.gmail.com>
References: <1397134229-2380-1-git-send-email-harinik@xilinx.com>
	<20140410173616.GC6518@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140410173616.GC6518-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Thu, Apr 10, 2014 at 11:06 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Apr 10, 2014 at 06:20:29PM +0530, Harini Katakam wrote:
>
>> Considering acceptable latencies, this timeout can be set to a large
>> value >= 1*HZ typically.
>
>> This patch adds a tolerance of 2000 msec in the core accordingly.
>
> That's too much, it's 2 seconds which gets to be incredibly painful when
> trying to debug problems - if you're sitting there waiting for a driver
> to time out some operations (and it may be more than one of them) so you
> can look at the diagnostics it can be quite aggrivating.  That's why the
> delays are related to the expected runtime for the operation.  Something
> like double the expected runtime plus something in the 100ms or so range
> perhaps?
>

OK.

> Ideally we'd use the actual speed the device set rather than the
> requested one too, that'd help.

How would you propose to do that - driver should write back actual speed set
to xfer->speed_hz?

Regards,
Harini
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
