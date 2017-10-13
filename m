From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early
 system PM callbacks
Date: Fri, 13 Oct 2017 11:30:06 -0700
Message-ID: <20171013183006.k6pzcr5tcwsxxtmp@dtor-ws>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
 <20171013104138.3216-2-jeffy.chen@rock-chips.com>
 <CAD=FV=X6pkaY3t=ceh3QEUws+_gqRGMN9zveW0fXR1noF1T6ew@mail.gmail.com>
 <20171013155120.GA137489@google.com>
 <20171013164235.thgqha7sl5tdptwv@sirena.co.uk>
 <59E103B0.8060705@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: jeffy <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <59E103B0.8060705-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, Oct 14, 2017 at 02:19:28AM +0800, jeffy wrote:
> Hi guys,
> 
> it looks like the suspend sequence depends on the dt node sequence, and we
> are putting display-subsystem dt node above spi dt node, so it would be
> earlier in the device list, then got suspended later than spi device.

Would it not get a deferral when trying to get resource reference, which
would cause it bumped down to the end of dpm list?

> 
> the pwm backlight and cros_ec_spi pwm are very interesting, not only about
> suspend dependency... if we unbind cros_ec_spi pwm, the pwm backlight would
> still hold a reference to it, and crash the kernel later.

That would be a bug in PWM/cors_ec and it should keep the PWM object
until last reference drops and simply error out on all requests.

> 
> On 10/14/2017 12:42 AM, Mark Brown wrote:
> > On Fri, Oct 13, 2017 at 08:51:21AM -0700, Brian Norris wrote:
> > 
> > > Yes, this does seem odd to me too. This looks like an arms race hack
> > > that should be avoided unless we know a legit root cause. Also,
> > > "probe order implies suspend order" doesn't quite work for async suspend
> > > anyway, so we'd probably want to express the dependency properly
> > > anyway.
> > 
> > Yeah, it's the same stuff as we get with initcall ordering.  This sort
> > of thing does happen with things like PMICs which tend to have hardware
> > that the system wants to manipulate in the IRQs off part of suspend.
> > Ideally the dependency annotation stuff would figure things out though
> > I'm not sure what the status of that is.

I'd say non-existent for resources such as regulators, pwms, clocks,
etc. I do not think many places call device_link_add()... I think adding
this to devm_* APIs might be easiest to get the ball going as they
naturally have consumer device and can easily figure out the supplier
side.

> > 
> > > Any chance this is related? Seems like that might break the parent/child
> > > relationship for master/slave:
> > 
> > > commit d7e2ee257038baeb03baef602500368a51ee9eef
> > > Author: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > Date:   Mon Apr 11 13:51:03 2016 +0200
> > 
> > >      spi: let SPI masters ignore their children for PM
> > 
> > That's for runtime PM, I'd not expect it to affect system suspend.
> > 
> 
> 

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
