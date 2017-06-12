From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: rockchip: add support for "cs-gpios" dts property
Date: Mon, 12 Jun 2017 11:23:37 +0200
Message-ID: <2280770.UMxRo5IhGO@diego>
References: <1497248057-16550-1-git-send-email-jeffy.chen@rock-chips.com> <4418523.E0t9k04HOG@diego> <593E5AF8.1080404@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Cc: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: jeffy <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <593E5AF8.1080404-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Am Montag, 12. Juni 2017, 17:12:24 CEST schrieb jeffy:
> Hi Heiko,
> 
> thanx for your comments.
> 
> On 06/12/2017 04:36 PM, Heiko Stübner wrote:
> > Am Montag, 12. Juni 2017, 16:26:07 CEST schrieb jeffy:
> >> Hi Shawn,
> >> 
> >> On 06/12/2017 03:15 PM, Shawn Lin wrote:
> >>> Hi Jeffy,
> >>> 
> >>> On 2017/6/12 14:14, Jeffy Chen wrote:
> >>>> Support using "cs-gpios" property to specify cs gpios.
> >>>> 
> >>>> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> >>>> ---
> >>>> 
> >>>>    .../devicetree/bindings/spi/spi-rockchip.txt       |  2 +
> >>>>    drivers/spi/spi-rockchip.c                         | 52
> >>>> 
> >>>> ++++++++++++++++++++++
> >>>> 
> >>>>    2 files changed, 54 insertions(+)
> >>>> 
> >>>> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> >>>> b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> >>>> index 83da493..02171b2 100644
> >>>> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> >>>> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> >>> 
> >>> The changes for doc should be another patch, and...
> >> 
> >> but i saw others didn't separate them:
> >> cf9e478 spi: sh-msiof: Add slave mode support
> >> 23e291c spi: rockchip: support "sleep" pin configuration
> > 
> > it sometimes falls through the cracks, but having dt-binding patches
> > separate is meant to make it easier on DT-Maintainers to find
> > patches they need to look at.
> 
> ok, will do.
> 
> >>>> +    if (!data->cs_gpio_requested) {
> >>>> +        ret = gpio_request_one(spi->cs_gpio, flags,
> >>>> +                       dev_name(&spi->dev));
> >>>> +        if (!ret)
> >>>> +            data->cs_gpio_requested = 1;
> >>>> +    } else
> >>>> +        ret = gpio_direction_output(spi->cs_gpio, flags);
> >>> 
> >>> need brace around 'else' statement. Also I don't see data used
> >>> elsewhere, so you need these code above.
> >> 
> >> ok.
> >> and the cs_gpio_requested is to mark cs_gpio requested, because the
> >> setup func might be called multiple times, we only need to request gpio
> >> at the first time.
> > 
> > Aren't the gpiod* functions meant to be used for new things?
> > Also you might actually do a bit of error handling there, especially
> > EPROBE_DEFER.
> 
> so you are suggesting to use gpiod* functions here to replace gpio_*
> functions right?

correct. And handle errors that may get returned, especially EPROBE_DEFER,
but also other errors may indicate that your spi won't function as expected.


Heiko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
