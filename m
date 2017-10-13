From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early
 system PM callbacks
Date: Fri, 13 Oct 2017 11:30:48 -0700
Message-ID: <20171013183048.dg6wsabnz7qiviwy@dtor-ws>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
 <20171013104138.3216-2-jeffy.chen@rock-chips.com>
 <CAD=FV=X6pkaY3t=ceh3QEUws+_gqRGMN9zveW0fXR1noF1T6ew@mail.gmail.com>
 <20171013155120.GA137489@google.com>
 <20171013164235.thgqha7sl5tdptwv@sirena.co.uk>
 <59E103B0.8060705@rock-chips.com>
 <59E1052C.3000503@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
To: jeffy <jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <59E1052C.3000503@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Oct 14, 2017 at 02:25:48AM +0800, jeffy wrote:
> On 10/14/2017 02:19 AM, jeffy wrote:
> > 
> > 
> > it looks like the suspend sequence depends on the dt node sequence, and
> > we are putting display-subsystem dt node above spi dt node, so it would
> > be earlier in the device list, then got suspended later than spi device.
> > 
> > the pwm backlight and cros_ec_spi pwm are very interesting, not only
> > about suspend dependency... if we unbind cros_ec_spi pwm, the pwm
> > backlight would still hold a reference to it, and crash the kernel later.
> 
> or maybe we should move device_pm_add() from device_add() to driver_bound()?

You do not necessarily need to have a driver to power the dveice on and
off.

-- 
Dmitry
