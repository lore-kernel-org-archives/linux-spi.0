From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3] bindings: spi-samsung: document the clocks and the
 clock-name property
Date: Mon, 11 Jul 2016 11:36:21 +0900
Message-ID: <1468204581-16873-1-git-send-email-andi.shyti@samsung.com>
References: <20160708203207.GB25980@kozik-lap>
Cc: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
	Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20160708203207.GB25980@kozik-lap>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

These two properties were not documented but used in the spi
dts. Add the related documentation.

Suggested-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
Hi,

Changelog related only to this patch:

V1 -> V2: [new] added the clocks and clock-name documentation
   in the bindings

V2 -> V3: reworded the 'clock-names' as suggested by Krzysztof,
   added Mike's and Krzysztof's review and Krzysztof's
   suggested-by.

Thanks,
Andi

 Documentation/devicetree/bindings/spi/spi-samsung.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 57d5539..f45c6eb 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -24,6 +24,15 @@ Required SoC Specific Properties:
 - dma-names: Names for the dma channels. There must be at least one channel
   named "tx" for transmit and named "rx" for receive.
 
+- clocks: specifies the clock IDs provided to the SPI controller; they are
+  required for interacting with the controller itself, for synchronizing the bus
+  and as I/O clock (the latter is required by exynos5433 and exynos7).
+
+- clock-names: string names of the clocks in the 'clocks' property; for all the
+  the devices the names must be "spi", "spi_busclkN" (where N is determined by
+  "samsung,spi-src-clk"), while Exynos5433 should specify a third clock
+  "spi_ioclk" for the I/O clock.
+
 Required Board Specific Properties:
 
 - #address-cells: should be 1.
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
