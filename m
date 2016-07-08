From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH 0/4] spi s3c64xx ioclk handling
Date: Fri, 08 Jul 2016 21:18:20 +0900
Message-ID: <1467980304-14093-1-git-send-email-andi.shyti@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>,
	Andi Shyti <andi@etezian.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

this patchset improves the compatibility between the s3c64xx
driver and the exynos5433. One point of incompatibility, indeed,
was that the SPI controller in exynos5433 is fed by three clocks
which need to be handled by the driver. The third clock is the
ioclk which support is the main purpose of this patchset.

The last patch is a bit unrelated, it restores a comment that has
been removed earlier by mistake.

Thanks,
Andi

Andi Shyti (4):
  spi: s3c64xx: rename goto labels to meaningful names
  bindings: spi-samsung: add exynos5433 spi compatible
  spi: s3c64xx: add nexynos5433 compatible for ioclk handling
  spi: s3c64xx: restore removed comments

 .../devicetree/bindings/spi/spi-samsung.txt        |  1 +
 drivers/spi/spi-s3c64xx.c                          | 83 +++++++++++++++++-----
 2 files changed, 67 insertions(+), 17 deletions(-)

-- 
2.8.1
