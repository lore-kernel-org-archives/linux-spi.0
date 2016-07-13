From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v3 7/7] clk: exynos5433: remove CLK_IGNORE_UNUSED flag from
 SPI clocks
Date: Wed, 13 Jul 2016 11:21:01 +0200
Message-ID: <578607FD.6050705@samsung.com>
References: <1468317736-18841-1-git-send-email-andi.shyti@samsung.com>
 <1468317736-18841-8-git-send-email-andi.shyti@samsung.com>
 <146836184696.73491.9452469757415968654@resonance>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Andi Shyti <andi.shyti@samsung.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
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
In-reply-to: <146836184696.73491.9452469757415968654@resonance>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 07/13/2016 12:17 AM, Michael Turquette wrote:
>
> Do you want these patches to go through same tree? If not, I can take
> this patch into clk-next.

I think this patch can safely go separately through the clk tree,
we just need to ensure whole series is merged for same release
to avoid regressions. There should be no problems with git bisect
since there is no exynos5433 based board dts in mainline yet.

--
Thanks,
Sylwester
