From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 3/3] spi: meson-axg: add a linear clock divider
 support
Date: Thu, 13 Dec 2018 16:01:24 +0100
Message-ID: <d2ecc15badf2b273ce9a62ecbbb0962051a46bc1.camel@baylibre.com>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
         <1544690354-16409-4-git-send-email-sunny.luo@amlogic.com>
         <3cc699dc-4021-b993-2b47-b00b40f380f8@baylibre.com>
         <e6d5220e45a54d5251bec0f8fd3c147307f8b071.camel@baylibre.com>
         <d9ec856c-d93f-4e4a-c5d4-7b2182f93cf7@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Sunny Luo <sunny.luo@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d9ec856c-d93f-4e4a-c5d4-7b2182f93cf7@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 2018-12-13 at 22:37 +0800, Sunny Luo wrote:
> Hi Jerome,
> 
> On 2018/12/13 17:28, Jerome Brunet wrote:
> > On Thu, 2018-12-13 at 09:55 +0100, Neil Armstrong wrote:
> > > > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > > >   config SPI_MESON_SPICC
> > > >   	tristate "Amlogic Meson SPICC controller"
> > > > -	depends on ARCH_MESON || COMPILE_TEST
> > > > +	depends on OF && COMMON_CLK && (ARCH_MESON || COMPILE_TEST)
> > 
> > The purpose of this patch is clock, right ? Why does it add a dependency
> > on OF
> > ?
> > I did it by the way. Maybe it's better to add it in patch 1.
> > > > +static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
> > > > +{
> > > > +	struct device *dev = &spicc->pdev->dev;
> > > > +	struct clk_fixed_factor *div0;
> > > > +	struct clk_divider *div1;
> > 
> > Could you come up with something better than div0 and div1 ? it is
> > confusing,
> > especially with the comment above about div3 and 4 ... fixed_factor, div
> > maybe
> > ?
> > Good, It is really confusing, I will change next patch.
> > > > +	div1 = &meson_spicc_div1;
> > > > +	div1->reg = spicc->base + (u64)div1->reg;
> > 
> > So you have static data which you override here. This works only if there
> > is a
> > single instance ... and does not really improve readability in your case.
> > 
> > IMO, you'd be better off without the static data above.
> 
> This is a terrible bug for more than one instances. I must overwrite it.

You must set them properly, yes ... having these static data is not necessary

> 
> 
> > > > +	if (!spicc->data->has_enhance_clk_div) {
> > 
> > Do all SoC with 'has_oen' have 'has_enhance_clk_div' too ?
> > DO you really need two flags ?
> 
> Yes, all Soc with 'has_oen' must have 'has_enhance_clk_div' too.
> It is distinct to use two flags here, what do you think of it?

I wonder if you should be using of_device_is_compatible() instead of adding
these flags.

> 
> > > > +	mux = &meson_spicc_sel;
> > > > +	snprintf(name, sizeof(name), "%s#_sel", dev_name(dev));
> > > > +	init.name = name;
> > > > +	init.ops = &clk_mux_ops;
> > > > +	init.parent_names = mux_parent_names;
> > > > +	init.num_parents = 2;
> > > > +	init.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT;
> > 
> > Why CLK_SET_RATE_NO_REPARENT ? CCF should pick the parent that give the
> > best
> > results, best to let it do its task ...
> > 
> There are two div in AXG, one is the coarse old-div and the other is 
> enhance-div. From SoCs designer's opinion, the ehance-div aims to take 
> place of the old-div.

... and all likelyhood, CCF will pick it BUT, unless the old path is broken,
please let the framework do its job. 

If the old path was broken you should not have described it ... but we have
been using it so far, so we know it works fine.

it's a very simple fix: drop CLK_SET_RATE_NO_REPARENT and your call
clk_set_parent()

> 
> 

Last but not least, I did not see it in my initial review, but:

I see you call clk_set_rate(spicc->clk, ...) but I don't see any call to
clk_prepare_enable() and clk_disable_unprepare().

It works because the input clock and your local tree does not gate, but it is
wrong. A driver should not assume that they clock is enabled by default.
