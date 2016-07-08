From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 5/7] spi: s3c64xx: add exynos5433 compatible for ioclk
 handling
Date: Fri, 8 Jul 2016 22:39:27 +0200
Message-ID: <20160708203927.GB26626@kozik-lap>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-6-git-send-email-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kukjin Kim <kgene@kernel.org>,
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
In-Reply-To: <1467989201-14661-6-git-send-email-andi.shyti@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 08, 2016 at 11:46:39PM +0900, Andi Shyti wrote:
> The new compatible is related to the Samsung Exynos5433 SoC. The
> difference between the previous is that in the exynos5433 the SPI
> controller is driven by three clocks instead of only one.
> 
> The new clock (ioclk) is controlling the input/output clock
> whenever the controller is slave or master.
> 
> The presence of the clock line is detected from the compatibility
> structure (exynos5433_spi_port_config) as a boolean value.
> 
> The probe function checks whether the ioclk is present and if so,
> it acquires.
> 
> The runtime suspend and resume functions will handle the clock
> enabling and disabling as well.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 57 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 52 insertions(+), 5 deletions(-)
>

Looks fine to me, thanks for updates.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

