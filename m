From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH] spi: sirf: add reset controller dependency
Date: Tue, 24 Feb 2015 21:36:22 +0800
Message-ID: <CAGb2v65tzFrPKJP0kRjyXAk6OZXHVEMmC2QkrokKev_P2bzLwA@mail.gmail.com>
References: <4553005.HBquOfbqXe@wuerfel> <5840299.CR2H70RAJi@wuerfel>
 <CAGb2v64hgW39c+gQXp-btpOu2_ddEnGBQk7udMGatCG8We+dBQ@mail.gmail.com> <11771349.MCSxFTdomh@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <11771349.MCSxFTdomh@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Feb 24, 2015 at 9:34 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Tuesday 24 February 2015 18:56:44 Chen-Yu Tsai wrote:
>> > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> > @@ -1,11 +1,11 @@
>> >  config STMMAC_ETH
>> >         tristate "STMicroelectronics 10/100/1000 Ethernet driver"
>> >         depends on HAS_IOMEM && HAS_DMA
>> > +       depends on RESET_CONTROLLER
>> >         select MII
>> >         select PHYLIB
>> >         select CRC32
>> >         select PTP_1588_CLOCK
>> > -       select RESET_CONTROLLER
>>
>> I was the one that introduced this. At the time a generic binding for the
>> stmmac core was requested, which supported an optional reset control. There
>> wasn't an *_optional stub available, so I went with this. See
>>
>>     http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/224684.html
>> b424080a9e08
>> With commit b424080a9e08 ("reset: Add optional resets and stubs") in, I
>> think using devm_reset_control_get() in the driver is the proper solution.
>> The hardware is found in quite a few platforms, and not all of them have
>> reset controllers.
>
> I suppose you mean devm_reset_control_get_option() instead of
> devm_reset_control_get()?

That's right.

ChenYu

> Yes, that sounds right.
>
>         Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
