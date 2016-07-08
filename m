From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH v2 5/7] spi: s3c64xx: add exynos5433 compatible for ioclk
 handling
Date: Sat, 9 Jul 2016 01:31:58 +0900
Message-ID: <20160708163158.GD1256@jack.zhora.eu>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-6-git-send-email-andi.shyti@samsung.com>
 <146799441227.73491.13833003558807352160@resonance>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Shyti <andi.shyti@samsung.com>,
	Rob Herring <robh+dt@kernel.org>,
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
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <146799441227.73491.13833003558807352160@resonance>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mike,

> >         pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
> >         pm_runtime_use_autosuspend(&pdev->dev);
> >         pm_runtime_set_active(&pdev->dev);
> > @@ -1193,6 +1211,8 @@ err_pm_put:
> >         pm_runtime_disable(&pdev->dev);
> >         pm_runtime_set_suspended(&pdev->dev);
> >  
> > +       clk_disable_unprepare(sdd->ioclk);
> > +err_disable_src_clk:
> >         clk_disable_unprepare(sdd->src_clk);
> >  err_disable_clk:
> >         clk_disable_unprepare(sdd->clk);
> 
> Why aren't these clocks enabled/disabled by calls to pm_runtime_get/put?

yes, they are, but this should be fixed in a different patch.

I will send a follow-up, thanks for pointing this out.

Andi
