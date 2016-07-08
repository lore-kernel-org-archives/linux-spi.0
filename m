From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v2 2/7] bindings: spi-samsung: document the clocks and the
 clock-name property
Date: Fri, 08 Jul 2016 23:46:36 +0900
Message-ID: <1467989201-14661-3-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	Andi Shyti <andi.shyti@samsung.com>,
	Andi Shyti <andi@etezian.org>
To: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

These two properties were not documented but used in the spi
dts. Add the related documentation.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 Documentation/devicetree/bindings/spi/spi-samsung.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 57d5539..2b7167e 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -24,6 +24,14 @@ Required SoC Specific Properties:
 - dma-names: Names for the dma channels. There must be at least one channel
   named "tx" for transmit and named "rx" for receive.
 
+- clocks: specifies the clock IDs provided to the SPI controller; they are
+  required for interacting with the controller itself, for synchronizing the bus
+  and as I/O clock (the latter is required by exynos5433 and exynos7).
+
+- clock-names: string names of the clocks in the 'clocks' property; the names
+  mut be "spi", "spi_busclkN" and "spi_ioclk", where N is determined by
+  "samsung,spi-src-clk".
+
 Required Board Specific Properties:
 
 - #address-cells: should be 1.
-- 
2.8.1

