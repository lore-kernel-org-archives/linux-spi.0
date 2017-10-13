From: jeffy <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: rockchip: Convert to late and early system PM
 callbacks
Date: Fri, 13 Oct 2017 18:47:18 +0800
Message-ID: <59E099B6.1000804@rock-chips.com>
References: <20171013100116.8271-1-jeffy.chen@rock-chips.com> <20171013101719.bophbiz7qb5wi7n2@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171013101719.bophbiz7qb5wi7n2-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On 10/13/2017 06:17 PM, Mark Brown wrote:
> On Fri, Oct 13, 2017 at 06:01:15PM +0800, Jeffy Chen wrote:
>> Currently we are suspending the spi master in it's ->suspend callback,
>> which is racy as some other drivers may still want to transmit messages
>> on the bus(e.g. spi based pwm backlight).
>
> I'm missing patch 2/2.
>
Sorry, i'll resend them...

This patch is to defer suspend_spi_master to late suspend.

Since we put display-subsystem dt node above spi dt node, which makes 
spi suspend been called before display driver. Then the display driver 
would fail to set pwm backlight through spi in it's suspend/resume.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
