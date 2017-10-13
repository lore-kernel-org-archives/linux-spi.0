From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RESEND PATCH 0/2] rockchip: kevin: Enable edp display
Date: Fri, 13 Oct 2017 08:34:25 -0700
Message-ID: <CAD=FV=XieqJoXfurJZwayOmCSanaPr-4e2mp0g8Zf4pc_Tc0yQ@mail.gmail.com>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Alexandru M Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171013104138.3216-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Fri, Oct 13, 2017 at 3:41 AM, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>
> Make edp display works on chromebook kevin.
>
>
> Jeffy Chen (2):
>   spi: rockchip: Convert to late and early system PM callbacks
>   arm64: dts: rockchip: Enable edp disaplay on kevin
>
>  arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 29 +++++++++++++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi      | 16 +++++++++++++
>  drivers/spi/spi-rockchip.c                        |  2 +-
>  3 files changed, 46 insertions(+), 1 deletion(-)

Presumably including Sean Paul would be a wise idea on future patches
trying to make eDP work well upstream since he's worked on supporting
rk3399 eDP in the past.  I think Alexandru has also expressed interest
in this area, too.

-Doug
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
