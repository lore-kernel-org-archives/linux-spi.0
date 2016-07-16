From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/7] bindings: spi-samsung: document the clocks and
 the clock-name property
Date: Sat, 16 Jul 2016 15:30:44 -0500
Message-ID: <20160716203044.GA13087@rob-hp-laptop>
References: <1468317736-18841-1-git-send-email-andi.shyti@samsung.com>
 <1468317736-18841-3-git-send-email-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	Andi Shyti <andi@etezian.org>
To: Andi Shyti <andi.shyti@samsung.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1468317736-18841-3-git-send-email-andi.shyti@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 12, 2016 at 07:02:11PM +0900, Andi Shyti wrote:
> These two properties were not documented but used in the spi
> dts. Add the related documentation.
> 
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Reviewed-by: Michael Turquette <mturquette@baylibre.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-samsung.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
> index 57d5539..f45c6eb 100644
> --- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
> @@ -24,6 +24,15 @@ Required SoC Specific Properties:
>  - dma-names: Names for the dma channels. There must be at least one channel
>    named "tx" for transmit and named "rx" for receive.
>  
> +- clocks: specifies the clock IDs provided to the SPI controller; they are
> +  required for interacting with the controller itself, for synchronizing the bus
> +  and as I/O clock (the latter is required by exynos5433 and exynos7).
> +
> +- clock-names: string names of the clocks in the 'clocks' property; for all the
> +  the devices the names must be "spi", "spi_busclkN" (where N is determined by
> +  "samsung,spi-src-clk"), while Exynos5433 should specify a third clock

This sounds like you are describing the configuration of the clocks, not 
the connections. The binding here should list clocks for all possible 
vaules of N as those are all the input clocks to the block.

> +  "spi_ioclk" for the I/O clock.
> +
>  Required Board Specific Properties:
>  
>  - #address-cells: should be 1.
> -- 
> 2.8.1
> 
