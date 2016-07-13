From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH v3 7/7] clk: exynos5433: remove CLK_IGNORE_UNUSED flag from
 SPI clocks
Date: Wed, 13 Jul 2016 11:08:52 +0900
Message-ID: <20160713020852.GH18237@samsunx.samsung>
References: <1468317736-18841-1-git-send-email-andi.shyti@samsung.com>
 <1468317736-18841-8-git-send-email-andi.shyti@samsung.com>
 <CGME20160712221734epcas1p2e2069af657e3afa912bea5bf7217e08a@epcas1p2.samsung.com>
 <146836184696.73491.9452469757415968654@resonance>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	Andi Shyti <andi@etezian.org>
To: Michael Turquette <mturquette@baylibre.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <146836184696.73491.9452469757415968654@resonance>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mike,

> > Because the Exynos5433 SPI driver supports the ioclk handling and
> > the following patch:
> > 
> >   http://marc.info/?l=linux-kernel&m=146787645626318&w=2
> > 
> > fixes a synchronus abort issue, none of the SPI clocks require
> > any critical handling: remove, then, the CLK_IGNORE_UNUSED flag
> > for the SPI related clocks.
> > 
> > Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> > Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Reviewed-by: Michael Turquette <mturquette@baylibre.com>
> > Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> Do you want these patches to go through same tree? If not, I can take
> this patch into clk-next.

I think this patchset doesn't apply in your repository, but in
Mark Brown's spi/topic/s3c64xx branch. So that I guess Mark
should take this patchset.

Sorry, I should have specified it in the cover letter.

Thanks,
Andi
