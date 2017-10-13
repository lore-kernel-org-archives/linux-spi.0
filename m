From: jeffy <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early system
 PM callbacks
Date: Sat, 14 Oct 2017 02:25:48 +0800
Message-ID: <59E1052C.3000503@rock-chips.com>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com> <20171013104138.3216-2-jeffy.chen@rock-chips.com> <CAD=FV=X6pkaY3t=ceh3QEUws+_gqRGMN9zveW0fXR1noF1T6ew@mail.gmail.com> <20171013155120.GA137489@google.com> <20171013164235.thgqha7sl5tdptwv@sirena.co.uk> <59E103B0.8060705@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <59E103B0.8060705-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10/14/2017 02:19 AM, jeffy wrote:
>
>
> it looks like the suspend sequence depends on the dt node sequence, and
> we are putting display-subsystem dt node above spi dt node, so it would
> be earlier in the device list, then got suspended later than spi device.
>
> the pwm backlight and cros_ec_spi pwm are very interesting, not only
> about suspend dependency... if we unbind cros_ec_spi pwm, the pwm
> backlight would still hold a reference to it, and crash the kernel later.

or maybe we should move device_pm_add() from device_add() to driver_bound()?

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
