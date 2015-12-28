From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 2/3] spi: sun4i: Fix clock calculations
 to be predictable and never exceed the requested rate
Date: Mon, 28 Dec 2015 17:22:35 +0100
Message-ID: <CAGNoLaMsdPe4BE7+skYR45doEcXkZGA7QdFOidUA_yPZmiE9eg@mail.gmail.com>
References: <1451145186-14235-1-git-send-email-mweseloh42@gmail.com>
	<1451145186-14235-3-git-send-email-mweseloh42@gmail.com>
	<20151227210946.GL30359@lukather>
	<CAGNoLaPcBAqDqFuff7sWWADjVH3Z-LWhZatSmzvEm4mLSrSNvw@mail.gmail.com>
Reply-To: mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"Mailing List, Arm" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBDFO74UEV4IRBTGDQW2AKGQEU2H2XWY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAGNoLaPcBAqDqFuff7sWWADjVH3Z-LWhZatSmzvEm4mLSrSNvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi again,

2015-12-28 0:29 GMT+01:00 Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> 2015-12-27 22:09 GMT+01:00 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>:
[...]
> [...]
>>> -     /* Ensure that we have a parent clock fast enough */
>>> +     /*
>>> +      * Ensure that the parent clock is set to twice the max speed
>>> +      * of the spi device (possibly rounded up by the clk driver)
>>> +      */
>>>       mclk_rate = clk_get_rate(sspi->mclk);
>>> -     if (mclk_rate < (2 * tfr->speed_hz)) {
>>> -             clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
>>> +     if (spi->max_speed_hz != sspi->cur_max_speed ||
>>> +         mclk_rate != sspi->cur_mclk) {
>>
>> Do you need to cache the values? As far as I'm aware, you end up doing
>> the computation all the time anyway.
>
> By caching the values we optimize the case when a single SPI slave
> device (or even multiple slave devices with the same max_speed) are
> used multiple times in a row. In that case, we're saving two calls:
> clk_set_rate and clk_get_rate. I was unsure about how expensive the
> clk_* calls were, so I thought it would be safer use caching. But
> maybe it's not worth the extra code?
>
> Oh, and I just noticed a mistake in the comment: the clock driver
> rounds up _or_ down, so I should drop the "up".

As I'm looking further into this, I think the comment should read
"possibly rounded down", as the clk framework is expected to set a
frequency that is less or equal to the requested frequency. So the
effect I was seeing (that I got a frequency higher than the requested
one) is actually a bug!? Further details below.

> [...]
>>> -     div = mclk_rate / (2 * tfr->speed_hz);
>>> -     if (div <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
>>> -             if (div > 0)
>>> -                     div--;
>>> -
>>> +     div = DIV_ROUND_UP(mclk_rate, 2 * tfr->speed_hz) - 1;
>>
>> Isn't it exactly the same thing as mclk_rate / (2 * tfr->speed_hz) ?
>
> It is quite often, but not in all cases. The plain division rounds to
> the nearest integer, so it rounds down sometimes. Consider the
> following case: we have a slow SPI device with a spi-max-frequency of
> 50kHz. Our clock driver can't find a clock as slow as 100kHz, so it
> sets mclk to 214,285Hz.

That clk_set_rate sets a higher frequency than requested seems to be a
problem in itself. I had a look at clk/sunxi/clk-mod0.c and noticed a
few small problems there. Will post an RFC patch in a couple of
minutes.

That doesn't invalidate any of the fixes proposed in this patch,
though. They are still needed, as I see it. But after fixing
clk-mod0.c, we need to make further changes to the spi-sun4i clock
selection, as clk_set_rate could now return -EINVAL. Will amend this
patch as well after receiving feedback on the (soon to come) mod0 clk
patch.

Cheers,

  Marcus
