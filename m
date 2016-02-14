From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: Get fifosize via device tree
Date: Sun, 14 Feb 2016 17:31:52 +0900
Message-ID: <56C03B78.1040100@samsung.com>
References: <1455031585-11113-1-git-send-email-ym0914@gmail.com>
 <56C02634.8020204@samsung.com> <56C03731.5040107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: k.kozlowski.k@gmail.com, linux-samsung-soc@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Youngmin Nam <ym0914@gmail.com>, kgene@kernel.org,
	broonie@kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <56C03731.5040107@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

W dniu 14.02.2016 o 17:13, Youngmin Nam pisze:
> Hello Krzysztof,
> 
> As you mentioned, spi fifosize is not configurable in the given SoC.
> The point is we can set fifosize without changing driver code.
> For example, if some SoC in exynos7 series has different spi fifosize of on each channel with current
> our compatible, we can't cover this situation without adding new compatible into spi driver code.

Yes, because new SoC is not compatible with old ones... so a new
compatible is required!

> Whenever new SoC kind of exynos7 come out, we should add new compatible into driver code only for fifosize change.
> I think this is not efficient. I think we can reduces this works through DT handling.

I agree that this is not the most efficient possible way of setting some
specific properties of devices but this is the way how DT works.

What if the property is not present on board with Exynos7? What value
should be used?

You did not want to add a new compatible but you are adding a
compatible-like property which apparently is required for some devices.

That looks bad. It's easy to make a mistake, messes with compatibles.

Best regards,
Krzysztof
