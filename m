From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2 7/7] clk: exynos5433: remove CLK_IGNORE_UNUSED flag from
 SPI clocks
Date: Mon, 11 Jul 2016 12:58:28 +0200
Message-ID: <57837BD4.5030602@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-8-git-send-email-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	Andi Shyti <andi@etezian.org>
To: Andi Shyti <andi.shyti@samsung.com>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <1467989201-14661-8-git-send-email-andi.shyti@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 07/08/2016 04:46 PM, Andi Shyti wrote:
> Because the Exynos5433 SPI driver supports the ioclk handling and
> the following patch:
> 
>   http://marc.info/?l=linux-kernel&m=146787645626318&w=2
> 
> fixes a synchronus abort issue, none of the SPI clocks require
s/synchronus/synchronous

> any critical handling: remove, then, the CLK_IGNORE_UNUSED flag
> for the SPI related clocks.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

In case this goes through the spi tree:
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

