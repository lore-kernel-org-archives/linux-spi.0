From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v6 2/3] spi: sun4i: Fix clock calculations
 to be predictable and never exceed the requested rate
Date: Sun, 10 Jan 2016 19:14:28 +0100
Message-ID: <20160110181428.GH9631@lukather>
References: <1451145186-14235-1-git-send-email-mweseloh42@gmail.com>
 <1451145186-14235-3-git-send-email-mweseloh42@gmail.com>
 <20151227210946.GL30359@lukather>
 <CAGNoLaPcBAqDqFuff7sWWADjVH3Z-LWhZatSmzvEm4mLSrSNvw@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OWHXb1mYLuhj1Ox"
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"Mailing List, Arm" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBBN7ZK2AKGQEFG2HBCQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGNoLaPcBAqDqFuff7sWWADjVH3Z-LWhZatSmzvEm4mLSrSNvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--0OWHXb1mYLuhj1Ox
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Mon, Dec 28, 2015 at 12:29:16AM +0100, Marcus Weseloh wrote:
> Hi,
> 
> 2015-12-27 22:09 GMT+01:00 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>:
> > On Sat, Dec 26, 2015 at 04:53:05PM +0100, Marcus Weseloh wrote:
> >> This patch fixes multiple problems with the current clock calculations:
> >>
> >> 1. The A10/A20 datasheet contains the formula AHB_CLK / (2^(n+1)) to
> >> calculate SPI_CLK from CDR1, but this formula is wrong. The actual
> >> formula - determined by analyzing the actual waveforms - is
> >> AHB_CLK / (2^n).
> >>
> >> 2. The divisor calculations for CDR1 and CDR2 both rounded to the
> >> nearest integer. This could lead to a transfer speed that is higher than
> >> the requested speed. This patch changes both calculations to always
> >> round down.
> >>
> >> 3. The mclk frequency was only ever increased, never decreased. This could
> >> lead to unpredictable transfer speeds, depending on the order in which
> >> transfers with different speeds where serviced by the SPI driver.
> >
> > These 3 should probably be separate patches (and be Cc'd to stable
> 
> Will do. But I have the feeling that at least 1. and 2. should be in
> the same patch as they touch the same lines of code. Do you think that
> would be ok?

It can also be two subsequent patches that are part of the same serie.

> And before CC'ing stable, I would love to have someone with access to
> A10 hardware and a scope (or even a bus pirate) check that the A10 SPI
> controller does indeed have the same "bug". I strongly think so, but
> would sleep better if it could be confirmed.

We never noticed any significant difference between the two. By now,
if there was any, we probably would be aware of it. And if there's
any, we can always send a subsequent patch.

> >> -     /* Ensure that we have a parent clock fast enough */
> >> +     /*
> >> +      * Ensure that the parent clock is set to twice the max speed
> >> +      * of the spi device (possibly rounded up by the clk driver)
> >> +      */
> >>       mclk_rate = clk_get_rate(sspi->mclk);
> >> -     if (mclk_rate < (2 * tfr->speed_hz)) {
> >> -             clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
> >> +     if (spi->max_speed_hz != sspi->cur_max_speed ||
> >> +         mclk_rate != sspi->cur_mclk) {
> >
> > Do you need to cache the values? As far as I'm aware, you end up doing
> > the computation all the time anyway.
> 
> By caching the values we optimize the case when a single SPI slave
> device (or even multiple slave devices with the same max_speed) are
> used multiple times in a row. In that case, we're saving two calls:
> clk_set_rate and clk_get_rate. I was unsure about how expensive the
> clk_* calls were, so I thought it would be safer use caching. But
> maybe it's not worth the extra code?

Unless you can point that there's a significant performance
difference, I'm not sure it's worth it.

> Oh, and I just noticed a mistake in the comment: the clock driver
> rounds up _or_ down, so I should drop the "up".
> 
> [...]
> >> -     div = mclk_rate / (2 * tfr->speed_hz);
> >> -     if (div <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
> >> -             if (div > 0)
> >> -                     div--;
> >> -
> >> +     div = DIV_ROUND_UP(mclk_rate, 2 * tfr->speed_hz) - 1;
> >
> > Isn't it exactly the same thing as mclk_rate / (2 * tfr->speed_hz) ?
> 
> It is quite often, but not in all cases. The plain division rounds to
> the nearest integer, so it rounds down sometimes. Consider the
> following case: we have a slow SPI device with a spi-max-frequency of
> 50kHz. Our clock driver can't find a clock as slow as 100kHz, so it
> sets mclk to 214,285Hz.
> 
> Using the old calculation we get: 214,285 / (2 * 50,000) = 2, so div =
> 1 as the old code subtracts 1 two lines further down
> The new calculation results in: DIV_ROUND_UP(214,285, 2 * 50,000)  =
> 3, so div = 2 if we add the -1

Except that you have that extra - 1 after your DIV_ROUND_UP
calculation in the line you add.  so you have to remove 1 from that
line above, and then 1 again when we set the register, which ends up
being the exact same thing, or am I missing something?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--0OWHXb1mYLuhj1Ox--
