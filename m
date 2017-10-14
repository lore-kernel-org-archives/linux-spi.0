From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early system PM callbacks
Date: Sat, 14 Oct 2017 02:15:34 +0200
Message-ID: <1617641.TtuYKIH8aZ@aspire.rjw.lan>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com> <20171013183750.piabs7m3dnpabnkm@sirena.co.uk> <20171013234511.dxazu5wvvz7sjiiu@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, jeffy <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171013234511.dxazu5wvvz7sjiiu@dtor-ws>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Saturday, October 14, 2017 1:45:11 AM CEST Dmitry Torokhov wrote:
> On Fri, Oct 13, 2017 at 07:37:50PM +0100, Mark Brown wrote:
> > On Fri, Oct 13, 2017 at 11:30:06AM -0700, Dmitry Torokhov wrote:
> > > On Sat, Oct 14, 2017 at 02:19:28AM +0800, jeffy wrote:
> > 
> > > > > Yeah, it's the same stuff as we get with initcall ordering.  This sort
> > > > > of thing does happen with things like PMICs which tend to have hardware
> > > > > that the system wants to manipulate in the IRQs off part of suspend.
> > > > > Ideally the dependency annotation stuff would figure things out though
> > > > > I'm not sure what the status of that is.
> > 
> > > I'd say non-existent for resources such as regulators, pwms, clocks,
> > > etc. I do not think many places call device_link_add()... I think adding
> > > this to devm_* APIs might be easiest to get the ball going as they
> > > naturally have consumer device and can easily figure out the supplier
> > > side.
> > 
> > Hrm, are things in a state where we're supposed to be doing that?  I've
> > not seen anyone even trying which is a bit odd, I'd thought there was
> > some core work still ongoing (and it wasn't clear to me if we were going
> > to try to do things like use DT/ACPI cross references to figure this
> > stuff out).
> 
> Not sure, adding Rafael...

The infrastructure in the core is there, the part related to getting that
information from firmware is (mostly) missing.

Still, moving system suspend/resume callbacks to the late/early phases may
be a good idea anyway.

Thanks,
Rafael



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
