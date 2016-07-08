From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 4/7] spi: s3c64xx: use error code from
 clk_prepare_enable()
Date: Fri, 8 Jul 2016 22:33:28 +0200
Message-ID: <20160708203328.GC25980@kozik-lap>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-5-git-send-email-andi.shyti@samsung.com>
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
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467989201-14661-5-git-send-email-andi.shyti@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 08, 2016 at 11:46:38PM +0900, Andi Shyti wrote:
> If clk_prepare_enable() fails do not return -EBUSY but use the
> value provided by the function itself.
> 
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Cool, thanks for fixing existing pattern:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
