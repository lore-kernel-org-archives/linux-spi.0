From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 2/2] spi: sun4i: Add support for wait
 time between word transmissions
Date: Sun, 20 Dec 2015 13:47:43 +0100
Message-ID: <CAGNoLaOf6ZDxi+skRKc6gQKzAJot=fvvX91xx+H3c4ni9P-gdQ@mail.gmail.com>
References: <1450352427-25350-1-git-send-email-mweseloh42@gmail.com>
	<1450352427-25350-3-git-send-email-mweseloh42@gmail.com>
	<20151218111627.GM30359@lukather>
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
Return-path: <linux-sunxi+bncBDFO74UEV4IRB4GG3KZQKGQEW45ZSWI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20151218111627.GM30359@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi,

2015-12-18 12:16 GMT+01:00 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>:

>>       sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);
>>
>> +     /*
>> +      * Setup wait time between words.
>> +      *
>> +      * Wait time is set in SPI_CLK cycles. The SPI hardware needs 3
>> +      * additional cycles to setup the wait counter, so the minimum delay
>> +      * time is 4 cycles.
>> +      */
>> +     if (spi->word_wait_ns) {
>> +             clk_ns = DIV_ROUND_UP(1000000000, tfr->speed_hz);
>
> You should use the actual rate of the clock returned by clk_get_rate
> (or probably just use mclk_rate).
>
> The clock driver might round the frequency to something else than what
> was set in clk_set_rate, which would make your calculation here a bit
> off.

Yes, good point! And as the wait clock counter is based on the actual
SPI_CLK and not the mod clock, I need to calculate the exact clock
myself before handling the wait clock setting. Will amend the patch
and send a new version.

While looking into this, I also noticed a problem with a previous
patch of mine, which changed the spi-sun[46]i to use
transfer->speed_hz instead of the spi->max_speed_hz: I also changed
the mclk_rate calculation to be based on tfr->speed_hz, which should
have stayed with spi->max_speed_hz. In the current state, the clock
calculations only ever increase mclk_rate, wich leads to very
different clocks being set depending on which clock was used on the
previous transfer. Will send a fix for that as well in a separate
patch.

Cheers,

   Marcus
