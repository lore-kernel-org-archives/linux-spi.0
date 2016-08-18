From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v2] MAINTAINERS: add myself as Samsung SPI maintainer
Date: Thu, 18 Aug 2016 16:25:55 +0900
Message-ID: <20160818072555.9208-1-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andi Shyti <andi.shyti@samsung.com>, linux-spi@vger.kernel.org,
 Andi Shyti <andi@etezian.org>, linux-arm-kernel@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Create a new entry for the Samsung SPI driver supported by the
drivers/spi/spi-s3c* and remove it from its original place under
"ARM/SAMSUNG EXYNOS ARM ARCHITECTURES".

The original maintainership inherited from the Samsung Exynos
ARM Architecture is kept as it was (i.e. Kukjin and Krzysztof), I
will help and co-maintain the driver.

CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: Kukjin Kim <kgene@kernel.org>
CC: Mark Brown <broonie@kernel.org>
CC: linux-samsung-soc@vger.kernel.org
CC: linux-spi@vger.kernel.org
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
Hi,

as Krzysztof pointed out, in the first version of this patch I
forgot some files related to the Samsung's SPI drivers. In this
version I added them.

Thanks,
Andi

 MAINTAINERS | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9cd8d3..fa71cea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1633,7 +1633,6 @@ F:	drivers/*/*s3c64xx*
 F:	drivers/*/*s5pv210*
 F:	drivers/memory/samsung/*
 F:	drivers/soc/samsung/*
-F:	drivers/spi/spi-s3c*
 F:	Documentation/arm/Samsung/
 F:	Documentation/devicetree/bindings/arm/samsung/
 F:	Documentation/devicetree/bindings/sram/samsung-sram.txt
@@ -10240,6 +10239,17 @@ S:	Supported
 L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
 F:	drivers/clk/samsung/
 
+SAMSUNG SPI DRIVERS
+M:	Kukjin Kim <kgene@kernel.org>
+M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Andi Shyti <andi.shyti@samsung.com>
+L:	linux-spi@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-samsung.txt
+F:	drivers/spi/spi-s3c*
+F:	include/linux/platform_data/spi-s3c64xx.h
+
 SAMSUNG SXGBE DRIVERS
 M:	Byungho An <bh74.an@samsung.com>
 M:	Girish K S <ks.giri@samsung.com>
-- 
2.8.1
