From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 2/3] spi: sun4i: Fix clock calculations
 to be predictable and never exceed the requested rate
Date: Sun, 10 Jan 2016 22:37:21 +0100
Message-ID: <CAGNoLaOnpCLALNMscQC1XsnPjf55rXMomYdJPJFdpk=FuFgK4g@mail.gmail.com>
References: <1451145186-14235-1-git-send-email-mweseloh42@gmail.com>
	<1451145186-14235-3-git-send-email-mweseloh42@gmail.com>
	<20151227210946.GL30359@lukather>
	<CAGNoLaPcBAqDqFuff7sWWADjVH3Z-LWhZatSmzvEm4mLSrSNvw@mail.gmail.com>
	<CAGNoLaMsdPe4BE7+skYR45doEcXkZGA7QdFOidUA_yPZmiE9eg@mail.gmail.com>
	<20160110194450.GI9631@lukather>
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
Return-path: <linux-sunxi+bncBDFO74UEV4IRBEM6ZO2AKGQEZM2VVFQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20160110194450.GI9631@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi,

2016-01-10 20:44 GMT+01:00 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>:
> On Mon, Dec 28, 2015 at 05:22:35PM +0100, Marcus Weseloh wrote:
>> 2015-12-28 0:29 GMT+01:00 Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> > 2015-12-27 22:09 GMT+01:00 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>:
[...]
>> > Oh, and I just noticed a mistake in the comment: the clock driver
>> > rounds up _or_ down, so I should drop the "up".
>>
>> As I'm looking further into this, I think the comment should read
>> "possibly rounded down", as the clk framework is expected to set a
>> frequency that is less or equal to the requested frequency.
>
> AFAIK, there's no such expectation in the clock framework. You
> treating this from a maximum frequency perspective, but it would be
> the exact opposite if you were talking about a minimum frequency, as
> might be the case for other consumers.

I was looking though the clk driver source and found this comment in
drivers/clk/sunxi/clk-factors.c (Line 89):

/* find the parent that can help provide the fastest rate <= rate */

And that comments seems to be correct, because that is what the code
is doing (and the comment is copied from the core clk framework). So
it checks every parent to see if that parent could be used to get a
clock rate that is less or equal to the requested clock. If it can't
find one, i.e. all parents can only supply a larger clock, then
-EINVAL is returned. Or am I missing something here?

Up to now this driver would never return -EINVAL, because of the
problems in the mod0 clock driver I mentioned. But the intended effect
seems to be actual rate <= requested rate. And it seems like clk
drivers on other platforms do this as well.

[...]
>> That clk_set_rate sets a higher frequency than requested seems to be a
>> problem in itself. I had a look at clk/sunxi/clk-mod0.c and noticed a
>> few small problems there. Will post an RFC patch in a couple of
>> minutes.
>
> Did you post these patches already? I think I missed them if that's
> the case.

Yes, I've posted the patch to the clk-mod0.c here:
https://groups.google.com/d/msg/linux-sunxi/BQWhOHGqliI/fMtirUFsBgAJ

Cheers,

  Marcus
